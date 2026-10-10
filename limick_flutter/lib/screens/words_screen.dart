import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/word_review.dart';

/// The word bank: everything saved from posts, with a review session for
/// the words that are due.
class WordsScreen extends StatefulWidget {
  const WordsScreen({super.key});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  List<SavedWord>? _words;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final words = await client.word.list();
      if (mounted) {
        setState(() {
          _words = words;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  List<SavedWord> get _due =>
      (_words ?? []).where((w) => !w.dueAt.isAfter(DateTime.now())).toList();

  Future<void> _review() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => _ReviewSession(words: _due)));
    _load();
  }

  Future<void> _remove(SavedWord w) async {
    setState(() => _words!.remove(w));
    try {
      await client.word.remove(w.id!);
    } catch (e) {
      if (mounted) {
        showError(context, e);
        _load();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final words = _words;
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
                    'Word bank',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Text(
                    words == null
                        ? ''
                        : '${words.length} words saved from your reading.',
                    style: TextStyle(color: p.muted),
                  ),
                ),
                if (_error != null)
                  Empty.error(_error!, onRetry: _load)
                else if (words == null)
                  const Padding(padding: EdgeInsets.all(40), child: Loading())
                else if (words.isEmpty)
                  const Empty(
                    icon: Icons.style_outlined,
                    title: 'No words yet',
                    message:
                        'When a word post teaches you something, tap "Save to word bank". It will come back for review at the right time.',
                  )
                else ...[
                  if (_due.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: p.accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_due.length} due for review',
                                    style: serif(
                                      size: 22,
                                      weight: FontWeight.w600,
                                      color: p.ink,
                                    ),
                                  ),
                                  Text(
                                    'A minute now saves forgetting later.',
                                    style: TextStyle(
                                      color: p.muted,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FilledButton(
                              onPressed: _review,
                              child: const Text('Review'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  for (final w in words)
                    Dismissible(
                      key: ValueKey(w.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: p.bad.withValues(alpha: 0.15),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 24),
                        child: Icon(Icons.delete_outline, color: p.bad),
                      ),
                      onDismissed: (_) => _remove(w),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 4,
                        ),
                        title: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: w.word,
                                style: serif(
                                  size: 20,
                                  weight: FontWeight.w600,
                                  color: p.ink,
                                ),
                              ),
                              if (w.partOfSpeech.isNotEmpty)
                                TextSpan(
                                  text: '  ${w.partOfSpeech}',
                                  style: serif(
                                    size: 14,
                                    style: FontStyle.italic,
                                    color: p.muted,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          w.definition,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: p.muted, height: 1.4),
                        ),
                        trailing: _Strength(box: w.box),
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
}

/// Five dots showing how well a word has stuck.
class _Strength extends StatelessWidget {
  final int box;
  const _Strength({required this.box});
  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Tooltip(
      message: box == 0 ? 'New' : 'Remembered $box times in a row',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < 5; i++)
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(left: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < box ? p.accent : p.line,
              ),
            ),
        ],
      ),
    );
  }
}

class _ReviewSession extends StatefulWidget {
  final List<SavedWord> words;
  const _ReviewSession({required this.words});

  @override
  State<_ReviewSession> createState() => _ReviewSessionState();
}

class _ReviewSessionState extends State<_ReviewSession> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final done = _index >= widget.words.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(done ? 'Done' : '${_index + 1} of ${widget.words.length}'),
      ),
      body: Readable(
        maxWidth: 520,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: done
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_outline, size: 44, color: p.good),
                      const SizedBox(height: 16),
                      Text(
                        'All caught up.',
                        style: serif(size: 28, color: p.ink),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Back to the word bank'),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: WordReviewCard(
                      key: ValueKey(widget.words[_index].id),
                      word: widget.words[_index],
                      inFeed: false,
                      onDone: () => setState(() => _index++),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
