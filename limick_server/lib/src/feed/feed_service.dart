import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../books/library_service.dart';
import '../generated/protocol.dart';
import 'affinity.dart';

/// Builds personalised feeds and decorates posts with the viewer's state.
class FeedService {
  static final _random = Random();

  /// The "For you" feed.
  ///
  /// 1. Candidates: unseen posts from books and topics the user cares about,
  ///    the next unread posts of books they are into, and random exploration.
  /// 2. Score: topic and book affinity, follows, freshness, engagement and a
  ///    little noise so the feed never feels static.
  /// 3. Select greedily with diversity rules: no book twice within three
  ///    cards, no two identical post kinds in a row, and a regular slot for
  ///    something outside the user's usual topics.
  static Future<FeedPage> forYou(
    Session session,
    Reader profile, {
    required List<int> excludeIds,
    int limit = 12,
  }) async {
    final profileId = profile.id!;
    final topicScores = await Affinity.topics(session, profileId);
    final bookScores = await Affinity.books(session, profileId);
    final follows = (await BookFollow.db.find(
      session,
      where: (t) => t.profileId.equals(profileId),
    )).map((f) => f.bookId).toSet();

    final topTopics =
        (topicScores.entries.where((e) => e.value > 0).toList()
              ..sort((a, b) => b.value.compareTo(a.value)))
            .take(6)
            .map((e) => e.key)
            .toList();
    final topBooks =
        (bookScores.entries.where((e) => e.value > 0).toList()
              ..sort((a, b) => b.value.compareTo(a.value)))
            .take(12)
            .map((e) => e.key)
            .toSet()
          ..addAll(follows);

    final exclude = excludeIds.take(500).toList();
    final excludeSql = exclude.isEmpty
        ? ''
        : 'AND p.id NOT IN (${exclude.join(',')})';
    const unseen =
        'NOT EXISTS (SELECT 1 FROM post_view v WHERE v."postId" = p.id AND v."profileId" = @profileId)';

    Future<List<int>> ids(String where, String order, int take) async {
      final result = await session.db.unsafeQuery(
        'SELECT p.id FROM post p WHERE $unseen $excludeSql AND ($where) ORDER BY $order LIMIT $take',
        parameters: QueryParameters.named({'profileId': profileId}),
      );
      return result.map((r) => r[0] as int).toList();
    }

    final interestWhere = [
      if (topBooks.isNotEmpty) 'p."bookId" IN (${topBooks.join(',')})',
      if (topTopics.isNotEmpty)
        'p."primaryTopic" IN (${topTopics.map((t) => "'${t.name}'").join(',')})',
    ].join(' OR ');
    final interested = interestWhere.isEmpty
        ? <int>[]
        : await ids(interestWhere, 'random()', 160);
    final explore = await ids('TRUE', 'random()', 60);

    // The next unread posts of the books the user is most into, in order,
    // so scrolling can turn into reading a book from start to finish.
    final continueIds = <int>{};
    final serialBooks =
        (bookScores.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value)))
            .where((e) => e.value >= 2)
            .take(3)
            .map((e) => e.key);
    for (final bookId in serialBooks) {
      continueIds.addAll(await ids('p."bookId" = $bookId', 'p.id ASC', 2));
    }

    final candidateIds = {...interested, ...explore, ...continueIds};
    final posts = candidateIds.isEmpty
        ? <Post>[]
        : await Post.db.find(session, where: (t) => t.id.inSet(candidateIds));

    final maxTopic = topicScores.values.fold<double>(1, max);
    final maxBook = bookScores.values.fold<double>(1, max);
    final now = DateTime.now();
    final scored = <({Post post, double score, bool explore})>[];
    for (final post in posts) {
      final topic = (topicScores[post.primaryTopic] ?? 0) / maxTopic;
      final book = (bookScores[post.bookId] ?? 0) / maxBook;
      final ageHours = now.difference(post.createdAt).inMinutes / 60;
      final engagement = log(1 + post.likeCount + 2 * post.commentCount);
      final score =
          topic +
          0.7 * book +
          (follows.contains(post.bookId) ? 0.5 : 0) +
          (continueIds.contains(post.id) ? 0.45 : 0) +
          0.2 * exp(-ageHours / 72) +
          0.08 * engagement +
          0.35 * _random.nextDouble();
      final isExplore = topic <= 0.05 && !follows.contains(post.bookId);
      scored.add((post: post, score: score, explore: isExplore));
    }
    scored.sort((a, b) => b.score.compareTo(a.score));

    final picked = <({Post post, double score, bool explore})>[];
    final remaining = [...scored];
    while (picked.length < limit && remaining.isNotEmpty) {
      final wantExplore = picked.length % 6 == 5;
      final recentBooks = picked.reversed
          .take(2)
          .map((p) => p.post.bookId)
          .toSet();
      final lastKind = picked.isEmpty ? null : picked.last.post.kind;
      int index = -1;
      if (wantExplore) index = remaining.indexWhere((c) => c.explore);
      if (index < 0) {
        index = remaining.indexWhere(
          (c) =>
              !recentBooks.contains(c.post.bookId) && c.post.kind != lastKind,
        );
      }
      if (index < 0) {
        index = remaining.indexWhere(
          (c) => !recentBooks.contains(c.post.bookId),
        );
      }
      if (index < 0) index = 0;
      picked.add(remaining.removeAt(index));
    }

    final reasons = <int, String>{};
    final fieldTopics = topicsForField(profile.field);
    for (final c in picked) {
      final post = c.post;
      if (continueIds.contains(post.id)) {
        reasons[post.id!] = 'continue';
      } else if (follows.contains(post.bookId)) {
        reasons[post.id!] = 'following';
      } else if (fieldTopics.contains(post.primaryTopic) &&
          profile.field != null) {
        reasons[post.id!] = 'For your ${profile.field}';
      } else if (profile.interests.contains(post.primaryTopic) ||
          topTopics.contains(post.primaryTopic)) {
        reasons[post.id!] = 'Because you like ${topicLabel(post.primaryTopic)}';
      } else if (c.explore) {
        reasons[post.id!] = 'Something new';
      }
    }

    final items = await decorate(
      session,
      profileId,
      picked.map((c) => c.post).toList(),
      reasons: reasons,
    );

    // Slip a word review into the feed when one is due.
    final due = await SavedWord.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profileId) & (t.dueAt <= DateTime.now()),
      orderBy: (t) => t.dueAt,
    );
    if (due != null && items.length >= 6 && _random.nextDouble() < 0.6) {
      items.insert(5, FeedItem(kind: FeedItemKind.review, review: due));
    }

    // Running low: ask the generator to focus on this user's books.
    final lowOnPosts = scored.length < limit * 3;
    if (lowOnPosts) await _boostBooks(session, topBooks, topTopics);

    return FeedPage(
      items: items,
      hasMore: scored.length > picked.length || lowOnPosts,
      generating: lowOnPosts,
    );
  }

  /// Raises the generation target for the books this user wants more of.
  static Future<void> _boostBooks(
    Session session,
    Set<int> books,
    List<Topic> topics,
  ) async {
    var targets = books.take(6).toList();
    if (targets.length < 3 && topics.isNotEmpty) {
      final extra = await Book.db.find(
        session,
        where: (t) =>
            t.status.equals(BookStatus.ready) &
            t.primaryTopic.inSet(topics.toSet()),
        orderBy: (t) => t.postCount,
        limit: 4,
      );
      targets = [...targets, ...extra.map((b) => b.id!)];
    }
    if (targets.isEmpty) return;
    await session.db.unsafeExecute(
      'UPDATE book SET popularity = LEAST(popularity + 6, 400) WHERE id IN (${targets.join(',')})',
    );
  }

  /// Posts from books the user follows, newest first.
  static Future<FeedPage> following(
    Session session,
    int profileId, {
    int? beforeId,
    int limit = 15,
  }) async {
    final follows = (await BookFollow.db.find(
      session,
      where: (t) => t.profileId.equals(profileId),
    )).map((f) => f.bookId).toSet();
    if (follows.isEmpty) return FeedPage(items: [], hasMore: false);
    final posts = await Post.db.find(
      session,
      where: (t) =>
          t.bookId.inSet(follows) &
          (beforeId == null ? Constant.bool(true) : t.id < beforeId),
      orderBy: (t) => t.id.desc(),
      limit: limit,
    );
    return FeedPage(
      items: await decorate(session, profileId, posts),
      hasMore: posts.length == limit,
    );
  }

  /// Attaches the book, chapter title and the viewer's own state to posts.
  static Future<List<FeedItem>> decorate(
    Session session,
    int profileId,
    List<Post> posts, {
    Map<int, String> reasons = const {},
  }) async {
    if (posts.isEmpty) return [];
    final postIds = posts.map((p) => p.id!).toSet();
    final bookIds = posts.map((p) => p.bookId).toSet();
    final chapterIds = posts.map((p) => p.chapterId).toSet();

    final books = {
      for (final b in await Book.db.find(
        session,
        where: (t) => t.id.inSet(bookIds),
      ))
        b.id!: b,
    };
    final titles = <int, String>{};
    final titleRows = await session.db.unsafeQuery(
      'SELECT id, title FROM chapter WHERE id IN (${chapterIds.join(',')})',
    );
    for (final row in titleRows) {
      titles[row[0] as int] = row[1] as String;
    }
    final liked = (await PostLike.db.find(
      session,
      where: (t) => t.profileId.equals(profileId) & t.postId.inSet(postIds),
    )).map((r) => r.postId).toSet();
    final saved = (await PostSave.db.find(
      session,
      where: (t) => t.profileId.equals(profileId) & t.postId.inSet(postIds),
    )).map((r) => r.postId).toSet();
    final answers = {
      for (final a in await QuizAnswer.db.find(
        session,
        where: (t) => t.profileId.equals(profileId) & t.postId.inSet(postIds),
      ))
        a.postId: a,
    };
    final votes = {
      for (final v in await DebateVote.db.find(
        session,
        where: (t) => t.profileId.equals(profileId) & t.postId.inSet(postIds),
      ))
        v.postId: v.agree,
    };
    final follows = (await BookFollow.db.find(
      session,
      where: (t) => t.profileId.equals(profileId) & t.bookId.inSet(bookIds),
    )).map((f) => f.bookId).toSet();

    final items = <FeedItem>[];
    for (final post in posts) {
      final book = books[post.bookId];
      if (book == null) continue;
      final answer = answers[post.id];
      var reason = reasons[post.id];
      if (reason == 'continue') reason = 'Continue ${book.title}';
      if (reason == 'following') reason = 'You follow @${book.handle}';
      items.add(
        FeedItem(
          kind: FeedItemKind.post,
          post: post,
          book: book,
          chapterTitle: titles[post.chapterId],
          liked: liked.contains(post.id),
          saved: saved.contains(post.id),
          followingBook: follows.contains(post.bookId),
          quizChoice: answer?.choiceIndex,
          quizCorrectIndex: answer == null ? null : post.quizAnswerIndex,
          // Answers and the two sides of a debate are revealed after the
          // reader has committed to a choice.
          quizExplanation: answer != null || votes.containsKey(post.id)
              ? post.quizExplanation
              : null,
          debateVote: votes[post.id],
          reason: reason,
        ),
      );
    }
    return items;
  }
}
