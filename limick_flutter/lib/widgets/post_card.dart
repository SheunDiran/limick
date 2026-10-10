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

  Widget _body(BuildContext context, String text, {double size = 15.5}) => Text(
    text,
    style: TextStyle(fontSize: size, height: 1.5, color: context.palette.ink),
  );

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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _quote(context, post.quote ?? '', large: true),
            const SizedBox(height: 12),
            Text(
              post.body,
              style: TextStyle(color: p.muted, fontSize: 14.5, height: 1.45),
            ),
          ],
        );
      case PostKind.word:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: p.raised,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WORD',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 1.6,
                  color: p.accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: post.word ?? '',
                      style: serif(
                        size: 30,
                        weight: FontWeight.w600,
                        color: p.ink,
                        height: 1.1,
                      ),
                    ),
                    if ((post.wordPartOfSpeech ?? '').isNotEmpty)
                      TextSpan(
                        text: '  ${post.wordPartOfSpeech}',
                        style: serif(
                          size: 16,
                          style: FontStyle.italic,
                          color: p.muted,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post.wordDefinition ?? '',
                style: TextStyle(fontSize: 15.5, color: p.ink, height: 1.45),
              ),
              if (post.quote != null) _quote(context, post.quote!),
              const SizedBox(height: 12),
              Text(
                post.body,
                style: TextStyle(color: p.muted, fontSize: 14, height: 1.45),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _saveWord,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Save to word bank'),
              ),
            ],
          ),
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
                child: Text('Show thread · ${parts.length} more'),
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
                            CurvedAnimation(parent: a, curve: Curves.elasticOut),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUIZ',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1.6,
            color: p.accent,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          post.body,
          style: serif(
            size: 20,
            weight: FontWeight.w500,
            color: p.ink,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 12),
        for (final (i, option) in options.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _QuizOption(
              label: option,
              state: !answered
                  ? _OptionState.open
                  : i == item.quizCorrectIndex
                  ? _OptionState.correct
                  : i == item.quizChoice
                  ? _OptionState.wrong
                  : _OptionState.dim,
              onTap: answered || busy ? null : () => onAnswer(i),
            ),
          ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: answered
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.quizChoice == item.quizCorrectIndex
                            ? 'Correct.'
                            : 'Not quite.',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: item.quizChoice == item.quizCorrectIndex
                              ? p.good
                              : p.bad,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.quizExplanation ?? '',
                        style: TextStyle(color: p.muted, height: 1.45),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${compactCount(post.quizAnswerCount)} answered',
                        style: TextStyle(fontSize: 12, color: p.faint),
                      ),
                    ],
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}

enum _OptionState { open, correct, wrong, dim }

class _QuizOption extends StatelessWidget {
  final String label;
  final _OptionState state;
  final VoidCallback? onTap;
  const _QuizOption({required this.label, required this.state, this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (border, fill, text) = switch (state) {
      _OptionState.open => (p.line, Colors.transparent, p.ink),
      _OptionState.correct => (p.good, p.good.withValues(alpha: 0.12), p.ink),
      _OptionState.wrong => (p.bad, p.bad.withValues(alpha: 0.10), p.ink),
      _OptionState.dim => (p.line, Colors.transparent, p.faint),
    };
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(color: text, fontSize: 14.5),
                ),
              ),
              if (state == _OptionState.correct)
                Icon(Icons.check_rounded, size: 18, color: p.good),
              if (state == _OptionState.wrong)
                Icon(Icons.close_rounded, size: 18, color: p.bad),
            ],
          ),
        ),
      ),
    );
  }
}

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
    final agreeShare = total == 0 ? 0.5 : post.agreeCount / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DEBATE',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1.6,
            color: p.accent,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          post.body,
          style: serif(
            size: 20,
            weight: FontWeight.w500,
            color: p.ink,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _voteButton(context, 'Agree', true)),
            const SizedBox(width: 10),
            Expanded(child: _voteButton(context, 'Disagree', false)),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: voted
              ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: SizedBox(
                          height: 6,
                          child: Row(
                            children: [
                              Expanded(
                                flex: (agreeShare * 1000).round().clamp(1, 999),
                                child: Container(color: p.accent),
                              ),
                              Expanded(
                                flex: ((1 - agreeShare) * 1000).round().clamp(
                                  1,
                                  999,
                                ),
                                child: Container(color: p.line),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${(agreeShare * 100).round()}% agree · ${compactCount(total)} votes',
                        style: TextStyle(fontSize: 12, color: p.faint),
                      ),
                      if ((item.quizExplanation ?? '').isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          item.quizExplanation!,
                          style: TextStyle(color: p.muted, height: 1.45),
                        ),
                      ],
                    ],
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }

  Widget _voteButton(BuildContext context, String label, bool agree) {
    final p = context.palette;
    final selected = item.debateVote == agree;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: selected ? p.ink : null,
        foregroundColor: selected ? p.background : p.ink,
        side: BorderSide(color: selected ? p.ink : p.line),
      ),
      onPressed: busy ? null : () => onVote(agree),
      child: Text(label),
    );
  }
}
