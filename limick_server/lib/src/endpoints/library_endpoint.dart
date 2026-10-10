import 'package:serverpod/serverpod.dart';

import '../ai/llm.dart';
import '../generated/protocol.dart';

/// Public, live numbers about the library pipeline.
class LibraryEndpoint extends Endpoint {
  Future<LibraryStatus> status(Session session) async {
    const key = 'library-status';
    final cached = await session.caches.local.get<LibraryStatus>(key);
    if (cached != null) return cached;
    final status = LibraryStatus(
      booksCatalogued: await Book.db.count(session),
      booksReady: await Book.db.count(
        session,
        where: (t) => t.status.equals(BookStatus.ready),
      ),
      booksQueued: await Book.db.count(
        session,
        where: (t) =>
            t.status.equals(BookStatus.queued) |
            t.status.equals(BookStatus.ingesting),
      ),
      posts: await Post.db.count(session),
      generationEnabled: LlmPool.isConfigured(session),
    );
    await session.caches.local.put(
      key,
      status,
      lifetime: const Duration(seconds: 20),
    );
    return status;
  }
}
