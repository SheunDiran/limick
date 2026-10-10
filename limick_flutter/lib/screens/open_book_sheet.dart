import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/covers.dart';
import 'reader_screen.dart';

/// "Open in book": jump to the chapter this post came from, start at the
/// beginning, or continue where you left off.
Future<void> showOpenBookSheet(BuildContext context, FeedItem item) async {
  final post = item.post!;
  final book = item.book!;
  // Fire and forget: opening the book is the strongest interest signal.
  client.feed.openedBook(post.id!).catchError((_) {});

  ReadingProgress? progress;
  try {
    progress = (await client.book.detail(book.id!)).progress;
  } catch (_) {}
  if (!context.mounted) return;

  void open(int position, {bool highlight = false, double? fraction}) {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReaderScreen(
          book: book,
          position: position,
          scrollFraction: fraction,
          highlightStart: highlight ? post.passageStart : null,
          highlightEnd: highlight ? post.passageEnd : null,
        ),
      ),
    );
  }

  await showModalBottomSheet<void>(
    context: context,
    builder: (context) {
      final p = context.palette;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BookCover(book: book, width: 54, showTitle: false),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: serif(
                            size: 20,
                            weight: FontWeight.w600,
                            color: p.ink,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(book.author, style: TextStyle(color: p.muted)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _Option(
                icon: Icons.my_location_outlined,
                title: 'Read this chapter',
                subtitle:
                    item.chapterTitle ?? 'Chapter ${post.chapterPosition + 1}',
                note: 'The passage behind this post is highlighted.',
                primary: true,
                onTap: () => open(post.chapterPosition, highlight: true),
              ),
              if (progress != null &&
                  progress.chapterPosition != post.chapterPosition)
                _Option(
                  icon: Icons.bookmark_outline,
                  title: 'Continue where you left off',
                  subtitle: 'Chapter ${progress.chapterPosition + 1}',
                  onTap: () => open(
                    progress!.chapterPosition,
                    fraction: progress.scrollFraction,
                  ),
                ),
              _Option(
                icon: Icons.first_page,
                title: 'Start from the beginning',
                subtitle:
                    '${book.chapterCount} chapters · about ${(book.wordCount / 250).round()} min',
                onTap: () => open(0),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _Option extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? note;
  final bool primary;
  final VoidCallback onTap;

  const _Option({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.note,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: primary ? p.ink : p.raised,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: primary ? p.background : p.ink),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: primary ? p.background : p.ink,
                        ),
                      ),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: primary
                              ? p.background.withValues(alpha: 0.7)
                              : p.muted,
                        ),
                      ),
                      if (note != null)
                        Text(
                          note!,
                          style: TextStyle(
                            fontSize: 12,
                            color: primary
                                ? p.background.withValues(alpha: 0.55)
                                : p.faint,
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: primary ? p.background : p.faint,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
