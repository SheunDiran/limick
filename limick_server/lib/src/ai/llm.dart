import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

/// Thrown when no model could produce a usable response.
class LlmException implements Exception {
  final String message;

  /// True for rate limits, outages and network errors: problems with the
  /// provider, not with the request or the passage.
  final bool providerProblem;

  /// How long the provider asked us to wait, when it said so.
  final Duration? retryAfter;

  LlmException(this.message, {this.providerProblem = false, this.retryAfter});

  @override
  String toString() => 'LlmException: $message';
}

/// One model behind one provider's HTTP API.
abstract class LlmModel {
  String get provider;
  String get model;
  String get id => '$provider:$model';

  Future<Map<String, dynamic>> generateJson({
    required String system,
    required String user,
    required Map<String, dynamic> schema,
    required int maxTokens,
  });
}

/// Groq's OpenAI-compatible chat completions API. GPT-OSS models support
/// strict JSON-schema decoding; other models get JSON mode plus the schema
/// in the prompt, and our validator checks the result either way.
class GroqModel extends LlmModel {
  static final _endpoint = Uri.parse(
    'https://api.groq.com/openai/v1/chat/completions',
  );

  final String apiKey;
  @override
  final String model;
  @override
  String get provider => 'groq';

  GroqModel(this.apiKey, this.model);

  bool get _strictSchema => model.startsWith('openai/gpt-oss');

  @override
  Future<Map<String, dynamic>> generateJson({
    required String system,
    required String user,
    required Map<String, dynamic> schema,
    required int maxTokens,
  }) async {
    final systemText = _strictSchema
        ? system
        : '$system\n\nRespond with a single JSON object matching this JSON Schema:\n${jsonEncode(schema)}';
    final body = {
      'model': model,
      'messages': [
        {'role': 'system', 'content': systemText},
        {'role': 'user', 'content': user},
      ],
      'temperature': 0.9,
      'max_completion_tokens': maxTokens,
      'response_format': _strictSchema
          ? {
              'type': 'json_schema',
              'json_schema': {
                'name': 'limick_output',
                'strict': true,
                'schema': schema,
              },
            }
          : {'type': 'json_object'},
      if (_strictSchema) 'reasoning_effort': 'low',
    };
    final response = await _postJson(
      _endpoint,
      headers: {'Authorization': 'Bearer $apiKey'},
      body: body,
    );
    final choice = (response['choices'] as List?)?.firstOrNull;
    if (choice == null) throw LlmException('Groq returned no choices');
    if (choice['finish_reason'] == 'length') {
      throw LlmException('Groq response was cut off');
    }
    return _decodeObject(choice['message']?['content'] as String?, 'Groq');
  }
}

/// Google's Gemini API (generateContent) with a JSON schema response.
class GeminiModel extends LlmModel {
  final String apiKey;
  @override
  final String model;
  @override
  String get provider => 'gemini';

  GeminiModel(this.apiKey, this.model);

  @override
  Future<Map<String, dynamic>> generateJson({
    required String system,
    required String user,
    required Map<String, dynamic> schema,
    required int maxTokens,
  }) async {
    final endpoint = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent',
    );
    final response = await _postJson(
      endpoint,
      headers: {'x-goog-api-key': apiKey},
      body: {
        'systemInstruction': {
          'parts': [
            {'text': system},
          ],
        },
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': user},
            ],
          },
        ],
        'generationConfig': {
          'responseMimeType': 'application/json',
          'responseJsonSchema': schema,
          'temperature': 0.9,
          'maxOutputTokens': maxTokens,
        },
      },
    );
    final candidate = (response['candidates'] as List?)?.firstOrNull;
    if (candidate == null) {
      final reason = response['promptFeedback']?['blockReason'];
      throw LlmException('Gemini returned no candidates ($reason)');
    }
    final finish = candidate['finishReason'];
    if (finish == 'MAX_TOKENS') {
      throw LlmException('Gemini response was cut off');
    }
    if (finish == 'SAFETY' || finish == 'RECITATION') {
      throw LlmException('Gemini declined this passage ($finish)');
    }
    final text = ((candidate['content']?['parts'] as List?) ?? const [])
        .map((p) => p['text'] as String? ?? '')
        .join();
    return _decodeObject(text, 'Gemini');
  }
}

/// All configured models, best first. A model that hits a rate limit cools
/// down for as long as its provider asks (or a minute), and the next model
/// takes over, so free-tier quotas on Groq and Gemini add up.
class LlmPool {
  final List<LlmModel> models;
  LlmPool(this.models);

  static final Map<String, DateTime> _coolingUntil = {};

  // Both are on Groq's free tier and support strict JSON schemas. Each model
  // has its own tokens-per-minute budget, so two models double throughput.
  static const defaultGroqModels = [
    'openai/gpt-oss-120b',
    'openai/gpt-oss-20b',
  ];
  static const defaultGeminiModels = [
    'gemini-3.8-flash',
    'gemini-3.5-flash-lite',
  ];

  /// Builds the pool from `groqApiKey` and `geminiApiKey` in passwords.yaml
  /// (or the `SERVERPOD_PASSWORD_<name>` environment variables). Model lists
  /// can be overridden with `groqModels` / `geminiModels` (comma separated).
  static LlmPool? fromSession(Session session) {
    String? read(String key) {
      final value = session.passwords[key]?.trim();
      return value == null || value.isEmpty ? null : value;
    }

    List<String> list(String key, List<String> fallback) =>
        read(key)
            ?.split(',')
            .map((m) => m.trim())
            .where((m) => m.isNotEmpty)
            .toList() ??
        fallback;

    final groq = read('groqApiKey');
    final gemini = read('geminiApiKey');
    final groqModels = groq == null
        ? <LlmModel>[]
        : list(
            'groqModels',
            defaultGroqModels,
          ).map((m) => GroqModel(groq, m)).toList();
    final geminiModels = gemini == null
        ? <LlmModel>[]
        : list(
            'geminiModels',
            defaultGeminiModels,
          ).map((m) => GeminiModel(gemini, m)).toList();

    // Best first: each provider's main model, then the lighter ones.
    final models = <LlmModel>[];
    for (var i = 0; i < groqModels.length || i < geminiModels.length; i++) {
      if (i < groqModels.length) models.add(groqModels[i]);
      if (i < geminiModels.length) models.add(geminiModels[i]);
    }
    return models.isEmpty ? null : LlmPool(models);
  }

  static bool isConfigured(Session session) => fromSession(session) != null;

  /// True when every model is cooling down after a rate limit.
  bool get allCooling => models.every(
    (m) => _coolingUntil[m.id]?.isAfter(DateTime.now()) ?? false,
  );

  Future<({Map<String, dynamic> json, String modelId})> generateJson({
    required String system,
    required String user,
    required Map<String, dynamic> schema,
    int maxTokens = 4096,
    Session? session,
  }) async {
    // Models are listed best first. Always start with the best one that isn't
    // cooling down; weaker models only take overflow during rate limits.
    const start = 0;
    final errors = <String>[];
    var everyFailureWasProvider = true;
    Duration? shortestWait;

    for (var i = 0; i < models.length; i++) {
      final model = models[(start + i) % models.length];
      final cooling = _coolingUntil[model.id];
      if (cooling != null && cooling.isAfter(DateTime.now())) continue;
      try {
        final json = await model.generateJson(
          system: system,
          user: user,
          schema: schema,
          maxTokens: maxTokens,
        );
        return (json: json, modelId: model.id);
      } on LlmException catch (e) {
        errors.add('${model.id}: ${e.message}');
        if (e.providerProblem) {
          final wait = e.retryAfter ?? const Duration(seconds: 60);
          _coolingUntil[model.id] = DateTime.now().add(wait);
          if (shortestWait == null || wait < shortestWait) shortestWait = wait;
        } else {
          everyFailureWasProvider = false;
        }
        session?.log(
          'LLM ${model.id} failed: ${e.message}',
          level: LogLevel.debug,
        );
      }
    }
    throw LlmException(
      errors.isEmpty
          ? 'All models are cooling down after rate limits'
          : errors.join(' | '),
      providerProblem: everyFailureWasProvider,
      retryAfter: shortestWait,
    );
  }
}

Future<Map<String, dynamic>> _postJson(
  Uri url, {
  required Map<String, String> headers,
  required Map<String, dynamic> body,
}) async {
  final client = HttpClient()..connectionTimeout = const Duration(seconds: 20);
  try {
    final request = await client.postUrl(url);
    headers.forEach(request.headers.set);
    request.headers.contentType = ContentType.json;
    request.add(utf8.encode(jsonEncode(body)));
    final response = await request.close().timeout(const Duration(seconds: 90));
    final text = await response.transform(utf8.decoder).join();
    if (response.statusCode == 200) {
      return jsonDecode(text) as Map<String, dynamic>;
    }
    final status = response.statusCode;
    var message = 'HTTP $status';
    Duration? retryAfter;
    final header = response.headers.value('retry-after');
    if (header != null) {
      final seconds = double.tryParse(header);
      if (seconds != null) {
        retryAfter = Duration(milliseconds: (seconds * 1000).round());
      }
    }
    try {
      final error = jsonDecode(text)['error'];
      message = '$message ${error['message'] ?? error}';
      // Gemini puts the wait in error.details[].retryDelay, e.g. "17s".
      for (final detail in (error['details'] as List? ?? const [])) {
        final delay = detail is Map ? detail['retryDelay'] as String? : null;
        final seconds = delay == null
            ? null
            : double.tryParse(delay.replaceAll('s', ''));
        if (seconds != null) {
          retryAfter = Duration(milliseconds: (seconds * 1000).round());
        }
      }
    } catch (_) {}
    if (message.length > 300) message = message.substring(0, 300);
    // A model that fails the provider's own schema check is having a bad
    // moment; that's not the passage's fault.
    final modelSlip =
        status == 400 &&
        (message.contains('failed_generation') ||
            message.contains('does not match'));
    throw LlmException(
      message,
      // Other 400s are our fault (bad request); everything else is the
      // provider being busy, down or refusing our key.
      providerProblem: status != 400 || modelSlip,
      retryAfter:
          retryAfter ??
          (modelSlip ? const Duration(seconds: 5) : null) ??
          switch (status) {
            // Bad key or no access: don't hammer it.
            401 || 403 => const Duration(minutes: 30),
            // Model not available on this account.
            404 => const Duration(hours: 6),
            _ => null,
          },
    );
  } on TimeoutException {
    throw LlmException('Request timed out', providerProblem: true);
  } on SocketException catch (e) {
    throw LlmException('Network error: ${e.message}', providerProblem: true);
  } on HttpException catch (e) {
    throw LlmException('HTTP error: ${e.message}', providerProblem: true);
  } finally {
    client.close(force: true);
  }
}

Map<String, dynamic> _decodeObject(String? text, String provider) {
  if (text == null || text.trim().isEmpty) {
    throw LlmException('$provider returned an empty response');
  }
  var cleaned = text.trim();
  // Some models wrap JSON in a code fence even in JSON mode.
  if (cleaned.startsWith('```')) {
    cleaned = cleaned
        .replaceFirst(RegExp(r'^```(json)?'), '')
        .replaceFirst(RegExp(r'```$'), '');
  }
  try {
    final decoded = jsonDecode(cleaned.trim());
    if (decoded is Map<String, dynamic>) return decoded;
  } on FormatException {
    // Fall through.
  }
  throw LlmException('$provider returned invalid JSON');
}
