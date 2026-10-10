import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/covers.dart';
import '../widgets/post_card.dart';
import 'reader_profile_screen.dart';

/// A post with its comment thread. New comments, likes and deletions from
/// other readers arrive live over a Serverpod stream.
class PostScreen extends StatefulWidget {
  final FeedItem item;
  final ValueChanged<FeedItem>? onChanged;
  const PostScreen({super.key, required this.item, this.onChanged});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late FeedItem _item = widget.item;
  List<CommentView>? _comments;
  Object? _error;
  StreamSubscription<CommentEvent>? _live;
  Timer? _reconnect;
  final _input = TextEditingController();
  final _focus = FocusNode();
  CommentView? _replyTo;
  bool _sending = false;

  int get _postId => _item.post!.id!;

  @override
  void initState() {
    super.initState();
    _load();
    _connect();
  }

  @override
  void dispose() {
    _live?.cancel();
    _reconnect?.cancel();
    _input.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final comments = await client.comment.list(_postId);
      if (mounted) {
        setState(() {
          _comments = comments;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  void _connect() {
    _live?.cancel();
    _live = client.comment
        .watch(_postId)
        .listen(
          _onEvent,
          onError: (_) => _scheduleReconnect(),
          onDone: _scheduleReconnect,
          cancelOnError: true,
        );
  }

  void _scheduleReconnect() {
    if (!mounted) return;
    _reconnect?.cancel();
    _reconnect = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      _connect();
      _load(); // Catch up on anything missed while offline.
    });
  }

  void _onEvent(CommentEvent event) {
    final comments = _comments;
    if (comments == null || !mounted) return;
    setState(() {
      switch (event.type) {
        case LiveEventType.added:
          final c = event.comment!;
          if (comments.any((x) => x.comment.id == c.comment.id)) return;
          _insert(c);
          _item = _item.copyWith(
            post: _item.post!.copyWith(
              commentCount: _item.post!.commentCount + 1,
            ),
          );
        case LiveEventType.deleted:
          comments.removeWhere((x) => x.comment.id == event.commentId);
        case LiveEventType.liked:
          final i = comments.indexWhere((x) => x.comment.id == event.commentId);
          if (i >= 0) {
            comments[i] = comments[i].copyWith(
              comment: comments[i].comment.copyWith(likeCount: event.likeCount),
            );
          }
        case LiveEventType.presence:
          break;
      }
    });
  }

  /// Replies go right after their thread; new top-level comments go last.
  void _insert(CommentView c) {
    final comments = _comments!;
    final parent = c.comment.parentId;
    if (parent == null) {
      comments.add(c);
      return;
    }
    var at = comments.indexWhere((x) => x.comment.id == parent);
    if (at < 0) {
      comments.add(c);
      return;
    }
    at++;
    while (at < comments.length && comments[at].comment.parentId == parent) {
      at++;
    }
    comments.insert(at, c);
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      final c = await client.comment.add(_postId, text, _replyTo?.comment.id);
      _input.clear();
      setState(() {
        _comments ??= [];
        _insert(c);
        _replyTo = null;
        _item = _item.copyWith(
          post: _item.post!.copyWith(
            commentCount: _item.post!.commentCount + 1,
          ),
        );
      });
      widget.onChanged?.call(_item);
    } catch (e) {
      if (mounted) showError(context, e);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _like(CommentView c) async {
    final liked = !c.likedByMe;
    final i = _comments!.indexOf(c);
    setState(
      () => _comments![i] = c.copyWith(
        likedByMe: liked,
        comment: c.comment.copyWith(
          likeCount: c.comment.likeCount + (liked ? 1 : -1),
        ),
      ),
    );
    try {
      await client.comment.setLiked(c.comment.id!, liked);
    } catch (e) {
      if (mounted) {
        setState(() => _comments![i] = c);
        showError(context, e);
      }
    }
  }

  Future<void> _menu(CommentView c) async {
    final mine = c.author.id == app.reader?.id;
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.reply),
              title: const Text('Reply'),
              onTap: () => Navigator.pop(context, 'reply'),
            ),
            if (mine)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Delete'),
                onTap: () => Navigator.pop(context, 'delete'),
              )
            else ...[
              ListTile(
                leading: const Icon(Icons.flag_outlined),
                title: const Text('Report'),
                onTap: () => Navigator.pop(context, 'report'),
              ),
              ListTile(
                leading: const Icon(Icons.block),
                title: Text('Block @${c.author.handle}'),
                onTap: () => Navigator.pop(context, 'block'),
              ),
            ],
          ],
        ),
      ),
    );
    if (!mounted || action == null) return;
    try {
      switch (action) {
        case 'reply':
          setState(() => _replyTo = c);
          _focus.requestFocus();
        case 'delete':
          await client.comment.delete(c.comment.id!);
          setState(() => _comments!.remove(c));
        case 'report':
          await client.moderation.report(
            'comment',
            c.comment.id!,
            'Reported from the app',
          );
          if (mounted) showMessage(context, 'Thanks. We will take a look.');
        case 'block':
          await client.moderation.setBlocked(c.author.id, true);
          setState(
            () => _comments!.removeWhere((x) => x.author.id == c.author.id),
          );
          if (mounted) showMessage(context, '@${c.author.handle} is blocked.');
      }
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      appBar: AppBar(title: const Text('Post')),
      body: Readable(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  PostCard(
                    item: _item,
                    detail: true,
                    onChanged: (next) {
                      setState(() => _item = next);
                      widget.onChanged?.call(next);
                    },
                  ),
                  Divider(color: p.line),
                  if (_error != null)
                    Empty.error(_error!, onRetry: _load)
                  else if (_comments == null)
                    const Padding(padding: EdgeInsets.all(32), child: Loading())
                  else if (_comments!.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Text(
                          'No comments yet. Start the conversation.',
                          style: TextStyle(color: p.muted),
                        ),
                      ),
                    )
                  else
                    for (final c in _comments!)
                      _CommentTile(
                        view: c,
                        onLike: () => _like(c),
                        onMenu: () => _menu(c),
                      ),
                ],
              ),
            ),
            _composer(context),
          ],
        ),
      ),
    );
  }

  Widget _composer(BuildContext context) {
    final p = context.palette;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: p.line)),
      ),
      padding: EdgeInsets.fromLTRB(
        16,
        8,
        8,
        8 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_replyTo != null)
            Row(
              children: [
                Text(
                  'Replying to @${_replyTo!.author.handle}',
                  style: TextStyle(fontSize: 12.5, color: p.muted),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () => setState(() => _replyTo = null),
                ),
              ],
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _input,
                  focusNode: _focus,
                  minLines: 1,
                  maxLines: 5,
                  maxLength: 1000,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _send(),
                  decoration: const InputDecoration(
                    hintText: 'Add a comment',
                    counterText: '',
                  ),
                ),
              ),
              const SizedBox(width: 6),
              IconButton.filled(
                onPressed: _sending ? null : _send,
                icon: const Icon(Icons.arrow_upward_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final CommentView view;
  final VoidCallback onLike;
  final VoidCallback onMenu;
  const _CommentTile({
    required this.view,
    required this.onLike,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final c = view.comment;
    final reply = c.parentId != null;
    return InkWell(
      onLongPress: onMenu,
      child: Padding(
        padding: EdgeInsets.fromLTRB(reply ? 64 : 20, 14, 8, 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      ReaderProfileScreen(handle: view.author.handle),
                ),
              ),
              child: ReaderAvatar(
                name: view.author.displayName,
                hue: view.author.avatarHue,
                size: reply ? 28 : 34,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: view.author.displayName,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text:
                              '  @${view.author.handle} · ${timeAgo(c.createdAt)}',
                          style: TextStyle(color: p.faint),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13.5),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    c.deleted ? '[deleted]' : c.body,
                    style: TextStyle(
                      height: 1.45,
                      color: c.deleted ? p.faint : p.ink,
                      fontStyle: c.deleted ? FontStyle.italic : null,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: c.deleted ? null : onLike,
                  icon: Icon(
                    view.likedByMe ? Icons.favorite : Icons.favorite_border,
                    size: 17,
                    color: view.likedByMe ? p.accent : p.faint,
                  ),
                ),
                if (c.likeCount > 0)
                  Text(
                    compactCount(c.likeCount),
                    style: TextStyle(fontSize: 11.5, color: p.faint),
                  ),
              ],
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onMenu,
              icon: Icon(Icons.more_horiz, size: 18, color: p.faint),
            ),
          ],
        ),
      ),
    );
  }
}
