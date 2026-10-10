import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/current_profile.dart';
import '../util/text.dart';

/// Reporting content and blocking people.
class ModerationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const targetTypes = {'post', 'comment', 'message', 'user'};

  Future<void> report(
    Session session,
    String targetType,
    int targetId,
    String reason,
  ) async {
    final profile = await currentProfile(session);
    if (!targetTypes.contains(targetType)) {
      throw AppException(message: 'Unknown report type.', code: 'invalid');
    }
    await rateLimit(
      session,
      action: 'report',
      profileId: profile.id!,
      window: const Duration(seconds: 10),
    );
    await Report.db.insertRow(
      session,
      Report(
        profileId: profile.id!,
        targetType: targetType,
        targetId: targetId,
        reason: cleanUserText(reason, maxLength: 500),
      ),
    );
    session.log(
      'Report: $targetType #$targetId by @${profile.handle}',
      level: LogLevel.warning,
    );
  }

  Future<void> setBlocked(Session session, int profileId, bool blocked) async {
    final profile = await currentProfile(session);
    if (profileId == profile.id) {
      throw AppException(message: "You can't block yourself.", code: 'invalid');
    }
    final target = await Reader.db.findById(session, profileId);
    if (target == null || target.official) {
      throw AppException(
        message: 'This account cannot be blocked.',
        code: 'invalid',
      );
    }
    final existing = await UserBlock.db.findFirstRow(
      session,
      where: (t) =>
          t.profileId.equals(profile.id!) & t.blockedId.equals(profileId),
    );
    if (blocked && existing == null) {
      await UserBlock.db.insertRow(
        session,
        UserBlock(profileId: profile.id!, blockedId: profileId),
      );
    } else if (!blocked && existing != null) {
      await UserBlock.db.deleteRow(session, existing);
    }
  }

  Future<List<Author>> blocked(Session session) async {
    final profile = await currentProfile(session);
    final ids = await blockedIds(session, profile.id!);
    if (ids.isEmpty) return [];
    final profiles = await Reader.db.find(
      session,
      where: (t) => t.id.inSet(ids),
    );
    return profiles.map(authorOf).toList();
  }
}
