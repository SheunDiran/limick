import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../screens/reader_screen.dart';
import '../state/app_state.dart';
import '../state/view_tracker.dart';
import '../theme.dart';
import 'common.dart';

String _clock(Duration d) =>
    '${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

/// Compact control: a timer icon, or a live countdown pill during a break.
class BreakButton extends StatelessWidget {
  const BreakButton({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ListenableBuilder(
      listenable: app,
      builder: (context, _) {
        if (app.activeBreak == null) {
          return IconButton(
            tooltip: 'Start a study break',
            onPressed: () => showStartBreak(context),
            icon: const Icon(Icons.timer_outlined),
          );
        }
        return Material(
          color: p.accent.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(99),
          child: InkWell(
            borderRadius: BorderRadius.circular(99),
            onTap: () => _confirmEnd(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.timer_outlined, size: 16, color: p.accent),
                  const SizedBox(width: 6),
                  Text(
                    _clock(app.breakRemaining),
                    style: TextStyle(
                      color: p.accent,
                      fontWeight: FontWeight.w700,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// The larger version for the desktop side rail.
class BreakCard extends StatelessWidget {
  const BreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ListenableBuilder(
      listenable: app,
      builder: (context, _) {
        final b = app.activeBreak;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: b == null ? p.surface : p.accent.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: b == null ? p.line : p.accent.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                b == null ? 'Study break' : 'On a break',
                style: TextStyle(fontWeight: FontWeight.w700, color: p.ink),
              ),
              const SizedBox(height: 4),
              if (b == null)
                Text(
                  'Scroll with a time limit.',
                  style: TextStyle(fontSize: 13, color: p.muted),
                )
              else
                Text(
                  _clock(app.breakRemaining),
                  style: serif(
                    size: 34,
                    weight: FontWeight.w600,
                    color: p.accent,
                  ),
                ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => b == null
                      ? showStartBreak(context)
                      : _confirmEnd(context),
                  child: Text(b == null ? 'Start' : 'End now'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> showStartBreak(BuildContext context) async {
  final goal = app.reader?.dailyGoalMinutes ?? 15;
  final options = {5, 10, 15, goal}.toList()..sort();
  final minutes = await showModalBottomSheet<int>(
    context: context,
    builder: (context) {
      final p = context.palette;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Take a break',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 6),
              Text(
                "Scroll as much as you like. When time's up, we'll show you what you learned and send you back to work.",
                style: TextStyle(color: p.muted, height: 1.5),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  for (final m in options)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context, m),
                          child: Text('$m min'),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
  if (minutes == null || !context.mounted) return;
  try {
    await app.startBreak(minutes);
    if (context.mounted) {
      showMessage(context, 'Break started: $minutes minutes. Enjoy.');
    }
  } catch (e) {
    if (context.mounted) showError(context, e);
  }
}

Future<void> _confirmEnd(BuildContext context) async {
  final end = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('End your break?'),
      content: Text('${_clock(app.breakRemaining)} left.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Keep going'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('End break'),
        ),
      ],
    ),
  );
  if (end != true || !context.mounted) return;
  try {
    await ViewTracker.instance.flush();
    final summary = await app.endBreak();
    if (summary != null && context.mounted) {
      await showBreakSummary(context, summary);
    }
  } catch (e) {
    if (context.mounted) showError(context, e);
  }
}

/// "Break's over" with what the reader learned, and a way to keep reading
/// the book they spent the most time with.
Future<void> showBreakSummary(BuildContext context, BreakSummary summary) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final p = context.palette;
      final minutes = summary.studyBreak.endedAt!
          .difference(summary.studyBreak.startedAt)
          .inMinutes;
      final learned = summary.postsRead + summary.wordsSaved;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Break's over.",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                learned == 0
                    ? 'A real rest. Back to it.'
                    : 'In ${minutes < 1 ? 'under a minute' : '$minutes min'} you learned $learned new things.',
                style: TextStyle(color: p.muted, fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  _Metric(value: '${summary.postsRead}', label: 'posts read'),
                  _Metric(value: '${summary.wordsSaved}', label: 'words saved'),
                  _Metric(
                    value: summary.quizzesAnswered == 0
                        ? '–'
                        : '${summary.quizzesCorrect}/${summary.quizzesAnswered}',
                    label: 'quiz score',
                  ),
                ],
              ),
              if (summary.books.isNotEmpty) ...[
                const SizedBox(height: 18),
                Text(
                  'From ${summary.books.take(3).join(', ')}',
                  style: TextStyle(color: p.faint, fontSize: 13, height: 1.5),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to studying'),
                ),
              ),
              if (summary.continueBook != null) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ReaderScreen(
                            book: summary.continueBook!,
                            position: summary.continueChapter ?? 0,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Save my place in ${summary.continueBook!.title}',
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}

class _Metric extends StatelessWidget {
  final String value;
  final String label;
  const _Metric({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: serif(size: 32, weight: FontWeight.w600, color: p.ink),
          ),
          Text(label, style: TextStyle(fontSize: 12.5, color: p.muted)),
        ],
      ),
    );
  }
}
