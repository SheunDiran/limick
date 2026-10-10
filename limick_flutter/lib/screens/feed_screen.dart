import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../state/view_tracker.dart';
import '../theme.dart';
import '../widgets/break_widgets.dart';
import '../widgets/common.dart';
import '../widgets/official_card.dart';
import '../widgets/post_card.dart';
import '../widgets/word_review.dart';
import 'notifications_screen.dart';
import 'reader_screen.dart';

enum FeedMode { forYou, following }

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late final _tabs = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final narrow = MediaQuery.sizeOf(context).width < 760;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Readable(
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                floating: true,
                snap: true,
                toolbarHeight: narrow ? 56 : 8,
                titleSpacing: 20,
                title: narrow
                    ? Text(
                        'limick',
                        style: serif(
                          size: 24,
                          weight: FontWeight.w600,
                          color: p.accent,
                        ),
                      )
                    : null,
                actions: narrow
                    ? const [
                        _NotificationButton(),
                        BreakButton(),
                        SizedBox(width: 8),
                      ]
                    : null,
                bottom: TabBar(
                  controller: _tabs,
                  dividerColor: p.line,
                  indicatorColor: p.accent,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: p.ink,
                  unselectedLabelColor: p.faint,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  tabs: const [
                    Tab(text: 'For you'),
                    Tab(text: 'Following'),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabs,
              children: const [
                _FeedList(mode: FeedMode.forYou),
                _FeedList(mode: FeedMode.following),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeedList extends StatefulWidget {
  final FeedMode mode;
  const _FeedList({required this.mode});

  @override
  State<_FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<_FeedList>
    with AutomaticKeepAliveClientMixin {
  final _items = <FeedItem>[];
  final _shownIds = <int>[];
  bool _loading = false;
  bool _hasMore = true;
  bool _generating = false;
  Object? _error;
  Timer? _retry;
  final _dismissedCheckIns = <int>{};

  static const _checkInEvery = 20;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _retry?.cancel();
    ViewTracker.instance.hideAll();
    super.dispose();
  }

  Future<void> _load({bool reset = false}) async {
    if (_loading) return;
    _retry?.cancel();
    setState(() {
      _loading = true;
      if (reset) _error = null;
    });
    try {
      final FeedPage page;
      if (widget.mode == FeedMode.forYou) {
        page = await client.feed.forYou(reset ? [] : _shownIds);
      } else {
        final last = reset
            ? null
            : _items
                  .lastWhere(
                    (i) => i.post != null,
                    orElse: () => FeedItem(kind: FeedItemKind.post),
                  )
                  .post
                  ?.id;
        page = await client.feed.following(last);
      }
      if (!mounted) return;
      setState(() {
        if (reset) {
          _items.clear();
          _shownIds.clear();
          _dismissedCheckIns.clear();
        }
        for (final item in page.items) {
          final id = item.post?.id;
          if (id != null && _shownIds.contains(id)) continue;
          if (id != null) _shownIds.add(id);
          _items.add(item);
        }
        _hasMore = page.hasMore;
        _generating = page.generating;
        _error = null;
      });
      // New posts are being written for this reader: check back shortly.
      if (_generating && page.items.length < 4) {
        _retry = Timer(const Duration(seconds: 8), _load);
      }
    } catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _refresh() async {
    await ViewTracker.instance.flush();
    await _load(reset: true);
  }

  bool _onScroll(ScrollNotification n) {
    if (n.metrics.extentAfter < 1400 &&
        _hasMore &&
        !_loading &&
        _error == null) {
      _load();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final p = context.palette;

    if (_items.isEmpty) {
      if (_error != null) {
        return Empty.error(_error!, onRetry: () => _load(reset: true));
      }
      if (_loading && !_generating) return const Loading();
      if (widget.mode == FeedMode.following) {
        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            children: const [
              SizedBox(height: 80),
              Empty(
                icon: Icons.bookmarks_outlined,
                title: 'Follow a few books',
                message:
                    'Open any book and tap Follow. Its newest posts will gather here.',
              ),
            ],
          ),
        );
      }
      return _GeneratingState(onRetry: () => _load(reset: true));
    }

    // Posts, with a check-in card after every [_checkInEvery] of them.
    final entries = <Object>[];
    for (var i = 0; i < _items.length; i++) {
      entries.add(_items[i]);
      final n = (i + 1) ~/ _checkInEvery;
      if ((i + 1) % _checkInEvery == 0 && !_dismissedCheckIns.contains(n)) {
        entries.add((checkIn: n, after: _items[i]));
      }
    }
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: RefreshIndicator(
        color: p.accent,
        onRefresh: _refresh,
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 96),
          itemCount: entries.length + 1,
          itemBuilder: (context, index) {
            if (index == entries.length) return _footer(context);
            final entry = entries[index];
            if (entry is ({int checkIn, FeedItem after})) {
              return _CheckIn(
                lastItem: entry.after,
                onDismiss: () =>
                    setState(() => _dismissedCheckIns.add(entry.checkIn)),
              );
            }
            final item = entry as FeedItem;
            return Column(
              children: [
                if (item.kind == FeedItemKind.official)
                  OfficialCard(item: item)
                else if (item.kind == FeedItemKind.review)
                  WordReviewCard(
                    word: item.review!,
                    onDone: () => setState(() => _items.remove(item)),
                  )
                else
                  VisibilityDetector(
                    key: ValueKey('post-${item.post!.id}-${widget.mode.name}'),
                    onVisibilityChanged: (info) {
                      final id = item.post!.id!;
                      if (info.visibleFraction >= 0.6) {
                        ViewTracker.instance.visible(id);
                      } else {
                        ViewTracker.instance.hidden(id);
                      }
                    },
                    child: PostCard(
                      item: item,
                      onChanged: (next) {
                        final at = _items.indexWhere(
                          (x) => x.post?.id == next.post?.id,
                        );
                        if (at >= 0) _items[at] = next;
                      },
                    ),
                  ),
                Divider(color: p.line),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _footer(BuildContext context) {
    final p = context.palette;
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: OutlinedButton(
            onPressed: _load,
            child: Text(friendlyError(_error!)),
          ),
        ),
      );
    }
    if (_hasMore || _loading) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Loading(),
            if (_generating) ...[
              const SizedBox(height: 12),
              Text(
                'Writing more posts from your books…',
                style: TextStyle(color: p.faint, fontSize: 13),
              ),
            ],
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 40, 32, 40),
      child: Column(
        children: [
          Text("You're all caught up.", style: serif(size: 22, color: p.ink)),
          const SizedBox(height: 6),
          Text(
            widget.mode == FeedMode.forYou
                ? 'New posts are being written. Meanwhile, why not read a chapter?'
                : 'Follow more books to fill this tab.',
            textAlign: TextAlign.center,
            style: TextStyle(color: p.muted),
          ),
        ],
      ),
    );
  }
}

/// First-run state while the pipeline writes the reader's first posts.
class _GeneratingState extends StatefulWidget {
  final VoidCallback onRetry;
  const _GeneratingState({required this.onRetry});

  @override
  State<_GeneratingState> createState() => _GeneratingStateState();
}

class _GeneratingStateState extends State<_GeneratingState>
    with SingleTickerProviderStateMixin {
  late final _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: Tween(begin: 0.35, end: 1.0).animate(_pulse),
              child: Icon(
                Icons.auto_stories_outlined,
                size: 40,
                color: p.accent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Writing your first posts',
              style: serif(size: 26, color: p.ink),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Text(
                'Limick is reading your books and writing posts from them. This takes a moment the first time.',
                textAlign: TextAlign.center,
                style: TextStyle(color: p.muted, height: 1.5),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: widget.onRetry,
              child: const Text('Check again'),
            ),
          ],
        ),
      ),
    );
  }
}

/// A nudge after a run of posts: what you learned, and a door into the book.
class _CheckIn extends StatelessWidget {
  final FeedItem lastItem;
  final VoidCallback onDismiss;
  const _CheckIn({required this.lastItem, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final tracker = ViewTracker.instance;
    final minutes = DateTime.now().difference(tracker.sessionStart).inMinutes;
    final book = lastItem.book;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [p.accent.withValues(alpha: 0.16), p.surface],
        ),
        border: Border.all(color: p.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You learned ${tracker.readThisSession} things in ${minutes < 1 ? 'under a minute' : '$minutes min'}.',
            style: serif(
              size: 22,
              weight: FontWeight.w600,
              color: p.ink,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            book == null
                ? 'Nice. Keep going, or take a breath.'
                : 'Want the full story? Pick up ${book.title} where these posts left off.',
            style: TextStyle(color: p.muted, height: 1.5),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              if (book != null)
                FilledButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ReaderScreen(
                        book: book,
                        position: lastItem.post!.chapterPosition,
                      ),
                    ),
                  ),
                  child: const Text('Read the chapter'),
                ),
              OutlinedButton(
                onPressed: onDismiss,
                child: const Text('Keep scrolling'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: app,
      builder: (context, _) {
        final count = app.me?.unreadNotifications ?? 0;
        return IconButton(
          tooltip: 'Notifications',
          icon: Badge(
            isLabelVisible: count > 0,
            label: Text('$count'),
            child: const Icon(Icons.notifications_outlined),
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
          ),
        );
      },
    );
  }
}
