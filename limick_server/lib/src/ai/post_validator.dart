import '../generated/protocol.dart';
import '../util/text.dart';
import 'post_formats.dart';

/// Context representing the readable slice of a book that was fed to the model.
class PassageContext {
  final Book book;
  final Chapter chapter;
  final String text;
  final int start;
  final int end;

  const PassageContext({
    required this.book,
    required this.chapter,
    required this.text,
    required this.start,
    required this.end,
  });
}

/// Pure validation function that filters and transforms raw LLM structured JSON
/// into verified [Post] entities. Enforces strict factual grounding:
/// - Verbatim quote checking against [passage.text]
/// - Vocabulary presence in [passage.text]
/// - Valid quiz options (≥3 unique) and in-bounds answerIndex
/// - Valid threads (≥2 parts)
/// - Deduplication across post kinds
List<Post> validateGeneratedPosts(
  Map<String, dynamic> response,
  Book book,
  PassageContext passage, {
  List<String>? rejections,
}) {
  void reject(Object? kind, String why) => rejections?.add('$kind: $why');

  final raw = (response['posts'] as List?) ?? const [];
  final posts = <Post>[];
  final seenKinds = <PostKind>{};

  for (final item in raw.whereType<Map<String, dynamic>>()) {
    final kind = PostKind.values.asNameMap()[item['kind']];
    if (kind == null || seenKinds.contains(kind)) {
      reject(item['kind'], 'unknown or duplicate kind');
      continue;
    }
    final body = clipText(item['body'], 700);
    final minBody = kind == PostKind.quote ? 8 : 20;
    if (body == null || body.length < minBody) {
      reject(kind.name, 'body too short');
      continue;
    }

    var start = passage.start;
    var end = passage.end;
    String? quote = clipText(item['quote'], 400);
    if (quote != null) {
      final found = findQuote(passage.text, quote);
      if (found == null) {
        // Never publish a quote that is not in the book.
        if (kind == PostKind.quote || kind == PostKind.word) {
          reject(kind.name, 'quote not in passage: "$quote"');
          continue;
        }
        quote = null;
      } else {
        quote = passage.text
            .substring(found.start, found.end)
            .replaceAll('\n', ' ');
        start = passage.start + found.start;
        end = passage.start + found.end;
      }
    }
    if (kind == PostKind.quote && quote == null) continue;

    // Every other post must point at the sentence that proves it. If that
    // sentence isn't really in the passage, the post is not published.
    if (kind != PostKind.quote && kind != PostKind.word) {
      final evidence = clipText(item['evidence'], 600);
      final found = evidence == null
          ? null
          : findEvidence(passage.text, evidence);
      if (found == null) {
        reject(kind.name, 'evidence not in passage: "$evidence"');
        continue;
      }
      if (quote == null) {
        start = passage.start + found.start;
        end = passage.start + found.end;
      }
    }

    String? word, definition, partOfSpeech;
    if (kind == PostKind.word) {
      word = clipText(item['word'], 40);
      definition = clipText(item['definition'], 240);
      partOfSpeech = clipText(item['partOfSpeech'], 30);
      if (word == null || definition == null) continue;
      if (!containsWord(passage.text, word)) {
        reject(kind.name, 'word "$word" not in passage');
        continue;
      }
    }

    List<String>? parts;
    if (kind == PostKind.thread) {
      parts = ((item['parts'] as List?) ?? const [])
          .map((p) => clipText(p, 400))
          .whereType<String>()
          .take(4)
          .toList();
      if (parts.length < 2) {
        reject(kind.name, 'thread needs 2+ parts');
        continue;
      }
    }

    List<String>? options;
    int? answer;
    String? explanation;
    if (kind == PostKind.quiz) {
      options = ((item['options'] as List?) ?? const [])
          .map((o) => clipText(o, 120))
          .whereType<String>()
          .take(4)
          .toList();
      answer = item['answerIndex'] is int ? item['answerIndex'] as int : -1;
      explanation = clipText(item['explanation'], 400);
      if (options.length < 3 || answer < 0 || answer >= options.length) {
        reject(kind.name, 'bad options or answer');
        continue;
      }
      if (options.toSet().length != options.length) {
        reject(kind.name, 'duplicate options');
        continue;
      }
    }
    if (kind == PostKind.debate) {
      explanation = clipText(item['explanation'], 400);
    }

    final topic = Topic.values.asNameMap()[item['topic']] ?? book.primaryTopic;
    seenKinds.add(kind);
    posts.add(
      Post(
        bookId: book.id!,
        chapterId: passage.chapter.id!,
        chapterPosition: passage.chapter.position,
        kind: kind,
        body: body,
        style: formatById(item['style'] as String?)?.id,
        quote: quote,
        parts: parts,
        word: word,
        wordDefinition: definition,
        wordPartOfSpeech: partOfSpeech,
        quizOptions: options,
        quizAnswerIndex: answer,
        quizExplanation: explanation,
        primaryTopic: book.topics.contains(topic) ? topic : book.primaryTopic,
        historical: item['historical'] == true,
        passageStart: start,
        passageEnd: end,
      ),
    );
  }
  return posts;
}

/// Finds the evidence for a post in the passage. Models sometimes join two
/// sentences with "..." or trim the ends, so if the whole string isn't
/// present, the longest fragment of 30+ characters that is present counts.
/// Anything shorter is not evidence.
final _edgeQuotes = RegExp(
  '^["\u201C\u201D\'\u2018\u2019]+|["\u201C\u201D\'\u2018\u2019]+\$',
);

({int start, int end})? findEvidence(String passage, String evidence) {
  final whole = findQuote(passage, evidence);
  if (whole != null) return whole;
  final fragments =
      evidence
          .split(RegExp(r'\.\.\.|…|(?<=[.!?;:])\s+'))
          .map((f) => f.trim().replaceAll(_edgeQuotes, ''))
          .where((f) => f.length >= 30)
          .toList()
        ..sort((a, b) => b.length.compareTo(a.length));
  for (final fragment in fragments) {
    final found = findQuote(passage, fragment);
    if (found != null) return found;
  }
  return null;
}

/// Helper that clips string values to [max] characters and trims whitespace.
String? clipText(Object? value, int max) {
  if (value is! String) return null;
  final t = value.trim();
  if (t.isEmpty) return null;
  return t.length > max ? '${t.substring(0, max - 1)}…' : t;
}
