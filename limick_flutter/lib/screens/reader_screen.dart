import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// The reader: one chapter at a time, comfortable type, the source passage
/// of a post highlighted, and the reading position saved on the server.
class ReaderScreen extends StatefulWidget {
  final Book book;
  final int position;
  final double? scrollFraction;
  final int? highlightStart;
  final int? highlightEnd;

  const ReaderScreen({
    super.key,
    required this.book,
    required this.position,
    this.scrollFraction,
    this.highlightStart,
    this.highlightEnd,
  });

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  static double _fontSize = 19;

  late int _position = widget.position;
  ChapterContent? _chapter;
  Object? _error;
  final _scroll = ScrollController();
  final _highlightKey = GlobalKey();
  Timer? _saveDebounce;
  double _progress = 0;
  bool _showHighlight = true;
  List<ChapterSummary>? _chapters;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    _load(restore: widget.scrollFraction);
  }

  @override
  void dispose() {
    _saveDebounce?.cancel();
    _save();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _load({double? restore}) async {
    setState(() {
      _chapter = null;
      _error = null;
    });
    try {
      final chapter = await client.book.chapter(widget.book.id!, _position);
      if (!mounted) return;
      setState(() => _chapter = chapter);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scroll.hasClients) return;
        final target = _highlightKey.currentContext;
        if (_showHighlight && target != null) {
          Scrollable.ensureVisible(
            target,
            alignment: 0.25,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
          );
        } else if (restore != null) {
          _scroll.jumpTo(_scroll.position.maxScrollExtent * restore);
        } else {
          _scroll.jumpTo(0);
        }
      });
      _save();
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final max = _scroll.position.maxScrollExtent;
    final fraction = max <= 0 ? 1.0 : (_scroll.offset / max).clamp(0.0, 1.0);
    if ((fraction - _progress).abs() > 0.005) {
      setState(() => _progress = fraction);
    }
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 1500), _save);
  }

  Future<void> _save() async {
    if (_chapter == null) return;
    try {
      await client.book.saveProgress(widget.book.id!, _position, _progress);
    } catch (_) {
      // Saving progress is best effort.
    }
  }

  void _go(int position) {
    if (position < 0 ||
        _chapter == null ||
        position >= _chapter!.chapterCount) {
      return;
    }
    _save();
    setState(() {
      _position = position;
      _progress = 0;
      _showHighlight = false;
    });
    _load();
  }

  Future<void> _openChapters() async {
    try {
      _chapters ??= (await client.book.detail(widget.book.id!)).chapters;
    } catch (e) {
      if (mounted) showError(context, e);
      return;
    }
    if (!mounted) return;
    final picked = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final p = context.palette;
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.95,
          builder: (context, controller) => ListView.builder(
            controller: controller,
            itemCount: _chapters!.length,
            itemBuilder: (context, i) {
              final c = _chapters![i];
              final current = c.position == _position;
              return ListTile(
                selected: current,
                selectedColor: p.accent,
                title: Text(
                  c.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${(c.wordCount / 250).ceil()} min',
                  style: TextStyle(color: p.faint),
                ),
                onTap: () => Navigator.pop(context, c.position),
              );
            },
          ),
        );
      },
    );
    if (picked != null) _go(picked);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final chapter = _chapter;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.book.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            tooltip: 'Smaller text',
            onPressed: () =>
                setState(() => _fontSize = (_fontSize - 1).clamp(14, 28)),
            icon: const Icon(Icons.text_decrease),
          ),
          IconButton(
            tooltip: 'Larger text',
            onPressed: () =>
                setState(() => _fontSize = (_fontSize + 1).clamp(14, 28)),
            icon: const Icon(Icons.text_increase),
          ),
          IconButton(
            tooltip: 'Light or dark',
            onPressed: app.toggleTheme,
            icon: const Icon(Icons.contrast),
          ),
          IconButton(
            tooltip: 'Chapters',
            onPressed: _openChapters,
            icon: const Icon(Icons.list),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: LinearProgressIndicator(
            value: _progress,
            minHeight: 2,
            backgroundColor: p.line,
            color: p.accent,
          ),
        ),
      ),
      body: _error != null
          ? Empty.error(_error!, onRetry: _load)
          : chapter == null
          ? const Loading()
          : SingleChildScrollView(
              controller: _scroll,
              child: Readable(
                maxWidth: 680,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CHAPTER ${chapter.position + 1} OF ${chapter.chapterCount}',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 1.6,
                          color: p.accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        chapter.title,
                        style: serif(
                          size: 30,
                          weight: FontWeight.w600,
                          color: p.ink,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 28),
                      ..._paragraphs(context, chapter),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          if (chapter.position > 0)
                            OutlinedButton.icon(
                              onPressed: () => _go(chapter.position - 1),
                              icon: const Icon(Icons.chevron_left),
                              label: const Text('Previous'),
                            ),
                          const Spacer(),
                          if (chapter.position < chapter.chapterCount - 1)
                            FilledButton.icon(
                              onPressed: () => _go(chapter.position + 1),
                              icon: const Icon(Icons.chevron_right),
                              label: const Text('Next chapter'),
                            )
                          else
                            Text(
                              'The end.',
                              style: serif(
                                size: 20,
                                style: FontStyle.italic,
                                color: p.muted,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'From Project Gutenberg. This book is in the public domain.',
                        style: TextStyle(fontSize: 12, color: p.faint),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  /// Splits the chapter into paragraphs, highlighting the source passage.
  List<Widget> _paragraphs(BuildContext context, ChapterContent chapter) {
    final p = context.palette;
    final style = serif(size: _fontSize, color: p.ink, height: 1.65);
    final hs = _showHighlight && chapter.position == widget.position
        ? widget.highlightStart
        : null;
    final he = hs == null ? null : widget.highlightEnd;
    final widgets = <Widget>[];
    var offset = 0;
    var keyed = false;
    for (final paragraph in chapter.text.split('\n\n')) {
      final start = offset;
      final end = offset + paragraph.length;
      offset = end + 2;
      if (paragraph.trim().isEmpty) continue;

      final overlaps = hs != null && he != null && hs < end && he > start;
      Widget text;
      if (overlaps) {
        final a = (hs - start).clamp(0, paragraph.length);
        final b = (he - start).clamp(0, paragraph.length);
        text = Text.rich(
          TextSpan(
            style: style,
            children: [
              TextSpan(text: paragraph.substring(0, a)),
              TextSpan(
                text: paragraph.substring(a, b),
                style: TextStyle(
                  backgroundColor: p.accent.withValues(alpha: 0.22),
                ),
              ),
              TextSpan(text: paragraph.substring(b)),
            ],
          ),
        );
        if (!keyed) {
          text = KeyedSubtree(key: _highlightKey, child: text);
          keyed = true;
        }
      } else {
        text = Text(paragraph, style: style);
      }
      widgets.add(
        Padding(padding: const EdgeInsets.only(bottom: 18), child: text),
      );
    }
    return [
      SelectionArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ),
      ),
    ];
  }
}
