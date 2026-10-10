import 'package:limick_server/src/books/gutenberg.dart';
import 'package:limick_server/src/books/topic_mapping.dart';
import 'package:limick_server/src/generated/protocol.dart';
import 'package:limick_server/src/util/text.dart';
import 'package:test/test.dart';

void main() {
  group('Given a passage with typographic quotes', () {
    const source =
        'He said, “It is a truth\nuniversally acknowledged.” Then left.';

    test('when the model quotes it with plain quotes then it is found', () {
      final range = findQuote(
        source,
        '"It is a truth universally acknowledged."',
      );
      expect(range, isNotNull);
      expect(source.substring(range!.start, range.end), contains('truth'));
    });

    test('when the model uses a different hyphen then it is still found', () {
      expect(
        findQuote('the so-called sophist spoke', 'the so\u2011called sophist'),
        isNotNull,
      );
    });

    test('when the model invents a quote then it is rejected', () {
      expect(
        findQuote(source, 'It is a lie universally acknowledged.'),
        isNull,
      );
    });
  });

  group('Given a book with a table of contents', () {
    final filler = List.filled(400, 'word').join(' ');
    final body =
        '''
CONTENTS

CHAPTER I. The Start

CHAPTER II. The End

CHAPTER I.
THE START

$filler

CHAPTER II.
THE END

$filler
''';

    test('when splitting then contents entries are dropped', () {
      final chapters = splitIntoChapters(body);
      expect(chapters.map((c) => c.title), [
        'Chapter I. — The Start',
        'Chapter II. — The End',
      ]);
      expect(chapters.first.wordCount, 400);
    });
  });

  test(
    'Given Gutenberg boilerplate when stripping then only the work remains',
    () {
      const raw =
          'Header\r\n*** START OF THE PROJECT GUTENBERG EBOOK X ***\r\nThe work.\r\n'
          '*** END OF THE PROJECT GUTENBERG EBOOK X ***\r\nLicence';
      expect(stripBoilerplate(raw), 'The work.');
    },
  );

  test(
    'Given catalogue metadata when mapping then topics follow LoC classes',
    () {
      expect(
        topicsFor(locc: 'RT', subjects: 'Nursing', bookshelves: '').first,
        Topic.medicine,
      );
      expect(
        topicsFor(locc: 'KD', subjects: '', bookshelves: '').first,
        Topic.law,
      );
      expect(parseAuthors('Darwin, Charles, 1809-1882').name, 'Charles Darwin');
      expect(
        parseAuthors(
          'Plato, 428? BCE-348? BCE; Jowett, Benjamin [Translator]',
        ).name,
        'Plato',
      );
    },
  );

  test('Given titles when making handles then they are short CamelCase', () {
    expect(handleFromTitle('On the Origin of Species'), 'OriginOfSpecies');
    expect(suggestUserHandle('Jane.Doe@example.com'), 'janedoe');
    expect(maskProfanity('what the shit'), 'what the s***');
  });
}
