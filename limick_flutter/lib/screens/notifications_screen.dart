import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/covers.dart';
import 'post_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _scroll = ScrollController();
  List<ReaderNotification>? _items;
  Object? _error;
  bool _loadingMore = false;
  bool _hasMore = true;
  int? _openingPostId;

  @override
  void initState() {
    super.initState();
    _load();
    _markRead();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200 &&
        !_loadingMore &&
        _hasMore &&
        _items != null &&
        _items!.isNotEmpty) {
      _loadMore();
    }
  }

  Future<void> _markRead() async {
    try {
      await client.notification.markAllRead();
      final currentMe = app.me;
      if (currentMe != null && currentMe.unreadNotifications > 0) {
        app.setMe(currentMe.copyWith(unreadNotifications: 0));
      }
    } catch (_) {}
  }

  Future<void> _load() async {
    setState(() {
      _error = null;
    });
    try {
      final list = await client.notification.list(null);
      if (!mounted) return;
      setState(() {
        _items = list;
        _hasMore = list.length >= 20;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
    }
  }

  Future<void> _loadMore() async {
    if (_items == null || _items!.isEmpty || _loadingMore) return;
    setState(() => _loadingMore = true);
    try {
      final lastId = _items!.last.id;
      final next = await client.notification.list(lastId);
      if (!mounted) return;
      setState(() {
        _loadingMore = false;
        _items!.addAll(next);
        _hasMore = next.length >= 20;
      });
    } catch (_) {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  Future<void> _openPost(ReaderNotification n) async {
    final postId = n.postId;
    if (postId == null || _openingPostId != null) return;
    setState(() => _openingPostId = postId);
    try {
      final item = await client.feed.post(postId);
      if (!mounted) return;
      setState(() => _openingPostId = null);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => PostScreen(item: item)),
      );
    } catch (e) {
      if (mounted) {
        setState(() => _openingPostId = null);
        showError(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Notifications',
          style: serif(size: 22, weight: FontWeight.w600, color: p.ink),
        ),
      ),
      body: SafeArea(
        child: Readable(
          child: _buildBody(p),
        ),
      ),
    );
  }

  Widget _buildBody(Palette p) {
    if (_error != null) {
      return Empty.error(_error!, onRetry: _load);
    }
    if (_items == null) {
      return const Loading();
    }
    if (_items!.isEmpty) {
      return const Empty(
        icon: Icons.notifications_none_outlined,
        title: 'All caught up',
        message: 'Replies, likes, and answers from books will appear here.',
      );
    }

    return RefreshIndicator(
      color: p.accent,
      onRefresh: () async {
        await _load();
        await _markRead();
      },
      child: ListView.separated(
        controller: _scroll,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _items!.length + (_loadingMore ? 1 : 0),
        separatorBuilder: (_, _) => Divider(height: 1, color: p.line),
        itemBuilder: (context, index) {
          if (index >= _items!.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Loading(),
            );
          }
          final item = _items![index];
          return _NotificationTile(
            notification: item,
            isOpening: _openingPostId == item.postId,
            onTap: () => _openPost(item),
          );
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final ReaderNotification notification;
  final bool isOpening;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.notification,
    required this.isOpening,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (icon, iconColor, actionText) = switch (notification.kind) {
      NotificationKind.reply => (
        Icons.chat_bubble_outline_rounded,
        p.accent,
        'replied to your comment',
      ),
      NotificationKind.commentLike => (
        Icons.favorite_outline_rounded,
        p.accent,
        'liked your comment',
      ),
      NotificationKind.bookReply => (
        Icons.auto_stories_outlined,
        p.accent,
        'answered your question from the text',
      ),
    };

    final isBook = notification.kind == NotificationKind.bookReply;

    return InkWell(
      onTap: isOpening ? null : onTap,
      child: Container(
        color: notification.read
            ? Colors.transparent
            : p.raised.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ReaderAvatar(
                  name: notification.actorName,
                  hue: (notification.actorHandle.hashCode.abs()) % 360,
                  size: 40,
                ),
                Positioned(
                  right: -4,
                  bottom: -4,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: p.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 12, color: iconColor),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: p.ink,
                        fontSize: 14.5,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: notification.actorName,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        if (isBook)
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6, right: 4),
                              child: Tag('Book', color: p.accent),
                            ),
                          ),
                        TextSpan(
                          text: ' $actionText',
                          style: TextStyle(color: p.muted),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '@${notification.actorHandle}',
                        style: TextStyle(color: p.faint, fontSize: 12.5),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '·',
                        style: TextStyle(color: p.faint, fontSize: 12.5),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        timeAgo(notification.createdAt),
                        style: TextStyle(color: p.faint, fontSize: 12.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isOpening)
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else if (!notification.read)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: p.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
