import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/covers.dart';
import '../widgets/post_card.dart';
import 'reader_screen.dart';
import 'room_screen.dart';

/// A book's profile: like an account page, with its posts in reading order
/// and its chapters.
class BookScreen extends StatefulWidget {
  final int bookId;
  const BookScreen({super.key, required this.bookId});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  BookDetail? _detail;
  Object? _error;
  bool _showChapters = false;
  Timer? _poll;
  bool _busy = false;

  final _posts = <FeedItem>[];
  bool _postsLoading = false;
  bool _postsHasMore = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final detail = await client.book.detail(widget.bookId);
      if (!mounted) return;
      setState(() {
        _detail = detail;
        _error = null;
      });
      final status = detail.book.status;
      _poll?.cancel();
      if (status == BookStatus.queued || status == BookStatus.ingesting) {
        _poll = Timer(const Duration(seconds: 4), _load);
      }
      if (_posts.isEmpty) _loadPosts();
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  Future<void> _loadPosts() async {
    if (_postsLoading || !_postsHasMore) return;
    setState(() => _postsLoading = true);
    try {
      final after = _posts.isEmpty ? null : _posts.last.post!.id;
      final page = await client.feed.bookPosts(widget.bookId, after);
      if (!mounted) return;
      setState(() {
        _posts.addAll(page.items);
        _postsHasMore = page.hasMore;
      });
    } catch (_) {
      if (mounted) setState(() => _postsHasMore = false);
    } finally {
      if (mounted) setState(() => _postsLoading = false);
    }
  }

  Future<void> _toggleFollow() async {
    final d = _detail!;
    setState(() => _detail = d.copyWith(following: !d.following));
    try {
      final book = await client.book.setFollowing(d.book.id!, !d.following);
      if (mounted) setState(() => _detail = _detail!.copyWith(book: book));
      if (!d.following && book.status != BookStatus.ready && mounted) {
        showMessage(
          context,
          'Following. Its posts will appear in your feed soon.',
        );
        _load();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _detail = d);
        showError(context, e);
      }
    }
  }

  Future<void> _prepare() async {
    setState(() => _busy = true);
    try {
      await client.book.prepare(widget.bookId);
      await _load();
    } catch (e) {
      if (mounted) showError(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _openClub() async {
    try {
      final room = await client.room.forBook(widget.bookId);
      if (!mounted) return;
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => RoomScreen(initial: room)));
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  void _read(int position, {double? fraction}) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => ReaderScreen(
        book: _detail!.book,
        position: position,
        scrollFraction: fraction,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final d = _detail;
    return Scaffold(
      appBar: AppBar(title: Text(d == null ? '' : '@${d.book.handle}')),
      body: _error != null
          ? Empty.error(_error!, onRetry: _load)
          : d == null
          ? const Loading()
          : NotificationListener<ScrollNotification>(
              onNotification: (n) {
                if (!_showChapters && n.metrics.extentAfter < 800) _loadPosts();
                return false;
              },
              child: ListView(
                padding: const EdgeInsets.only(bottom: 48),
                children: [
                  Readable(child: _header(context, d)),
                  Readable(child: _tabs(context)),
                  if (_showChapters)
                    ..._chapterList(context, d)
                  else
                    ..._postList(context, d),
                ],
              ),
            ),
    );
  }

  Widget _header(BuildContext context, BookDetail d) {
    final p = context.palette;
    final b = d.book;
    final ready = b.status == BookStatus.ready;
    final preparing =
        b.status == BookStatus.queued || b.status == BookStatus.ingesting;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BookCover(book: b, width: 112),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tag(
                      topicLabel(b.primaryTopic),
                      color: topicColor(b.primaryTopic),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      b.title,
                      style: serif(
                        size: 24,
                        weight: FontWeight.w600,
                        color: p.ink,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      [
                        b.author,
                        if (b.authorYears != null) b.authorYears!,
                      ].join(' · '),
                      style: TextStyle(color: p.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (b.blurb != null) ...[
            const SizedBox(height: 16),
            Text(
              b.blurb!,
              style: TextStyle(fontSize: 15, height: 1.5, color: p.ink),
            ),
          ],
          const SizedBox(height: 14),
          Wrap(
            spacing: 18,
            children: [
              _count(context, b.followerCount, 'followers'),
              _count(context, b.postCount, 'posts'),
              if (ready) _count(context, b.chapterCount, 'chapters'),
              if (ready)
                Text(
                  '~${(b.wordCount / 250 / 60).toStringAsFixed(1)} h read',
                  style: TextStyle(color: p.muted, fontSize: 13.5),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ready
                    ? FilledButton(
                        onPressed: () => d.progress == null
                            ? _read(0)
                            : _read(
                                d.progress!.chapterPosition,
                                fraction: d.progress!.scrollFraction,
                              ),
                        child: Text(
                          d.progress == null
                              ? 'Start reading'
                              : 'Continue · ch. ${d.progress!.chapterPosition + 1}',
                        ),
                      )
                    : FilledButton(
                        onPressed: preparing || _busy ? null : _prepare,
                        child: Text(
                          preparing
                              ? 'Preparing the book…'
                              : b.status == BookStatus.failed
                              ? 'Try again'
                              : 'Prepare this book',
                        ),
                      ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: _toggleFollow,
                style: OutlinedButton.styleFrom(
                  backgroundColor: d.following ? null : p.raised,
                ),
                child: Text(d.following ? 'Following' : 'Follow'),
              ),
              const SizedBox(width: 6),
              IconButton(
                tooltip: 'Book club',
                onPressed: _openClub,
                icon: const Icon(Icons.forum_outlined),
              ),
            ],
          ),
          if (preparing)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Downloading from Project Gutenberg and splitting it into chapters. This usually takes under a minute.',
                style: TextStyle(fontSize: 12.5, color: p.faint, height: 1.4),
              ),
            ),
          if (b.status == BookStatus.failed)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "We couldn't prepare this book: Gutenberg may not have a plain-text edition.",
                style: TextStyle(fontSize: 12.5, color: p.bad),
              ),
            ),
        ],
      ),
    );
  }

  Widget _count(BuildContext context, int value, String label) {
    final p = context.palette;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: compactCount(value),
            style: TextStyle(fontWeight: FontWeight.w700, color: p.ink),
          ),
          TextSpan(
            text: ' $label',
            style: TextStyle(color: p.muted),
          ),
        ],
      ),
      style: const TextStyle(fontSize: 13.5),
    );
  }

  Widget _tabs(BuildContext context) {
    final p = context.palette;
    Widget tab(String label, bool selected, VoidCallback onTap) => Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? p.accent : p.line,
                width: selected ? 2 : 1,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: selected ? p.ink : p.faint,
            ),
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          tab(
            'Posts',
            !_showChapters,
            () => setState(() => _showChapters = false),
          ),
          tab(
            'Chapters',
            _showChapters,
            () => setState(() => _showChapters = true),
          ),
        ],
      ),
    );
  }

  List<Widget> _postList(BuildContext context, BookDetail d) {
    final p = context.palette;
    if (_posts.isEmpty) {
      return [
        if (_postsLoading)
          const Padding(padding: EdgeInsets.all(40), child: Loading())
        else
          Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Text(
                d.book.status == BookStatus.ready
                    ? 'Posts from this book are on their way. Follow it to see them first.'
                    : 'Follow or prepare this book to start its feed.',
                textAlign: TextAlign.center,
                style: TextStyle(color: p.muted, height: 1.5),
              ),
            ),
          ),
      ];
    }
    return [
      for (final item in _posts)
        Readable(
          child: Column(
            children: [
              PostCard(item: item),
              Divider(color: p.line),
            ],
          ),
        ),
      if (_postsLoading)
        const Padding(padding: EdgeInsets.all(24), child: Loading()),
    ];
  }

  List<Widget> _chapterList(BuildContext context, BookDetail d) {
    final p = context.palette;
    if (d.chapters.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: Text(
              'Chapters appear once the book is prepared.',
              style: TextStyle(color: p.muted),
            ),
          ),
        ),
      ];
    }
    return [
      for (final c in d.chapters)
        Readable(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: Text(
              '${c.position + 1}',
              style: serif(size: 18, color: p.faint),
            ),
            title: Text(c.title, maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: Text(
              '${(c.wordCount / 250).ceil()} min',
              style: TextStyle(color: p.faint),
            ),
            trailing: d.progress?.chapterPosition == c.position
                ? Icon(Icons.bookmark, color: p.accent, size: 18)
                : null,
            onTap: () => _read(c.position),
          ),
        ),
    ];
  }
}
