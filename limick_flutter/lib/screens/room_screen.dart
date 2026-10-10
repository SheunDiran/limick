import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/covers.dart';
import 'reader_profile_screen.dart';

/// A live public room, powered by a Serverpod stream with presence.
class RoomScreen extends StatefulWidget {
  final RoomView initial;
  const RoomScreen({super.key, required this.initial});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late RoomView _room = widget.initial;
  final _messages = <RoomMessageView>[]; // Newest first.
  bool _loading = true;
  bool _loadingOlder = false;
  bool _hasOlder = true;
  Object? _error;
  int _online = 0;
  bool _connected = false;

  StreamSubscription<RoomEvent>? _live;
  Timer? _reconnect;
  int _backoff = 1;

  final _input = TextEditingController();
  bool _sending = false;

  int get _roomId => _room.room.id!;

  @override
  void initState() {
    super.initState();
    _online = _room.onlineCount;
    _load();
    _connect();
  }

  @override
  void dispose() {
    _live?.cancel();
    _reconnect?.cancel();
    _input.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final page = await client.room.messages(_roomId, null);
      if (!mounted) return;
      setState(() {
        _messages
          ..clear()
          ..addAll(page);
        _hasOlder = page.length == 50;
        _loading = false;
        _error = null;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e;
          _loading = false;
        });
      }
    }
  }

  Future<void> _loadOlder() async {
    if (_loadingOlder || !_hasOlder || _messages.isEmpty) return;
    setState(() => _loadingOlder = true);
    try {
      final page = await client.room.messages(
        _roomId,
        _messages.last.message.id,
      );
      if (!mounted) return;
      setState(() {
        _messages.addAll(page);
        _hasOlder = page.length == 50;
      });
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loadingOlder = false);
    }
  }

  void _connect() {
    _live?.cancel();
    _live = client.room
        .live(_roomId)
        .listen(
          (event) {
            if (!mounted) return;
            if (!_connected) {
              _backoff = 1;
              setState(() => _connected = true);
            }
            setState(() {
              switch (event.type) {
                case LiveEventType.added:
                  final m = event.message!;
                  if (_messages.any((x) => x.message.id == m.message.id)) {
                    return;
                  }
                  _messages.insert(0, m);
                case LiveEventType.deleted:
                  _messages.removeWhere((x) => x.message.id == event.messageId);
                case LiveEventType.presence:
                  _online = event.onlineCount ?? _online;
                case LiveEventType.liked:
                  break;
              }
            });
          },
          onError: (_) => _scheduleReconnect(),
          onDone: _scheduleReconnect,
          cancelOnError: true,
        );
  }

  void _scheduleReconnect() {
    if (!mounted) return;
    setState(() => _connected = false);
    _reconnect?.cancel();
    _reconnect = Timer(Duration(seconds: _backoff), () {
      if (!mounted) return;
      _backoff = (_backoff * 2).clamp(1, 30);
      _connect();
      _load();
    });
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      final m = await client.room.send(_roomId, text);
      _input.clear();
      if (!_room.joined) setState(() => _room = _room.copyWith(joined: true));
      setState(() {
        if (!_messages.any((x) => x.message.id == m.message.id)) {
          _messages.insert(0, m);
        }
      });
    } catch (e) {
      if (mounted) showError(context, e);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _toggleJoin() async {
    try {
      final updated = await client.room.setJoined(_roomId, !_room.joined);
      if (mounted) {
        setState(() => _room = updated.copyWith(onlineCount: _online));
      }
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  Future<void> _messageMenu(RoomMessageView m) async {
    final mine = m.author.id == app.reader?.id;
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (mine)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Delete message'),
                onTap: () => Navigator.pop(context, 'delete'),
              )
            else ...[
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text('View @${m.author.handle}'),
                onTap: () => Navigator.pop(context, 'profile'),
              ),
              ListTile(
                leading: const Icon(Icons.flag_outlined),
                title: const Text('Report'),
                onTap: () => Navigator.pop(context, 'report'),
              ),
              ListTile(
                leading: const Icon(Icons.block),
                title: Text('Block @${m.author.handle}'),
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
        case 'delete':
          await client.room.delete(m.message.id!);
          setState(() => _messages.remove(m));
        case 'profile':
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ReaderProfileScreen(handle: m.author.handle),
            ),
          );
        case 'report':
          await client.moderation.report(
            'message',
            m.message.id!,
            'Reported from a room',
          );
          if (mounted) showMessage(context, 'Thanks. We will take a look.');
        case 'block':
          await client.moderation.setBlocked(m.author.id, true);
          setState(
            () => _messages.removeWhere((x) => x.author.id == m.author.id),
          );
      }
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_room.room.name, maxLines: 1, overflow: TextOverflow.ellipsis),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _connected ? p.good : p.faint,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  _connected
                      ? '$_online online · ${compactCount(_room.room.memberCount)} members'
                      : 'Connecting…',
                  style: TextStyle(
                    fontSize: 12,
                    color: p.muted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _toggleJoin,
            child: Text(_room.joined ? 'Leave' : 'Join'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Readable(
        child: Column(
          children: [
            Expanded(
              child: _error != null
                  ? Empty.error(_error!, onRetry: _load)
                  : _loading
                  ? const Loading()
                  : _messages.isEmpty
                  ? Empty(
                      icon: Icons.waving_hand_outlined,
                      title: 'Say hello',
                      message: _room.room.description,
                    )
                  : NotificationListener<ScrollNotification>(
                      onNotification: (n) {
                        if (n.metrics.extentAfter < 400) _loadOlder();
                        return false;
                      },
                      child: ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        itemCount: _messages.length + (_loadingOlder ? 1 : 0),
                        itemBuilder: (context, i) {
                          if (i == _messages.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Loading(),
                            );
                          }
                          final m = _messages[i];
                          final older = i + 1 < _messages.length
                              ? _messages[i + 1]
                              : null;
                          final grouped =
                              older != null &&
                              older.author.id == m.author.id &&
                              m.message.createdAt
                                      .difference(older.message.createdAt)
                                      .inMinutes <
                                  5;
                          return _Bubble(
                            message: m,
                            grouped: grouped,
                            onLongPress: () => _messageMenu(m),
                          );
                        },
                      ),
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: p.line)),
              ),
              padding: EdgeInsets.fromLTRB(
                16,
                8,
                8,
                8 + MediaQuery.paddingOf(context).bottom,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      minLines: 1,
                      maxLines: 5,
                      maxLength: 800,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                      decoration: InputDecoration(
                        hintText: 'Message ${_room.room.name}',
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
            ),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final RoomMessageView message;
  final bool grouped;
  final VoidCallback onLongPress;
  const _Bubble({
    required this.message,
    required this.grouped,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final mine = message.author.id == app.reader?.id;
    return InkWell(
      onLongPress: onLongPress,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, grouped ? 2 : 12, 16, 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              child: grouped
                  ? null
                  : ReaderAvatar(
                      name: message.author.displayName,
                      hue: message.author.avatarHue,
                      size: 32,
                    ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!grouped)
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: mine ? 'You' : message.author.displayName,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: mine ? p.accent : p.ink,
                            ),
                          ),
                          TextSpan(
                            text: '  ${timeAgo(message.message.createdAt)}',
                            style: TextStyle(color: p.faint, fontSize: 12),
                          ),
                        ],
                      ),
                      style: const TextStyle(fontSize: 13.5),
                    ),
                  Text(
                    message.message.body,
                    style: TextStyle(height: 1.45, color: p.ink),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
