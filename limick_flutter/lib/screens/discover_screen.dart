import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/covers.dart';
import 'book_screen.dart';
import 'reader_screen.dart';

/// The catalogue: search tens of thousands of public-domain books, browse by
/// topic, and pick up books you have started.
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _query = TextEditingController();
  Timer? _debounce;
  Topic? _topic;
  List<Book>? _books;
  List<ContinueReading> _shelf = [];
  Object? _error;
  bool _loadingMore = false;
  bool _hasMore = true;
  int _request = 0;

  @override
  void initState() {
    super.initState();
    _search();
    _loadShelf();
  }

  @override
  void dispose() {
    _query.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadShelf() async {
    try {
      final shelf = await client.book.continueReading();
      if (mounted) setState(() => _shelf = shelf);
    } catch (_) {}
  }

  Future<void> _search({bool more = false}) async {
    final id = ++_request;
    if (more) {
      if (_loadingMore || !_hasMore) return;
      setState(() => _loadingMore = true);
    } else {
      setState(() {
        _books = null;
        _error = null;
        _hasMore = true;
      });
    }
    try {
      final results = await client.book.search(
        _query.text,
        _topic,
        more ? _books?.length ?? 0 : 0,
      );
      if (!mounted || id != _request) return;
      setState(() {
        _books = more ? [...?_books, ...results] : results;
        _hasMore = results.length == 30;
      });
    } catch (e) {
      if (mounted && id == _request) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final searching = _query.text.trim().isNotEmpty;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: NotificationListener<ScrollNotification>(
          onNotification: (n) {
            if (n.metrics.extentAfter < 600) _search(more: true);
            return false;
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Readable(
                  maxWidth: 900,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discover',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _query,
                          decoration: InputDecoration(
                            hintText: 'Search 60,000 books by title or author',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: searching
                                ? IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      _query.clear();
                                      _search();
                                    },
                                  )
                                : null,
                          ),
                          onChanged: (_) {
                            setState(() {});
                            _debounce?.cancel();
                            _debounce = Timer(
                              const Duration(milliseconds: 350),
                              _search,
                            );
                          },
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 38,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _topicChip(context, null, 'All'),
                              for (final t in Topic.values)
                                _topicChip(context, t, topicLabel(t)),
                            ],
                          ),
                        ),
                        if (!searching && _shelf.isNotEmpty) ...[
                          const SizedBox(height: 28),
                          Text(
                            'Continue reading',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: p.ink,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 182,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _shelf.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: 14),
                              itemBuilder: (context, i) {
                                final c = _shelf[i];
                                return GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .push(
                                        MaterialPageRoute(
                                          builder: (_) => ReaderScreen(
                                            book: c.book,
                                            position:
                                                c.progress.chapterPosition,
                                            scrollFraction:
                                                c.progress.scrollFraction,
                                          ),
                                        ),
                                      )
                                      .then((_) => _loadShelf()),
                                  child: SizedBox(
                                    width: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BookCover(book: c.book, width: 100),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Ch. ${c.progress.chapterPosition + 1} of ${c.book.chapterCount}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: p.muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                        const SizedBox(height: 28),
                        Text(
                          searching
                              ? 'Results'
                              : (_topic == null
                                    ? 'Popular on Limick'
                                    : topicLabel(_topic!)),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: p.ink,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ),
              ),
              if (_error != null)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Empty.error(_error!, onRetry: _search),
                )
              else if (_books == null)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Loading(),
                )
              else if (_books!.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Empty(
                    icon: Icons.search_off,
                    title: 'Nothing found',
                    message:
                        'Try another title, an author, or a broader topic.',
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width > 940 ? (width - 900) / 2 + 20 : 20,
                  ),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          mainAxisSpacing: 22,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.48,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _BookTile(book: _books![i]),
                      childCount: _books!.length,
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 96),
                  child: _loadingMore
                      ? const Loading()
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topicChip(BuildContext context, Topic? topic, String label) {
    final p = context.palette;
    final selected = _topic == topic;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        showCheckmark: false,
        side: BorderSide(color: selected ? p.ink : p.line),
        selectedColor: p.ink,
        backgroundColor: Colors.transparent,
        labelStyle: TextStyle(
          color: selected ? p.background : p.muted,
          fontWeight: FontWeight.w600,
        ),
        onSelected: (_) {
          setState(() => _topic = topic);
          _search();
        },
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  final Book book;
  const _BookTile({required this.book});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return GestureDetector(
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => BookScreen(bookId: book.id!))),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookCover(book: book, width: constraints.maxWidth),
            const SizedBox(height: 8),
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
                height: 1.3,
              ),
            ),
            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: p.muted),
            ),
            if (book.status == BookStatus.ready && book.postCount > 0)
              Text(
                '${compactCount(book.postCount)} posts',
                style: TextStyle(fontSize: 11.5, color: p.faint),
              ),
          ],
        ),
      ),
    );
  }
}
