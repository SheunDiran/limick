import 'package:serverpod/serverpod.dart';

import '../ai/post_generator.dart';
import '../books/library_service.dart';
import '../generated/protocol.dart';

/// The background pipeline, run on a recurring schedule. Each tick:
/// imports the Gutenberg catalogue if it is missing (retrying every
/// 15 minutes), ingests queued books and generates posts for the books
/// that need them most.
class LibraryFutureCall extends FutureCall {
  static var _warnedNoKey = false;
  static var _running = false;
  static DateTime? _lastCatalogAttempt;

  Future<void> tick(Session session) async {
    // A slow round must not overlap the next one, or two rounds could read
    // the same passage of a book.
    if (_running) return;
    _running = true;
    try {
      await LibraryService.ingestNext(session, count: 3);
      await _maybeImportCatalog(session);

      if (PostGenerator.apiKey(session) == null) {
        if (!_warnedNoKey) {
          session.log(
            'anthropicApiKey is not set in config/passwords.yaml: post generation is paused.',
            level: LogLevel.warning,
          );
          _warnedNoKey = true;
        }
        return;
      }
      await PostGenerator.generateRound(session, books: 4);
    } catch (e, stackTrace) {
      session.log(
        'Library tick failed',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
    } finally {
      _running = false;
    }
  }

  static Future<void> _maybeImportCatalog(Session session) async {
    final last = _lastCatalogAttempt;
    if (last != null && DateTime.now().difference(last).inMinutes < 15) return;
    // Let the featured books get ingested first on a fresh install.
    final stillQueued = await Book.db.count(
      session,
      where: (t) =>
          t.featured.equals(true) & t.status.equals(BookStatus.queued),
    );
    if (stillQueued > 40) return;
    _lastCatalogAttempt = DateTime.now();
    try {
      await LibraryService.importCatalog(session);
    } catch (e) {
      session.log(
        'Catalogue import failed, will retry in 15 minutes: $e',
        level: LogLevel.warning,
      );
    }
  }
}
