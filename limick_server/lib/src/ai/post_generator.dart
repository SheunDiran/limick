import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/text.dart';
import 'dart:math';

import 'llm.dart';
import 'post_formats.dart';
import 'post_validator.dart';

/// Turns passages of ingested books into feed posts.
///
/// Each call reads the next passage of a book (books are read in order, so
/// posts follow the book's own arc), asks an LLM (Groq or Gemini) for a few posts of varied
/// kinds, validates every post against the passage, and stores the ones that
/// pass. Quotes and vocabulary must appear verbatim in the source.
class PostGenerator {
  static const passageWords = 650;
  static final _random = Random();

  /// How many posts we aim to keep for a book. Popularity rises when users
  /// follow, read or run low on posts from a book.
  static int targetPosts(Book book) =>
      (book.featured ? 18 : 10) + book.popularity.clamp(0, 150);

  /// Generates posts for the books that need them most.
  static Future<int> generateRound(Session session, {int books = 2}) async {
    final pool = LlmPool.fromSession(session);
    if (pool == null || pool.allCooling) return 0;

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

    // One request at a time: free tiers limit tokens per minute, so parallel
    // requests mostly earn 429s.
    var total = 0;
    for (final book in picked) {
      if (pool.allCooling) break;
      total += await generateForBook(session, book, pool);
    }
    return total;
  }

  static Future<int> generateForBook(
    Session session,
    Book book,
    LlmPool pool,
  ) async {
    try {
      final passage = await _nextPassage(session, book);
      if (passage == null) {
        // Nothing readable found: count it so the book stops hogging a slot.
        await _recordFailure(session, book);
        return 0;
      }

      final formats = pickFormats(book, _random);
      final persona = pickPersona(book, _random);
      final recentOpeners = await _recentOpeners(session);
      final result = await pool.generateJson(
        system: postSystemPrompt,
        user: _userPrompt(book, passage, formats, persona, recentOpeners),
        schema: _schema,
        session: session,
      );
      final response = result.json;
      final rejections = <String>[];
      final posts = _validate(
        response,
        book,
        passage,
        rejections,
      ).map(humanize).toList();
      if (rejections.isNotEmpty) {
        session.log(
          'Rejected for @${book.handle}: ${rejections.join(' | ')}',
          level: LogLevel.info,
        );
      }
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
      final rawCount = ((response['posts'] as List?) ?? const []).length;
      final rejected = rawCount - posts.length;
      session.log(
        'Generated ${posts.length} posts for @${book.handle} with ${result.modelId}'
        '${rejected > 0 ? ' ($rejected rejected by validation)' : ''}.',
      );
      return posts.length;
    } catch (e) {
      // Outages, rate limits and auth errors are not the book's fault: don't
      // let them push books out of rotation.
      final apiProblem = e is LlmException && e.providerProblem;
      if (!apiProblem) await _recordFailure(session, book);
      session.log(
        'Generation failed for @${book.handle}: $e',
        level: LogLevel.warning,
      );
      return 0;
    }
  }

  /// The first few words of the latest posts, so new ones don't all open the
  /// same way.
  static Future<List<String>> _recentOpeners(Session session) async {
    final recent = await Post.db.find(
      session,
      where: (t) => t.style.notEquals(null),
      orderBy: (t) => t.id.desc(),
      limit: 12,
    );
    return recent
        .map((p) => p.body.split(RegExp(r'\s+')).take(5).join(' '))
        .toSet()
        .toList();
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
    for (var tries = 0; tries < 10; tries++) {
      if (position >= book.chapterCount) {
        position = 0;
        offset = 0;
      }
      final chapter = await Chapter.db.findFirstRow(
        session,
        where: (t) => t.bookId.equals(book.id!) & t.position.equals(position),
      );
      if (chapter == null) return null;
      // Prefaces, contents, translator notes and indexes make dull posts.
      if (book.chapterCount > 2 && isFrontOrBackMatter(chapter.title)) {
        position++;
        offset = 0;
        continue;
      }

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
    List<String> rejections,
  ) => validateGeneratedPosts(response, book, passage, rejections: rejections);

  static String _userPrompt(
    Book book,
    _Passage passage,
    List<PostFormat> formats,
    String persona,
    List<String> recentOpeners,
  ) {
    final topics = book.topics.map((t) => t.name).join(', ');
    final asks = formats
        .map(
          (f) =>
              '- kind "${f.kind.name}", style "${f.id}": ${f.guide}\n  Example of the voice (different book, do not reuse its facts or wording):\n  ${f.pickExample(_random).replaceAll('\n', '\n  ')}',
        )
        .join('\n');
    return '''
Book: "${book.title}" by ${book.author}${book.authorYears != null ? ' (${book.authorYears})' : ''}
Account: @${book.handle}
Topics: $topics
Chapter: ${passage.chapter.title}
${book.blurb == null ? 'Also write bookBlurb: the account bio, one punchy line in the book\'s own voice (max 140 characters).' : 'Set bookBlurb to an empty string.'}

You are posting as $persona. Stay in that voice.
${recentOpeners.isEmpty ? '' : 'Other posts in the feed recently started like this, so start yours differently:\n${recentOpeners.map((o) => '- "$o..."').join('\n')}\n'}
Write exactly these ${formats.length} posts, in this order:
$asks

<passage>
${passage.text}
</passage>''';
  }

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
            'style',
            'evidence',
            'body',
            'quote',
            'parts',
            'word',
            'definition',
            'partOfSpeech',
            'options',
            'answerIndex',
            'explanation',
            'historical',
          ],
          'properties': {
            'kind': {
              'type': 'string',
              'enum': PostKind.values.map((k) => k.name).toList(),
            },
            'style': {
              'type': 'string',
              'enum': postFormats.map((f) => f.id).toList(),
            },
            'evidence': {'type': 'string'},
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
            'historical': {'type': 'boolean'},
          },
        },
      },
    },
  };
}

/// Small clean-ups on the post text (never on quotes or evidence): the em
/// dash is the most recognisable sign of generated text, so it becomes the
/// plain hyphen people actually type.
Post humanize(Post post) {
  String fix(String text) => text
      .replaceAll(RegExp(r'\s*\u2014\s*'), ' - ')
      // Hashtags read as marketing; keep the word, drop the "#".
      .replaceAllMapped(RegExp(r'#(\w+)'), (m) => m[1]!)
      .replaceAll(RegExp(r' {2,}'), ' ')
      .trim();
  return post.copyWith(
    body: fix(post.body),
    parts: post.parts?.map(fix).toList(),
    quizExplanation: post.quizExplanation == null
        ? null
        : fix(post.quizExplanation!),
  );
}

final _matter = RegExp(
  r'^(opening|preface|foreword|introduction|introductory|contents|table of contents|'
  r"translator|translator's|editor|editor's|transcriber|note|notes|advertisement|"
  r'dedication|biographical|bibliography|index|appendix|glossary|footnotes|errata|'
  r'list of|illustrations|acknowledg)',
  caseSensitive: false,
);

/// Whether a chapter title looks like front or back matter rather than the
/// work itself.
bool isFrontOrBackMatter(String title) => _matter.hasMatch(title.trim());

class _Passage extends PassageContext {
  _Passage(
    Book book,
    Chapter chapter,
    String text,
    int start,
    int end,
  ) : super(
        book: book,
        chapter: chapter,
        text: text,
        start: start,
        end: end,
      );
}
