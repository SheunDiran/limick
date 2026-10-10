import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Thrown when Claude could not produce a usable response.
class ClaudeException implements Exception {
  final String message;
  final bool retryable;
  ClaudeException(this.message, {this.retryable = false});
  @override
  String toString() => 'ClaudeException: $message';
}

/// A small client for the Claude Messages API. Dart has no official
/// Anthropic SDK, so this calls the HTTP API directly.
class ClaudeClient {
  static const model = 'claude-haiku-4-5';
  static final _endpoint = Uri.parse('https://api.anthropic.com/v1/messages');

  final String apiKey;
  ClaudeClient(this.apiKey);

  /// Sends one request constrained to [schema] and returns the parsed JSON.
  Future<Map<String, dynamic>> structured({
    required String system,
    required String user,
    required Map<String, dynamic> schema,
    int maxTokens = 4096,
    int maxAttempts = 3,
  }) async {
    final body = jsonEncode({
      'model': model,
      'max_tokens': maxTokens,
      'system': system,
      'messages': [
        {'role': 'user', 'content': user},
      ],
      'output_config': {
        'format': {'type': 'json_schema', 'schema': schema},
      },
    });

    ClaudeException? last;
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        return await _send(body);
      } on ClaudeException catch (e) {
        last = e;
        if (!e.retryable) rethrow;
      } on TimeoutException {
        last = ClaudeException('Request timed out', retryable: true);
      } on SocketException catch (e) {
        last = ClaudeException('Network error: ${e.message}', retryable: true);
      }
      await Future.delayed(Duration(seconds: 2 << attempt));
    }
    throw last ?? ClaudeException('Request failed');
  }

  Future<Map<String, dynamic>> _send(String body) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 20);
    try {
      final request = await client.postUrl(_endpoint);
      request.headers
        ..set('x-api-key', apiKey)
        ..set('anthropic-version', '2023-06-01')
        ..contentType = ContentType.json;
      request.add(utf8.encode(body));
      final response = await request.close().timeout(
        const Duration(seconds: 120),
      );
      final text = await response.transform(utf8.decoder).join();

      if (response.statusCode != 200) {
        final retryable =
            response.statusCode == 429 ||
            response.statusCode == 408 ||
            response.statusCode >= 500;
        String message = 'HTTP ${response.statusCode}';
        try {
          final error = jsonDecode(text)['error'];
          message = '$message ${error['type']}: ${error['message']}';
        } catch (_) {}
        throw ClaudeException(message, retryable: retryable);
      }

      final json = jsonDecode(text) as Map<String, dynamic>;
      final stopReason = json['stop_reason'];
      if (stopReason == 'refusal') {
        throw ClaudeException('Model declined this passage');
      }
      if (stopReason == 'max_tokens') {
        throw ClaudeException('Response was cut off', retryable: true);
      }
      final content = (json['content'] as List)
          .where((b) => b['type'] == 'text')
          .map((b) => b['text'] as String)
          .join();
      try {
        return jsonDecode(content) as Map<String, dynamic>;
      } on FormatException {
        throw ClaudeException('Response was not valid JSON', retryable: true);
      }
    } finally {
      client.close(force: true);
    }
  }
}
