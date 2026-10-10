import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../screens/book_screen.dart';
import '../screens/reader_profile_screen.dart';
import '../theme.dart';
import 'common.dart';
import 'covers.dart';
import 'official_card.dart';

class BookSquare extends StatelessWidget {
  final Author author;
  final double size;
  const BookSquare({super.key, required this.author, required this.size});

  @override
  Widget build(BuildContext context) {
    final color = HSLColor.fromAHSL(
      1,
      author.avatarHue.toDouble(),
      0.5,
      0.45,
    ).toColor();
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      alignment: Alignment.center,
      child: Text(
        author.handle.isEmpty ? '?' : author.handle[0],
        style: serif(
          size: size * 0.5,
          weight: FontWeight.w600,
          color: Colors.white,
          height: 1,
        ),
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  final CommentView view;
  final VoidCallback onLike;
  final VoidCallback onMenu;

  const CommentTile({
    super.key,
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
                  builder: (_) => view.author.bookId != null
                      ? BookScreen(bookId: view.author.bookId!)
                      : ReaderProfileScreen(handle: view.author.handle),
                ),
              ),
              child: view.author.bookId != null
                  ? BookSquare(author: view.author, size: reply ? 28 : 34)
                  : view.author.official
                  ? LimickMark(size: reply ? 28 : 34)
                  : ReaderAvatar(
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
                        if (view.author.official)
                          const WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: OfficialBadge(size: 14),
                            ),
                          ),
                        if (view.author.bookId != null)
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Tag('AI · from the text', color: p.accent),
                            ),
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
                  tooltip: view.likedByMe ? 'Unlike' : 'Like',
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
              tooltip: 'More options',
              icon: Icon(Icons.more_horiz, size: 18, color: p.faint),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentActionSheet extends StatelessWidget {
  final CommentView view;
  final bool isMine;
  final ValueChanged<String>? onAction;

  const CommentActionSheet({
    super.key,
    required this.view,
    required this.isMine,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.reply),
            title: const Text('Reply'),
            onTap: () {
              Navigator.pop(context, 'reply');
              onAction?.call('reply');
            },
          ),
          if (isMine)
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context, 'delete');
                onAction?.call('delete');
              },
            )
          else ...[
            ListTile(
              leading: const Icon(Icons.flag_outlined),
              title: const Text('Report'),
              onTap: () {
                Navigator.pop(context, 'report');
                onAction?.call('report');
              },
            ),
            if (!view.author.official && view.author.bookId == null)
              ListTile(
                leading: const Icon(Icons.block),
                title: Text('Block @${view.author.handle}'),
                onTap: () {
                  Navigator.pop(context, 'block');
                  onAction?.call('block');
                },
              ),
          ],
        ],
      ),
    );
  }
}
