import 'dart:async';

import 'package:limick_client/limick_client.dart';

import '../client.dart';

/// Measures how long each post is on screen and reports it in batches.
/// The server uses this both to mark posts as seen and to learn what the
/// reader actually lingers on.
class ViewTracker {
  ViewTracker._();
  static final instance = ViewTracker._();

  final _visibleSince = <int, DateTime>{};
  final _pending = <int, int>{};
  Timer? _flushTimer;

  /// Posts read for at least 1.5 s in this app session.
  int readThisSession = 0;
  final DateTime sessionStart = DateTime.now();

  void visible(int postId) {
    _visibleSince.putIfAbsent(postId, DateTime.now);
  }

  void hidden(int postId) {
    final since = _visibleSince.remove(postId);
    if (since == null) return;
    final ms = DateTime.now().difference(since).inMilliseconds;
    final previous = _pending[postId] ?? 0;
    if (previous < 1500 && previous + ms >= 1500) readThisSession++;
    _pending[postId] = previous + ms;
    _flushTimer ??= Timer(const Duration(seconds: 4), flush);
  }

  /// Ends every open view, e.g. when the feed is left or the app pauses.
  void hideAll() {
    for (final id in _visibleSince.keys.toList()) {
      hidden(id);
    }
  }

  Future<void> flush() async {
    _flushTimer?.cancel();
    _flushTimer = null;
    if (_pending.isEmpty) return;
    final batch = Map.of(_pending);
    _pending.clear();
    try {
      await client.feed.recordViews([
        for (final e in batch.entries)
          ViewSignal(postId: e.key, dwellMs: e.value),
      ]);
    } catch (_) {
      // Keep the signals for the next flush if the network blipped.
      batch.forEach((k, v) => _pending[k] = (_pending[k] ?? 0) + v);
    }
  }
}
