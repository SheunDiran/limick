import 'package:limick_server/src/books/library_service.dart';
import 'package:limick_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Given a book ingested with the italic-marker bug',
    (
      sessionBuilder,
      _,
    ) {
      test(
        'when the repair runs then its chapters no longer contain \$1',
        () async {
          final session = sessionBuilder.build();
          await LibraryService.seed(session);
          final book = (await Book.db.findFirstRow(
            session,
            where: (t) => t.gutenbergId.equals(12439),
          ))!;
          await LibraryService.ingest(session, book);
          final chapters = await Chapter.db.find(
            session,
            where: (t) => t.bookId.equals(book.id!),
          );
          // Simulate the old bug in one chapter.
          await Chapter.db.updateRow(
            session,
            chapters.first.copyWith(
              text: '${chapters.first.text} the \$1 word',
            ),
          );

          await ItalicsRepair.run(session);

          final broken = await Chapter.db.count(
            session,
            where: (t) => t.bookId.equals(book.id!) & t.text.like(r'%$1%'),
          );
          expect(broken, 0);
        },
        timeout: const Timeout(Duration(minutes: 2)),
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
