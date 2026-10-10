import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'room_screen.dart';

/// Public rooms: one per subject, plus the book clubs you have joined.
class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  List<RoomView>? _rooms;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final rooms = await client.room.list();
      if (mounted) {
        setState(() {
          _rooms = rooms;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  Future<void> _open(RoomView room) async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => RoomScreen(initial: room)));
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final rooms = _rooms;
    final joined = rooms?.where((r) => r.joined).toList() ?? [];
    final others = rooms?.where((r) => !r.joined).toList() ?? [];
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Readable(
          child: RefreshIndicator(
            onRefresh: _load,
            child: ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 4),
                  child: Text(
                    'Rooms',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Text(
                    'Talk books with people studying what you study.',
                    style: TextStyle(color: p.muted),
                  ),
                ),
                if (_error != null)
                  Empty.error(_error!, onRetry: _load)
                else if (rooms == null)
                  const Padding(padding: EdgeInsets.all(40), child: Loading())
                else ...[
                  if (joined.isNotEmpty) _section(context, 'Your rooms'),
                  for (final r in joined)
                    _RoomTile(room: r, onTap: () => _open(r)),
                  if (others.isNotEmpty) _section(context, 'More rooms'),
                  for (final r in others)
                    _RoomTile(room: r, onTap: () => _open(r)),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Every book has its own book club too. Open a book and tap the chat icon.',
                      style: TextStyle(fontSize: 13, color: p.faint),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(BuildContext context, String label) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
    child: Text(
      label.toUpperCase(),
      style: TextStyle(
        fontSize: 11.5,
        letterSpacing: 1.4,
        fontWeight: FontWeight.w700,
        color: context.palette.faint,
      ),
    ),
  );
}

class _RoomTile extends StatelessWidget {
  final RoomView room;
  final VoidCallback onTap;
  const _RoomTile({required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final r = room.room;
    final color = r.topic == null ? p.accent : topicColor(r.topic!);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: r.topic == null
                  ? Icon(Icons.menu_book_rounded, color: color, size: 22)
                  : Text(
                      r.name[0],
                      style: serif(
                        size: 22,
                        weight: FontWeight.w600,
                        color: color,
                        height: 1,
                      ),
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          r.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                      if (room.onlineCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: p.good,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${room.onlineCount}',
                          style: TextStyle(fontSize: 12, color: p.good),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    room.lastMessage ?? r.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: room.unread > 0 ? p.ink : p.muted,
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            if (room.unread > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: p.accent,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  room.unread > 99 ? '99+' : '${room.unread}',
                  style: TextStyle(
                    color: p.onAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            else
              Text(
                '${compactCount(r.memberCount)} members',
                style: TextStyle(fontSize: 12, color: p.faint),
              ),
          ],
        ),
      ),
    );
  }
}
