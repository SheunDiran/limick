import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/text.dart';
import 'claude_client.dart';

/// Turns passages of ingested books into feed posts.
///
/// Each call reads the next passage of a book (books are read in order, so
/// posts follow the book's own arc), asks Claude for a few posts of varied
/// kinds, validates every post against the passage, and stores the ones that
/// pass. Quotes and vocabulary must appear verbatim in the source.
class PostGenerator {
  static const passageWords = 750;
  static const _rotations = [
    [PostKind.insight, PostKind.quote, PostKind.word],
    [PostKind.thread, PostKind.quiz, PostKind.debate],
    [PostKind.insight, PostKind.word, PostKind.quiz],
    [PostKind.quote, PostKind.thread, PostKind.debate],
    [PostKind.insight, PostKind.quiz, PostKind.word],
  ];

  static String? apiKey(Session session) {
    final key = session.passwords['anthropicApiKey'];
    return key == null || key.trim().isEmpty ? null : key.trim();
  }

  /// How many posts we aim to keep for a book. Popularity rises when users
  /// follow, read or run low on posts from a book.
  static int targetPosts(Book book) =>
      (book.featured ? 18 : 10) + book.popularity.clamp(0, 150);

  /// Generates posts for the books that need them most.
  static Future<int> generateRound(Session session, {int books = 4}) async {
    final key = apiKey(session);
    if (key == null) return 0;

    // Books that still have no posts come first, so a new user's feed is
    // varied quickly; then the books furthest below their target.
    final candidates = await Book.db.find(
      session,
      where: (t) =>
          t.status.equals(BookStatus.ready) & (t.generationFailures < 5),
      orderByList: (t) => [t.postCount.asc(), t.popularity.desc()],
      limit: 60,
    );
    final picked = candidates
        .where((b) => b.postCount < targetPosts(b))
        .take(books)
        .toList();
    if (picked.isEmpty) return 0;

    final client = ClaudeClient(key);
    final results = await Future.wait(
      picked.map((b) => generateForBook(session, b, client)),
    );
    return results.fold<int>(0, (a, b) => a + b);
  }

  static Future<int> generateForBook(
    Session session,
    Book book,
    ClaudeClient client,
  ) async {
    try {
      final passage = await _nextPassage(session, book);
      if (passage == null) {
        // Nothing readable found: count it so the book stops hogging a slot.
        await _recordFailure(session, book);
        return 0;
      }

      final kinds = _rotations[(book.postCount ~/ 3) % _rotations.length];
      final response = await client.structured(
        system: _systemPrompt,
        user: _userPrompt(book, passage, kinds),
        schema: _schema,
      );
      final posts = _validate(response, book, passage);
      final blurb = (response['bookBlurb'] as String?)?.trim();

      await session.db.transaction((tx) async {
        if (posts.isNotEmpty) {
          await Post.db.insert(session, posts, transaction: tx);
        }
        await Book.db.updateRow(
          session,
          passage.book.copyWith(
            postCount: passage.book.postCount + posts.length,
            blurb:
                book.blurb ??
                (blurb != null && blurb.length > 20 && blurb.length < 400
                    ? blurb
                    : null),
            lastGeneratedAt: DateTime.now(),
            generationFailures: 0,
          ),
          transaction: tx,
        );
      });
      session.log('Generated ${posts.length} posts for @${book.handle}.');
      return posts.length;
    } catch (e) {
      // Outages, rate limits and auth errors are not the book's fault: don't
      // let them push books out of rotation.
      final apiProblem =
          e is ClaudeException && (e.retryable || e.message.startsWith('HTTP'));
      if (!apiProblem) await _recordFailure(session, book);
      session.log(
        'Generation failed for @${book.handle}: $e',
        level: LogLevel.warning,
      );
      return 0;
    }
  }

  static Future<void> _recordFailure(Session session, Book book) async {
    final fresh = await Book.db.findById(session, book.id!);
    if (fresh == null) return;
    await Book.db.updateRow(
      session,
      fresh.copyWith(generationFailures: fresh.generationFailures + 1),
    );
  }

  /// Picks the next readable window of the book and advances the cursor.
  static Future<_Passage?> _nextPassage(Session session, Book book) async {
    var position = book.nextChapterPosition;
    var offset = book.nextOffset;
    for (var tries = 0; tries < 6; tries++) {
      if (position >= book.chapterCount) {
        position = 0;
        offset = 0;
      }
      final chapter = await Chapter.db.findFirstRow(
        session,
        where: (t) => t.bookId.equals(book.id!) & t.position.equals(position),
      );
      if (chapter == null) return null;

      final text = chapter.text;
      if (offset >= text.length) {
        position++;
        offset = 0;
        continue;
      }
      // Grow the window paragraph by paragraph.
      var end = offset;
      var words = 0;
      while (end < text.length && words < passageWords) {
        var next = text.indexOf('\n\n', end + 1);
        if (next < 0) next = text.length;
        words += countWords(text.substring(end, next));
        end = next;
      }
      // Don't leave a tiny remainder for the next round.
      if (countWords(text.substring(end)) < 200) end = text.length;

      final rawWindow = text.substring(offset, end);
      final window = rawWindow.trim();
      final start = offset + rawWindow.length - rawWindow.trimLeft().length;
      final atChapterEnd = end >= text.length;
      final nextPosition = atChapterEnd ? position + 1 : position;
      final nextOffset = atChapterEnd ? 0 : end;

      final letters = RegExp(r'[A-Za-z]').allMatches(window).length;
      final readable = window.isNotEmpty && letters / window.length > 0.6;
      if (countWords(window) < 120 || !readable) {
        position = nextPosition;
        offset = nextOffset;
        continue;
      }
      final updated = book.copyWith(
        nextChapterPosition: nextPosition,
        nextOffset: nextOffset,
      );
      return _Passage(updated, chapter, window, start, start + window.length);
    }
    // Nothing usable nearby: save progress so we move on next time.
    await Book.db.updateRow(
      session,
      book.copyWith(nextChapterPosition: position, nextOffset: offset),
    );
    return null;
  }

  static List<Post> _validate(
    Map<String, dynamic> response,
    Book book,
    _Passage passage,
  ) {
    final raw = (response['posts'] as List?) ?? const [];
    final posts = <Post>[];
    final seenKinds = <PostKind>{};
    for (final item in raw.whereType<Map<String, dynamic>>()) {
      final kind = PostKind.values.asNameMap()[item['kind']];
      if (kind == null || seenKinds.contains(kind)) continue;
      final body = _clip(item['body'], 600);
      if (body == null || body.length < 20) continue;

      var start = passage.start;
      var end = passage.end;
      String? quote = _clip(item['quote'], 400);
      if (quote != null) {
        final found = findQuote(passage.text, quote);
        if (found == null) {
          // Never publish a quote that is not in the book.
          if (kind == PostKind.quote || kind == PostKind.word) continue;
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

      String? word, definition, partOfSpeech;
      if (kind == PostKind.word) {
        word = _clip(item['word'], 40);
        definition = _clip(item['definition'], 240);
        partOfSpeech = _clip(item['partOfSpeech'], 30);
        if (word == null || definition == null) continue;
        if (!containsWord(passage.text, word)) continue;
      }

      List<String>? parts;
      if (kind == PostKind.thread) {
        parts = ((item['parts'] as List?) ?? const [])
            .map((p) => _clip(p, 400))
            .whereType<String>()
            .take(4)
            .toList();
        if (parts.length < 2) continue;
      }

      List<String>? options;
      int? answer;
      String? explanation;
      if (kind == PostKind.quiz) {
        options = ((item['options'] as List?) ?? const [])
            .map((o) => _clip(o, 120))
            .whereType<String>()
            .take(4)
            .toList();
        answer = item['answerIndex'] is int ? item['answerIndex'] as int : -1;
        explanation = _clip(item['explanation'], 400);
        if (options.length < 3 || answer < 0 || answer >= options.length) {
          continue;
        }
        if (options.toSet().length != options.length) continue;
      }
      if (kind == PostKind.debate) {
        explanation = _clip(item['explanation'], 400);
      }

      final topic =
          Topic.values.asNameMap()[item['topic']] ?? book.primaryTopic;
      seenKinds.add(kind);
      posts.add(
        Post(
          bookId: book.id!,
          chapterId: passage.chapter.id!,
          chapterPosition: passage.chapter.position,
          kind: kind,
          body: body,
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

  static String? _clip(Object? value, int max) {
    if (value is! String) return null;
    final t = value.trim();
    if (t.isEmpty) return null;
    return t.length > max ? '${t.substring(0, max - 1)}…' : t;
  }

  static String _userPrompt(Book book, _Passage passage, List<PostKind> kinds) {
    final topics = book.topics.map((t) => t.name).join(', ');
    return '''
Book: "${book.title}" by ${book.author}${book.authorYears != null ? ' (${book.authorYears})' : ''}
Account handle: @${book.handle}
Topics: $topics
Chapter: ${passage.chapter.title}
${book.blurb == null ? 'Also write bookBlurb: a one-sentence profile bio for this account (max 160 characters), in its own voice.' : 'Set bookBlurb to an empty string.'}

Write exactly one post of each of these kinds: ${kinds.map((k) => k.name).join(', ')}.

<passage>
${passage.text}
</passage>''';
  }

  static const _systemPrompt = '''
You write posts for Limick, a social feed where every post is grounded in a real public-domain book. Readers are students and curious people who opened the app for a short break. Each post should make them learn one real thing from the passage and want the next post, or the book itself.

Voice: a sharp, warm person posting about a book they love. Plain modern English. Open with a hook. Concrete over abstract. No hashtags, no emojis, no "In this passage" or "This book". Never invent facts that the passage does not support; brief, widely known context (who the author was, when they wrote) is fine.

Post kinds:
- insight: body (max 280 chars) explains one surprising or useful idea from the passage. quote may hold a short supporting excerpt copied exactly from the passage, or be empty.
- quote: quote is one to three consecutive sentences copied character for character from the passage (60-300 chars, choose the most striking line). body (max 160 chars) is a one-line reaction or context.
- word: word is an uncommon, archaic or technical word that appears in the passage exactly as written. definition is a plain-English definition (max 160 chars). partOfSpeech as one word. quote is the sentence from the passage that contains the word, copied exactly. body (max 200 chars) says how the author uses it and gives a modern example sentence.
- thread: body (max 200 chars) is the hook. parts holds 2 to 4 follow-up posts (max 240 chars each) that walk through the argument or story of the passage.
- quiz: body is a question (max 160 chars) answerable from the passage. options holds 3 or 4 short, plausible, distinct answers. answerIndex is the 0-based index of the correct one. explanation (max 220 chars) explains the answer using the passage.
- debate: body (max 200 chars) states a provocative but fair claim the author makes or implies, ending with "Agree or disagree?". explanation (max 220 chars) gives the strongest point on each side.

Every post: topic is the single best-fitting topic. historical is true when the passage's medical, legal or scientific claims are outdated and must not be read as current advice; otherwise false. Use empty strings, empty arrays and -1 for fields a kind does not use.''';

  static final Map<String, dynamic> _schema = {
    'type': 'object',
    'additionalProperties': false,
    'required': ['bookBlurb', 'posts'],
    'properties': {
      'bookBlurb': {'type': 'string'},
      'posts': {
        'type': 'array',
        'items': {
          'type': 'object',
          'additionalProperties': false,
          'required': [
            'kind',
            'body',
            'quote',
            'parts',
            'word',
            'definition',
            'partOfSpeech',
            'options',
            'answerIndex',
            'explanation',
            'topic',
            'historical',
          ],
          'properties': {
            'kind': {
              'type': 'string',
              'enum': PostKind.values.map((k) => k.name).toList(),
            },
            'body': {'type': 'string'},
            'quote': {'type': 'string'},
            'parts': {
              'type': 'array',
              'items': {'type': 'string'},
            },
            'word': {'type': 'string'},
            'definition': {'type': 'string'},
            'partOfSpeech': {'type': 'string'},
            'options': {
              'type': 'array',
              'items': {'type': 'string'},
            },
            'answerIndex': {'type': 'integer'},
            'explanation': {'type': 'string'},
            'topic': {
              'type': 'string',
              'enum': Topic.values.map((t) => t.name).toList(),
            },
            'historical': {'type': 'boolean'},
          },
        },
      },
    },
  };
}

class _Passage {
  /// The book with its reading cursor already advanced past this passage.
  final Book book;
  final Chapter chapter;
  final String text;

  /// Offsets of [text] inside the chapter.
  final int start;
  final int end;

  _Passage(this.book, this.chapter, this.text, this.start, this.end);
}
