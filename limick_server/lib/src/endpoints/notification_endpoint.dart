import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/current_profile.dart';

/// Notifications for reader interactions (comment replies, comment likes, book replies).
class NotificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Returns the signed-in reader's notifications, 20 per page, newest first.
  Future<List<ReaderNotification>> list(Session session, int? beforeId) async {
    final profile = await currentProfile(session);
    return ReaderNotification.db.find(
      session,
      where: (t) =>
          t.profileId.equals(profile.id!) &
          (beforeId == null ? Constant.bool(true) : t.id < beforeId),
      orderBy: (t) => t.id.desc(),
      limit: 20,
    );
  }

  /// Number of unread notifications for the signed-in reader.
  Future<int> unreadCount(Session session) async {
    final profile = await currentProfile(session);
    return ReaderNotification.db.count(
      session,
      where: (t) => t.profileId.equals(profile.id!) & t.read.equals(false),
    );
  }

  /// Marks all unread notifications as read.
  Future<void> markAllRead(Session session) async {
    final profile = await currentProfile(session);
    await session.db.unsafeExecute(
      'UPDATE reader_notification SET "read" = true WHERE "profileId" = ${profile.id!} AND "read" = false',
    );
  }
}
