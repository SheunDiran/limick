import 'package:limick_server/src/ai/llm.dart';
import 'package:limick_server/src/books/library_service.dart';
import 'package:limick_server/src/generated/protocol.dart';
import 'package:limick_server/src/official/book_replies.dart';
import 'package:limick_server/src/official/official_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _alice = '550e8400-e29b-41d4-a716-446655440011';

/// Makes one featured book ready with real-looking posts of every kind.
Future<Book> _readyBookWithPosts(Session session, {int posts = 12}) async {
  var book = (await Book.db.findFirstRow(
    session,
    where: (t) => t.gutenbergId.equals(1228),
  ))!;
  book = await Book.db.updateRow(
    session,
    book.copyWith(status: BookStatus.ready, chapterCount: 1, wordCount: 3000),
  );
  final chapter = await Chapter.db.insertRow(
    session,
    Chapter(
      bookId: book.id!,
      position: 0,
      title: 'Chapter I.',
      wordCount: 3000,
      text: 'Text.',
    ),
  );
  final kinds = PostKind.values;
  await Post.db.insert(session, [
    for (var i = 0; i < posts; i++)
      Post(
        bookId: book.id!,
        chapterId: chapter.id!,
        chapterPosition: 0,
        kind: kinds[i % kinds.length],
        body: 'Post $i about natural selection, long enough to pass.',
        word: kinds[i % kinds.length] == PostKind.word ? 'perspicuous' : null,
        wordDefinition: kinds[i % kinds.length] == PostKind.word
            ? 'Clearly expressed.'
            : null,
        primaryTopic: Topic.science,
        passageStart: 0,
        passageEnd: 5,
      ),
  ]);
  return Book.db.updateRow(session, book.copyWith(postCount: posts));
}

void main() {
  withServerpod('Given the official account', (sessionBuilder, endpoints) {
    final alice = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_alice, {}),
    );

    setUp(() async {
      final session = sessionBuilder.build();
      await LibraryService.seed(session);
      await OfficialService.seed(session);
    });

    Future<void> onboard() => endpoints.profile.completeOnboarding(
      alice,
      OnboardingInput(
        displayName: 'Alice',
        handle: 'alice',
        interests: [Topic.science, Topic.law, Topic.medicine],
        favoriteBookIds: [],
        dailyGoalMinutes: 10,
      ),
    );

    test(
      'when seeding twice then the account, welcome and tips exist once',
      () async {
        final session = sessionBuilder.build();
        await OfficialService.seed(session);
        expect(
          await Reader.db.count(session, where: (t) => t.official.equals(true)),
          1,
        );
        expect(
          await OfficialPost.db.count(
            session,
            where: (t) => t.kind.equals(OfficialPostKind.welcome),
          ),
          1,
        );
        expect(
          await OfficialPost.db.count(
            session,
            where: (t) => t.kind.equals(OfficialPostKind.tip),
          ),
          5,
        );
        // Every room got exactly one welcome message.
        final rooms = await Room.db.find(session);
        for (final room in rooms) {
          expect(room.messageCount, 1, reason: room.name);
        }
      },
    );

    test(
      'when a new reader opens the feed then the welcome comes first, once',
      () async {
        await _readyBookWithPosts(sessionBuilder.build());
        await onboard();
        final first = await endpoints.feed.forYou(alice, []);
        expect(first.items.first.kind, FeedItemKind.official);
        expect(first.items.first.official!.kind, OfficialPostKind.welcome);

        final second = await endpoints.feed.forYou(alice, []);
        final officials = second.items.where(
          (i) => i.kind == FeedItemKind.official,
        );
        expect(officials.single.official!.kind, OfficialPostKind.tip);
      },
    );

    test(
      'when there is no content yet then no daily posts are invented',
      () async {
        final session = sessionBuilder.build();
        await OfficialService.publishDaily(session);
        expect(
          await OfficialPost.db.count(
            session,
            where: (t) => t.kind.notInSet({
              OfficialPostKind.welcome,
              OfficialPostKind.tip,
            }),
          ),
          0,
        );
      },
    );

    test('when books and posts exist then daily posts use real data', () async {
      final session = sessionBuilder.build();
      final book = await _readyBookWithPosts(session);
      await OfficialService.publishDaily(session);
      await OfficialService.publishDaily(session); // Idempotent.

      final bookOfDay = await OfficialPost.db.find(
        session,
        where: (t) => t.kind.equals(OfficialPostKind.bookOfTheDay),
      );
      expect(bookOfDay.single.bookId, book.id);
      expect(bookOfDay.single.body, contains('1 chapters'));

      final word = await OfficialPost.db.findFirstRow(
        session,
        where: (t) => t.kind.equals(OfficialPostKind.wordOfTheDay),
      );
      expect(word!.title, 'Word of the day: perspicuous');

      final digest = await OfficialPost.db.findFirstRow(
        session,
        where: (t) => t.kind.equals(OfficialPostKind.weeklyDigest),
      );
      expect(digest!.body, startsWith('12 new posts written from 1 books.'));

      // The science room got today's question from a real debate post.
      final science = await Room.db.findFirstRow(
        session,
        where: (t) => t.topic.equals(Topic.science),
      );
      expect(science!.messageCount, 2);
    });

    test('when blocking the official account then it is refused', () async {
      await onboard();
      final official = await OfficialService.account(sessionBuilder.build());
      await expectLater(
        endpoints.moderation.setBlocked(alice, official.id!, true),
        throwsA(isA<AppException>()),
      );
    });

    test('when no AI keys are configured then generation is off', () async {
      expect(LlmPool.fromSession(sessionBuilder.build()), isNull);
      final status = await endpoints.library.status(sessionBuilder);
      expect(status.generationEnabled, isFalse);
    });
  });

  group('Given a comment on a book post', () {
    final book = Book(
      gutenbergId: 1,
      title: 'Walden',
      author: 'Thoreau',
      handle: 'Walden',
      topics: [Topic.nature],
      primaryTopic: Topic.nature,
    );
    Comment comment(String body, {int? asBookId}) =>
        Comment(postId: 1, profileId: 1, body: body, asBookId: asBookId);

    test('when it asks a question then the book replies', () {
      expect(BookReplies.wants(comment('Why the woods?'), book), isTrue);
    });
    test('when it mentions the book then the book replies', () {
      expect(BookReplies.wants(comment('Love this @walden'), book), isTrue);
    });
    test('when it answers the book then the book replies', () {
      expect(
        BookReplies.wants(
          comment('Fair point'),
          book,
          parent: comment('Hi', asBookId: 9),
        ),
        isTrue,
      );
    });
    test('when it is a plain statement then the book stays quiet', () {
      expect(BookReplies.wants(comment('Great post'), book), isFalse);
    });
    test('when a reader asks too often then replies are rate limited', () {
      final allowed = List.generate(15, (_) => BookReplies.allow(424242));
      expect(allowed.where((a) => a).length, 12);
    });
  });
}
