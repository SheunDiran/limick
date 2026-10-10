import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../state/view_tracker.dart';
import '../theme.dart';
import '../widgets/break_widgets.dart';
import '../widgets/common.dart';
import '../widgets/covers.dart';
import 'book_screen.dart';
import 'discover_screen.dart';
import 'feed_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'reader_screen.dart';
import 'rooms_screen.dart';
import 'words_screen.dart';

/// The signed-in app: bottom navigation on phones, a side rail and a context
/// panel on wide screens.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> with WidgetsBindingObserver {
  int _tab = 0;
  StreamSubscription<StudyBreak>? _breakDone;

  static const _destinations = [
    (Icons.home_outlined, Icons.home_rounded, 'Home'),
    (Icons.explore_outlined, Icons.explore, 'Discover'),
    (Icons.forum_outlined, Icons.forum, 'Rooms'),
    (Icons.style_outlined, Icons.style, 'Words'),
    (Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _breakDone = app.breakFinished.stream.listen((_) => _finishBreak());
    app.tabRequest.addListener(_switchTab);
  }

  void _switchTab() {
    final tab = app.tabRequest.value;
    if (tab == null) return;
    app.tabRequest.value = null;
    // Leave any pushed screens so the tab is visible.
    Navigator.of(context).popUntil((route) => route.isFirst);
    setState(() => _tab = tab);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _breakDone?.cancel();
    app.tabRequest.removeListener(_switchTab);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      ViewTracker.instance.hideAll();
      ViewTracker.instance.flush();
    }
    if (state == AppLifecycleState.resumed) app.refresh();
  }

  Future<void> _finishBreak() async {
    if (!mounted) return;
    try {
      await ViewTracker.instance.flush();
      final summary = await app.endBreak();
      if (summary != null && mounted) await showBreakSummary(context, summary);
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final width = MediaQuery.sizeOf(context).width;
    final rail = width >= 760;
    final panel = width >= 1180;

    final pages = IndexedStack(
      index: _tab,
      children: const [
        FeedScreen(),
        DiscoverScreen(),
        RoomsScreen(),
        WordsScreen(),
        ProfileScreen(),
      ],
    );

    if (!rail) {
      return Scaffold(
        body: pages,
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: p.line)),
          ),
          child: NavigationBar(
            selectedIndex: _tab,
            onDestinationSelected: (i) => setState(() => _tab = i),
            destinations: [
              for (final d in _destinations)
                NavigationDestination(
                  icon: _badged(d.$3, Icon(d.$1)),
                  selectedIcon: _badged(d.$3, Icon(d.$2)),
                  label: d.$3,
                ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: width >= 1280 ? 240 : 84,
            child: _SideNav(
              index: _tab,
              expanded: width >= 1280,
              onSelect: (i) => setState(() => _tab = i),
              badge: _badged,
            ),
          ),
          VerticalDivider(width: 1, color: p.line),
          Expanded(child: pages),
          if (panel) ...[
            VerticalDivider(width: 1, color: p.line),
            const SizedBox(width: 340, child: _ContextPanel()),
          ],
        ],
      ),
    );
  }

  Widget _badged(String label, Widget icon) {
    if (label != 'Words') return icon;
    return ListenableBuilder(
      listenable: app,
      builder: (context, _) {
        final due = app.me?.dueWords ?? 0;
        return due > 0 ? Badge(label: Text('$due'), child: icon) : icon;
      },
    );
  }
}

class _SideNav extends StatelessWidget {
  final int index;
  final bool expanded;
  final ValueChanged<int> onSelect;
  final Widget Function(String, Widget) badge;

  const _SideNav({
    required this.index,
    required this.expanded,
    required this.onSelect,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: expanded ? 16 : 12,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: expanded
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: expanded ? 14 : 0,
                right: expanded ? 4 : 0,
                bottom: expanded ? 20 : 16,
              ),
              child: Row(
                mainAxisAlignment: expanded
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  Text(
                    expanded ? 'limick' : 'l',
                    style: serif(
                      size: 28,
                      weight: FontWeight.w600,
                      color: p.accent,
                    ),
                  ),
                  if (expanded) const _SideNavNotificationBell(),
                ],
              ),
            ),
            if (!expanded) ...[
              const _SideNavNotificationBell(),
              const SizedBox(height: 12),
            ],
            for (final (i, d) in _HomeShellState._destinations.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Material(
                  color: i == index ? p.raised : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => onSelect(i),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: expanded ? 14 : 16,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisSize: expanded
                            ? MainAxisSize.max
                            : MainAxisSize.min,
                        children: [
                          badge(
                            d.$3,
                            Icon(
                              i == index ? d.$2 : d.$1,
                              color: i == index ? p.ink : p.muted,
                            ),
                          ),
                          if (expanded) ...[
                            const SizedBox(width: 14),
                            Text(
                              d.$3,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: i == index
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: i == index ? p.ink : p.muted,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            const Spacer(),
            if (expanded) const BreakCard() else const BreakButton(),
          ],
        ),
      ),
    );
  }
}

/// The right-hand panel on wide screens: live library numbers and the
/// reader's shelf.
class _ContextPanel extends StatefulWidget {
  const _ContextPanel();

  @override
  State<_ContextPanel> createState() => _ContextPanelState();
}

class _ContextPanelState extends State<_ContextPanel> {
  LibraryStatus? _status;
  List<ContinueReading> _shelf = [];
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _load();
    _poll = Timer.periodic(const Duration(seconds: 30), (_) => _load());
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final results = await Future.wait([
        client.library.status(),
        client.book.continueReading(),
      ]);
      if (!mounted) return;
      setState(() {
        _status = results[0] as LibraryStatus;
        _shelf = results[1] as List<ContinueReading>;
      });
    } catch (_) {
      // The panel is supplementary; keep the last good values.
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final s = _status;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        children: [
          if (_shelf.isNotEmpty) ...[
            Text(
              'Continue reading',
              style: TextStyle(fontWeight: FontWeight.w700, color: p.ink),
            ),
            const SizedBox(height: 14),
            for (final c in _shelf.take(3))
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ReaderScreen(
                        book: c.book,
                        position: c.progress.chapterPosition,
                        scrollFraction: c.progress.scrollFraction,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      BookCover(book: c.book, width: 40, showTitle: false),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.book.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              c.chapterTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12.5, color: p.muted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 18),
          ],
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: p.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: p.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: p.good,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Library, live',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: p.ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (s == null)
                  const Loading()
                else ...[
                  _stat(
                    context,
                    compactCount(s.booksCatalogued),
                    'books in the catalogue',
                  ),
                  _stat(context, compactCount(s.booksReady), 'ready to read'),
                  _stat(
                    context,
                    compactCount(s.posts),
                    'posts written from them',
                  ),
                  if (s.booksQueued > 0)
                    _stat(
                      context,
                      compactCount(s.booksQueued),
                      'being prepared now',
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Every book is in the public domain, courtesy of Project Gutenberg. '
            'Posts are written by AI from the original text; quotes are checked word for word.',
            style: TextStyle(fontSize: 12, color: p.faint, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _stat(BuildContext context, String value, String label) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 72,
            child: Text(
              value,
              style: serif(size: 24, weight: FontWeight.w600, color: p.ink),
            ),
          ),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: p.muted, fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }
}

/// Opens a book's profile from anywhere.
void openBook(BuildContext context, int bookId) => Navigator.of(context).push(
  MaterialPageRoute(builder: (_) => BookScreen(bookId: bookId)),
);

class _SideNavNotificationBell extends StatelessWidget {
  const _SideNavNotificationBell();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ListenableBuilder(
      listenable: app,
      builder: (context, _) {
        final count = app.me?.unreadNotifications ?? 0;
        return IconButton(
          tooltip: 'Notifications',
          icon: Badge(
            isLabelVisible: count > 0,
            label: Text('$count'),
            child: Icon(Icons.notifications_outlined, color: p.muted),
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
          ),
        );
      },
    );
  }
}
