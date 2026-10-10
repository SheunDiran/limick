import 'package:serverpod/serverpod.dart';

import '../feed/affinity.dart';
import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import '../official/book_replies.dart';
import '../official/official_service.dart';
import '../util/current_profile.dart';
import '../util/text.dart';

/// Comment threads under posts, with live updates.
class CommentEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static String channel(int postId) => 'comments-$postId';

  /// All comments for a post: top level by popularity, replies in order.
  Future<List<CommentView>> list(Session session, int postId) async {
    final profile = await currentProfile(session);
    final blocked = await blockedIds(session, profile.id!);
    final comments = await Comment.db.find(
      session,
      where: (t) => t.postId.equals(postId),
      orderBy: (t) => t.createdAt,
      limit: 300,
    );
    final visible = comments
        .where((c) => !blocked.contains(c.profileId))
        .toList();
    final views = await _views(session, profile.id!, visible);
    final top =
        views
            .where(
              (v) =>
                  v.comment.parentId == null ||
                  !views.any((p) => p.comment.id == v.comment.parentId),
            )
            .toList()
          ..sort((a, b) {
            final byLikes = b.comment.likeCount.compareTo(a.comment.likeCount);
            return byLikes != 0
                ? byLikes
                : a.comment.createdAt.compareTo(b.comment.createdAt);
          });
    final ordered = <CommentView>[];
    for (final parent in top) {
      if (parent.comment.deleted && parent.comment.replyCount == 0) continue;
      ordered.add(parent);
      ordered.addAll(
        views.where(
          (v) => v.comment.parentId == parent.comment.id && !v.comment.deleted,
        ),
      );
    }
    return ordered;
  }

  Future<CommentView> add(
    Session session,
    int postId,
    String body,
    int? parentId,
  ) async {
    final profile = await currentProfile(session);
    final text = maskProfanity(cleanUserText(body, maxLength: 1000));
    if (text.isEmpty) {
      throw AppException(message: 'Write something first.', code: 'invalid');
    }
    await rateLimit(
      session,
      action: 'comment',
      profileId: profile.id!,
      window: const Duration(seconds: 3),
    );
    final post = await Post.db.findById(session, postId);
    if (post == null) {
      throw AppException(message: 'This post is gone.', code: 'not_found');
    }

    int? parent;
    Comment? parentComment;
    if (parentId != null) {
      parentComment = await Comment.db.findById(session, parentId);
      if (parentComment == null || parentComment.postId != postId) {
        throw AppException(message: 'That comment is gone.', code: 'not_found');
      }
      // Threads are one level deep: replying to a reply joins its thread.
      parent = parentComment.parentId ?? parentComment.id;
    }
    final comment = await Comment.db.insertRow(
      session,
      Comment(
        postId: postId,
        profileId: profile.id!,
        parentId: parent,
        body: text,
      ),
    );
    await session.db.unsafeExecute(
      'UPDATE post SET "commentCount" = "commentCount" + 1 WHERE id = $postId',
    );
    if (parent != null) {
      await session.db.unsafeExecute(
        'UPDATE comment SET "replyCount" = "replyCount" + 1 WHERE id = $parent',
      );
    }
    await Affinity.forPost(session, profile.id!, post, Signals.comment);

    // Notify parent author on replies, unless self-reply or blocked.
    if (parentComment != null && parentComment.profileId != profile.id!) {
      final blocked = await blockedIds(session, parentComment.profileId);
      if (!blocked.contains(profile.id!)) {
        await ReaderNotification.db.insertRow(
          session,
          ReaderNotification(
            profileId: parentComment.profileId,
            actorName: profile.displayName,
            actorHandle: profile.handle,
            kind: NotificationKind.reply,
            postId: postId,
            commentId: comment.id,
          ),
        );
      }
    }

    // Questions to the book get an answer from the book, in the background.
    final book = await Book.db.findById(session, post.bookId);
    if (book != null &&
        BookReplies.wants(comment, book, parent: parentComment) &&
        BookReplies.allow(profile.id!)) {
      await Serverpod.instance.futureCalls
          .callWithDelay(const Duration(seconds: 1))
          .bookReply
          .reply(comment.id!);
    }

    final view = CommentView(comment: comment, author: authorOf(profile));
    await session.messages.postMessage(
      channel(postId),
      CommentEvent(type: LiveEventType.added, postId: postId, comment: view),
    );
    return view;
  }

  Future<void> delete(Session session, int commentId) async {
    final profile = await currentProfile(session);
    final comment = await Comment.db.findById(session, commentId);
    if (comment == null) return;
    if (comment.profileId != profile.id) {
      throw AppException(
        message: 'You can only delete your own comments.',
        code: 'forbidden',
      );
    }
    if (comment.replyCount > 0) {
      // Keep the thread readable: blank the comment but keep its replies.
      await Comment.db.updateRow(
        session,
        comment.copyWith(deleted: true, body: ''),
      );
    } else {
      await Comment.db.deleteRow(session, comment);
      if (comment.parentId != null) {
        await session.db.unsafeExecute(
          'UPDATE comment SET "replyCount" = GREATEST("replyCount" - 1, 0) WHERE id = ${comment.parentId}',
        );
      }
    }
    await session.db.unsafeExecute(
      'UPDATE post SET "commentCount" = GREATEST("commentCount" - 1, 0) WHERE id = ${comment.postId}',
    );
    await session.messages.postMessage(
      channel(comment.postId),
      CommentEvent(
        type: LiveEventType.deleted,
        postId: comment.postId,
        commentId: commentId,
      ),
    );
  }

  Future<int> setLiked(Session session, int commentId, bool liked) async {
    final profile = await currentProfile(session);
    final comment = await Comment.db.findById(session, commentId);
    if (comment == null) {
      throw AppException(message: 'That comment is gone.', code: 'not_found');
    }
    final existing = await CommentLike.db.findFirstRow(
      session,
      where: (t) =>
          t.profileId.equals(profile.id!) & t.commentId.equals(commentId),
    );
    var delta = 0;
    if (liked && existing == null) {
      await CommentLike.db.insertRow(
        session,
        CommentLike(profileId: profile.id!, commentId: commentId),
      );
      delta = 1;
      if (comment.profileId != profile.id!) {
        final blocked = await blockedIds(session, comment.profileId);
        if (!blocked.contains(profile.id!)) {
          await ReaderNotification.db.insertRow(
            session,
            ReaderNotification(
              profileId: comment.profileId,
              actorName: profile.displayName,
              actorHandle: profile.handle,
              kind: NotificationKind.commentLike,
              postId: comment.postId,
              commentId: comment.id,
            ),
          );
        }
      }
    } else if (!liked && existing != null) {
      await CommentLike.db.deleteRow(session, existing);
      delta = -1;
    }
    if (delta == 0) return comment.likeCount;
    final result = await session.db.unsafeQuery(
      'UPDATE comment SET "likeCount" = GREATEST("likeCount" + $delta, 0) WHERE id = $commentId RETURNING "likeCount"',
    );
    final count = result.first[0] as int;
    await session.messages.postMessage(
      channel(comment.postId),
      CommentEvent(
        type: LiveEventType.liked,
        postId: comment.postId,
        commentId: commentId,
        likeCount: count,
      ),
    );
    return count;
  }

  /// Live updates for an open thread. Comments from blocked users are
  /// filtered per viewer.
  Stream<CommentEvent> watch(Session session, int postId) async* {
    final profile = await currentProfile(session);
    final blocked = await blockedIds(session, profile.id!);
    final updates = session.messages.createStream<CommentEvent>(
      channel(postId),
    );
    await for (final event in updates) {
      final author = event.comment?.author.id;
      if (author != null && blocked.contains(author)) continue;
      if (author == profile.id) continue; // The author already has it.
      yield event;
    }
  }

  static Future<List<CommentView>> _views(
    Session session,
    int viewerId,
    List<Comment> comments,
  ) async {
    if (comments.isEmpty) return [];
    final authors = {
      for (final p in await Reader.db.find(
        session,
        where: (t) => t.id.inSet(comments.map((c) => c.profileId).toSet()),
      ))
        p.id!: authorOf(p),
    };
    final liked = (await CommentLike.db.find(
      session,
      where: (t) =>
          t.profileId.equals(viewerId) &
          t.commentId.inSet(comments.map((c) => c.id!).toSet()),
    )).map((l) => l.commentId).toSet();
    final bookIds = comments.map((c) => c.asBookId).whereType<int>().toSet();
    final books = bookIds.isEmpty
        ? <int, Book>{}
        : {
            for (final b in await Book.db.find(
              session,
              where: (t) => t.id.inSet(bookIds),
            ))
              b.id!: b,
          };
    final official = bookIds.isEmpty
        ? null
        : await OfficialService.account(session);
    return [
      for (final c in comments)
        if (c.asBookId != null && books[c.asBookId] != null && official != null)
          CommentView(
            comment: c,
            author: bookAuthor(official, books[c.asBookId]!),
            likedByMe: liked.contains(c.id),
          )
        else if (authors[c.profileId] != null)
          CommentView(
            comment: c,
            author: authors[c.profileId]!,
            likedByMe: liked.contains(c.id),
          ),
    ];
  }
}
