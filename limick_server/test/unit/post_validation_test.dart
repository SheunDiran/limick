import 'package:limick_server/src/ai/post_generator.dart';
import 'package:limick_server/src/ai/post_validator.dart';
import 'package:limick_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  final testBook = Book(
    id: 42,
    gutenbergId: 1228,
    title: 'On the Origin of Species',
    author: 'Charles Darwin',
    handle: 'OriginOfSpecies',
    topics: [Topic.science, Topic.nature],
    primaryTopic: Topic.science,
  );

  final testChapter = Chapter(
    id: 101,
    bookId: 42,
    position: 0,
    title: 'Chapter I. Variation Under Domestication',
    wordCount: 150,
    text:
        'When we look to the individuals of the same variety or sub-variety of our older cultivated plants and animals, '
        'one of the first points which strikes us is, that they generally differ more from each other than do the '
        'individuals of any one species or variety in a state of nature. This is a perspicuous fact of breeding.',
  );

  final passage = PassageContext(
    book: testBook,
    chapter: testChapter,
    text: testChapter.text,
    start: 0,
    end: testChapter.text.length,
  );

  Map<String, dynamic> wrap(List<Map<String, dynamic>> posts) => {
    'bookBlurb': 'A foundational treatise on evolutionary biology.',
    'posts': posts,
  };

  group('Given post validation engine', () {
    test(
      'when a post cites evidence that is not in the passage then it is rejected',
      () {
        final response = wrap([
          {
            'kind': 'insight',
            'style': 'hotTake',
            'evidence': 'Darwin says pigeons are secretly dinosaurs.',
            'body': 'hot take: pigeons are dinosaurs and Darwin knew it.',
            'quote': '',
            'topic': 'science',
          },
        ]);
        expect(validateGeneratedPosts(response, testBook, passage), isEmpty);
      },
    );

    test(
      'when a post cites real evidence then it is highlighted in the reader',
      () {
        final response = wrap([
          {
            'kind': 'insight',
            'style': 'til',
            'evidence': 'they generally differ more from each other',
            'body':
                'TIL farm animals of one breed vary more than wild animals of one species.',
            'quote': '',
            'topic': 'science',
          },
        ]);
        final validated = validateGeneratedPosts(response, testBook, passage);
        expect(validated.single.style, 'til');
        expect(
          testChapter.text.substring(
            validated.single.passageStart,
            validated.single.passageEnd,
          ),
          'they generally differ more from each other',
        );
      },
    );

    test('when quote is invented then quote post is rejected', () {
      final response = wrap([
        {
          'kind': 'quote',
          'body': 'A bold declaration on survival.',
          'quote':
              'Only the strongest individuals are destined to live forever in nature.',
          'topic': 'science',
        },
      ]);

      final validated = validateGeneratedPosts(response, testBook, passage);
      expect(validated, isEmpty);
    });

    test(
      'when quote exists in passage then quote post is accepted with recalculated offsets',
      () {
        final response = wrap([
          {
            'kind': 'quote',
            'body': 'Darwin on diversity.',
            'quote': 'they generally differ more from each other',
            'topic': 'science',
          },
        ]);

        final validated = validateGeneratedPosts(response, testBook, passage);
        expect(validated, hasLength(1));
        expect(validated.first.kind, PostKind.quote);
        expect(
          validated.first.quote,
          'they generally differ more from each other',
        );
        expect(validated.first.passageStart, greaterThan(0));
        expect(
          validated.first.passageEnd,
          greaterThan(validated.first.passageStart),
        );
      },
    );

    test('when word does not appear in passage then word post is rejected', () {
      final response = wrap([
        {
          'kind': 'word',
          'word': 'ephemeral',
          'definition': 'Lasting for a very short time.',
          'partOfSpeech': 'adjective',
          'quote': 'they generally differ more from each other',
          'body': 'A word reflecting the transient nature of life.',
          'topic': 'science',
        },
      ]);

      final validated = validateGeneratedPosts(response, testBook, passage);
      expect(validated, isEmpty);
    });

    test(
      'when word appears verbatim in passage then word post is accepted',
      () {
        final response = wrap([
          {
            'kind': 'word',
            'word': 'perspicuous',
            'definition': 'Plain to the understanding; clear.',
            'partOfSpeech': 'adjective',
            'quote': 'This is a perspicuous fact of breeding.',
            'body': 'Darwin uses perspicuous to indicate obvious clarity.',
            'topic': 'science',
          },
        ]);

        final validated = validateGeneratedPosts(response, testBook, passage);
        expect(validated, hasLength(1));
        expect(validated.first.kind, PostKind.word);
        expect(validated.first.word, 'perspicuous');
        expect(
          validated.first.wordDefinition,
          'Plain to the understanding; clear.',
        );
      },
    );

    test('when quiz has invalid answerIndex then quiz post is rejected', () {
      final negativeIndex = wrap([
        {
          'kind': 'quiz',
          'evidence': 'one of the first points which strikes us',
          'body': 'What do cultivated varieties do?',
          'options': ['They differ more', 'They are identical', 'They vanish'],
          'answerIndex': -1,
          'explanation': 'Darwin states they differ more.',
          'topic': 'science',
        },
      ]);
      expect(validateGeneratedPosts(negativeIndex, testBook, passage), isEmpty);

      final outOfBoundsIndex = wrap([
        {
          'kind': 'quiz',
          'evidence': 'one of the first points which strikes us',
          'body': 'What do cultivated varieties do?',
          'options': ['They differ more', 'They are identical', 'They vanish'],
          'answerIndex': 3,
          'explanation': 'Darwin states they differ more.',
          'topic': 'science',
        },
      ]);
      expect(
        validateGeneratedPosts(outOfBoundsIndex, testBook, passage),
        isEmpty,
      );
    });

    test(
      'when quiz has fewer than 3 options or duplicate options then it is rejected',
      () {
        final twoOptions = wrap([
          {
            'kind': 'quiz',
            'evidence': 'one of the first points which strikes us',
            'body': 'What do cultivated varieties do?',
            'options': ['They differ more', 'They are identical'],
            'answerIndex': 0,
            'topic': 'science',
          },
        ]);
        expect(validateGeneratedPosts(twoOptions, testBook, passage), isEmpty);

        final duplicateOptions = wrap([
          {
            'kind': 'quiz',
            'evidence': 'one of the first points which strikes us',
            'body': 'What do cultivated varieties do?',
            'options': ['They differ more', 'They differ more', 'They vanish'],
            'answerIndex': 0,
            'topic': 'science',
          },
        ]);
        expect(
          validateGeneratedPosts(duplicateOptions, testBook, passage),
          isEmpty,
        );
      },
    );

    test('when quiz is well-formed then it is accepted', () {
      final validQuiz = wrap([
        {
          'kind': 'quiz',
          'evidence': 'one of the first points which strikes us',
          'body': 'What do cultivated varieties do?',
          'options': ['They differ more', 'They are identical', 'They vanish'],
          'answerIndex': 0,
          'explanation':
              'Darwin observes greater variation under domestication.',
          'topic': 'science',
        },
      ]);

      final validated = validateGeneratedPosts(validQuiz, testBook, passage);
      expect(validated, hasLength(1));
      expect(validated.first.quizAnswerIndex, 0);
      expect(validated.first.quizOptions, hasLength(3));
    });

    test(
      'when duplicate post kinds are returned then only the first is kept',
      () {
        final response = wrap([
          {
            'kind': 'insight',
            'evidence': 'one of the first points which strikes us',
            'body': 'First insight on variation under domestication.',
            'topic': 'science',
          },
          {
            'kind': 'insight',
            'evidence': 'one of the first points which strikes us',
            'body': 'Second insight covering another biological concept.',
            'topic': 'science',
          },
        ]);

        final validated = validateGeneratedPosts(response, testBook, passage);
        expect(validated, hasLength(1));
        expect(validated.first.body, contains('First insight'));
      },
    );

    test('when thread has fewer than 2 parts then it is rejected', () {
      final response = wrap([
        {
          'kind': 'thread',
          'evidence': 'one of the first points which strikes us',
          'body': 'Opening hook of an evolutionary thread.',
          'parts': ['Single follow-up part that is insufficient.'],
          'topic': 'science',
        },
      ]);

      final validated = validateGeneratedPosts(response, testBook, passage);
      expect(validated, isEmpty);
    });

    test('when debate post has body and explanation then it is accepted', () {
      final response = wrap([
        {
          'kind': 'debate',
          'evidence': 'one of the first points which strikes us',
          'body':
              'Domestic varieties diverge faster than wild species. Agree or disagree?',
          'explanation':
              'Proponents point to artificial selection; skeptics point to natural limits.',
          'topic': 'science',
        },
      ]);

      final validated = validateGeneratedPosts(response, testBook, passage);
      expect(validated, hasLength(1));
      expect(validated.first.kind, PostKind.debate);
      expect(validated.first.quizExplanation, contains('artificial selection'));
    });
  });

  test(
    'Given a post with em dashes when humanized then they become hyphens, quotes untouched',
    () {
      final post = Post(
        bookId: 1,
        chapterId: 1,
        chapterPosition: 0,
        kind: PostKind.insight,
        body: 'Darwin\u2014of all people\u2014saw it first.',
        quote: 'a quote\u2014kept verbatim',
        primaryTopic: Topic.science,
        passageStart: 0,
        passageEnd: 1,
      );
      final human = humanize(post);
      expect(human.body, 'Darwin - of all people - saw it first.');
      expect(human.quote, 'a quote\u2014kept verbatim');
    },
  );
}
