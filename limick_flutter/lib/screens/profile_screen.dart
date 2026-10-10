import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:flutter/services.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/break_widgets.dart';
import '../widgets/common.dart';
import '../widgets/covers.dart';
import '../widgets/post_card.dart';

/// Your profile: streak, what you have learned, saved posts and settings.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileStats? _stats;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final stats = await client.profile.stats();
      if (mounted) setState(() => _stats = stats);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  Future<void> _edit() async {
    final updated = await showModalBottomSheet<Reader>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _EditProfileSheet(),
    );
    if (updated != null) app.updateReader(updated);
  }

  Future<void> _export() async {
    try {
      final json = await client.profile.exportData();
      await Clipboard.setData(ClipboardData(text: json));
      if (mounted) {
        showMessage(context, 'Your data was copied to the clipboard as JSON.');
      }
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete your account?'),
        content: const Text(
          'This permanently deletes your profile, comments, messages, word bank and reading history. It cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: context.palette.bad),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete forever'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      await client.profile.deleteAccount();
      await client.auth.signOutDevice();
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ListenableBuilder(
      listenable: app,
      builder: (context, _) {
        final r = app.reader;
        if (r == null) return const Scaffold(body: Loading());
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: Readable(
              child: RefreshIndicator(
                onRefresh: _load,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 96),
                  children: [
                    Row(
                      children: [
                        ReaderAvatar(
                          name: r.displayName,
                          hue: r.avatarHue,
                          size: 68,
                        ),
                        const Spacer(),
                        OutlinedButton(
                          onPressed: _edit,
                          child: const Text('Edit profile'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      r.displayName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '@${r.handle}${r.field == null ? '' : ' · ${r.field}'}',
                      style: TextStyle(color: p.muted),
                    ),
                    if (r.bio.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(r.bio, style: const TextStyle(height: 1.5)),
                    ],
                    const SizedBox(height: 24),
                    _Streak(days: r.streakDays),
                    const SizedBox(height: 16),
                    if (_error != null)
                      Empty.error(_error!, onRetry: _load)
                    else if (_stats == null)
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Loading(),
                      )
                    else ...[
                      StatsGrid(stats: _stats!),
                      if (_stats!.topTopics.isNotEmpty) ...[
                        const SizedBox(height: 18),
                        Text(
                          'Your feed leans towards',
                          style: TextStyle(color: p.muted, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            for (final t in _stats!.topTopics)
                              Tag(topicLabel(t), color: topicColor(t)),
                          ],
                        ),
                      ],
                    ],
                    const SizedBox(height: 28),
                    _row(
                      context,
                      Icons.bookmark_outline,
                      'Saved posts',
                      () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SavedScreen()),
                      ),
                    ),
                    _row(
                      context,
                      Icons.timer_outlined,
                      'Start a study break',
                      () => showStartBreak(context),
                    ),
                    _row(
                      context,
                      app.themeMode == ThemeMode.dark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      app.themeMode == ThemeMode.dark
                          ? 'Light theme'
                          : 'Dark theme',
                      app.toggleTheme,
                    ),
                    _row(
                      context,
                      Icons.download_outlined,
                      'Export my data',
                      _export,
                    ),
                    _row(
                      context,
                      Icons.logout,
                      'Sign out',
                      () => client.auth.signOutDevice(),
                    ),
                    _row(
                      context,
                      Icons.delete_forever_outlined,
                      'Delete account',
                      _delete,
                      danger: true,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Limick turns public-domain books from Project Gutenberg into posts with AI (Groq and Gemini models). '
                      'Quotes are checked against the original text. Old medical and legal texts are marked as historical.',
                      style: TextStyle(
                        fontSize: 12,
                        color: p.faint,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _row(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool danger = false,
  }) {
    final p = context.palette;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: danger ? p.bad : p.muted),
      title: Text(
        label,
        style: TextStyle(
          color: danger ? p.bad : p.ink,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: p.faint),
      onTap: onTap,
    );
  }
}

class _Streak extends StatelessWidget {
  final int days;
  const _Streak({required this.days});
  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [p.accent.withValues(alpha: 0.18), p.surface],
        ),
        border: Border.all(color: p.line),
      ),
      child: Row(
        children: [
          Icon(Icons.local_fire_department_rounded, color: p.accent, size: 32),
          const SizedBox(width: 12),
          Text(
            '$days',
            style: serif(
              size: 36,
              weight: FontWeight.w600,
              color: p.ink,
              height: 1,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              days == 1
                  ? 'day of learning. Come back tomorrow to start a streak.'
                  : 'days in a row. Keep it going.',
              style: TextStyle(color: p.muted, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

/// The numbers behind a reader's learning.
class StatsGrid extends StatelessWidget {
  final ProfileStats stats;
  const StatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final items = [
      (compactCount(stats.postsRead), 'posts read'),
      (compactCount(stats.wordsSaved), 'words saved'),
      (compactCount(stats.booksOpened), 'books opened'),
      (
        stats.quizzesAnswered == 0
            ? '–'
            : '${(stats.quizzesCorrect * 100 / stats.quizzesAnswered).round()}%',
        'quiz accuracy',
      ),
      (compactCount(stats.booksFollowed), 'books followed'),
      (compactCount(stats.comments), 'comments'),
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.45,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        for (final (value, label) in items)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: p.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: p.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: serif(
                    size: 26,
                    weight: FontWeight.w600,
                    color: p.ink,
                    height: 1.1,
                  ),
                ),
                Text(label, style: TextStyle(fontSize: 12, color: p.muted)),
              ],
            ),
          ),
      ],
    );
  }
}

class _EditProfileSheet extends StatefulWidget {
  const _EditProfileSheet();

  @override
  State<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<_EditProfileSheet> {
  final r = app.reader!;
  late final _name = TextEditingController(text: r.displayName);
  late final _bio = TextEditingController(text: r.bio);
  late final _field = TextEditingController(text: r.field ?? '');
  late int _hue = r.avatarHue;
  late int _goal = r.dailyGoalMinutes;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    _field.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final updated = await client.profile.updateProfile(
        displayName: _name.text,
        bio: _bio.text,
        field: _field.text,
        avatarHue: _hue,
        dailyGoalMinutes: _goal,
      );
      if (mounted) Navigator.pop(context, updated);
    } catch (e) {
      if (mounted) {
        showError(context, e);
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        0,
        24,
        24 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit profile', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            Center(
              child: ReaderAvatar(name: _name.text, hue: _hue, size: 72),
            ),
            Slider(
              value: _hue.toDouble(),
              max: 359,
              activeColor: HSLColor.fromAHSL(
                1,
                _hue.toDouble(),
                0.55,
                0.55,
              ).toColor(),
              onChanged: (v) => setState(() => _hue = v.round()),
            ),
            TextField(
              controller: _name,
              maxLength: 40,
              decoration: const InputDecoration(
                labelText: 'Name',
                counterText: '',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _field,
              maxLength: 60,
              decoration: const InputDecoration(
                labelText: 'Field of study',
                counterText: '',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bio,
              maxLength: 160,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Bio'),
            ),
            const SizedBox(height: 8),
            Text(
              'Study break length: $_goal min',
              style: TextStyle(color: p.muted),
            ),
            Slider(
              value: _goal.toDouble(),
              min: 5,
              max: 60,
              divisions: 11,
              onChanged: (v) => setState(() => _goal = v.round()),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  FeedPage? _page;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final page = await client.feed.saved(null);
      if (mounted) setState(() => _page = page);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final page = _page;
    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: _error != null
          ? Empty.error(_error!, onRetry: _load)
          : page == null
          ? const Loading()
          : page.items.isEmpty
          ? const Empty(
              icon: Icons.bookmark_outline,
              title: 'Nothing saved yet',
              message: 'Tap the bookmark on any post to keep it here.',
            )
          : Readable(
              child: ListView(
                children: [
                  for (final item in page.items)
                    Column(
                      children: [
                        PostCard(item: item),
                        Divider(color: p.line),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}
