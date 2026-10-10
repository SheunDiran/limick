import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../screens/book_screen.dart';
import '../screens/open_book_sheet.dart';
import '../screens/post_screen.dart';
import '../theme.dart';
import 'common.dart';
import 'covers.dart';

/// A post in a feed. Owns its interactive state (likes, quiz answers, votes)
/// and reports changes through [onChanged] so lists stay in sync.
class PostCard extends StatefulWidget {
  final FeedItem item;
  final ValueChanged<FeedItem>? onChanged;
  final bool detail;

  const PostCard({
    super.key,
    required this.item,
    this.onChanged,
    this.detail = false,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late FeedItem item = widget.item;
  bool threadOpen = false;
  bool busy = false;

  @override
  void didUpdateWidget(PostCard old) {
    super.didUpdateWidget(old);
    if (old.item != widget.item) item = widget.item;
  }

  Post get post => item.post!;
  Book get book => item.book!;

  void _update(FeedItem next) {
    setState(() => item = next);
    widget.onChanged?.call(next);
  }

  Future<void> _toggleLike() async {
    final before = item;
    final liked = !item.liked;
    HapticFeedback.lightImpact();
    _update(
      item.copyWith(
        liked: liked,
        post: post.copyWith(likeCount: post.likeCount + (liked ? 1 : -1)),
      ),
    );
    try {
      final count = await client.feed.setLiked(post.id!, liked);
      _update(item.copyWith(post: post.copyWith(likeCount: count)));
    } catch (e) {
      _update(before);
      if (mounted) showError(context, e);
    }
  }

  Future<void> _toggleSave() async {
    final before = item;
    final saved = !item.saved;
    _update(item.copyWith(saved: saved));
    try {
      await client.feed.setSaved(post.id!, saved);
      if (mounted && saved) showMessage(context, 'Saved for later');
    } catch (e) {
      _update(before);
      if (mounted) showError(context, e);
    }
  }

  Future<void> _answer(int index) async {
    if (item.quizChoice != null || busy) return;
    setState(() => busy = true);
    HapticFeedback.selectionClick();
    try {
      final result = await client.feed.answerQuiz(post.id!, index);
      _update(
        item.copyWith(
          quizCounts: result.counts,
          quizChoice: index,
          quizCorrectIndex: result.correctIndex,
          quizExplanation: result.explanation,
          post: post.copyWith(quizAnswerCount: result.answerCount),
        ),
      );
      if (result.correct) HapticFeedback.mediumImpact();
    } catch (e) {
      if (mounted) showError(context, e);
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  Future<void> _vote(bool agree) async {
    if (busy || item.debateVote == agree) return;
    setState(() => busy = true);
    try {
      final updated = await client.feed.vote(post.id!, agree);
      _update(updated.copyWith(reason: item.reason));
    } catch (e) {
      if (mounted) showError(context, e);
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  Future<void> _saveWord() async {
    try {
      await client.word.saveFromPost(post.id!);
      if (mounted) {
        showMessage(context, '"${post.word}" added to your word bank');
      }
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  Future<void> _sharePost() async {
    HapticFeedback.lightImpact();
    final uri = Uri.base;
    final origin = (uri.scheme.isNotEmpty && uri.host.isNotEmpty)
        ? '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}'
        : 'https://limick.app';
    final shareUrl = '$origin/p/${post.id}';
    await Clipboard.setData(ClipboardData(text: shareUrl));
    if (mounted) {
      showMessage(context, 'Post link copied to clipboard');
    }
  }

  void _openDetail() {
    if (widget.detail) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PostScreen(item: item, onChanged: _update),
      ),
    );
  }

  void _openBook() => Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => BookScreen(bookId: book.id!)),
  );

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return InkWell(
      onTap: _openDetail,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.reason != null && !widget.detail)
              Padding(
                padding: const EdgeInsets.only(left: 54, bottom: 6),
                child: Text(
                  item.reason!,
                  style: TextStyle(
                    fontSize: 12,
                    color: p.faint,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _openBook,
                  child: BookAvatar(book: book, size: 42),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _openBook,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: book.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: p.ink,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '  @${book.handle} · ${timeAgo(post.createdAt)}',
                                style: TextStyle(color: p.faint),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14.5),
                        ),
                      ),
                      if (item.chapterTitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            item.chapterTitle!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12.5, color: p.muted),
                          ),
                        ),
                      const SizedBox(height: 10),
                      _content(context),
                      if (post.historical) ...[
                        const SizedBox(height: 10),
                        Tag(
                          'Historical text · not current advice',
                          icon: Icons.history_edu_outlined,
                          color: p.muted,
                        ),
                      ],
                      const SizedBox(height: 4),
                      _actions(context),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context, String text, {double size = 16}) => Text(
    text,
    style: TextStyle(fontSize: size, height: 1.45, color: context.palette.ink),
  );

  /// An embedded card under the post text, like a quoted post.
  Widget _embed(BuildContext context, {required Widget child}) {
    final p = context.palette;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: p.line),
      ),
      child: child,
    );
  }

  Widget _quote(BuildContext context, String text, {bool large = false}) {
    final p = context.palette;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 14),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: p.accent, width: 2)),
      ),
      child: Text(
        '“$text”',
        style: serif(
          size: large ? 22 : 17,
          style: FontStyle.italic,
          color: p.ink,
          height: large ? 1.35 : 1.45,
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    final p = context.palette;
    switch (post.kind) {
      case PostKind.quote:
        // Reaction first, then the quote embedded like a quoted post.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _body(context, post.body),
            _embed(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '“${post.quote ?? ''}”',
                    style: serif(size: 19, color: p.ink, height: 1.4),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${book.author} · ${book.title}',
                    style: TextStyle(fontSize: 12.5, color: p.faint),
                  ),
                ],
              ),
            ),
          ],
        );
      case PostKind.word:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _body(context, post.body),
            _embed(
              context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: post.word ?? '',
                          style: serif(
                            size: 28,
                            weight: FontWeight.w600,
                            color: p.ink,
                            height: 1.1,
                          ),
                        ),
                        if ((post.wordPartOfSpeech ?? '').isNotEmpty)
                          TextSpan(
                            text: '  ${post.wordPartOfSpeech}',
                            style: serif(
                              size: 15,
                              style: FontStyle.italic,
                              color: p.muted,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    post.wordDefinition ?? '',
                    style: TextStyle(fontSize: 15, color: p.ink, height: 1.45),
                  ),
                  if (post.quote != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      '“${post.quote}”',
                      style: serif(
                        size: 15,
                        style: FontStyle.italic,
                        color: p.muted,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 32),
                    ),
                    onPressed: _saveWord,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Save to word bank'),
                  ),
                ],
              ),
            ),
          ],
        );
      case PostKind.thread:
        final parts = post.parts ?? const [];
        final open = threadOpen || widget.detail;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _body(context, post.body),
            AnimatedSize(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: open
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final (i, part) in parts.indexed)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 28,
                                  child: Text(
                                    '${i + 2}/${parts.length + 1}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: p.faint,
                                      height: 1.9,
                                    ),
                                  ),
                                ),
                                Expanded(child: _body(context, part, size: 15)),
                              ],
                            ),
                          ),
                      ],
                    )
                  : const SizedBox(width: double.infinity),
            ),
            if (!open && parts.isNotEmpty)
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 36),
                ),
                onPressed: () => setState(() => threadOpen = true),
                child: Text('Show this thread (${parts.length} more)'),
              ),
          ],
        );
      case PostKind.quiz:
        return _Quiz(item: item, busy: busy, onAnswer: _answer);
      case PostKind.debate:
        return _Debate(item: item, busy: busy, onVote: _vote);
      case PostKind.insight:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _body(context, post.body),
            if (post.quote != null) _quote(context, post.quote!),
          ],
        );
    }
  }

  Widget _actions(BuildContext context) {
    final p = context.palette;
    return Row(
      children: [
        _Action(
          icon: Icons.mode_comment_outlined,
          label: post.commentCount > 0 ? compactCount(post.commentCount) : null,
          tooltip: 'Comments',
          onTap: _openDetail,
        ),
        _Action(
          icon: item.liked ? Icons.favorite : Icons.favorite_border,
          color: item.liked ? p.accent : null,
          label: post.likeCount > 0 ? compactCount(post.likeCount) : null,
          tooltip: item.liked ? 'Unlike' : 'Like',
          onTap: _toggleLike,
          animate: true,
        ),
        _Action(
          icon: item.saved ? Icons.bookmark : Icons.bookmark_border,
          color: item.saved ? p.ink : null,
          tooltip: item.saved ? 'Remove from saved' : 'Save',
          onTap: _toggleSave,
        ),
        _Action(
          icon: Icons.share_outlined,
          tooltip: 'Share post',
          onTap: _sharePost,
        ),
        const Spacer(),
        Semantics(
          button: true,
          label: 'Read chapter in book',
          child: TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: p.ink,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: const Size(0, 36),
            ),
            onPressed: () => showOpenBookSheet(context, item),
            icon: const Icon(Icons.menu_book_outlined, size: 18),
            label: const Text('Read'),
          ),
        ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String? label;
  final String tooltip;
  final Color? color;
  final VoidCallback onTap;
  final bool animate;

  const _Action({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.label,
    this.color,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final c = color ?? p.faint;
    return Semantics(
      button: true,
      label: label != null ? '$tooltip, $label' : tooltip,
      child: Tooltip(
        message: tooltip,
        child: InkResponse(
          onTap: onTap,
          radius: 22,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  transitionBuilder: (child, a) => animate
                      ? ScaleTransition(
                          scale: Tween(begin: 0.6, end: 1.0).animate(
                            CurvedAnimation(
                              parent: a,
                              curve: Curves.elasticOut,
                            ),
                          ),
                          child: child,
                        )
                      : FadeTransition(opacity: a, child: child),
                  child: Icon(icon, key: ValueKey(icon), size: 19, color: c),
                ),
                if (label != null) ...[
                  const SizedBox(width: 5),
                  Text(label!, style: TextStyle(fontSize: 13, color: c)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A quiz shown as a poll. After answering, real percentages appear and the
/// right answer is marked.
class _Quiz extends StatelessWidget {
  final FeedItem item;
  final bool busy;
  final ValueChanged<int> onAnswer;
  const _Quiz({required this.item, required this.busy, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final post = item.post!;
    final answered = item.quizChoice != null;
    final options = post.quizOptions ?? const [];
    final counts = item.quizCounts ?? List.filled(options.length, 0);
    final total = counts.fold<int>(0, (a, b) => a + b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.body,
          style: TextStyle(fontSize: 16, height: 1.45, color: p.ink),
        ),
        const SizedBox(height: 12),
        for (final (i, option) in options.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _PollOption(
              label: option,
              share: answered && total > 0 && i < counts.length
                  ? counts[i] / total
                  : null,
              correct: answered && i == item.quizCorrectIndex,
              chosen: answered && i == item.quizChoice,
              onTap: answered || busy ? null : () => onAnswer(i),
            ),
          ),
        Text(
          answered
              ? '${compactCount(total)} ${total == 1 ? 'vote' : 'votes'}'
              : 'Tap an answer to see how everyone voted',
          style: TextStyle(fontSize: 12.5, color: p.faint),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: answered
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: item.quizChoice == item.quizCorrectIndex
                              ? 'Got it. '
                              : 'Not quite. ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: item.quizChoice == item.quizCorrectIndex
                                ? p.good
                                : p.bad,
                          ),
                        ),
                        TextSpan(text: item.quizExplanation ?? ''),
                      ],
                    ),
                    style: TextStyle(color: p.muted, height: 1.45),
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}

/// One option of a poll. Before voting it's a button; afterwards it fills to
/// its real share of the votes.
class _PollOption extends StatelessWidget {
  final String label;
  final double? share;
  final bool correct;
  final bool chosen;
  final VoidCallback? onTap;

  const _PollOption({
    required this.label,
    required this.share,
    required this.onTap,
    this.correct = false,
    this.chosen = false,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final revealed = share != null;
    final fill = correct ? p.good : (chosen ? p.bad : p.faint);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: revealed
                  ? Colors.transparent
                  : p.accent.withValues(alpha: 0.6),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                if (revealed)
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: share!),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    builder: (context, v, _) => FractionallySizedBox(
                      widthFactor: v.clamp(0.0, 1.0),
                      heightFactor: 1,
                      child: Container(
                        color: fill.withValues(
                          alpha: correct || chosen ? 0.28 : 0.16,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.5,
                            color: revealed ? p.ink : p.accent,
                            fontWeight: correct || chosen || !revealed
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (correct) ...[
                        Icon(Icons.check_circle, size: 16, color: p.good),
                        const SizedBox(width: 6),
                      ],
                      if (revealed)
                        Text(
                          '${(share! * 100).round()}%',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: p.ink,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A debate shown as a two-option poll with real vote shares.
class _Debate extends StatelessWidget {
  final FeedItem item;
  final bool busy;
  final ValueChanged<bool> onVote;
  const _Debate({required this.item, required this.busy, required this.onVote});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final post = item.post!;
    final voted = item.debateVote != null;
    final total = post.agreeCount + post.disagreeCount;
    final agree = total == 0 ? 0.0 : post.agreeCount / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.body,
          style: TextStyle(fontSize: 16, height: 1.45, color: p.ink),
        ),
        const SizedBox(height: 12),
        _PollOption(
          label: 'Agree',
          share: voted ? agree : null,
          chosen: item.debateVote == true,
          onTap: busy ? null : () => onVote(true),
        ),
        const SizedBox(height: 8),
        _PollOption(
          label: 'Disagree',
          share: voted ? 1 - agree : null,
          chosen: item.debateVote == false,
          onTap: busy ? null : () => onVote(false),
        ),
        const SizedBox(height: 6),
        Text(
          voted
              ? '${compactCount(total)} ${total == 1 ? 'vote' : 'votes'} · tap to change yours'
              : 'Pick a side to see the split',
          style: TextStyle(fontSize: 12.5, color: p.faint),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: voted && (item.quizExplanation ?? '').isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    item.quizExplanation!,
                    style: TextStyle(color: p.muted, height: 1.45),
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
