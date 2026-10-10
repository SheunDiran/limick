import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../endpoints/profile_endpoint.dart';
import '../feed/affinity.dart';
import '../generated/protocol.dart';

/// A real account the team owns, created at boot so it is ready to sign in
/// with. Credentials live in config/passwords.yaml (never in git):
/// `<key>Email` and `<key>Password` under `shared:`.
class DemoAccount {
  final String key;
  final String handle;
  final String displayName;
  final String field;
  final String bio;
  final List<Topic> interests;

  /// Gutenberg ids of books to follow.
  final List<int> favourites;

  /// Extra interest on top of onboarding, to tilt the feed further.
  final Map<Topic, double> extraAffinity;

  const DemoAccount({
    required this.key,
    required this.handle,
    required this.displayName,
    required this.field,
    required this.bio,
    required this.interests,
    required this.favourites,
    this.extraAffinity = const {},
  });
}

const demoAccounts = [
  // For the hackathon judges: builders who like how things work and why.
  DemoAccount(
    key: 'tester',
    handle: 'tester',
    displayName: 'Tester',
    field: 'Software engineering',
    bio: 'Testing Limick for the Serverpod hackathon.',
    interests: [
      Topic.technology,
      Topic.science,
      Topic.philosophy,
      Topic.history,
      Topic.selfImprovement,
    ],
    favourites: [
      820,
      30155,
      2680,
      1228,
    ], // Edison, Relativity, Meditations, Origin of Species
  ),
  // Sheun: frontend (React) engineer who mostly wants fun economics, plus
  // tech and psychology.
  DemoAccount(
    key: 'sheun',
    handle: 'sheun',
    displayName: 'Sheun',
    field: 'Frontend engineering (React)',
    bio: 'Frontend dev. Economics nerd on breaks.',
    interests: [Topic.economics, Topic.technology, Topic.psychology],
    favourites: [3300, 833, 33310], // Wealth of Nations, Leisure Class, Ricardo
    extraAffinity: {Topic.economics: 12},
  ),
];

class DemoAccounts {
  /// Creates each configured account once. Accounts without credentials in
  /// passwords.yaml are skipped. If the account exists, its password is kept
  /// in sync with passwords.yaml.
  static Future<void> ensure(Session session) async {
    for (final spec in demoAccounts) {
      final email = session.passwords['${spec.key}Email']?.trim();
      final password = session.passwords['${spec.key}Password'];
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        continue;
      }
      try {
        await _ensure(session, spec, email.toLowerCase(), password);
      } catch (e, stackTrace) {
        session.log(
          'Could not create the ${spec.key} account',
          level: LogLevel.warning,
          exception: e,
          stackTrace: stackTrace,
        );
      }
    }
  }

  static Future<void> _ensure(
    Session session,
    DemoAccount spec,
    String email,
    String password,
  ) async {
    final emailIdp = AuthServices.getIdentityProvider<EmailIdp>();
    final existing = await Reader.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(spec.handle),
    );
    if (existing != null) {
      await emailIdp.admin.setPassword(
        session,
        email: email,
        password: password,
      );
      return;
    }

    final authUser = await AuthServices.instance.authUsers.create(session);
    await emailIdp.admin.createEmailAuthentication(
      session,
      authUserId: authUser.id,
      email: email,
      password: password,
    );
    await AuthServices.instance.userProfiles.createUserProfile(
      session,
      authUser.id,
      UserProfileData(fullName: spec.displayName, email: email),
    );

    final books = await Book.db.find(
      session,
      where: (t) => t.gutenbergId.inSet(spec.favourites.toSet()),
    );
    final reader = await ProfileEndpoint.applyOnboarding(
      session,
      authUser.id,
      OnboardingInput(
        displayName: spec.displayName,
        handle: spec.handle,
        field: spec.field,
        interests: spec.interests,
        favoriteBookIds: books.map((b) => b.id!).toList(),
        dailyGoalMinutes: 15,
      ),
    );
    await Reader.db.updateRow(session, reader.copyWith(bio: spec.bio));
    for (final entry in spec.extraAffinity.entries) {
      await Affinity.bump(
        session,
        profileId: reader.id!,
        topic: entry.key,
        weight: entry.value,
      );
    }
    session.log('Created the @${spec.handle} account.');
  }
}
