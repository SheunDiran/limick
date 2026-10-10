import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../books/library_service.dart';
import '../feed/affinity.dart';
import '../generated/protocol.dart';
import '../util/current_profile.dart';
import '../util/text.dart';

/// Onboarding, profiles, streaks, stats, data export and account deletion.
class ProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Called on every launch. Also keeps the daily streak up to date.
  Future<Me> me(Session session, int tzOffsetMinutes) async {
    final authUserId = session.authenticated!.authUserId;
    var profile = await Reader.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (profile == null) {
      String? email;
      try {
        final auth = await session.authenticated!.userProfile(session);
        email = auth?.email ?? auth?.userName;
      } catch (e) {
        session.log(
          'Could not read the auth profile: $e',
          level: LogLevel.debug,
        );
      }
      final base = suggestUserHandle(email ?? 'reader');
      return Me(
        profile: null,
        suggestedHandle: await _freeHandle(session, base),
      );
    }
    profile = await touchStreak(
      session,
      profile,
      tzOffsetMinutes: tzOffsetMinutes,
    );
    final activeBreak = await StudyBreak.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile!.id!) & t.endedAt.equals(null),
      orderBy: (t) => t.startedAt.desc(),
    );
    final dueWords = await SavedWord.db.count(
      session,
      where: (t) =>
          t.profileId.equals(profile!.id!) & (t.dueAt <= DateTime.now()),
    );
    return Me(
      profile: profile,
      suggestedHandle: profile.handle,
      activeBreak: activeBreak,
      dueWords: dueWords,
    );
  }

  Future<bool> isHandleAvailable(Session session, String handle) async {
    final h = handle.trim().toLowerCase();
    if (!userHandlePattern.hasMatch(h)) return false;
    final existing = await Reader.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(h),
    );
    if (existing == null) return true;
    return existing.authUserId == session.authenticated!.authUserId;
  }

  /// Creates the profile and seeds the recommendation engine from the user's
  /// field, interests and favourite books.
  Future<Me> completeOnboarding(Session session, OnboardingInput input) async {
    final authUserId = session.authenticated!.authUserId;
    final handle = input.handle.trim().toLowerCase();
    final displayName = cleanUserText(input.displayName, maxLength: 40);
    final field = input.field == null
        ? null
        : cleanUserText(input.field!, maxLength: 60);
    final interests = input.interests.toSet().toList();

    if (displayName.isEmpty) {
      throw AppException(message: 'Add your name.', code: 'invalid');
    }
    if (!userHandlePattern.hasMatch(handle)) {
      throw AppException(
        message: 'Handles use 3–20 lowercase letters, numbers or underscores.',
        code: 'invalid_handle',
      );
    }
    if (!await isHandleAvailable(session, handle)) {
      throw AppException(message: '@$handle is taken.', code: 'handle_taken');
    }
    if (interests.length < 3) {
      throw AppException(
        message: 'Pick at least three interests.',
        code: 'invalid',
      );
    }

    var profile = await Reader.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final wasOnboarded = profile?.onboarded ?? false;
    final values = (
      handle: handle,
      displayName: displayName,
      field: field == null || field.isEmpty ? null : field,
      interests: interests,
      goal: input.dailyGoalMinutes.clamp(5, 120),
    );
    if (profile == null) {
      profile = await Reader.db.insertRow(
        session,
        Reader(
          authUserId: authUserId,
          handle: values.handle,
          displayName: values.displayName,
          field: values.field,
          interests: values.interests,
          dailyGoalMinutes: values.goal,
          avatarHue: handle.codeUnits.fold<int>(0, (a, b) => a + b * 37) % 360,
          onboarded: true,
        ),
      );
    } else {
      profile = await Reader.db.updateRow(
        session,
        profile.copyWith(
          handle: values.handle,
          displayName: values.displayName,
          field: values.field,
          interests: values.interests,
          dailyGoalMinutes: values.goal,
          onboarded: true,
        ),
      );
    }
    final profileId = profile.id!;

    if (!wasOnboarded) {
      for (final topic in interests) {
        await Affinity.bump(
          session,
          profileId: profileId,
          topic: topic,
          weight: Signals.onboardingInterest,
        );
      }
      for (final topic in topicsForField(values.field)) {
        await Affinity.bump(
          session,
          profileId: profileId,
          topic: topic,
          weight: Signals.onboardingField,
        );
      }
      final favourites = await Book.db.find(
        session,
        where: (t) => t.id.inSet(input.favoriteBookIds.take(10).toSet()),
      );
      for (final book in favourites) {
        await _follow(session, profileId, book);
        await Affinity.bump(
          session,
          profileId: profileId,
          topic: book.primaryTopic,
          bookId: book.id,
          weight: Signals.favouriteBook,
        );
      }
      // Join the rooms for the user's interests so Rooms isn't empty.
      final rooms = await Room.db.find(
        session,
        where: (t) => t.topic.inSet(interests.toSet()),
      );
      for (final room in rooms) {
        await RoomMember.db.insertRow(
          session,
          RoomMember(profileId: profileId, roomId: room.id!),
        );
        await session.db.unsafeExecute(
          'UPDATE room SET "memberCount" = "memberCount" + 1 WHERE id = ${room.id}',
        );
      }
    }
    return me(session, profile.tzOffsetMinutes);
  }

  static Future<void> _follow(Session session, int profileId, Book book) async {
    final existing = await BookFollow.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profileId) & t.bookId.equals(book.id!),
    );
    if (existing != null) return;
    await BookFollow.db.insertRow(
      session,
      BookFollow(profileId: profileId, bookId: book.id!),
    );
    await session.db.unsafeExecute(
      'UPDATE book SET "followerCount" = "followerCount" + 1, '
      'popularity = LEAST(popularity + 10, 400) WHERE id = ${book.id}',
    );
    await LibraryService.requestIngest(session, book);
  }

  Future<Reader> updateProfile(
    Session session, {
    required String displayName,
    required String bio,
    String? field,
    int? avatarHue,
    int? dailyGoalMinutes,
  }) async {
    final profile = await currentProfile(session);
    final name = cleanUserText(displayName, maxLength: 40);
    if (name.isEmpty) {
      throw AppException(message: 'Add your name.', code: 'invalid');
    }
    final cleanField = field == null
        ? null
        : cleanUserText(field, maxLength: 60);
    return Reader.db.updateRow(
      session,
      profile.copyWith(
        displayName: name,
        bio: maskProfanity(cleanUserText(bio, maxLength: 160)),
        field: cleanField == null || cleanField.isEmpty ? null : cleanField,
        avatarHue: (avatarHue ?? profile.avatarHue) % 360,
        dailyGoalMinutes: (dailyGoalMinutes ?? profile.dailyGoalMinutes).clamp(
          5,
          120,
        ),
      ),
    );
  }

  Future<PublicProfile> getProfile(Session session, String handle) async {
    final me = await currentProfile(session);
    final profile = await Reader.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(handle.toLowerCase()),
    );
    if (profile == null || !profile.onboarded) {
      throw AppException(
        message: 'No reader called @$handle.',
        code: 'not_found',
      );
    }
    final blocked = await UserBlock.db.findFirstRow(
      session,
      where: (t) =>
          t.profileId.equals(me.id!) & t.blockedId.equals(profile.id!),
    );
    return PublicProfile(
      author: authorOf(profile),
      bio: profile.bio,
      field: profile.field,
      stats: await statsFor(session, profile),
      isMe: profile.id == me.id,
      blocked: blocked != null,
    );
  }

  Future<ProfileStats> stats(Session session) async =>
      statsFor(session, await currentProfile(session));

  static Future<ProfileStats> statsFor(Session session, Reader profile) async {
    final id = profile.id!;
    final booksOpened = await ReadingProgress.db.count(
      session,
      where: (t) => t.profileId.equals(id),
    );
    final topics = await TopicAffinity.db.find(
      session,
      where: (t) => t.profileId.equals(id) & (t.score > 0.0),
      orderBy: (t) => t.score.desc(),
      limit: 3,
    );
    return ProfileStats(
      postsRead: await PostView.db.count(
        session,
        where: (t) => t.profileId.equals(id) & (t.dwellMs >= 1500),
      ),
      wordsSaved: await SavedWord.db.count(
        session,
        where: (t) => t.profileId.equals(id),
      ),
      booksOpened: booksOpened,
      quizzesAnswered: await QuizAnswer.db.count(
        session,
        where: (t) => t.profileId.equals(id),
      ),
      quizzesCorrect: await QuizAnswer.db.count(
        session,
        where: (t) => t.profileId.equals(id) & t.correct.equals(true),
      ),
      streakDays: profile.streakDays,
      booksFollowed: await BookFollow.db.count(
        session,
        where: (t) => t.profileId.equals(id),
      ),
      comments: await Comment.db.count(
        session,
        where: (t) => t.profileId.equals(id) & t.deleted.equals(false),
      ),
      topTopics: topics.map((t) => t.topic).toList(),
    );
  }

  /// Everything Limick stores about the user, as JSON (GDPR data portability).
  Future<String> exportData(Session session) async {
    final profile = await currentProfile(session, requireOnboarded: false);
    final id = profile.id!;
    final data = {
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'profile': profile.toJson(),
      'interests': (await TopicAffinity.db.find(
        session,
        where: (t) => t.profileId.equals(id),
      )).map((r) => r.toJson()).toList(),
      'follows': (await BookFollow.db.find(
        session,
        where: (t) => t.profileId.equals(id),
      )).map((r) => r.toJson()).toList(),
      'likes': (await PostLike.db.find(
        session,
        where: (t) => t.profileId.equals(id),
      )).map((r) => r.toJson()).toList(),
      'saves': (await PostSave.db.find(
        session,
        where: (t) => t.profileId.equals(id),
      )).map((r) => r.toJson()).toList(),
      'comments': (await Comment.db.find(
        session,
        where: (t) => t.profileId.equals(id),
      )).map((r) => r.toJson()).toList(),
      'roomMessages': (await RoomMessage.db.find(
        session,
        where: (t) => t.profileId.equals(id),
      )).map((r) => r.toJson()).toList(),
      'words': (await SavedWord.db.find(
        session,
        where: (t) => t.profileId.equals(id),
      )).map((r) => r.toJson()).toList(),
      'readingProgress': (await ReadingProgress.db.find(
        session,
        where: (t) => t.profileId.equals(id),
      )).map((r) => r.toJson()).toList(),
      'studyBreaks': (await StudyBreak.db.find(
        session,
        where: (t) => t.profileId.equals(id),
      )).map((r) => r.toJson()).toList(),
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  /// Permanently deletes the user's Limick data and their sign-in account.
  Future<void> deleteAccount(Session session) async {
    final authUserId = session.authenticated!.authUserId;
    await session.db.transaction((tx) async {
      final profile = await Reader.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(authUserId),
        transaction: tx,
      );
      if (profile != null) {
        // Rows that reference the profile are removed by cascading deletes.
        await Reader.db.deleteRow(session, profile, transaction: tx);
      }
      await AuthServices.instance.authUsers.delete(
        session,
        authUserId: authUserId,
        transaction: tx,
      );
    });
  }

  static Future<String> _freeHandle(Session session, String base) async {
    var candidate = base;
    for (var i = 0; i < 50; i++) {
      final taken = await Reader.db.findFirstRow(
        session,
        where: (t) => t.handle.equals(candidate),
      );
      if (taken == null) return candidate;
      candidate = '$base${i + 2}';
    }
    return '$base${DateTime.now().millisecondsSinceEpoch % 100000}';
  }
}

/// Updates the daily streak in the user's local time zone.
Future<Reader> touchStreak(
  Session session,
  Reader profile, {
  int? tzOffsetMinutes,
}) async {
  final offset = (tzOffsetMinutes ?? profile.tzOffsetMinutes).clamp(-840, 840);
  final local = DateTime.now().toUtc().add(Duration(minutes: offset));
  String key(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  final today = key(local);
  if (profile.lastActiveDay == today && profile.tzOffsetMinutes == offset) {
    return profile;
  }
  final yesterday = key(local.subtract(const Duration(days: 1)));
  final streak = profile.lastActiveDay == today
      ? profile.streakDays
      : profile.lastActiveDay == yesterday
      ? profile.streakDays + 1
      : 1;
  return Reader.db.updateRow(
    session,
    profile.copyWith(
      lastActiveDay: today,
      streakDays: streak,
      tzOffsetMinutes: offset,
    ),
  );
}
