import 'package:limick_server/src/books/library_service.dart';
import 'package:limick_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _alice = '550e8400-e29b-41d4-a716-446655440001';
const _bob = '550e8400-e29b-41d4-a716-446655440002';

/// Seeds the starter library and makes one book readable with a few posts,
/// standing in for the ingestion and generation pipeline.
Future<({Book book, Post quiz, Post debate, Post word})> _seedReadyBook(
  Session session,
) async {
  await LibraryService.seed(session);
  var book = (await Book.db.findFirstRow(
    session,
    where: (t) => t.gutenbergId.equals(1228),
  ))!;
  book = await Book.db.updateRow(
    session,
    book.copyWith(status: BookStatus.ready, chapterCount: 2, wordCount: 400),
  );
  final chapters = await Chapter.db.insert(session, [
    Chapter(
      bookId: book.id!,
      position: 0,
      title: 'Chapter I. — Variation Under Domestication',
      wordCount: 200,
      text:
          'When we look to the individuals of the same variety, '
          'one of the first points which strikes us is that they differ.\n\n'
          'This is a perspicuous observation.',
    ),
    Chapter(
      bookId: book.id!,
      position: 1,
      title: 'Chapter II. — Variation Under Nature',
      wordCount: 200,
      text: 'Nature is lavish with variation.',
    ),
  ]);
  Post post(PostKind kind, {Map<String, Object?> extra = const {}}) => Post(
    bookId: book.id!,
    chapterId: chapters.first.id!,
    chapterPosition: 0,
    kind: kind,
    body: 'A ${kind.name} post about variation that is long enough.',
    primaryTopic: Topic.science,
    passageStart: 0,
    passageEnd: 40,
    quizOptions: extra['options'] as List<String>?,
    quizAnswerIndex: extra['answer'] as int?,
    quizExplanation: extra['explanation'] as String?,
    word: extra['word'] as String?,
    wordDefinition: extra['definition'] as String?,
  );
  final posts = await Post.db.insert(session, [
    post(PostKind.insight),
    post(
      PostKind.quiz,
      extra: {
        'options': ['They differ', 'They are identical', 'They vanish'],
        'answer': 0,
        'explanation': 'Darwin notes individuals differ.',
      },
    ),
    post(PostKind.debate),
    post(
      PostKind.word,
      extra: {'word': 'perspicuous', 'definition': 'Clearly expressed.'},
    ),
    for (var i = 0; i < 6; i++) post(PostKind.thread),
  ]);
  await Book.db.updateRow(session, book.copyWith(postCount: posts.length));
  return (book: book, quiz: posts[1], debate: posts[2], word: posts[3]);
}

OnboardingInput _onboarding(String handle, List<int> favourites) =>
    OnboardingInput(
      displayName: 'Reader $handle',
      handle: handle,
      field: 'Medicine',
      interests: [Topic.science, Topic.philosophy, Topic.medicine],
      favoriteBookIds: favourites,
      dailyGoalMinutes: 15,
    );

void main() {
  withServerpod('Given a seeded library', (sessionBuilder, endpoints) {
    final alice = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_alice, {}),
    );
    final bob = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_bob, {}),
    );
    late ({Book book, Post quiz, Post debate, Post word}) seed;

    setUp(() async {
      seed = await _seedReadyBook(sessionBuilder.build());
    });

    test('when a new user signs in then they have no profile yet', () async {
      final me = await endpoints.profile.me(alice, 60);
      expect(me.profile, isNull);
      expect(me.suggestedHandle, isNotEmpty);
    });

    test(
      'when onboarding with too few interests then it is rejected',
      () async {
        await expectLater(
          endpoints.profile.completeOnboarding(
            alice,
            _onboarding('alice', []).copyWith(interests: [Topic.law]),
          ),
          throwsA(isA<AppException>()),
        );
      },
    );

    test(
      'when an onboarded user opens the feed then posts are personalised',
      () async {
        final me = await endpoints.profile.completeOnboarding(
          alice,
          _onboarding('alice', [seed.book.id!]),
        );
        expect(me.profile!.onboarded, isTrue);
        expect(me.profile!.streakDays, 1);

        final page = await endpoints.feed.forYou(alice, []);
        expect(page.items, isNotEmpty);
        final posts = page.items
            .where((i) => i.kind == FeedItemKind.post)
            .toList();
        expect(posts.every((i) => i.book!.id == seed.book.id), isTrue);
        expect(posts.first.followingBook, isTrue);
        // No two consecutive cards share a post kind when alternatives exist.
        expect(posts[0].post!.kind == posts[1].post!.kind, isFalse);

        // Paging with the shown ids never repeats a card.
        final shown = posts.map((i) => i.post!.id!).toList();
        final next = await endpoints.feed.forYou(alice, shown);
        final repeated = next.items.where((i) => shown.contains(i.post?.id));
        expect(repeated, isEmpty);
      },
    );

    test('when interacting with posts then counts and state update', () async {
      await endpoints.profile.completeOnboarding(
        alice,
        _onboarding('alice', []),
      );

      expect(await endpoints.feed.setLiked(alice, seed.quiz.id!, true), 1);
      expect(await endpoints.feed.setLiked(alice, seed.quiz.id!, true), 1);
      expect(await endpoints.feed.setLiked(alice, seed.quiz.id!, false), 0);

      final wrong = await endpoints.feed.answerQuiz(alice, seed.quiz.id!, 2);
      expect(wrong.correct, isFalse);
      expect(wrong.correctIndex, 0);
      // Changing your answer afterwards does not count.
      final retry = await endpoints.feed.answerQuiz(alice, seed.quiz.id!, 0);
      expect(retry.correct, isFalse);
      expect(retry.answerCount, 1);

      var debate = (await endpoints.feed.vote(
        alice,
        seed.debate.id!,
        true,
      )).post!;
      expect(debate.agreeCount, 1);
      debate = (await endpoints.feed.vote(alice, seed.debate.id!, false)).post!;
      expect((debate.agreeCount, debate.disagreeCount), (0, 1));

      await endpoints.feed.recordViews(alice, [
        ViewSignal(postId: seed.quiz.id!, dwellMs: 7000),
        ViewSignal(postId: seed.debate.id!, dwellMs: 300),
      ]);
      final item = await endpoints.feed.post(alice, seed.quiz.id!);
      expect(item.quizChoice, 2);
      expect(item.quizCorrectIndex, 0);

      final stats = await endpoints.profile.stats(alice);
      expect(stats.postsRead, 1);
      expect(stats.quizzesAnswered, 1);
    });

    test('when saving a word then it is due for review later', () async {
      await endpoints.profile.completeOnboarding(
        alice,
        _onboarding('alice', []),
      );
      final word = await endpoints.word.saveFromPost(alice, seed.word.id!);
      expect(word.word, 'perspicuous');
      expect(await endpoints.word.due(alice), isEmpty);
      final again = await endpoints.word.saveFromPost(alice, seed.word.id!);
      expect(again.id, word.id);

      final reviewed = await endpoints.word.review(alice, word.id!, true);
      expect(reviewed.box, 1);
      expect(
        reviewed.dueAt.isAfter(DateTime.now().add(const Duration(days: 1))),
        isTrue,
      );
    });

    test(
      'when reading a book then progress and continue-reading are kept',
      () async {
        await endpoints.profile.completeOnboarding(
          alice,
          _onboarding('alice', []),
        );
        final detail = await endpoints.book.detail(alice, seed.book.id!);
        expect(detail.chapters, hasLength(2));
        final chapter = await endpoints.book.chapter(alice, seed.book.id!, 1);
        expect(chapter.title, contains('Nature'));

        await endpoints.book.saveProgress(alice, seed.book.id!, 1, 0.5);
        final shelf = await endpoints.book.continueReading(alice);
        expect(shelf.single.progress.chapterPosition, 1);
        expect(shelf.single.chapterTitle, contains('Nature'));

        final results = await endpoints.book.search(alice, 'origin', null, 0);
        expect(results.map((b) => b.id), contains(seed.book.id));
      },
    );

    test('when two readers talk then comments and rooms work', () async {
      await endpoints.profile.completeOnboarding(
        alice,
        _onboarding('alice', []),
      );
      await endpoints.profile.completeOnboarding(bob, _onboarding('bob', []));

      final comment = await endpoints.comment.add(
        alice,
        seed.quiz.id!,
        'Great point!',
        null,
      );
      final reply = await endpoints.comment.add(
        bob,
        seed.quiz.id!,
        'Agreed',
        comment.comment.id,
      );
      expect(reply.comment.parentId, comment.comment.id);
      expect(
        await endpoints.comment.setLiked(bob, comment.comment.id!, true),
        1,
      );

      var thread = await endpoints.comment.list(alice, seed.quiz.id!);
      expect(thread.map((c) => c.comment.body), ['Great point!', 'Agreed']);

      // Blocking hides the blocked user's comments.
      final bobProfile = (await endpoints.profile.me(bob, 0)).profile!;
      await endpoints.moderation.setBlocked(alice, bobProfile.id!, true);
      thread = await endpoints.comment.list(alice, seed.quiz.id!);
      expect(thread.map((c) => c.comment.body), ['Great point!']);

      final rooms = await endpoints.room.list(alice);
      final science = rooms.firstWhere((r) => r.room.topic == Topic.science);
      expect(science.joined, isTrue);
      await endpoints.room.send(
        bob,
        science.room.id!,
        'Anyone reading Darwin?',
      );
      final aliceRooms = await endpoints.room.list(alice);
      // Alice blocked Bob, but unread counts still reflect the room.
      expect(
        aliceRooms.firstWhere((r) => r.room.id == science.room.id).unread,
        1,
      );
      final messages = await endpoints.room.messages(
        bob,
        science.room.id!,
        null,
      );
      expect(messages.single.message.body, 'Anyone reading Darwin?');

      final bookRoom = await endpoints.room.forBook(alice, seed.book.id!);
      final sameRoom = await endpoints.room.forBook(bob, seed.book.id!);
      expect(sameRoom.room.id, bookRoom.room.id);
    });

    test(
      'when a study break ends then it summarises what was learned',
      () async {
        await endpoints.profile.completeOnboarding(
          alice,
          _onboarding('alice', []),
        );
        final started = await endpoints.studyBreak.start(alice, 10);
        expect((await endpoints.studyBreak.active(alice))!.id, started.id);
        await endpoints.feed.recordViews(alice, [
          ViewSignal(postId: seed.quiz.id!, dwellMs: 4000),
        ]);
        await endpoints.feed.answerQuiz(alice, seed.quiz.id!, 0);
        final summary = await endpoints.studyBreak.end(alice, started.id!);
        expect(summary.postsRead, 1);
        expect(summary.quizzesCorrect, 1);
        expect(summary.continueBook!.id, seed.book.id);
        expect(await endpoints.studyBreak.active(alice), isNull);
      },
    );

    test('when the library status is requested then it is public', () async {
      final status = await endpoints.library.status(sessionBuilder);
      expect(status.booksCatalogued, greaterThanOrEqualTo(70));
      expect(status.booksReady, 1);
      expect(status.posts, 10);
    });
  });
}
