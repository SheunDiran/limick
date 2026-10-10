import 'dart:math';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/covers.dart';

/// First screen: the pitch on one side, sign in on the other.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final pitch = _Pitch(wide: wide);
    final signIn = Container(
      constraints: const BoxConstraints(maxWidth: 420),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: p.line),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: SignInWidget(
          client: client,
          onError: (error) => showError(context, error),
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: wide
            ? Row(
                children: [
                  Expanded(flex: 6, child: pitch),
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: signIn,
                      ),
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 420, child: pitch),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                      child: signIn,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _Pitch extends StatelessWidget {
  final bool wide;
  const _Pitch({required this.wide});

  static final _books = [
    ('On the Origin of Species', 'Charles Darwin', Topic.science, 1228),
    ('Meditations', 'Marcus Aurelius', Topic.philosophy, 2680),
    ('Notes on Nursing', 'Florence Nightingale', Topic.medicine, 12439),
    ('The Common Law', 'O. W. Holmes Jr.', Topic.law, 2449),
    ('Pride and Prejudice', 'Jane Austen', Topic.literature, 1342),
  ];

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        // A loose fan of covers drifting off the edge.
        Positioned(
          right: wide ? -40 : -60,
          top: wide ? 60 : 30,
          child: SizedBox(
            width: wide ? 460 : 300,
            height: wide ? 520 : 340,
            child: Stack(
              children: [
                for (final (i, b) in _books.indexed)
                  Positioned(
                    left: (wide ? 70.0 : 46.0) * i,
                    top: (i.isEven ? 0 : 1) * (wide ? 48.0 : 30.0) + i * 10,
                    child: Transform.rotate(
                      angle: (i - 2) * 0.09 + sin(i.toDouble()) * 0.03,
                      child: BookCover(
                        width: wide ? 170 : 110,
                        book: Book(
                          gutenbergId: b.$4,
                          title: b.$1,
                          author: b.$2,
                          handle: b.$1,
                          topics: [b.$3],
                          primaryTopic: b.$3,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  p.background,
                  p.background.withValues(alpha: 0.85),
                  p.background.withValues(alpha: 0),
                ],
                stops: const [0.25, 0.55, 1],
              ),
            ),
          ),
        ),
        Positioned(
          left: wide ? 64 : 24,
          right: wide ? 120 : 24,
          bottom: wide ? 72 : 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'limick',
                style: serif(
                  size: 22,
                  weight: FontWeight.w600,
                  color: p.accent,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Keep scrolling.\nKeep learning.',
                style: serif(
                  size: wide ? 68 : 44,
                  weight: FontWeight.w500,
                  color: p.ink,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Text(
                  'A feed where every post comes from a real book. Medicine, law, science, '
                  'philosophy and the great classics, one tap from the chapter they came from.',
                  style: TextStyle(
                    fontSize: wide ? 17 : 15,
                    color: p.muted,
                    height: 1.55,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
