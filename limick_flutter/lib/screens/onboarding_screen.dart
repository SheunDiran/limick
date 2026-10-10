import 'dart:async';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/covers.dart';

/// Five short steps that seed the recommendation engine: name, field,
/// interests, favourite books (optional) and a daily goal.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pages = PageController();
  int _step = 0;
  static const _steps = 5;

  final _name = TextEditingController();
  final _handle = TextEditingController(text: app.me?.suggestedHandle ?? '');
  final _field = TextEditingController();
  bool? _handleFree = true;
  Timer? _handleDebounce;

  final _interests = <Topic>{};
  final _favourites = <int, Book>{};
  int _goal = 15;
  bool _saving = false;

  @override
  void dispose() {
    _pages.dispose();
    _name.dispose();
    _handle.dispose();
    _field.dispose();
    _handleDebounce?.cancel();
    super.dispose();
  }

  bool get _canContinue => switch (_step) {
    0 =>
      _name.text.trim().isNotEmpty &&
          _handleFree == true &&
          RegExp(r'^[a-z0-9_]{3,20}$').hasMatch(_handle.text),
    2 => _interests.length >= 3,
    _ => true,
  };

  void _checkHandle(String value) {
    final h = value.trim().toLowerCase();
    setState(() => _handleFree = null);
    _handleDebounce?.cancel();
    _handleDebounce = Timer(const Duration(milliseconds: 400), () async {
      if (!RegExp(r'^[a-z0-9_]{3,20}$').hasMatch(h)) {
        if (mounted) setState(() => _handleFree = false);
        return;
      }
      try {
        final free = await client.profile.isHandleAvailable(h);
        if (mounted && _handle.text.trim().toLowerCase() == h) {
          setState(() => _handleFree = free);
        }
      } catch (_) {
        if (mounted) setState(() => _handleFree = true);
      }
    });
  }

  Future<void> _next() async {
    FocusScope.of(context).unfocus();
    if (_step < _steps - 1) {
      setState(() => _step++);
      await _pages.animateToPage(
        _step,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeOutCubic,
      );
      return;
    }
    setState(() => _saving = true);
    try {
      final me = await client.profile.completeOnboarding(
        OnboardingInput(
          displayName: _name.text.trim(),
          handle: _handle.text.trim().toLowerCase(),
          field: _field.text.trim().isEmpty ? null : _field.text.trim(),
          interests: _interests.toList(),
          favoriteBookIds: _favourites.keys.toList(),
          dailyGoalMinutes: _goal,
        ),
      );
      app.setMe(me);
    } catch (e) {
      if (mounted) {
        showError(context, e);
        setState(() => _saving = false);
        if (e is AppException && e.code.contains('handle')) {
          setState(() => _step = 0);
          _pages.jumpToPage(0);
        }
      }
    }
  }

  void _back() {
    if (_step == 0) return;
    setState(() => _step--);
    _pages.animateToPage(
      _step,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      body: SafeArea(
        child: Readable(
          maxWidth: 620,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 20, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _step == 0 ? null : _back,
                      icon: Icon(
                        Icons.arrow_back,
                        color: _step == 0 ? Colors.transparent : p.ink,
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(end: (_step + 1) / _steps),
                          duration: const Duration(milliseconds: 380),
                          builder: (_, v, _) => LinearProgressIndicator(
                            value: v,
                            minHeight: 3,
                            backgroundColor: p.line,
                            color: p.accent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${_step + 1}/$_steps',
                      style: TextStyle(color: p.faint, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pages,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _identity(context),
                    _fieldStep(context),
                    _interestStep(context),
                    _BookPicker(
                      selected: _favourites,
                      onToggle: (b) => setState(() {
                        if (_favourites.remove(b.id) == null &&
                            _favourites.length < 10) {
                          _favourites[b.id!] = b;
                        }
                      }),
                    ),
                    _goalStep(context),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                child: Row(
                  children: [
                    if (_step == 1 || _step == 3)
                      TextButton(
                        onPressed: _saving ? null : _next,
                        child: const Text('Skip'),
                      ),
                    const Spacer(),
                    FilledButton(
                      onPressed: _canContinue && !_saving ? _next : null,
                      child: _saving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              _step == _steps - 1
                                  ? 'Build my feed'
                                  : 'Continue',
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context, String title, String subtitle) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(color: p.muted, fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _identity(BuildContext context) {
    final p = context.palette;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      children: [
        _title(
          context,
          'Welcome to Limick.',
          'What should other readers call you?',
        ),
        TextField(
          controller: _name,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          maxLength: 40,
          decoration: const InputDecoration(
            hintText: 'Your name',
            counterText: '',
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _handle,
          maxLength: 20,
          decoration: InputDecoration(
            hintText: 'handle',
            prefixText: '@',
            counterText: '',
            suffixIcon: _handleFree == null
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : Icon(
                    _handleFree! ? Icons.check_circle : Icons.error_outline,
                    color: _handleFree! ? p.good : p.bad,
                    size: 20,
                  ),
          ),
          onChanged: _checkHandle,
        ),
        const SizedBox(height: 8),
        Text(
          _handleFree == false
              ? 'Taken or invalid. Use 3–20 lowercase letters, numbers or _.'
              : 'Lowercase letters, numbers and underscores.',
          style: TextStyle(
            fontSize: 12.5,
            color: _handleFree == false ? p.bad : p.faint,
          ),
        ),
      ],
    );
  }

  Widget _fieldStep(BuildContext context) {
    const suggestions = [
      'Medicine',
      'Nursing',
      'Law',
      'Computer Science',
      'Psychology',
      'Economics',
      'Biology',
      'Engineering',
      'Literature',
      'Philosophy',
      'History',
      'Business',
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      children: [
        _title(
          context,
          'What do you study?',
          'Your major, your job, or what you are curious about. We use it to pick your first posts.',
        ),
        TextField(
          controller: _field,
          maxLength: 60,
          decoration: const InputDecoration(
            hintText: 'e.g. Medicine',
            counterText: '',
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final s in suggestions)
              _Chip(
                label: s,
                selected: _field.text.trim().toLowerCase() == s.toLowerCase(),
                onTap: () => setState(() => _field.text = s),
              ),
          ],
        ),
      ],
    );
  }

  Widget _interestStep(BuildContext context) {
    final p = context.palette;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      children: [
        _title(
          context,
          'Pick what pulls you in.',
          'Choose at least three. Your feed keeps learning as you scroll.',
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final t in Topic.values)
              _Chip(
                label: topicLabel(t),
                color: topicColor(t),
                selected: _interests.contains(t),
                onTap: () => setState(
                  () => _interests.contains(t)
                      ? _interests.remove(t)
                      : _interests.add(t),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '${_interests.length} selected',
          style: TextStyle(color: p.faint, fontSize: 13),
        ),
      ],
    );
  }

  Widget _goalStep(BuildContext context) {
    final p = context.palette;
    const goals = [
      (5, 'A quick look'),
      (10, 'A short break'),
      (15, 'A proper break'),
      (30, 'Deep dive'),
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      children: [
        _title(
          context,
          'How long is a break?',
          'Start a study break any time and Limick will tell you when it is over, with what you learned.',
        ),
        for (final (minutes, label) in goals)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Material(
              color: _goal == minutes ? p.raised : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => setState(() => _goal = minutes),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _goal == minutes ? p.accent : p.line,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '$minutes min',
                        style: serif(
                          size: 22,
                          weight: FontWeight.w600,
                          color: p.ink,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(label, style: TextStyle(color: p.muted)),
                      const Spacer(),
                      if (_goal == minutes)
                        Icon(Icons.check_circle, color: p.accent, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final c = color ?? p.accent;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: selected ? c.withValues(alpha: 0.16) : Colors.transparent,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: selected ? c : p.line),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(99),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (color != null) ...[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: c, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: selected ? p.ink : p.muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Search the catalogue and pick favourite books.
class _BookPicker extends StatefulWidget {
  final Map<int, Book> selected;
  final ValueChanged<Book> onToggle;
  const _BookPicker({required this.selected, required this.onToggle});

  @override
  State<_BookPicker> createState() => _BookPickerState();
}

class _BookPickerState extends State<_BookPicker> {
  final _query = TextEditingController();
  Timer? _debounce;
  List<Book>? _results;
  Object? _error;
  int _request = 0;

  @override
  void initState() {
    super.initState();
    _search('');
  }

  @override
  void dispose() {
    _query.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _search(String q) async {
    final id = ++_request;
    try {
      final results = await client.book.search(q, null, 0);
      if (mounted && id == _request) {
        setState(() {
          _results = results;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted && id == _request) setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      children: [
        Text(
          'Any favourite books?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Optional. Their posts will show up first.',
          style: TextStyle(color: p.muted, fontSize: 15),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _query,
          decoration: const InputDecoration(
            hintText: 'Search title or author',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (v) {
            _debounce?.cancel();
            _debounce = Timer(
              const Duration(milliseconds: 350),
              () => _search(v),
            );
          },
        ),
        if (widget.selected.isNotEmpty) ...[
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final b in widget.selected.values)
                InputChip(
                  label: Text(b.title, overflow: TextOverflow.ellipsis),
                  onDeleted: () => widget.onToggle(b),
                ),
            ],
          ),
        ],
        const SizedBox(height: 16),
        if (_error != null)
          Empty.error(_error!, onRetry: () => _search(_query.text))
        else if (_results == null)
          const Padding(padding: EdgeInsets.all(32), child: Loading())
        else if (_results!.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'No books match "${_query.text}".',
              style: TextStyle(color: p.muted),
            ),
          )
        else
          for (final b in _results!)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: BookCover(book: b, width: 34, showTitle: false),
              title: Text(
                b.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                b.author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: p.muted),
              ),
              trailing: Icon(
                widget.selected.containsKey(b.id)
                    ? Icons.check_circle
                    : Icons.add_circle_outline,
                color: widget.selected.containsKey(b.id) ? p.accent : p.faint,
              ),
              onTap: () => widget.onToggle(b),
            ),
      ],
    );
  }
}
