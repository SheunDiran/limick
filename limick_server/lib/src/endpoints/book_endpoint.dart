import 'package:serverpod/serverpod.dart';

import '../books/library_service.dart';
import '../feed/affinity.dart';
import '../generated/protocol.dart';
import '../util/current_profile.dart';

/// The catalogue, book profiles and the reader.
class BookEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Searches ~60k public-domain books by title or author. With an empty
  /// query, returns the featured and most active books (optionally by topic).
  Future<List<Book>> search(
    Session session,
    String query,
    Topic? topic,
    int offset,
  ) async {
    final q = query.trim();
    const limit = 30;
    if (q.isEmpty) {
      return Book.db.find(
        session,
        where: (t) =>
            (t.featured.equals(true) | t.status.equals(BookStatus.ready)) &
            (topic == null
                ? Constant.bool(true)
                : t.primaryTopic.equals(topic)),
        orderByList: (t) => [
          t.popularity.desc(),
          t.postCount.desc(),
          t.id.asc(),
        ],
        limit: limit,
        offset: offset,
      );
    }
    final pattern = '%${q.replaceAll('%', '').replaceAll('_', r'\_')}%';
    final rows = await Book.db.find(
      session,
      where: (t) =>
          (t.title.ilike(pattern) |
              t.author.ilike(pattern) |
              t.handle.ilike(pattern)) &
          (topic == null ? Constant.bool(true) : t.primaryTopic.equals(topic)) &
          t.status.notEquals(BookStatus.failed),
      // Books people can read right now first, then featured, then popular.
      orderByList: (t) => [
        t.featured.desc(),
        t.popularity.desc(),
        t.postCount.desc(),
        t.id.asc(),
      ],
      limit: limit,
      offset: offset,
    );
    return rows;
  }

  Future<List<ContinueReading>> continueReading(Session session) async {
    final profile = await currentProfile(session);
    final progress = await ReadingProgress.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
      orderBy: (t) => t.updatedAt.desc(),
      limit: 10,
    );
    if (progress.isEmpty) return [];
    final books = {
      for (final b in await Book.db.find(
        session,
        where: (t) => t.id.inSet(progress.map((p) => p.bookId).toSet()),
      ))
        b.id!: b,
    };
    final result = <ContinueReading>[];
    for (final p in progress) {
      final book = books[p.bookId];
      if (book == null) continue;
      final rows = await session.db.unsafeQuery(
        'SELECT title FROM chapter WHERE "bookId" = @b AND position = @p',
        parameters: QueryParameters.named({
          'b': p.bookId,
          'p': p.chapterPosition,
        }),
      );
      result.add(
        ContinueReading(
          book: book,
          progress: p,
          chapterTitle: rows.isEmpty ? '' : rows.first[0] as String,
        ),
      );
    }
    return result;
  }

  Future<BookDetail> detail(Session session, int bookId) async {
    final profile = await currentProfile(session);
    return _detail(session, profile, await _book(session, bookId));
  }

  Future<BookDetail> byHandle(Session session, String handle) async {
    final profile = await currentProfile(session);
    final book = await Book.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(handle),
    );
    if (book == null) {
      throw AppException(
        message: 'No book called @$handle.',
        code: 'not_found',
      );
    }
    return _detail(session, profile, book);
  }

  Future<BookDetail> _detail(Session session, Reader profile, Book book) async {
    final chapters = <ChapterSummary>[];
    if (book.status == BookStatus.ready) {
      final rows = await session.db.unsafeQuery(
        'SELECT position, title, "wordCount" FROM chapter WHERE "bookId" = @b ORDER BY position',
        parameters: QueryParameters.named({'b': book.id}),
      );
      for (final r in rows) {
        chapters.add(
          ChapterSummary(
            position: r[0] as int,
            title: r[1] as String,
            wordCount: r[2] as int,
          ),
        );
      }
    }
    final follow = await BookFollow.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!) & t.bookId.equals(book.id!),
    );
    final progress = await ReadingProgress.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!) & t.bookId.equals(book.id!),
    );
    final room = await Room.db.findFirstRow(
      session,
      where: (t) => t.bookId.equals(book.id!),
    );
    return BookDetail(
      book: book,
      following: follow != null,
      progress: progress,
      chapters: chapters,
      roomId: room?.id,
    );
  }

  /// Follows a book. Following also queues the book for ingestion and raises
  /// its generation target, so its posts start arriving in the feed.
  Future<Book> setFollowing(Session session, int bookId, bool following) async {
    final profile = await currentProfile(session);
    var book = await _book(session, bookId);
    final existing = await BookFollow.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!) & t.bookId.equals(bookId),
    );
    if (following && existing == null) {
      await BookFollow.db.insertRow(
        session,
        BookFollow(profileId: profile.id!, bookId: bookId),
      );
      await session.db.unsafeExecute(
        'UPDATE book SET "followerCount" = "followerCount" + 1, '
        'popularity = LEAST(popularity + 10, 400) WHERE id = $bookId',
      );
      await Affinity.bump(
        session,
        profileId: profile.id!,
        topic: book.primaryTopic,
        bookId: bookId,
        weight: Signals.follow,
      );
      book = await LibraryService.requestIngest(
        session,
        await _book(session, bookId),
      );
    } else if (!following && existing != null) {
      await BookFollow.db.deleteRow(session, existing);
      await session.db.unsafeExecute(
        'UPDATE book SET "followerCount" = GREATEST("followerCount" - 1, 0) WHERE id = $bookId',
      );
      await Affinity.bump(
        session,
        profileId: profile.id!,
        topic: book.primaryTopic,
        bookId: bookId,
        weight: -Signals.follow,
      );
    }
    return _book(session, bookId);
  }

  /// Asks for a book to be downloaded and prepared for reading.
  Future<Book> prepare(Session session, int bookId) async {
    await currentProfile(session);
    final book = await _book(session, bookId);
    final queued = await LibraryService.requestIngest(session, book);
    if (queued.status == BookStatus.queued) {
      await session.db.unsafeExecute(
        'UPDATE book SET popularity = LEAST(popularity + 8, 400) WHERE id = $bookId',
      );
    }
    return queued;
  }

  /// One chapter of a book. Chapters are cached in memory because readers
  /// page back and forth.
  Future<ChapterContent> chapter(
    Session session,
    int bookId,
    int position,
  ) async {
    await currentProfile(session);
    final key = 'chapter:$bookId:$position';
    final cached = await session.caches.local.get<ChapterContent>(key);
    if (cached != null) return cached;

    final book = await _book(session, bookId);
    if (book.status != BookStatus.ready) {
      throw AppException(
        message: 'This book is still being prepared.',
        code: 'not_ready',
      );
    }
    final chapter = await Chapter.db.findFirstRow(
      session,
      where: (t) => t.bookId.equals(bookId) & t.position.equals(position),
    );
    if (chapter == null) {
      throw AppException(
        message: 'That chapter does not exist.',
        code: 'not_found',
      );
    }
    final content = ChapterContent(
      bookId: bookId,
      position: position,
      title: chapter.title,
      text: chapter.text,
      chapterCount: book.chapterCount,
    );
    await session.caches.local.put(
      key,
      content,
      lifetime: const Duration(minutes: 30),
    );
    return content;
  }

  Future<ReadingProgress> saveProgress(
    Session session,
    int bookId,
    int chapterPosition,
    double scrollFraction,
  ) async {
    final profile = await currentProfile(session);
    final book = await _book(session, bookId);
    final position = chapterPosition.clamp(
      0,
      book.chapterCount > 0 ? book.chapterCount - 1 : 0,
    );
    final fraction = scrollFraction.isNaN
        ? 0.0
        : scrollFraction.clamp(0.0, 1.0);
    final existing = await ReadingProgress.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!) & t.bookId.equals(bookId),
    );
    if (existing == null) {
      // First time opening this book.
      await Affinity.bump(
        session,
        profileId: profile.id!,
        topic: book.primaryTopic,
        bookId: bookId,
        weight: Signals.openBook,
      );
      return ReadingProgress.db.insertRow(
        session,
        ReadingProgress(
          profileId: profile.id!,
          bookId: bookId,
          chapterPosition: position,
          scrollFraction: fraction,
        ),
      );
    }
    return ReadingProgress.db.updateRow(
      session,
      existing.copyWith(
        chapterPosition: position,
        scrollFraction: fraction,
        updatedAt: DateTime.now(),
      ),
    );
  }

  static Future<Book> _book(Session session, int bookId) async {
    final book = await Book.db.findById(session, bookId);
    if (book == null) {
      throw AppException(
        message: 'This book could not be found.',
        code: 'not_found',
      );
    }
    return book;
  }
}
