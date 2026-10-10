import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/covers.dart';
import 'profile_screen.dart';

/// Another reader's public profile.
class ReaderProfileScreen extends StatefulWidget {
  final String handle;
  const ReaderProfileScreen({super.key, required this.handle});

  @override
  State<ReaderProfileScreen> createState() => _ReaderProfileScreenState();
}

class _ReaderProfileScreenState extends State<ReaderProfileScreen> {
  PublicProfile? _profile;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final profile = await client.profile.getProfile(widget.handle);
      if (mounted) setState(() => _profile = profile);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  Future<void> _toggleBlock() async {
    final pr = _profile!;
    try {
      await client.moderation.setBlocked(pr.author.id, !pr.blocked);
      setState(() => _profile = pr.copyWith(blocked: !pr.blocked));
      if (mounted) {
        showMessage(
          context,
          pr.blocked
              ? 'Unblocked.'
              : 'Blocked. You will no longer see their comments or messages.',
        );
      }
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final pr = _profile;
    return Scaffold(
      appBar: AppBar(title: Text('@${widget.handle}')),
      body: _error != null
          ? Empty.error(_error!, onRetry: _load)
          : pr == null
          ? const Loading()
          : Readable(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  ReaderAvatar(
                    name: pr.author.displayName,
                    hue: pr.author.avatarHue,
                    size: 72,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    pr.author.displayName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '@${pr.author.handle}${pr.field == null ? '' : ' · ${pr.field}'}',
                    style: TextStyle(color: p.muted),
                  ),
                  if (pr.bio.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(pr.bio, style: const TextStyle(height: 1.5)),
                  ],
                  const SizedBox(height: 24),
                  StatsGrid(stats: pr.stats),
                  if (!pr.isMe) ...[
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: _toggleBlock,
                      child: Text(pr.blocked ? 'Unblock' : 'Block'),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
