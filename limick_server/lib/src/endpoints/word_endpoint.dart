import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/current_profile.dart';

/// The word bank: words saved from posts, reviewed with a Leitner schedule.
class WordEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Days until the next review for each Leitner box.
  static const intervals = [1, 2, 4, 7, 15, 30, 60];

  Future<SavedWord> saveFromPost(Session session, int postId) async {
    final profile = await currentProfile(session);
    final post = await Post.db.findById(session, postId);
    if (post == null || post.word == null || post.wordDefinition == null) {
      throw AppException(
        message: 'There is no word to save here.',
        code: 'invalid',
      );
    }
    final word = post.word!.trim();
    final existing = await SavedWord.db.findFirstRow(
      session,
      where: (t) =>
          t.profileId.equals(profile.id!) & t.word.equals(word.toLowerCase()),
    );
    if (existing != null) return existing;
    final book = await Book.db.findById(session, post.bookId);
    return SavedWord.db.insertRow(
      session,
      SavedWord(
        profileId: profile.id!,
        word: word.toLowerCase(),
        definition: post.wordDefinition!,
        partOfSpeech: post.wordPartOfSpeech ?? '',
        example: post.quote,
        bookTitle: book?.title,
        postId: post.id,
        dueAt: DateTime.now().add(const Duration(hours: 20)),
      ),
    );
  }

  Future<List<SavedWord>> list(Session session) async {
    final profile = await currentProfile(session);
    return SavedWord.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  Future<List<SavedWord>> due(Session session) async {
    final profile = await currentProfile(session);
    return SavedWord.db.find(
      session,
      where: (t) =>
          t.profileId.equals(profile.id!) & (t.dueAt <= DateTime.now()),
      orderBy: (t) => t.dueAt,
      limit: 30,
    );
  }

  /// Remembered words move up a box and come back later; forgotten words go
  /// back to box 0 and return in a few hours.
  Future<SavedWord> review(Session session, int wordId, bool remembered) async {
    final word = await _own(session, wordId);
    final box = remembered ? (word.box + 1).clamp(0, intervals.length - 1) : 0;
    final due = remembered
        ? DateTime.now().add(Duration(days: intervals[box]))
        : DateTime.now().add(const Duration(hours: 4));
    return SavedWord.db.updateRow(
      session,
      word.copyWith(box: box, dueAt: due, reviewCount: word.reviewCount + 1),
    );
  }

  Future<void> remove(Session session, int wordId) async {
    await SavedWord.db.deleteRow(session, await _own(session, wordId));
  }

  Future<SavedWord> _own(Session session, int wordId) async {
    final profile = await currentProfile(session);
    final word = await SavedWord.db.findById(session, wordId);
    if (word == null || word.profileId != profile.id) {
      throw AppException(message: 'Word not found.', code: 'not_found');
    }
    return word;
  }
}
