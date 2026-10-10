import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/text.dart';
import 'catalog_csv.dart';
import 'gutenberg.dart';
import 'seed_books.dart';
import 'topic_mapping.dart';

/// Owns the book catalogue and the ingestion pipeline.
class LibraryService {
  static const catalogUrl =
      'https://www.gutenberg.org/cache/epub/feeds/pg_catalog.csv.gz';

  /// Inserts the curated starter library and the default rooms. Idempotent.
  static Future<void> seed(Session session) async {
    final existing = await Book.db.find(
      session,
      where: (t) => t.gutenbergId.inSet(seedBooks.map((b) => b.id).toSet()),
    );
    final byGutenbergId = {for (final b in existing) b.gutenbergId: b};
    final usedHandles = (await Book.db.find(
      session,
      where: (t) => t.featured.equals(true),
    )).map((b) => b.handle).toSet();

    final toInsert = <Book>[];
    for (final (index, seed) in seedBooks.indexed) {
      final current = byGutenbergId[seed.id];
      if (current != null) {
        // A catalogue row may exist already: promote it to a featured book.
        if (!current.featured) {
          await Book.db.updateRow(
            session,
            current.copyWith(
              featured: true,
              title: seed.title,
              author: seed.author,
              topics: seed.topics,
              primaryTopic: seed.topics.first,
              popularity: 30,
              status: current.status == BookStatus.catalogued
                  ? BookStatus.queued
                  : current.status,
              queuedAt: current.queuedAt ?? DateTime.now(),
            ),
          );
        }
        continue;
      }
      var handle = seed.handle ?? handleFromTitle(seed.title);
      if (usedHandles.contains(handle)) handle = '$handle${seed.id}';
      usedHandles.add(handle);
      toInsert.add(
        Book(
          gutenbergId: seed.id,
          title: seed.title,
          author: seed.author,
          handle: handle,
          topics: seed.topics,
          primaryTopic: seed.topics.first,
          featured: true,
          popularity: 30,
          status: BookStatus.queued,
          // Keep the curated order, so the queue ingests a spread of topics.
          queuedAt: DateTime.now().add(Duration(milliseconds: index)),
        ),
      );
    }
    if (toInsert.isNotEmpty) {
      await Book.db.insert(session, toInsert);
      session.log('Seeded ${toInsert.length} featured books.');
    }
    await _seedRooms(session);
  }

  static Future<void> _seedRooms(Session session) async {
    const descriptions = {
      Topic.medicine: 'Clinical history, anatomy and the art of healing.',
      Topic.law: 'Common law, constitutions and the ideas behind justice.',
      Topic.science: 'Discoveries, experiments and how we know what we know.',
      Topic.philosophy: 'Big questions, careful arguments.',
      Topic.psychology: 'Minds, dreams and behaviour.',
      Topic.economics: 'Markets, value and the wealth of nations.',
      Topic.history: 'Empires, revolutions and the people who lived them.',
      Topic.literature: 'Novels, characters and the stories that last.',
      Topic.poetry: 'Verse, sonnets and epics.',
      Topic.mathematics: 'Numbers, proofs and puzzles.',
      Topic.selfImprovement: 'Habits, discipline and living well.',
      Topic.politics: 'Power, liberty and government.',
    };
    final existing = (await Room.db.find(
      session,
      where: (t) => t.topic.notEquals(null),
    )).map((r) => r.topic).toSet();
    final rooms = [
      for (final entry in descriptions.entries)
        if (!existing.contains(entry.key))
          Room(
            slug: 'topic-${entry.key.name}',
            name: topicLabel(entry.key),
            description: entry.value,
            topic: entry.key,
          ),
    ];
    if (rooms.isNotEmpty) await Room.db.insert(session, rooms);
  }

  /// Imports the full Project Gutenberg catalogue (~60k English texts) so
  /// any public-domain book can be searched and ingested on demand.
  static Future<int> importCatalog(Session session) async {
    final count = await Book.db.count(session);
    if (count > 5000) return 0;

    session.log('Downloading Gutenberg catalogue...');
    final compressed = await Gutenberg.download(catalogUrl, maxAttempts: 40);
    final csv = utf8.decode(gzip.decode(compressed), allowMalformed: true);
    return importCatalogFromCsv(session, csv);
  }

  /// Parses CSV text and inserts eligible English books into the database.
  static Future<int> importCatalogFromCsv(Session session, String csv) async {
    final existingIds = (await Book.db.find(
      session,
    )).map((b) => b.gutenbergId).toSet();
    final handles = (await Book.db.find(session)).map((b) => b.handle).toSet();

    var header = true;
    var inserted = 0;
    final batch = <Book>[];
    for (final row in parseCsv(csv)) {
      if (header) {
        header = false;
        continue;
      }
      if (row.length < 9) continue;
      final id = int.tryParse(row[0]);
      if (id == null || existingIds.contains(id)) continue;
      if (row[1] != 'Text' ||
          !row[4].split(';').map((l) => l.trim()).contains('en')) {
        continue;
      }
      final title = row[3].replaceAll(RegExp(r'\s+'), ' ').trim();
      if (title.isEmpty) continue;
      final author = parseAuthors(row[5]);
      final topics = topicsFor(
        locc: row[7],
        subjects: row[6],
        bookshelves: row[8],
      );
      var handle = handleFromTitle(title);
      if (handles.contains(handle)) {
        handle = '${handle.length > 18 ? handle.substring(0, 18) : handle}$id';
      }
      handles.add(handle);
      final subjects = '${row[6]}; ${row[8]}';
      batch.add(
        Book(
          gutenbergId: id,
          title: title.length > 250 ? '${title.substring(0, 247)}...' : title,
          author: author.name,
          authorYears: author.years,
          handle: handle,
          topics: topics,
          primaryTopic: topics.first,
          subjects: subjects.length > 500
              ? subjects.substring(0, 500)
              : subjects,
        ),
      );
      if (batch.length >= 1000) {
        await Book.db.insert(session, batch);
        inserted += batch.length;
        batch.clear();
      }
    }
    if (batch.isNotEmpty) {
      await Book.db.insert(session, batch);
      inserted += batch.length;
    }
    session.log('Imported $inserted catalogue entries.');
    return inserted;
  }

  /// Puts a book in the ingestion queue. User requests jump ahead of the
  /// background queue by using an earlier queue time.
  static Future<Book> requestIngest(
    Session session,
    Book book, {
    bool userRequested = true,
  }) async {
    if (book.status == BookStatus.ready ||
        book.status == BookStatus.ingesting ||
        (book.status == BookStatus.queued && !userRequested)) {
      return book;
    }
    final queuedAt = userRequested
        ? DateTime.now().subtract(const Duration(days: 1))
        : DateTime.now();
    return Book.db.updateRow(
      session,
      book.copyWith(
        status: BookStatus.queued,
        queuedAt: queuedAt,
        ingestAttempts: book.status == BookStatus.failed
            ? 0
            : book.ingestAttempts,
      ),
    );
  }

  /// Downloads, cleans and splits the next queued books into chapters.
  static Future<void> ingestNext(Session session, {int count = 2}) async {
    final queued = await Book.db.find(
      session,
      where: (t) => t.status.equals(BookStatus.queued),
      orderBy: (t) => t.queuedAt,
      limit: count,
    );
    await Future.wait(queued.map((b) => ingest(session, b)));
  }

  static Future<void> ingest(Session session, Book book) async {
    book = await Book.db.updateRow(
      session,
      book.copyWith(
        status: BookStatus.ingesting,
        ingestAttempts: book.ingestAttempts + 1,
      ),
    );
    try {
      final raw = await Gutenberg.fetchBookText(book.gutenbergId);
      final chapters = splitIntoChapters(stripBoilerplate(raw));
      if (chapters.isEmpty) {
        throw const FormatException('No readable text found.');
      }
      await session.db.transaction((tx) async {
        await Chapter.db.deleteWhere(
          session,
          where: (t) => t.bookId.equals(book.id!),
          transaction: tx,
        );
        await Chapter.db.insert(session, [
          for (final (i, c) in chapters.indexed)
            Chapter(
              bookId: book.id!,
              position: i,
              title: c.title,
              wordCount: c.wordCount,
              text: c.text,
            ),
        ], transaction: tx);
        await Book.db.updateRow(
          session,
          book.copyWith(
            status: BookStatus.ready,
            chapterCount: chapters.length,
            wordCount: chapters.fold<int>(0, (s, c) => s + c.wordCount),
            nextChapterPosition: 0,
            nextOffset: 0,
            ingestError: null,
          ),
          transaction: tx,
        );
      });
      session.log(
        'Ingested "${book.title}" (${chapters.length} chapters).',
      );
    } catch (e) {
      final giveUp = book.ingestAttempts >= 3;
      await Book.db.updateRow(
        session,
        book.copyWith(
          status: giveUp ? BookStatus.failed : BookStatus.queued,
          ingestError: e.toString(),
          queuedAt: DateTime.now().add(const Duration(minutes: 2)),
        ),
      );
      session.log(
        'Ingest failed for "${book.title}": $e',
        level: LogLevel.warning,
      );
    }
  }
}

String topicLabel(Topic topic) => switch (topic) {
  Topic.medicine => 'Medicine',
  Topic.law => 'Law',
  Topic.science => 'Science',
  Topic.philosophy => 'Philosophy',
  Topic.psychology => 'Psychology',
  Topic.economics => 'Economics',
  Topic.history => 'History',
  Topic.literature => 'Literature',
  Topic.poetry => 'Poetry',
  Topic.mathematics => 'Mathematics',
  Topic.technology => 'Technology',
  Topic.religion => 'Religion & Myth',
  Topic.politics => 'Politics',
  Topic.biography => 'Biography',
  Topic.selfImprovement => 'Self-improvement',
  Topic.arts => 'Arts',
  Topic.education => 'Education',
  Topic.nature => 'Nature',
};
