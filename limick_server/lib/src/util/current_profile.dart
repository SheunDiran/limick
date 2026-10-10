import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// Resolves the signed-in user's [Reader].
///
/// Throws [AppException] with code `not_onboarded` when the user has signed in
/// but not finished onboarding, so the app can route them there.
Future<Reader> currentProfile(
  Session session, {
  bool requireOnboarded = true,
}) async {
  final authUserId = session.authenticated?.authUserId;
  if (authUserId == null) {
    throw AppException(message: 'Please sign in.', code: 'unauthenticated');
  }
  final profile = await Reader.db.findFirstRow(
    session,
    where: (t) => t.authUserId.equals(authUserId),
  );
  if (profile == null || (requireOnboarded && !profile.onboarded)) {
    throw AppException(
      message: 'Finish setting up your profile first.',
      code: 'not_onboarded',
    );
  }
  return profile;
}

/// Simple per-user rate limit backed by the local cache.
///
/// Returns normally if the action is allowed, otherwise throws [AppException].
Future<void> rateLimit(
  Session session, {
  required String action,
  required int profileId,
  required Duration window,
}) async {
  final key = 'rate:$action:$profileId';
  final hit = await session.caches.local.get<RateLimitMarker>(key);
  if (hit != null) {
    throw AppException(
      message: 'You are going a little fast. Try again in a moment.',
      code: 'rate_limited',
    );
  }
  await session.caches.local.put(key, RateLimitMarker(), lifetime: window);
}

/// Ids of users that [profileId] has blocked, used to filter social content.
Future<Set<int>> blockedIds(Session session, int profileId) async {
  final rows = await UserBlock.db.find(
    session,
    where: (t) => t.profileId.equals(profileId),
  );
  return rows.map((r) => r.blockedId).toSet();
}

Author authorOf(Reader profile) => Author(
  id: profile.id!,
  handle: profile.handle,
  displayName: profile.displayName,
  avatarHue: profile.avatarHue,
);
