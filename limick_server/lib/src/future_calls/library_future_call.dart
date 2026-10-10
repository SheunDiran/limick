import 'package:serverpod/serverpod.dart';

import '../ai/llm.dart';
import '../ai/post_generator.dart';
import '../books/library_service.dart';
import '../generated/protocol.dart';
import '../official/official_service.dart';

/// The background pipeline, run on a recurring schedule. Each tick:
/// imports the Gutenberg catalogue if it is missing (retrying every
/// 15 minutes), ingests queued books and generates posts for the books
/// that need them most.
class LibraryFutureCall extends FutureCall {
  static var _warnedNoKey = false;
  static var _running = false;
  static DateTime? _lastCatalogAttempt;
  static DateTime? _lastDaily;

  Future<void> tick(Session session) async {
    // A slow round must not overlap the next one, or two rounds could read
    // the same passage of a book.
    if (_running) return;
    _running = true;
    try {
      await LibraryService.ingestNext(session, count: 3);
      await _maybeImportCatalog(session);
      await ItalicsRepair.run(session);
      await _maybePublishDaily(session);

      if (!LlmPool.isConfigured(session)) {
        if (!_warnedNoKey) {
          session.log(
            'No AI provider configured: add groqApiKey and/or geminiApiKey to '
            'config/passwords.yaml (shared:). Post generation is paused.',
            level: LogLevel.warning,
          );
          _warnedNoKey = true;
        }
        return;
      }
      await PostGenerator.generateRound(session);
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

  /// Daily official posts and room prompts. Checked every ten minutes; each
  /// item is published at most once per day.
  static Future<void> _maybePublishDaily(Session session) async {
    final last = _lastDaily;
    if (last != null && DateTime.now().difference(last).inMinutes < 10) return;
    _lastDaily = DateTime.now();
    try {
      await OfficialService.publishDaily(session);
    } catch (e) {
      session.log('Daily official posts failed: $e', level: LogLevel.warning);
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
