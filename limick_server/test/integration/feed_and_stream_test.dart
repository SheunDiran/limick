import 'package:limick_server/src/books/library_service.dart';
import 'package:limick_server/src/generated/protocol.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _charlie = '550e8400-e29b-41d4-a716-446655440003';
const _dana = '550e8400-e29b-41d4-a716-446655440004';

OnboardingInput _testOnboarding(String handle, List<int> favs, List<Topic> topics) =>
    OnboardingInput(
      displayName: 'Reader $handle',
      handle: handle,
      field: 'Philosophy',
      interests: topics,
      favoriteBookIds: favs,
      dailyGoalMinutes: 20,
    );

void main() {
  withServerpod('Given feed, streaming, and account operations', (sessionBuilder, endpoints) {
    final charlie = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_charlie, {}),
    );
    final dana = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_dana, {}),
    );

    late Book bookA;
    late Book bookB;
    late List<Post> postsA;

    setUp(() async {
      final session = sessionBuilder.build();
      await LibraryService.seed(session);

      // Create two distinct ready books with multiple posts
      bookA = (await Book.db.findFirstRow(session, where: (t) => t.gutenbergId.equals(1228)))!;
      bookA = await Book.db.updateRow(
        session,
        bookA.copyWith(status: BookStatus.ready, chapterCount: 3, postCount: 6),
      );

      final bookBRow = await Book.db.findFirstRow(session, where: (t) => t.gutenbergId.equals(3300));
      bookB = bookBRow != null
          ? await Book.db.updateRow(session, bookBRow.copyWith(status: BookStatus.ready, chapterCount: 2, postCount: 6))
          : await Book.db.insertRow(
              session,
              Book(
                gutenbergId: 3300,
                title: 'An Inquiry into the Nature and Causes of the Wealth of Nations',
                author: 'Adam Smith',
                handle: 'WealthOfNations',
                topics: [Topic.economics, Topic.philosophy],
                primaryTopic: Topic.economics,
                status: BookStatus.ready,
                chapterCount: 2,
                postCount: 6,
              ),
            );

      final chA = await Chapter.db.insertRow(
        session,
        Chapter(bookId: bookA.id!, position: 0, title: 'Chapter 1 of A', wordCount: 200, text: 'Darwin text.'),
      );
      final chB = await Chapter.db.insertRow(
        session,
        Chapter(bookId: bookB.id!, position: 0, title: 'Chapter 1 of B', wordCount: 200, text: 'Smith text.'),
      );

      postsA = await Post.db.insert(session, [
        for (var i = 0; i < 6; i++)
          Post(
            bookId: bookA.id!,
            chapterId: chA.id!,
            chapterPosition: 0,
            kind: PostKind.insight,
            body: 'Darwin evolutionary insight #$i with sufficient character length.',
            primaryTopic: Topic.science,
            passageStart: 0,
            passageEnd: 20,
          ),
      ]);

      postsB = await Post.db.insert(session, [
        for (var i = 0; i < 6; i++)
          Post(
            bookId: bookB.id!,
            chapterId: chB.id!,
            chapterPosition: 0,
            kind: PostKind.quote,
            quote: 'Division of labour excerpt #$i',
            body: 'Economic synthesis #$i explaining specialization in trade.',
            primaryTopic: Topic.economics,
            passageStart: 0,
            passageEnd: 20,
          ),
      ]);
    });

    group('Feed diversity and following', () {
      test('when reading feed then diversity rules prevent three consecutive posts from same book', () async {
        await endpoints.profile.completeOnboarding(
          charlie,
          _testOnboarding('charlie', [bookA.id!, bookB.id!], [Topic.science, Topic.economics, Topic.philosophy]),
        );

        final page = await endpoints.feed.forYou(charlie, []);
        expect(page.items, isNotEmpty);

        final postItems = page.items.where((i) => i.kind == FeedItemKind.post).toList();
        for (var i = 2; i < postItems.length; i++) {
          final b0 = postItems[i - 2].book!.id;
          final b1 = postItems[i - 1].book!.id;
          final b2 = postItems[i].book!.id;
          final allSame = b0 == b1 && b1 == b2;
          expect(allSame, isFalse, reason: 'Three consecutive posts should not be from book $b0');
        }
      });

      test('when library has few posts then feed flags generating as true', () async {
        await endpoints.profile.completeOnboarding(
          charlie,
          _testOnboarding('charlie', [bookA.id!], [Topic.science, Topic.economics, Topic.philosophy]),
        );

        final page = await endpoints.feed.forYou(charlie, []);
        // Total posts is 12 (< 36 limit * 3), so generating is true
        expect(page.generating, isTrue);
      });

      test('when viewing following feed then posts are ordered newest first and pageable', () async {
        await endpoints.profile.completeOnboarding(
          charlie,
          _testOnboarding('charlie', [bookB.id!], [Topic.economics, Topic.science, Topic.philosophy]),
        );

        final followingPage = await endpoints.feed.following(charlie, null);
        expect(followingPage.items, isNotEmpty);
        expect(followingPage.items.every((i) => i.book!.id == bookB.id), isTrue);

        // Verify descending order by Post id
        final ids = followingPage.items.map((i) => i.post!.id!).toList();
        for (var i = 1; i < ids.length; i++) {
          expect(ids[i], lessThan(ids[i - 1]));
        }

        // Paging with beforeId returns strictly older posts
        final firstId = ids.first;
        final paged = await endpoints.feed.following(charlie, firstId);
        expect(paged.items.every((i) => i.post!.id! < firstId), isTrue);
      });
    });

    group('Rate limiting', () {
      test('when posting comments faster than the rate window then AppException is thrown', () async {
        await endpoints.profile.completeOnboarding(
          charlie,
          _testOnboarding('charlie', [], [Topic.science, Topic.philosophy, Topic.medicine]),
        );

        final post = postsA.first;
        await endpoints.comment.add(charlie, post.id!, 'First legitimate thought.', null);

        await expectLater(
          endpoints.comment.add(charlie, post.id!, 'Spamming another thought too quickly.', null),
          throwsA(
            isA<AppException>().having((e) => e.code, 'code', 'rate_limited'),
          ),
        );
      });
    });

    group('Realtime Streams', () {
      test('when watching a post thread then new comments are streamed live', () async {
        await endpoints.profile.completeOnboarding(
          charlie,
          _testOnboarding('charlie', [], [Topic.science, Topic.philosophy, Topic.medicine]),
        );
        await endpoints.profile.completeOnboarding(
          dana,
          _testOnboarding('dana', [], [Topic.science, Topic.philosophy, Topic.medicine]),
        );

        final post = postsA.first;
        final stream = endpoints.comment.watch(dana, post.id!);
        await flushEventQueue();

        await endpoints.comment.add(charlie, post.id!, 'Hello from Charlie via stream!', null);

        await expectLater(
          stream.take(1),
          emits(
            isA<CommentEvent>()
                .having((e) => e.type, 'type', LiveEventType.added)
                .having((e) => e.comment?.comment.body, 'body', 'Hello from Charlie via stream!'),
          ),
        );
      });

      test('when connecting to live room then initial presence is broadcast and tracks online count', () async {
        await endpoints.profile.completeOnboarding(
          charlie,
          _testOnboarding('charlie', [], [Topic.science, Topic.philosophy, Topic.medicine]),
        );

        final rooms = await endpoints.room.list(charlie);
        final scienceRoom = rooms.firstWhere((r) => r.room.topic == Topic.science);

        final roomStream = endpoints.room.live(charlie, scienceRoom.room.id!);
        await flushEventQueue();

        await expectLater(
          roomStream.take(1),
          emits(
            isA<RoomEvent>()
                .having((e) => e.type, 'type', LiveEventType.presence)
                .having((e) => e.onlineCount, 'onlineCount', greaterThanOrEqualTo(1)),
          ),
        );
      });
    });

    group('Catalog CSV Import & Account Deletion', () {
      test('when importing catalogue CSV then entries are added to database', () async {
        const fixtureCsv = '''Text#,Type,Issued,Title,Language,Authors,Subjects,LoCC,Bookshelves
99991,Text,2026-01-01,The Problems of Philosophy,en,"Russell, Bertrand, 1872-1970",Epistemology; Metaphysics,BD,Philosophy
99992,Sound,2026-01-01,Audiobook Title,en,"Unknown",Music,M,Audio
''';

        final session = sessionBuilder.build();
        final inserted = await LibraryService.importCatalogFromCsv(session, fixtureCsv);
        expect(inserted, 1);

        final russell = await Book.db.findFirstRow(session, where: (t) => t.gutenbergId.equals(99991));
        expect(russell, isNotNull);
        expect(russell!.title, 'The Problems of Philosophy');
        expect(russell.author, 'Bertrand Russell');
        expect(russell.primaryTopic, Topic.philosophy);
      });

      test('when deleting account then profile, data, and AuthUser row are permanently removed', () async {
        final session = sessionBuilder.build();

        // Create AuthUser row in the auth module's table
        await AuthUser.db.insertRow(
          session,
          AuthUser(id: _charlie, createdAt: DateTime.now()),
        );

        await endpoints.profile.completeOnboarding(
          charlie,
          _testOnboarding('charlie_del', [], [Topic.science, Topic.philosophy, Topic.medicine]),
        );

        final profileBefore = await Reader.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(_charlie),
        );
        expect(profileBefore, isNotNull);

        await endpoints.profile.deleteAccount(charlie);

        final profileAfter = await Reader.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(_charlie),
        );
        expect(profileAfter, isNull);

        final authUserAfter = await AuthUser.db.findById(session, _charlie);
        expect(authUserAfter, isNull);
      });
    });
  });
}
