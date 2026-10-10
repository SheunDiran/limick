import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// How much each action moves a user's interest in a topic and a book.
/// Positive actions teach the feed what to show more of; a fast skip is a
/// gentle negative signal.
class Signals {
  static const longRead = 0.6; // post on screen for 6s+
  static const read = 0.25; // 2.5s+
  static const fastSkip = -0.15; // scrolled past in under a second
  static const like = 1.0;
  static const save = 1.5;
  static const comment = 1.2;
  static const quiz = 0.6;
  static const vote = 0.5;
  static const openBook = 2.0;
  static const follow = 3.0;
  static const onboardingInterest = 6.0;
  static const onboardingField = 4.0;
  static const favouriteBook = 5.0;
}

class Affinity {
  /// Adds [weight] to the user's affinity for [topic] and, if given, [bookId].
  /// Scores are clamped so one binge can't lock the feed into one topic.
  static Future<void> bump(
    Session session, {
    required int profileId,
    required Topic topic,
    int? bookId,
    required double weight,
  }) async {
    await session.db.unsafeExecute(
      '''
INSERT INTO topic_affinity ("profileId", "topic", "score")
VALUES (@profileId, @topic, @weight)
ON CONFLICT ("profileId", "topic")
DO UPDATE SET "score" = LEAST(GREATEST(topic_affinity."score" + @weight, -10), 100)''',
      parameters: QueryParameters.named({
        'profileId': profileId,
        'topic': topic.name,
        'weight': weight,
      }),
    );
    if (bookId != null) {
      await session.db.unsafeExecute(
        '''
INSERT INTO book_affinity ("profileId", "bookId", "score", "createdAt")
VALUES (@profileId, @bookId, @weight, NOW())
ON CONFLICT ("profileId", "bookId")
DO UPDATE SET "score" = LEAST(GREATEST(book_affinity."score" + @weight, -10), 100)''',
        parameters: QueryParameters.named({
          'profileId': profileId,
          'bookId': bookId,
          'weight': weight,
        }),
      );
    }
  }

  static Future<void> forPost(
    Session session,
    int profileId,
    Post post,
    double weight,
  ) => bump(
    session,
    profileId: profileId,
    topic: post.primaryTopic,
    bookId: post.bookId,
    weight: weight,
  );

  static Future<Map<Topic, double>> topics(
    Session session,
    int profileId,
  ) async {
    final rows = await TopicAffinity.db.find(
      session,
      where: (t) => t.profileId.equals(profileId),
    );
    return {for (final r in rows) r.topic: r.score};
  }

  static Future<Map<int, double>> books(Session session, int profileId) async {
    final rows = await BookAffinity.db.find(
      session,
      where: (t) => t.profileId.equals(profileId),
      orderBy: (t) => t.score.desc(),
      limit: 80,
    );
    return {for (final r in rows) r.bookId: r.score};
  }

  /// Decays affinity scores slightly so tastes can drift naturally over time.
  static Future<void> decayAll(Session session, {double factor = 0.97}) async {
    await session.db.unsafeExecute(
      'UPDATE topic_affinity SET score = score * $factor',
    );
    await session.db.unsafeExecute(
      'UPDATE book_affinity SET score = score * $factor',
    );
  }
}

/// Maps free-text fields of study to topics, for cold-start ranking.
List<Topic> topicsForField(String? field) {
  if (field == null || field.trim().isEmpty) return const [];
  final f = field.toLowerCase();
  const map = <String, List<Topic>>{
    'medic': [Topic.medicine, Topic.science],
    'nurs': [Topic.medicine],
    'pharm': [Topic.medicine, Topic.science],
    'dent': [Topic.medicine],
    'health': [Topic.medicine],
    'bio': [Topic.science, Topic.nature, Topic.medicine],
    'anatom': [Topic.medicine],
    'law': [Topic.law, Topic.politics],
    'legal': [Topic.law],
    'politic': [Topic.politics, Topic.history],
    'international': [Topic.politics, Topic.history],
    'econ': [Topic.economics, Topic.politics],
    'business': [Topic.economics, Topic.selfImprovement],
    'financ': [Topic.economics],
    'account': [Topic.economics],
    'psych': [Topic.psychology, Topic.philosophy],
    'philos': [Topic.philosophy],
    'theolog': [Topic.religion, Topic.philosophy],
    'relig': [Topic.religion],
    'history': [Topic.history],
    'english': [Topic.literature, Topic.poetry],
    'literat': [Topic.literature, Topic.poetry],
    'writ': [Topic.literature, Topic.education],
    'journal': [Topic.literature, Topic.politics],
    'math': [Topic.mathematics],
    'statist': [Topic.mathematics],
    'physic': [Topic.science, Topic.mathematics],
    'chem': [Topic.science],
    'engineer': [Topic.technology, Topic.mathematics],
    'comput': [Topic.technology, Topic.mathematics],
    'software': [Topic.technology],
    'educat': [Topic.education, Topic.psychology],
    'teach': [Topic.education],
    'art': [Topic.arts],
    'music': [Topic.arts],
    'design': [Topic.arts, Topic.technology],
    'environment': [Topic.nature, Topic.science],
    'agric': [Topic.nature],
    'sociol': [Topic.politics, Topic.psychology],
  };
  final result = <Topic>[];
  for (final entry in map.entries) {
    if (f.contains(entry.key)) {
      for (final t in entry.value) {
        if (!result.contains(t)) result.add(t);
      }
    }
  }
  return result;
}
