import 'package:serverpod/serverpod.dart';

import '../official/book_replies.dart';

/// Writes a book's reply to a reader's comment in the background, so posting
/// a comment never waits on a model.
class BookReplyFutureCall extends FutureCall {
  Future<void> reply(Session session, int commentId) async {
    try {
      await BookReplies.reply(session, commentId);
    } catch (e, stackTrace) {
      session.log(
        'Book reply failed for comment $commentId',
        level: LogLevel.warning,
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }
}
