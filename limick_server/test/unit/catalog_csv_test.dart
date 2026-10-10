import 'package:limick_server/src/books/catalog_csv.dart';
import 'package:limick_server/src/books/topic_mapping.dart';
import 'package:limick_server/src/generated/protocol.dart';
import 'package:limick_server/src/util/text.dart';
import 'package:test/test.dart';

void main() {
  group('Given Gutenberg catalog CSV parsing', () {
    const csvFixture =
        '''Text#,Type,Issued,Title,Language,Authors,Subjects,LoCC,Bookshelves
11,Text,1994-01-01,Alice's Adventures in Wonderland,en,"Carroll, Lewis, 1832-1898",Fantasy fiction; Children's stories,PR,Children's Literature
12,Sound,1994-01-01,Through the Looking-Glass,en,"Carroll, Lewis, 1832-1898",Fantasy fiction,PR,Children's Literature
13,Text,1994-01-01,Le Tour du monde en quatre-vingts jours,fr,"Verne, Jules, 1828-1905",Adventure stories,PQ,French Literature
14,Text,1994-01-01,Treatise on Human Nature,en;fr,"Hume, David, 1711-1776",Philosophy; Ethics,B,Philosophy
not-an-id,Text,1994-01-01,Corrupted Entry,en,"Nobody",N/A,Z,None
''';

    test(
      'when parsing rows then non-Text and non-English rows are filtered',
      () {
        final rows = parseCsv(csvFixture).toList();
        expect(rows, hasLength(6)); // 1 header + 5 data rows

        final validEntries =
            <
              ({
                int id,
                String title,
                String author,
                Topic topic,
                String handle,
              })
            >[];
        final handles = <String>{};

        for (var i = 1; i < rows.length; i++) {
          final row = rows[i];
          if (row.length < 9) continue;
          final id = int.tryParse(row[0]);
          if (id == null) continue;
          if (row[1] != 'Text') continue;
          final languages = row[4].split(';').map((l) => l.trim()).toList();
          if (!languages.contains('en')) continue;

          final title = row[3].replaceAll(RegExp(r'\s+'), ' ').trim();
          final author = parseAuthors(row[5]);
          final topics = topicsFor(
            locc: row[7],
            subjects: row[6],
            bookshelves: row[8],
          );

          var handle = handleFromTitle(title);
          if (handles.contains(handle)) {
            handle = '$handle$id';
          }
          handles.add(handle);

          validEntries.add((
            id: id,
            title: title,
            author: author.name,
            topic: topics.first,
            handle: handle,
          ));
        }

        // Entry 11 (Alice, Text, en) -> valid
        // Entry 12 (Sound) -> filtered
        // Entry 13 (fr only) -> filtered
        // Entry 14 (en;fr, Text) -> valid
        // Entry not-an-id -> filtered
        expect(validEntries, hasLength(2));

        final alice = validEntries.firstWhere((e) => e.id == 11);
        expect(alice.title, "Alice's Adventures in Wonderland");
        expect(alice.author, 'Lewis Carroll');
        expect(alice.topic, Topic.literature);
        expect(alice.handle, 'AliceSAdventuresInWonder');

        final hume = validEntries.firstWhere((e) => e.id == 14);
        expect(hume.title, 'Treatise on Human Nature');
        expect(hume.author, 'David Hume');
        expect(hume.topic, Topic.philosophy);
        expect(hume.handle, 'TreatiseOnHumanNature');
      },
    );

    test(
      'when duplicate titles appear then handles are deduplicated with id suffix',
      () {
        final handles = {'Essays'};
        var duplicateHandle = handleFromTitle('Essays');
        if (handles.contains(duplicateHandle)) {
          duplicateHandle =
              '${duplicateHandle.length > 18 ? duplicateHandle.substring(0, 18) : duplicateHandle}1234';
        }
        expect(duplicateHandle, 'Essays1234');
      },
    );
  });
}
