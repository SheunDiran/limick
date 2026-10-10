# Limick: Flutter & Serverpod project

Limick is a social feed for students and readers where every post is generated from a real public-domain book
(Project Gutenberg). It looks and scrolls like a social app, but each post links to the exact chapter it came
from. Built for the Serverpod hackathon (deadline 14 Oct 2026); planning notes live in `.private/` (gitignored).

## How the app works

- **Library pipeline** (`limick_server/lib/src/books/`, `future_calls/library_future_call.dart`): on boot,
  `LibraryService.seed` inserts ~78 curated books (`seed_books.dart`) and the topic rooms. A recurring FutureCall
  (`library-tick`, every 20 s, registered in `lib/server.dart`) ingests queued books (download with HTTP range
  resume → strip the Gutenberg licence → split into chapters in `gutenberg.dart`), imports the full Gutenberg
  catalogue once (~60k English titles), and generates posts.
- **Post generation** (`lib/src/ai/`): `PostGenerator` reads the next ~750-word passage of a book, asks Claude
  Haiku 4.5 (`claude_client.dart`, raw HTTP, JSON-schema structured output) for three posts of rotating kinds
  (insight, quote, word, thread, quiz, debate), and validates them: quotes and vocabulary must appear verbatim in
  the passage (`util/text.dart` `findQuote`). The API key is `anthropicApiKey` in `config/passwords.yaml`
  (`shared:`) or env `SERVERPOD_PASSWORD_anthropicApiKey`; without it generation pauses with a warning.
- **Feed** (`lib/src/feed/`): per-reader topic and book affinity (`topic_affinity`, `book_affinity`), updated by
  signals in `affinity.dart` (dwell time, likes, saves, comments, quiz, open-book, follows, onboarding).
  `FeedService.forYou` picks unseen candidates, scores them, then applies diversity and exploration rules.
  Low supply raises `book.popularity`, which raises that book's generation target.
- **Endpoints** (`lib/src/endpoints/`): profile (onboarding, streaks, stats, export, delete), feed, book
  (catalogue, reader, progress), comment (+ `watch` stream), room (+ `live` stream with presence), word (Leitner
  review), studyBreak, moderation, library (public status). Errors for users are `AppException`.
- **Models**: `.spy.yaml` files in `lib/src/models/`. The app's user model is `Reader` (not `UserProfile`, which
  clashes with the auth module). Server-only fields must be nullable.
- **Flutter app** (`limick_flutter/lib/`): `main.dart` (AppGate: sign-in → onboarding → HomeShell),
  `state/app_state.dart` (current reader, study break timer, theme), `state/view_tracker.dart` (dwell signals),
  `widgets/post_card.dart` (all post kinds), screens for feed, post + live comments, book profile, reader,
  discover, rooms, words, profile. Theme in `theme.dart` (ink and paper with an ember accent, Newsreader +
  Instrument Sans). Book covers are generated (`widgets/covers.dart`); no image assets.

## Serverpod notes for this codebase

- Ordering is `orderBy: (t) => t.col.desc()` (no `orderDescending` in v4).
- Raw SQL in tests runs inside a transaction, so `NOW()` is the transaction start: pass Dart timestamps instead.
- Double columns compare against doubles (`t.score > 0.0`).
- Use `flutter pub get` / `flutter analyze` for the Flutter package; `dart fix` there rewrites `pubspec.yaml`.

## Working with this project

This project is a Flutter app (frontend) backed by a Serverpod server (backend). Always build the app's backend with Serverpod.
Build for multiple users, use Serverpod's built-in authentication, which is already set up in `lib/server.dart`.

The user starts the server and Flutter app with `serverpod start`. There is no need to check if the server is running: make the changes and call the `serverpod` MCP tools as needed. If the server is not running, an informative error message will be received from the MCP server. Then STOP and ask the user to start it. NEVER start the server yourself. The Flutter app is started along with it, or can be launched from the MCP tool `spawn_flutter_app`.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload both the server and the Flutter app.

Calling `serverpod generate` directly is not needed, but might be useful to troubleshoot when an incremental generation fails.

ALWAYS use the MCP server instead of the command line. Use the MCP server to:

- `create_migration` and `apply_migrations` for database (after you change data models).
- `create_repair_migration` if the database has drifted out of sync with the migrations.
- `tail_server_logs` to read logs from the server.
- `tail_flutter_logs` to read the raw stdout/stderr of the Flutter app.
- `hot_reload` / `hot_restart` to reload or restart the server and the Flutter app. ALWAYS call `hot_restart` after doing changes in the Flutter app that may not work with normal hot reload (which is automatically applied).
- `spawn_flutter_app` to start a Flutter app declared under `serverpod: flutter_apps:` in the server `pubspec.yaml`.
- `get_flutter_app_dtd` (Dart tooling daemon) for connecting to the app through the `dart` MCP.

NEVER edit generated code. The server's `lib/src/generated/` directory and the whole `limick_client` package are rewritten by the code generator. Change the `.spy.yaml` models, the endpoints, or `lib/server.dart` instead.

Migrations are a narrow exception: the `migration.sql` of a generated migration MAY be edited by hand when the generated SQL would lose data — to add a data transformation, or to reach a destructive change through non-destructive steps. Never touch the other files in the migration directory, and keep the schema the SQL ends up with identical to `definition.sql` — new databases are created from that file and never run `migration.sql`.

Only when the server cannot be started at all, fall back to the CLI in the server package:

- `serverpod generate` to regenerate the client and the generated server code.
- `serverpod create-migration` after changing a model with a `table` (add `--force` for destructive changes). It only writes the migration; `serverpod start` applies pending migrations when it boots the server.

Tests need no Docker. `config/test.yaml` sets `database.dataPath`, so Serverpod starts and manages the test database (an embedded PostgreSQL) itself, and the project's `docker-compose.yaml` is not used for it. Just run `dart test` in the server package.

Checklist after doing changes, in this order:

- `dart analyze` (CLI)
- `dart format` (CLI)
- `create_migration` and `apply_migrations` (MCP - only if necessary)
- Do `serverpod` MCP `hot_restart` if required (hot reload is done automatically). Will also hot restart Flutter app
- Run tests, if applicable (`dart test` in the server package)
- Check `serverpod` MCP `tail_server_logs` and `tail_flutter_logs` for any issues.

If the user asks you to test the app:

1. Use `get_flutter_app_dtd` (`serverpod` MCP) to get the Flutter app's DTD
2. Pass the DTD to `connect_dart_tooling_daemon` (`dart` MCP) to connect to the app
3. Use `flutter_driver` (`dart` MCP) to navigate through the app

The app is launched from `limick_flutter/lib/driver.dart`, which starts the Flutter driver extension with text entry emulation turned off so the app stays usable by hand. To let the driver type, set `enableTextEntryEmulation: true` there and `hot_restart` the app.
