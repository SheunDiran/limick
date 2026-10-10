import 'package:serverpod/serverpod.dart';

import '../ai/llm.dart';
import '../endpoints/comment_endpoint.dart';
import '../generated/protocol.dart';
import '../util/current_profile.dart';
import '../util/text.dart';
import 'official_service.dart';

/// "Ask the book": when a reader asks a question under a post, the book's
/// account replies, grounded in the passage the post came from. Replies are
/// AI-written, marked as such in the app, and rate limited per reader to
/// stay within free-tier model quotas.
class BookReplies {
  static const _maxPerReaderPerHour = 12;
  static final Map<int, List<DateTime>> _recent = {};

  /// Whether a new comment should get a reply from the book.
  static bool wants(Comment comment, Book book, {Comment? parent}) {
    final text = comment.body.toLowerCase();
    return text.contains('?') ||
        text.contains('@${book.handle.toLowerCase()}') ||
        parent?.asBookId != null;
  }

  /// Rate limit: true if this reader may get another reply now.
  static bool allow(int profileId) {
    final now = DateTime.now();
    final list = _recent.putIfAbsent(profileId, () => [])
      ..removeWhere((t) => now.difference(t).inMinutes >= 60);
    if (list.length >= _maxPerReaderPerHour) return false;
    list.add(now);
    return true;
  }

  static Future<void> reply(Session session, int commentId) async {
    final comment = await Comment.db.findById(session, commentId);
    if (comment == null || comment.deleted) return;
    final pool = LlmPool.fromSession(session);
    if (pool == null) return;
    final post = await Post.db.findById(session, comment.postId);
    if (post == null) return;
    final book = await Book.db.findById(session, post.bookId);
    final chapter = await Chapter.db.findById(session, post.chapterId);
    if (book == null || chapter == null) return;

    // The passage around the post, so answers stay grounded in the text.
    final from = (post.passageStart - 1500).clamp(0, chapter.text.length);
    final to = (post.passageEnd + 1500).clamp(from, chapter.text.length);
    final passage = chapter.text.substring(from, to);

    final rootId = comment.parentId ?? comment.id!;
    final thread = await Comment.db.find(
      session,
      where: (t) =>
          (t.id.equals(rootId) | t.parentId.equals(rootId)) &
          t.deleted.equals(false),
      orderBy: (t) => t.createdAt,
      limit: 8,
    );
    final conversation = thread
        .map(
          (c) =>
              '${c.asBookId != null ? '@${book.handle}' : 'Reader'}: ${c.body}',
        )
        .join('\n');

    try {
      final result = await pool.generateJson(
        session: session,
        maxTokens: 1024,
        system:
            'You are the book "${book.title}" by ${book.author}, replying to a reader in the comments '
            'of a social app for learning from books. Answer in the first person as the book, warmly '
            'and briefly (at most 400 characters), in plain modern English. Use only the passage and '
            'widely known facts about the book and its author. If the passage does not answer the '
            'question, say so honestly and suggest reading on. Never invent quotes or facts. '
            'For medical or legal questions, note that the text is historical and not advice. '
            'If the comment is abusive or off-topic, reply with an empty string.',
        user:
            'Post: ${post.body}${post.quote == null ? '' : '\nQuoted: "${post.quote}"'}\n'
            'Chapter: ${chapter.title}\n\n<passage>\n$passage\n</passage>\n\n'
            'Conversation so far:\n$conversation\n\nWrite the book\'s reply to the last message.',
        schema: const {
          'type': 'object',
          'additionalProperties': false,
          'required': ['reply'],
          'properties': {
            'reply': {'type': 'string'},
          },
        },
      );
      final text = cleanUserText(
        result.json['reply'] as String? ?? '',
        maxLength: 600,
      );
      if (text.length < 2) return;

      final official = await OfficialService.account(session);
      final saved = await Comment.db.insertRow(
        session,
        Comment(
          postId: post.id!,
          profileId: official.id!,
          parentId: rootId,
          body: text,
          asBookId: book.id,
        ),
      );
      await session.db.unsafeExecute(
        'UPDATE post SET "commentCount" = "commentCount" + 1 WHERE id = ${post.id}',
      );
      await session.db.unsafeExecute(
        'UPDATE comment SET "replyCount" = "replyCount" + 1 WHERE id = $rootId',
      );
      await session.messages.postMessage(
        CommentEndpoint.channel(post.id!),
        CommentEvent(
          type: LiveEventType.added,
          postId: post.id!,
          comment: CommentView(
            comment: saved,
            author: bookAuthor(official, book),
          ),
        ),
      );

      // Notify asking reader of the book's reply.
      if (comment.profileId != official.id!) {
        final blocked = await blockedIds(session, comment.profileId);
        if (!blocked.contains(official.id!)) {
          await ReaderNotification.db.insertRow(
            session,
            ReaderNotification(
              profileId: comment.profileId,
              actorName: book.title,
              actorHandle: book.handle,
              kind: NotificationKind.bookReply,
              postId: post.id,
              commentId: saved.id,
            ),
          );
        }
      }
    } on LlmException catch (e) {
      session.log('Book reply skipped: ${e.message}', level: LogLevel.info);
    }
  }
}

/// How a book account appears as a comment author.
Author bookAuthor(Reader official, Book book) => Author(
  id: official.id!,
  handle: book.handle,
  displayName: book.title,
  avatarHue: book.gutenbergId % 360,
  bookId: book.id,
);
