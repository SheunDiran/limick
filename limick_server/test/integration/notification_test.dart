import 'package:limick_server/src/books/library_service.dart';
import 'package:limick_server/src/generated/protocol.dart';
import 'package:limick_server/src/official/official_service.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _aliceAuth = '550e8400-e29b-41d4-a716-446655440091';
const _bobAuth = '550e8400-e29b-41d4-a716-446655440092';

OnboardingInput _onboarding(String handle) => OnboardingInput(
  displayName: handle[0].toUpperCase() + handle.substring(1),
  handle: handle,
  interests: [Topic.science, Topic.philosophy, Topic.history],
  favoriteBookIds: [],
  dailyGoalMinutes: 10,
);

void main() {
  withServerpod('Given reader notifications', (sessionBuilder, endpoints) {
    final alice = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_aliceAuth, {}),
    );
    final bob = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(_bobAuth, {}),
    );

    late Post seedPost;

    setUp(() async {
      final session = sessionBuilder.build();
      await LibraryService.seed(session);
      await OfficialService.seed(session);

      var book = (await Book.db.findFirstRow(
        session,
        where: (t) => t.gutenbergId.equals(1228),
      ))!;
      book = await Book.db.updateRow(
        session,
        book.copyWith(
          status: BookStatus.ready,
          chapterCount: 1,
          wordCount: 1000,
        ),
      );
      final chapter = await Chapter.db.insertRow(
        session,
        Chapter(
          bookId: book.id!,
          position: 0,
          title: 'Chapter I.',
          wordCount: 1000,
          text: 'Introductory text.',
        ),
      );
      seedPost = await Post.db.insertRow(
        session,
        Post(
          bookId: book.id!,
          chapterId: chapter.id!,
          chapterPosition: 0,
          kind: PostKind.insight,
          body: 'An insight to discuss.',
          primaryTopic: Topic.science,
          passageStart: 0,
          passageEnd: 10,
        ),
      );
    });

    test(
      'when readers interact then notifications are sent for replies and likes, skipping self-actions and blocks',
      () async {
        await endpoints.profile.completeOnboarding(alice, _onboarding('alice'));
        await endpoints.profile.completeOnboarding(bob, _onboarding('bob'));

        // Alice makes a comment.
        final aliceComment = await endpoints.comment.add(
          alice,
          seedPost.id!,
          'Initial thought.',
          null,
        );

        // Bob replies to Alice's comment -> Alice receives a reply notification.
        final bobReply = await endpoints.comment.add(
          bob,
          seedPost.id!,
          'Interesting perspective.',
          aliceComment.comment.id,
        );

        expect(await endpoints.notification.unreadCount(alice), 1);
        final aliceMe = await endpoints.profile.me(alice, 0);
        expect(aliceMe.unreadNotifications, 1);

        var aliceNotifications = await endpoints.notification.list(alice, null);
        expect(aliceNotifications, hasLength(1));
        expect(aliceNotifications.first.kind, NotificationKind.reply);
        expect(aliceNotifications.first.actorHandle, 'bob');
        expect(aliceNotifications.first.commentId, bobReply.comment.id);

        // Alice replies to her own comment -> No self-notification.
        await sessionBuilder.build().caches.local.clear();
        await endpoints.comment.add(
          alice,
          seedPost.id!,
          'Follow-up by myself.',
          aliceComment.comment.id,
        );
        expect(await endpoints.notification.unreadCount(alice), 1);

        // Bob likes Alice's comment -> Alice receives commentLike notification.
        await endpoints.comment.setLiked(bob, aliceComment.comment.id!, true);
        expect(await endpoints.notification.unreadCount(alice), 2);

        aliceNotifications = await endpoints.notification.list(alice, null);
        expect(aliceNotifications, hasLength(2));
        expect(aliceNotifications.first.kind, NotificationKind.commentLike);
        expect(aliceNotifications.first.actorHandle, 'bob');

        // Alice likes her own comment -> No self-notification.
        await endpoints.comment.setLiked(alice, aliceComment.comment.id!, true);
        expect(await endpoints.notification.unreadCount(alice), 2);

        // Alice marks all as read.
        await endpoints.notification.markAllRead(alice);
        expect(await endpoints.notification.unreadCount(alice), 0);
        aliceNotifications = await endpoints.notification.list(alice, null);
        expect(aliceNotifications.every((n) => n.read), isTrue);

        // Alice blocks Bob.
        final bobProfile = (await endpoints.profile.me(bob, 0)).profile!;
        await endpoints.moderation.setBlocked(alice, bobProfile.id!, true);

        // Bob replies again -> Since Alice blocked Bob, no notification is created.
        await sessionBuilder.build().caches.local.clear();
        await endpoints.comment.add(
          bob,
          seedPost.id!,
          'Another reply from blocked Bob.',
          aliceComment.comment.id,
        );
        expect(await endpoints.notification.unreadCount(alice), 0);
      },
    );
  });
}
