import 'package:serverpod/serverpod.dart';

import '../feed/affinity.dart';
import '../feed/feed_service.dart';
import '../generated/protocol.dart';
import '../util/current_profile.dart';
import 'profile_endpoint.dart';

/// Feeds and every interaction with a post.
class FeedEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// The personalised feed. [excludeIds] are posts already shown in this
  /// session, so paging never repeats a card.
  Future<FeedPage> forYou(Session session, List<int> excludeIds) async {
    final profile = await currentProfile(session);
    return FeedService.forYou(session, profile, excludeIds: excludeIds);
  }

  Future<FeedPage> following(Session session, int? beforeId) async {
    final profile = await currentProfile(session);
    return FeedService.following(session, profile.id!, beforeId: beforeId);
  }

  Future<FeedItem> post(Session session, int postId) async {
    final profile = await currentProfile(session);
    final post = await _post(session, postId);
    return (await FeedService.decorate(session, profile.id!, [post])).first;
  }

  /// A book's own timeline, in reading order.
  Future<FeedPage> bookPosts(Session session, int bookId, int? afterId) async {
    final profile = await currentProfile(session);
    const limit = 15;
    final posts = await Post.db.find(
      session,
      where: (t) =>
          t.bookId.equals(bookId) &
          (afterId == null ? Constant.bool(true) : t.id > afterId),
      orderBy: (t) => t.id,
      limit: limit,
    );
    return FeedPage(
      items: await FeedService.decorate(session, profile.id!, posts),
      hasMore: posts.length == limit,
    );
  }

  Future<FeedPage> saved(Session session, int? beforeSaveId) async {
    final profile = await currentProfile(session);
    const limit = 20;
    final saves = await PostSave.db.find(
      session,
      where: (t) =>
          t.profileId.equals(profile.id!) &
          (beforeSaveId == null ? Constant.bool(true) : t.id < beforeSaveId),
      orderBy: (t) => t.id.desc(),
      limit: limit,
    );
    final posts = await Post.db.find(
      session,
      where: (t) => t.id.inSet(saves.map((s) => s.postId).toSet()),
    );
    final byId = {for (final p in posts) p.id!: p};
    final ordered = saves.map((s) => byId[s.postId]).whereType<Post>().toList();
    return FeedPage(
      items: await FeedService.decorate(session, profile.id!, ordered),
      hasMore: saves.length == limit,
    );
  }

  /// Dwell times from the client. These teach the ranking what the user
  /// actually reads, and mark posts as seen.
  Future<void> recordViews(Session session, List<ViewSignal> views) async {
    if (views.isEmpty) return;
    final profile = await currentProfile(session);
    await touchStreak(session, profile);
    final signals = views.take(100).where((v) => v.dwellMs >= 0).toList();
    final posts = {
      for (final p in await Post.db.find(
        session,
        where: (t) => t.id.inSet(signals.map((s) => s.postId).toSet()),
      ))
        p.id!: p,
    };
    for (final view in signals) {
      final post = posts[view.postId];
      if (post == null) continue;
      final dwell = view.dwellMs.clamp(0, 10 * 60 * 1000);
      await session.db.unsafeExecute(
        '''
INSERT INTO post_view ("profileId", "postId", "dwellMs", "createdAt")
VALUES (@profileId, @postId, @dwell, @now)
ON CONFLICT ("profileId", "postId")
DO UPDATE SET "dwellMs" = GREATEST(post_view."dwellMs", @dwell)''',
        parameters: QueryParameters.named({
          'profileId': profile.id,
          'postId': post.id,
          'dwell': dwell,
          'now': DateTime.now().toUtc(),
        }),
      );
      final weight = dwell >= 6000
          ? Signals.longRead
          : dwell >= 2500
          ? Signals.read
          : dwell < 900
          ? Signals.fastSkip
          : 0.0;
      if (weight != 0) {
        await Affinity.forPost(session, profile.id!, post, weight);
      }
    }
  }

  Future<int> setLiked(Session session, int postId, bool liked) async {
    final profile = await currentProfile(session);
    final post = await _post(session, postId);
    final existing = await PostLike.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!) & t.postId.equals(postId),
    );
    if (liked && existing == null) {
      await PostLike.db.insertRow(
        session,
        PostLike(profileId: profile.id!, postId: postId),
      );
      await Affinity.forPost(session, profile.id!, post, Signals.like);
      return _bump(session, postId, 'likeCount', 1);
    }
    if (!liked && existing != null) {
      await PostLike.db.deleteRow(session, existing);
      await Affinity.forPost(session, profile.id!, post, -Signals.like);
      return _bump(session, postId, 'likeCount', -1);
    }
    return post.likeCount;
  }

  Future<bool> setSaved(Session session, int postId, bool saved) async {
    final profile = await currentProfile(session);
    final post = await _post(session, postId);
    final existing = await PostSave.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!) & t.postId.equals(postId),
    );
    if (saved && existing == null) {
      await PostSave.db.insertRow(
        session,
        PostSave(profileId: profile.id!, postId: postId),
      );
      await Affinity.forPost(session, profile.id!, post, Signals.save);
      await _bump(session, postId, 'saveCount', 1);
    } else if (!saved && existing != null) {
      await PostSave.db.deleteRow(session, existing);
      await _bump(session, postId, 'saveCount', -1);
    }
    return saved;
  }

  Future<QuizResult> answerQuiz(
    Session session,
    int postId,
    int choiceIndex,
  ) async {
    final profile = await currentProfile(session);
    final post = await _post(session, postId);
    final options = post.quizOptions;
    final answer = post.quizAnswerIndex;
    if (post.kind != PostKind.quiz || options == null || answer == null) {
      throw AppException(message: 'This post is not a quiz.', code: 'invalid');
    }
    if (choiceIndex < 0 || choiceIndex >= options.length) {
      throw AppException(message: 'Pick one of the options.', code: 'invalid');
    }
    final existing = await QuizAnswer.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!) & t.postId.equals(postId),
    );
    // The first answer counts; changing your mind afterwards doesn't.
    var count = post.quizAnswerCount;
    var choice = choiceIndex;
    if (existing == null) {
      await QuizAnswer.db.insertRow(
        session,
        QuizAnswer(
          profileId: profile.id!,
          postId: postId,
          choiceIndex: choiceIndex,
          correct: choiceIndex == answer,
        ),
      );
      count = await _bump(session, postId, 'quizAnswerCount', 1);
      await Affinity.forPost(session, profile.id!, post, Signals.quiz);
    } else {
      choice = existing.choiceIndex;
    }
    final counts =
        (await FeedService.quizCounts(session, {postId}))[postId] ?? {};
    return QuizResult(
      correct: choice == answer,
      correctIndex: answer,
      explanation: post.quizExplanation ?? '',
      answerCount: count,
      counts: List.generate(options.length, (i) => counts[i] ?? 0),
    );
  }

  /// Records an agree/disagree vote and returns the post with fresh counts
  /// and both sides of the argument.
  Future<FeedItem> vote(Session session, int postId, bool agree) async {
    final profile = await currentProfile(session);
    final post = await _post(session, postId);
    if (post.kind != PostKind.debate) {
      throw AppException(
        message: 'This post is not a debate.',
        code: 'invalid',
      );
    }
    final existing = await DebateVote.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!) & t.postId.equals(postId),
    );
    if (existing == null) {
      await DebateVote.db.insertRow(
        session,
        DebateVote(profileId: profile.id!, postId: postId, agree: agree),
      );
      await _bump(session, postId, agree ? 'agreeCount' : 'disagreeCount', 1);
      await Affinity.forPost(session, profile.id!, post, Signals.vote);
    } else if (existing.agree != agree) {
      await DebateVote.db.updateRow(session, existing.copyWith(agree: agree));
      await _bump(session, postId, agree ? 'agreeCount' : 'disagreeCount', 1);
      await _bump(session, postId, agree ? 'disagreeCount' : 'agreeCount', -1);
    }
    final fresh = await _post(session, postId);
    return (await FeedService.decorate(session, profile.id!, [fresh])).first;
  }

  /// The strongest interest signal: the user went from a post to the book.
  Future<void> openedBook(Session session, int postId) async {
    final profile = await currentProfile(session);
    final post = await _post(session, postId);
    await Affinity.forPost(session, profile.id!, post, Signals.openBook);
  }

  static Future<Post> _post(Session session, int postId) async {
    final post = await Post.db.findById(session, postId);
    if (post == null) {
      throw AppException(
        message: 'This post is no longer available.',
        code: 'not_found',
      );
    }
    return post;
  }

  /// Atomically changes a counter and returns its new value.
  static Future<int> _bump(
    Session session,
    int postId,
    String column,
    int delta,
  ) async {
    final result = await session.db.unsafeQuery(
      'UPDATE post SET "$column" = GREATEST("$column" + @delta, 0) WHERE id = @id RETURNING "$column"',
      parameters: QueryParameters.named({'delta': delta, 'id': postId}),
    );
    return result.isEmpty ? 0 : result.first[0] as int;
  }
}
