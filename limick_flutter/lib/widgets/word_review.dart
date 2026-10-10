import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import 'common.dart';

/// A flashcard for a saved word: recall it, reveal it, grade yourself.
class WordReviewCard extends StatefulWidget {
  final SavedWord word;
  final VoidCallback onDone;
  final bool inFeed;
  const WordReviewCard({
    super.key,
    required this.word,
    required this.onDone,
    this.inFeed = true,
  });

  @override
  State<WordReviewCard> createState() => _WordReviewCardState();
}

class _WordReviewCardState extends State<WordReviewCard> {
  bool _revealed = false;
  bool _busy = false;

  Future<void> _grade(bool remembered) async {
    setState(() => _busy = true);
    try {
      await client.word.review(widget.word.id!, remembered);
      final due = (app.me?.dueWords ?? 1) - 1;
      if (app.me != null) {
        app.setMe(app.me!.copyWith(dueWords: due < 0 ? 0 : due));
      }
      widget.onDone();
    } catch (e) {
      if (mounted) {
        showError(context, e);
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final w = widget.word;
    return Container(
      margin: widget.inFeed
          ? const EdgeInsets.fromLTRB(16, 14, 16, 14)
          : EdgeInsets.zero,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: p.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.inFeed ? 'REMEMBER THIS ONE?' : 'REVIEW',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1.6,
              color: p.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            w.word,
            style: serif(
              size: 34,
              weight: FontWeight.w600,
              color: p.ink,
              height: 1.1,
            ),
          ),
          if (w.bookTitle != null)
            Text(
              'from ${w.bookTitle}',
              style: TextStyle(fontSize: 12.5, color: p.faint),
            ),
          AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            child: _revealed
                ? Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (w.partOfSpeech.isNotEmpty)
                          Text(
                            w.partOfSpeech,
                            style: serif(
                              size: 15,
                              style: FontStyle.italic,
                              color: p.muted,
                            ),
                          ),
                        Text(
                          w.definition,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: p.ink,
                          ),
                        ),
                        if (w.example != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            '“${w.example}”',
                            style: serif(
                              size: 16,
                              style: FontStyle.italic,
                              color: p.muted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
          const SizedBox(height: 18),
          if (!_revealed)
            OutlinedButton(
              onPressed: () => setState(() => _revealed = true),
              child: const Text('Show meaning'),
            )
          else
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _busy ? null : () => _grade(false),
                    child: const Text('Forgot'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: _busy ? null : () => _grade(true),
                    child: const Text('Remembered'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
