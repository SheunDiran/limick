import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:limick_client/limick_client.dart';
import 'package:limick_flutter/client.dart';
import 'package:limick_flutter/theme.dart';
import 'package:limick_flutter/widgets/comment_tile.dart';
import 'package:limick_flutter/widgets/covers.dart';
import 'package:limick_flutter/widgets/official_card.dart';
import 'package:limick_flutter/widgets/post_card.dart';

void main() {
  setUpAll(() {
    try {
      client = Client('http://localhost:8080');
    } catch (_) {}
  });

  final testBook = Book(
    id: 1,
    gutenbergId: 1228,
    title: 'On the Origin of Species',
    author: 'Charles Darwin',
    handle: 'OriginOfSpecies',
    topics: [Topic.science],
    primaryTopic: Topic.science,
    subjects: 'Evolution; Natural selection',
  );

  FeedItem createItem({
    required PostKind kind,
    String body = 'Variations in nature occur under diverse conditions.',
    String? quote,
    List<String>? parts,
    String? word,
    String? wordDefinition,
    String? wordPartOfSpeech,
    List<String>? quizOptions,
    int? quizAnswerIndex,
    String? quizExplanation,
    int? quizChoice,
    int? quizCorrectIndex,
    bool? debateVote,
    int agreeCount = 12,
    int disagreeCount = 3,
  }) {
    final post = Post(
      id: 101,
      bookId: testBook.id!,
      chapterId: 1,
      chapterPosition: 0,
      kind: kind,
      body: body,
      quote: quote,
      parts: parts,
      word: word,
      wordDefinition: wordDefinition,
      wordPartOfSpeech: wordPartOfSpeech,
      quizOptions: quizOptions,
      agreeCount: agreeCount,
      disagreeCount: disagreeCount,
      primaryTopic: Topic.science,
      passageStart: 0,
      passageEnd: 100,
    );
    return FeedItem(
      kind: FeedItemKind.post,
      post: post,
      book: testBook,
      chapterTitle: 'Chapter I. — Variation Under Domestication',
      quizChoice: quizChoice,
      quizCorrectIndex: quizCorrectIndex ?? quizAnswerIndex,
      quizExplanation: quizExplanation,
      debateVote: debateVote,
    );
  }

  Widget wrapWithTheme(
    Widget child, {
    Brightness brightness = Brightness.dark,
    double textScale = 1.0,
  }) {
    return MaterialApp(
      theme: buildTheme(brightness),
      home: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
        child: Scaffold(
          body: SingleChildScrollView(child: child),
        ),
      ),
    );
  }

  group('PostCard rendering across post kinds', () {
    testWidgets('renders insight post with body and handle', (tester) async {
      final item = createItem(
        kind: PostKind.insight,
        body:
            'Insight: Natural selection preserves favourable individual differences.',
      );

      await tester.pumpWidget(wrapWithTheme(PostCard(item: item)));
      await tester.pump();

      expect(find.textContaining('On the Origin of Species'), findsOneWidget);
      expect(find.textContaining('@OriginOfSpecies'), findsOneWidget);
      expect(
        find.text(
          'Insight: Natural selection preserves favourable individual differences.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('renders quote post with striking excerpt', (tester) async {
      final item = createItem(
        kind: PostKind.quote,
        quote:
            'From so simple a beginning endless forms most beautiful have been evolved.',
        body: 'The closing synthesis of Darwin\'s thesis.',
      );

      await tester.pumpWidget(wrapWithTheme(PostCard(item: item)));
      await tester.pump();

      expect(
        find.textContaining('endless forms most beautiful'),
        findsOneWidget,
      );
      expect(
        find.text('The closing synthesis of Darwin\'s thesis.'),
        findsOneWidget,
      );
    });

    testWidgets('renders word post with vocab, definition and save button', (
      tester,
    ) async {
      final item = createItem(
        kind: PostKind.word,
        word: 'perspicuous',
        wordPartOfSpeech: 'adjective',
        wordDefinition: 'Clearly expressed and easily understood.',
        quote: 'This is a perspicuous observation.',
        body: 'Used by classical authors to denote lucidity.',
      );

      await tester.pumpWidget(wrapWithTheme(PostCard(item: item)));
      await tester.pump();

      expect(find.textContaining('perspicuous'), findsWidgets);
      expect(find.textContaining('adjective'), findsOneWidget);
      expect(
        find.text('Clearly expressed and easily understood.'),
        findsOneWidget,
      );
      expect(find.textContaining('perspicuous observation'), findsOneWidget);
      expect(find.text('Save to word bank'), findsOneWidget);
    });

    testWidgets('renders thread post with expand/collapse control', (
      tester,
    ) async {
      final item = createItem(
        kind: PostKind.thread,
        body: 'How variation develops over successive generations:',
        parts: [
          'First, organisms inherit slight phenotypic deviations.',
          'Second, competition selects for individuals with survival advantages.',
        ],
      );

      await tester.pumpWidget(wrapWithTheme(PostCard(item: item)));
      await tester.pump();

      expect(
        find.text('How variation develops over successive generations:'),
        findsOneWidget,
      );
      expect(find.textContaining('Show this thread'), findsOneWidget);

      await tester.tap(find.textContaining('Show this thread'));
      await tester.pumpAndSettle();

      expect(
        find.textContaining('organisms inherit slight phenotypic deviations'),
        findsOneWidget,
      );
      expect(
        find.textContaining('competition selects for individuals'),
        findsOneWidget,
      );
    });

    testWidgets('renders quiz post with options and reveals answered state', (
      tester,
    ) async {
      final item = createItem(
        kind: PostKind.quiz,
        body: 'What primarily drives divergence of character?',
        quizOptions: [
          'Natural selection',
          'Pure coincidence',
          'Instantaneous mutation',
        ],
        quizAnswerIndex: 0,
        quizExplanation: 'Selection acts continuously on minute variations.',
        quizChoice: 0,
        quizCorrectIndex: 0,
      );

      await tester.pumpWidget(wrapWithTheme(PostCard(item: item)));
      await tester.pump();

      expect(
        find.text('What primarily drives divergence of character?'),
        findsOneWidget,
      );
      expect(find.text('Natural selection'), findsOneWidget);
      expect(find.text('Pure coincidence'), findsOneWidget);
      expect(find.textContaining('Got it.'), findsOneWidget);
      expect(
        find.textContaining('Selection acts continuously on minute variations.'),
        findsOneWidget,
      );
    });

    testWidgets('renders debate post with vote bar and percentage breakdown', (
      tester,
    ) async {
      final item = createItem(
        kind: PostKind.debate,
        body:
            'Variation is driven more by environment than internal factors. Agree or disagree?',
        agreeCount: 8,
        disagreeCount: 2,
        debateVote: true,
      );

      await tester.pumpWidget(wrapWithTheme(PostCard(item: item)));
      await tester.pump();

      expect(find.text('Agree'), findsOneWidget);
      expect(find.text('Disagree'), findsOneWidget);
      expect(find.textContaining('votes'), findsOneWidget);
    });
  });

  group('Accessibility & Scalability', () {
    testWidgets('provides Semantics labels on action buttons', (tester) async {
      final item = createItem(kind: PostKind.insight);

      await tester.pumpWidget(wrapWithTheme(PostCard(item: item)));
      await tester.pump();

      expect(find.bySemanticsLabel('Comments'), findsOneWidget);
      expect(find.bySemanticsLabel('Like'), findsOneWidget);
      expect(find.bySemanticsLabel('Save'), findsOneWidget);
      expect(find.bySemanticsLabel('Share post'), findsOneWidget);
      expect(find.bySemanticsLabel('Read chapter in book'), findsOneWidget);
    });

    testWidgets('renders cleanly without overflow at 200% text scale', (
      tester,
    ) async {
      final item = createItem(
        kind: PostKind.word,
        word: 'unambiguous',
        wordPartOfSpeech: 'adj.',
        wordDefinition: 'Not open to more than one interpretation.',
        body:
            'Test text designed to ensure high accessibility font scaling works properly.',
      );

      await tester.pumpWidget(
        wrapWithTheme(PostCard(item: item), textScale: 2.0),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Save to word bank'), findsOneWidget);
      expect(find.textContaining('unambiguous'), findsOneWidget);
    });
  });

  group('OfficialCard rendering and interactions', () {
    testWidgets('renders title, body, badge and book of the day cover', (
      tester,
    ) async {
      final officialPost = OfficialPost(
        id: 1,
        kind: OfficialPostKind.bookOfTheDay,
        title: 'Book of the Day: Origin of Species',
        body: 'The foundational text of evolutionary biology.',
        action: 'openBook',
        actionLabel: 'Read chapter',
        bookId: testBook.id,
        createdAt: DateTime.now(),
      );
      final item = FeedItem(
        kind: FeedItemKind.official,
        official: officialPost,
        book: testBook,
      );

      await tester.pumpWidget(wrapWithTheme(OfficialCard(item: item)));
      await tester.pump();

      expect(find.text('Book of the Day: Origin of Species'), findsOneWidget);
      expect(
        find.text('The foundational text of evolutionary biology.'),
        findsOneWidget,
      );
      expect(find.byType(OfficialBadge), findsOneWidget);
      expect(find.byType(BookCover), findsOneWidget);
      expect(find.text('Read chapter'), findsOneWidget);
    });

    testWidgets(
      'tapping Start a break button opens bottom sheet with Take a break',
      (
        tester,
      ) async {
        final tipPost = OfficialPost(
          id: 2,
          kind: OfficialPostKind.tip,
          title: 'Time for a study break',
          body: 'Recharge your focus with a short interval.',
          action: 'startBreak',
          actionLabel: 'Start a break',
          createdAt: DateTime.now(),
        );
        final item = FeedItem(
          kind: FeedItemKind.official,
          official: tipPost,
        );

        await tester.pumpWidget(wrapWithTheme(OfficialCard(item: item)));
        await tester.pump();

        expect(find.text('Start a break'), findsOneWidget);
        await tester.tap(find.text('Start a break'));
        await tester.pumpAndSettle();

        expect(find.text('Take a break'), findsOneWidget);
      },
    );
  });

  group('CommentTile and CommentActionSheet UI', () {
    testWidgets('Comment tile with book author shows AI · from the text tag', (
      tester,
    ) async {
      final bookAuthor = Author(
        id: 99,
        handle: 'OriginOfSpecies',
        displayName: 'On the Origin of Species',
        avatarHue: 120,
        official: true,
        bookId: 1,
      );
      final comment = Comment(
        id: 1,
        postId: 101,
        profileId: 99,
        body: 'I explore how variations arise under natural selection.',
        asBookId: 1,
        createdAt: DateTime.now(),
      );
      final view = CommentView(comment: comment, author: bookAuthor);

      await tester.pumpWidget(
        wrapWithTheme(
          CommentTile(
            view: view,
            onLike: () {},
            onMenu: () {},
          ),
        ),
      );
      await tester.pump();

      expect(find.text('AI · from the text'), findsOneWidget);
      expect(
        find.text('I explore how variations arise under natural selection.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'CommentActionSheet for book author has no Block option, while regular author does',
      (
        tester,
      ) async {
        final bookAuthor = Author(
          id: 99,
          handle: 'OriginOfSpecies',
          displayName: 'On the Origin of Species',
          avatarHue: 120,
          official: true,
          bookId: 1,
        );
        final bookComment = Comment(
          id: 1,
          postId: 101,
          profileId: 99,
          body: 'An answer from the book.',
          asBookId: 1,
          createdAt: DateTime.now(),
        );
        final bookView = CommentView(comment: bookComment, author: bookAuthor);

        await tester.pumpWidget(
          wrapWithTheme(
            CommentActionSheet(
              view: bookView,
              isMine: false,
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Reply'), findsOneWidget);
        expect(find.text('Report'), findsOneWidget);
        expect(find.textContaining('Block'), findsNothing);

        // Now for a regular human author:
        final humanAuthor = Author(
          id: 42,
          handle: 'charlie',
          displayName: 'Charlie',
          avatarHue: 200,
          official: false,
        );
        final humanComment = Comment(
          id: 2,
          postId: 101,
          profileId: 42,
          body: 'A thoughtful comment from a reader.',
          createdAt: DateTime.now(),
        );
        final humanView = CommentView(
          comment: humanComment,
          author: humanAuthor,
        );

        await tester.pumpWidget(
          wrapWithTheme(
            CommentActionSheet(
              view: humanView,
              isMine: false,
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Block @charlie'), findsOneWidget);
      },
    );
  });
}
