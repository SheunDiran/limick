import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../screens/book_screen.dart';
import '../screens/post_screen.dart';
import '../state/app_state.dart';
import '../theme.dart';
import 'break_widgets.dart';
import 'common.dart';
import 'covers.dart';

/// The mark of the official @limick account.
class LimickMark extends StatelessWidget {
  final double size;
  const LimickMark({super.key, this.size = 42});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: p.accent,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      alignment: Alignment.center,
      child: Text(
        'l',
        style: serif(
          size: size * 0.62,
          weight: FontWeight.w700,
          color: p.onAccent,
          height: 1,
        ),
      ),
    );
  }
}

/// A small "official" check shown next to the platform account's name.
class OfficialBadge extends StatelessWidget {
  final double size;
  const OfficialBadge({super.key, this.size = 15});
  @override
  Widget build(BuildContext context) => Tooltip(
    message: 'Official Limick account',
    child: Icon(
      Icons.verified_rounded,
      size: size,
      color: context.palette.accent,
    ),
  );
}

/// A post from @limick: welcome, tips and daily picks built from real data.
class OfficialCard extends StatelessWidget {
  final FeedItem item;
  const OfficialCard({super.key, required this.item});

  Future<void> _act(BuildContext context) async {
    final post = item.official!;
    switch (post.action) {
      case 'openBook':
        if (post.bookId != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => BookScreen(bookId: post.bookId!)),
          );
        }
      case 'openPost':
        if (post.postId == null) return;
        try {
          final full = await client.feed.post(post.postId!);
          if (context.mounted) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => PostScreen(item: full)));
          }
        } catch (e) {
          if (context.mounted) showError(context, e);
        }
      case 'startBreak':
        await showStartBreak(context);
      case 'openRooms':
        app.tabRequest.value = 2;
      case 'openWords':
        app.tabRequest.value = 3;
      case 'openDiscover':
        app.tabRequest.value = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final post = item.official!;
    final book = item.book;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LimickMark(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Limick',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: p.ink,
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const OfficialBadge(),
                    Text(
                      '  @limick · ${timeAgo(post.createdAt)}',
                      style: TextStyle(color: p.faint, fontSize: 14.5),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  post.title,
                  style: serif(
                    size: 21,
                    weight: FontWeight.w600,
                    color: p.ink,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),
                if (book != null &&
                    post.kind == OfficialPostKind.bookOfTheDay) ...[
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BookCover(book: book, width: 76),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          post.body,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: p.ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else
                  Text(
                    post.body,
                    style: TextStyle(fontSize: 15, height: 1.5, color: p.ink),
                  ),
                if (post.actionLabel != null) ...[
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => _act(context),
                    child: Text(post.actionLabel!),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
