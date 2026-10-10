import 'package:serverpod/serverpod.dart';

import '../books/library_service.dart';
import '../endpoints/room_endpoint.dart';
import '../generated/protocol.dart';
import '../util/current_profile.dart';

/// The official @limick account: a welcome post, how-to tips, daily posts
/// built from real data, and room welcomes and prompts.
///
/// Nothing here invents activity. Daily posts point at real books and real
/// generated posts, and the weekly digest only reports counts from the
/// database (and is skipped when there is nothing to report).
class OfficialService {
  static const handle = 'limick';
  static const _questionPrefix = 'Question of the day';

  static Future<Reader> account(Session session) async {
    final existing = await Reader.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(handle) | t.official.equals(true),
    );
    if (existing != null) {
      if (!existing.official) {
        return Reader.db.updateRow(
          session,
          existing.copyWith(official: true),
        );
      }
      return existing;
    }
    return Reader.db.insertRow(
      session,
      Reader(
        authUserId: null,
        handle: handle,
        displayName: 'Limick',
        bio:
            'The official Limick account. Book picks, words of the day and tips.',
        interests: const [Topic.education],
        onboarded: true,
        official: true,
        avatarHue: 16,
      ),
    );
  }

  static String dayKey([DateTime? at]) {
    final d = (at ?? DateTime.now()).toUtc();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  /// Creates the account, the welcome post, the tips and room welcomes.
  /// Safe to run on every boot.
  static Future<void> seed(Session session) async {
    final official = await account(session);

    final existing = await OfficialPost.db.find(
      session,
      where: (t) =>
          t.kind.equals(OfficialPostKind.welcome) |
          t.kind.equals(OfficialPostKind.tip),
    );
    final titles = existing.map((p) => p.title).toSet();
    final posts = [
      OfficialPost(
        kind: OfficialPostKind.welcome,
        title: 'Welcome to Limick',
        body:
            'Scroll the way you always do, except every post here is written from a real book: '
            'medicine, law, science, philosophy, history and the great novels. '
            'Each one teaches you something, and each one links to the page it came from.',
        action: 'openDiscover',
        actionLabel: 'Browse the library',
      ),
      OfficialPost(
        kind: OfficialPostKind.tip,
        position: 1,
        title: 'Every post has a source',
        body:
            'Tap Read on any post to open the exact chapter it came from, with the passage highlighted. '
            'Or start the book from the beginning. Limick saves your place.',
      ),
      OfficialPost(
        kind: OfficialPostKind.tip,
        position: 2,
        title: 'Ask the book',
        body:
            'Leave a question in the comments of any post and the book itself answers, '
            'using only its own text. Answers are written by AI and marked as such.',
      ),
      OfficialPost(
        kind: OfficialPostKind.tip,
        position: 3,
        title: 'Take a break that ends',
        body:
            'Start a study break and scroll as much as you like. When the time is up, '
            'Limick tells you what you learned and sends you back to work.',
        action: 'startBreak',
        actionLabel: 'Start a break',
      ),
      OfficialPost(
        kind: OfficialPostKind.tip,
        position: 4,
        title: 'Keep the words you learn',
        body:
            'Word posts have a Save button. Saved words come back as quick review cards '
            'just before you would forget them.',
        action: 'openWords',
        actionLabel: 'Open word bank',
      ),
      OfficialPost(
        kind: OfficialPostKind.tip,
        position: 5,
        title: 'Find your people',
        body:
            'Rooms are live chats for each subject, and every book has its own book club. '
            'Join the ones you study.',
        action: 'openRooms',
        actionLabel: 'See rooms',
      ),
    ].where((p) => !titles.contains(p.title)).toList();
    if (posts.isNotEmpty) await OfficialPost.db.insert(session, posts);

    // A welcome message in every room that has never had one.
    final rooms = await Room.db.find(
      session,
      where: (t) => t.messageCount.equals(0),
    );
    for (final room in rooms) {
      await _postInRoom(
        session,
        official,
        room,
        'Welcome to ${room.name}. ${room.description} '
        'Share what you are reading, ask questions, or argue with an old idea. Be kind.',
      );
    }
  }

  /// Publishes today's daily posts and room prompts, once per day.
  static Future<void> publishDaily(Session session) async {
    final today = dayKey();
    await _bookOfTheDay(session, today);
    await _wordOfTheDay(session, today);
    await _weeklyDigest(session, today);
    await _roomPrompts(session, today);
  }

  static Future<bool> _published(
    Session session,
    OfficialPostKind kind,
    String day,
  ) async =>
      await OfficialPost.db.findFirstRow(
        session,
        where: (t) => t.kind.equals(kind) & t.day.equals(day),
      ) !=
      null;

  static Future<void> _insertOnce(Session session, OfficialPost post) async {
    try {
      await OfficialPost.db.insertRow(session, post);
    } on DatabaseException {
      // Another server published it first (unique kind + day).
    }
  }

  static Future<void> _bookOfTheDay(Session session, String today) async {
    if (await _published(session, OfficialPostKind.bookOfTheDay, today)) return;
    final recent = await OfficialPost.db.find(
      session,
      where: (t) =>
          t.kind.equals(OfficialPostKind.bookOfTheDay) &
          (t.createdAt > DateTime.now().subtract(const Duration(days: 45))),
    );
    final used = recent.map((p) => p.bookId).whereType<int>().toSet();
    final candidates = await Book.db.find(
      session,
      where: (t) =>
          t.status.equals(BookStatus.ready) &
          (t.postCount >= 3) &
          t.featured.equals(true),
      orderByList: (t) => [t.followerCount.desc(), t.postCount.desc()],
      limit: 120,
    );
    final pool = candidates.where((b) => !used.contains(b.id)).toList();
    if (pool.isEmpty) return;
    // Deterministic per day, so restarts don't change the pick.
    final book = pool[today.hashCode.abs() % pool.length];
    final hours = book.wordCount / 250 / 60;
    final years = book.authorYears == null ? '' : ' (${book.authorYears})';
    await _insertOnce(
      session,
      OfficialPost(
        kind: OfficialPostKind.bookOfTheDay,
        day: today,
        title: 'Book of the day: ${book.title}',
        body: [
          'by ${book.author}$years · ${topicLabel(book.primaryTopic)}',
          if (book.blurb != null) book.blurb!,
          '${book.chapterCount} chapters, about ${hours < 1 ? '${(hours * 60).round()} minutes' : '${hours.toStringAsFixed(1)} hours'} of reading.',
        ].join('\n\n'),
        bookId: book.id,
        action: 'openBook',
        actionLabel: 'Open the book',
      ),
    );
  }

  static Future<void> _wordOfTheDay(Session session, String today) async {
    if (await _published(session, OfficialPostKind.wordOfTheDay, today)) return;
    final used = (await OfficialPost.db.find(
      session,
      where: (t) => t.kind.equals(OfficialPostKind.wordOfTheDay),
    )).map((p) => p.postId).whereType<int>().toSet();
    final words = await Post.db.find(
      session,
      where: (t) => t.kind.equals(PostKind.word),
      orderByList: (t) => [t.likeCount.desc(), t.saveCount.desc(), t.id.desc()],
      limit: 50,
    );
    final post = words.where((w) => !used.contains(w.id)).firstOrNull;
    if (post == null) return;
    final book = await Book.db.findById(session, post.bookId);
    final pos = (post.wordPartOfSpeech ?? '').isEmpty
        ? ''
        : '${post.wordPartOfSpeech}. ';
    await _insertOnce(
      session,
      OfficialPost(
        kind: OfficialPostKind.wordOfTheDay,
        day: today,
        title: 'Word of the day: ${post.word}',
        body:
            '$pos${post.wordDefinition}${book == null ? '' : '\n\nFound in ${book.title}.'}',
        postId: post.id,
        bookId: post.bookId,
        action: 'openPost',
        actionLabel: 'See it in context',
      ),
    );
  }

  /// Once a week, real numbers from the past seven days. Skipped when there
  /// is nothing worth reporting.
  static Future<void> _weeklyDigest(Session session, String today) async {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final last = await OfficialPost.db.findFirstRow(
      session,
      where: (t) => t.kind.equals(OfficialPostKind.weeklyDigest),
      orderBy: (t) => t.createdAt.desc(),
    );
    if (last != null && last.createdAt.isAfter(weekAgo)) return;

    final posts = await Post.db.count(
      session,
      where: (t) => t.createdAt > weekAgo,
    );
    final booksWithPosts = await session.db.unsafeQuery(
      'SELECT COUNT(DISTINCT "bookId") FROM post WHERE "createdAt" > @since',
      parameters: QueryParameters.named({'since': weekAgo.toUtc()}),
    );
    final bookCount = booksWithPosts.first[0] as int;
    final answers = await QuizAnswer.db.count(
      session,
      where: (t) => t.createdAt > weekAgo,
    );
    final comments = await Comment.db.count(
      session,
      where: (t) => (t.createdAt > weekAgo) & t.asBookId.equals(null),
    );
    final readers = await Reader.db.count(
      session,
      where: (t) => (t.createdAt > weekAgo) & t.official.equals(false),
    );
    if (posts < 10) return;

    final lines = [
      '$posts new posts written from $bookCount books.',
      if (answers > 0) '$answers quiz answers.',
      if (comments > 0) '$comments comments.',
      if (readers > 0) '$readers new readers joined.',
    ];
    final top = await Book.db.findFirstRow(
      session,
      where: (t) => t.followerCount > 0,
      orderBy: (t) => t.followerCount.desc(),
    );
    if (top != null) lines.add('Most followed: ${top.title}.');
    await _insertOnce(
      session,
      OfficialPost(
        kind: OfficialPostKind.weeklyDigest,
        day: today,
        title: 'This week on Limick',
        body: lines.join('\n'),
        bookId: top?.id,
        action: top == null ? null : 'openBook',
        actionLabel: top == null ? null : 'Open ${top.title}',
      ),
    );
  }

  /// A "question of the day" in each topic room, taken from a real debate
  /// post on that topic.
  static Future<void> _roomPrompts(Session session, String today) async {
    final official = await account(session);
    final rooms = await Room.db.find(
      session,
      where: (t) => t.topic.notEquals(null),
    );
    final startOfDay = DateTime.parse('${today}T00:00:00Z');
    for (final room in rooms) {
      final postedToday = await RoomMessage.db.count(
        session,
        where: (t) =>
            t.roomId.equals(room.id!) &
            t.profileId.equals(official.id!) &
            t.body.like('$_questionPrefix%') &
            (t.createdAt >= startOfDay),
      );
      if (postedToday > 0) continue;
      final debates = await Post.db.find(
        session,
        where: (t) =>
            t.kind.equals(PostKind.debate) & t.primaryTopic.equals(room.topic!),
        orderBy: (t) => t.id.desc(),
        limit: 30,
      );
      if (debates.isEmpty) continue;
      final post = debates[(today.hashCode ^ room.id!).abs() % debates.length];
      final book = await Book.db.findById(session, post.bookId);
      if (book == null) continue;
      await _postInRoom(
        session,
        official,
        room,
        '$_questionPrefix, from ${book.title} by ${book.author}:\n\n${post.body}',
      );
    }
  }

  static Future<void> _postInRoom(
    Session session,
    Reader official,
    Room room,
    String body,
  ) async {
    final message = await RoomMessage.db.insertRow(
      session,
      RoomMessage(roomId: room.id!, profileId: official.id!, body: body),
    );
    await session.db.unsafeExecute(
      'UPDATE room SET "messageCount" = "messageCount" + 1, "lastMessageAt" = @now WHERE id = ${room.id}',
      parameters: QueryParameters.named({'now': DateTime.now().toUtc()}),
    );
    await session.messages.postMessage(
      RoomEndpoint.channel(room.id!),
      RoomEvent(
        type: LiveEventType.added,
        roomId: room.id!,
        message: RoomMessageView(message: message, author: authorOf(official)),
      ),
    );
  }

  /// The next official post this reader hasn't seen: the welcome first, then
  /// today's daily posts, then tips in order. Marks it as seen.
  static Future<OfficialPost?> nextFor(Session session, int profileId) async {
    final seen = (await OfficialSeen.db.find(
      session,
      where: (t) => t.profileId.equals(profileId),
    )).map((s) => s.officialPostId).toSet();
    final recent = DateTime.now().subtract(const Duration(hours: 36));
    final candidates = await OfficialPost.db.find(
      session,
      where: (t) =>
          t.kind.equals(OfficialPostKind.welcome) |
          t.kind.equals(OfficialPostKind.tip) |
          (t.createdAt > recent),
      orderBy: (t) => t.id,
    );
    int rank(OfficialPost p) => switch (p.kind) {
      OfficialPostKind.welcome => 0,
      OfficialPostKind.bookOfTheDay => 1,
      OfficialPostKind.wordOfTheDay => 2,
      OfficialPostKind.weeklyDigest => 3,
      OfficialPostKind.tip => 10 + p.position,
    };
    final next = candidates.where((p) => !seen.contains(p.id)).toList()
      ..sort((a, b) => rank(a).compareTo(rank(b)));
    final post = next.firstOrNull;
    if (post == null) return null;
    try {
      await OfficialSeen.db.insertRow(
        session,
        OfficialSeen(profileId: profileId, officialPostId: post.id!),
      );
    } on DatabaseException {
      // Seen concurrently; showing it once more is harmless.
    }
    return post;
  }
}
