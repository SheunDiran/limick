import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/current_profile.dart';

/// Timed study breaks. The break lives on the server so it survives app
/// restarts and works across devices; the summary shows what was learned.
class StudyBreakEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<StudyBreak> start(Session session, int minutes) async {
    final profile = await currentProfile(session);
    final planned = minutes.clamp(1, 60);
    await _endOpen(session, profile.id!);
    return StudyBreak.db.insertRow(
      session,
      StudyBreak(profileId: profile.id!, plannedMinutes: planned),
    );
  }

  Future<StudyBreak?> active(Session session) async {
    final profile = await currentProfile(session);
    return StudyBreak.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!) & t.endedAt.equals(null),
      orderBy: (t) => t.startedAt.desc(),
    );
  }

  /// Ends the break (if it is still running) and summarises it.
  Future<BreakSummary> end(Session session, int breakId) async {
    final profile = await currentProfile(session);
    var studyBreak = await StudyBreak.db.findById(session, breakId);
    if (studyBreak == null || studyBreak.profileId != profile.id) {
      throw AppException(message: 'Break not found.', code: 'not_found');
    }
    studyBreak = studyBreak.endedAt == null
        ? await StudyBreak.db.updateRow(
            session,
            studyBreak.copyWith(endedAt: DateTime.now()),
          )
        : studyBreak;
    final from = studyBreak.startedAt;
    final to = studyBreak.endedAt!;

    final views = await PostView.db.find(
      session,
      where: (t) =>
          t.profileId.equals(profile.id!) &
          (t.createdAt >= from) &
          (t.createdAt <= to) &
          (t.dwellMs >= 1500),
    );
    final posts = views.isEmpty
        ? <Post>[]
        : await Post.db.find(
            session,
            where: (t) => t.id.inSet(views.map((v) => v.postId).toSet()),
          );
    final perBook = <int, int>{};
    for (final p in posts) {
      perBook[p.bookId] = (perBook[p.bookId] ?? 0) + 1;
    }
    final books = perBook.isEmpty
        ? <Book>[]
        : await Book.db.find(
            session,
            where: (t) => t.id.inSet(perBook.keys.toSet()),
          );
    books.sort((a, b) => (perBook[b.id] ?? 0).compareTo(perBook[a.id] ?? 0));
    final top = books.where((b) => b.status == BookStatus.ready).firstOrNull;
    final topPost = top == null
        ? null
        : posts.firstWhere((p) => p.bookId == top.id);

    final answers = await QuizAnswer.db.find(
      session,
      where: (t) =>
          t.profileId.equals(profile.id!) &
          (t.createdAt >= from) &
          (t.createdAt <= to),
    );
    return BreakSummary(
      studyBreak: studyBreak,
      postsRead: views.length,
      wordsSaved: await SavedWord.db.count(
        session,
        where: (t) =>
            t.profileId.equals(profile.id!) &
            (t.createdAt >= from) &
            (t.createdAt <= to),
      ),
      quizzesAnswered: answers.length,
      quizzesCorrect: answers.where((a) => a.correct).length,
      books: books.take(5).map((b) => b.title).toList(),
      continueBook: top,
      continueChapter: topPost?.chapterPosition,
    );
  }

  Future<void> _endOpen(Session session, int profileId) async {
    final open = await StudyBreak.db.find(
      session,
      where: (t) => t.profileId.equals(profileId) & t.endedAt.equals(null),
    );
    for (final b in open) {
      await StudyBreak.db.updateRow(
        session,
        b.copyWith(endedAt: DateTime.now()),
      );
    }
  }
}
