import 'dart:math';

import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../theme.dart';

/// A generated cover: the book's topic colour, a quiet pattern seeded by its
/// id, and the title set in serif. Every book gets a recognisable face
/// without shipping any images.
class BookCover extends StatelessWidget {
  final Book book;
  final double width;
  final bool showTitle;

  const BookCover({
    super.key,
    required this.book,
    this.width = 120,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = topicColor(book.primaryTopic);
    final height = width * 1.5;
    final radius = BorderRadius.circular(max(4, width * 0.06));
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: width * 0.12,
            offset: Offset(0, width * 0.05),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: CustomPaint(
          painter: _CoverPainter(color, book.gutenbergId),
          child: showTitle && width >= 64
              ? Padding(
                  padding: EdgeInsets.fromLTRB(
                    width * 0.1,
                    width * 0.12,
                    width * 0.1,
                    width * 0.1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: serif(
                          size: width * 0.115,
                          weight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: width * 0.18,
                        height: 1.5,
                        color: Colors.white70,
                      ),
                      SizedBox(height: width * 0.05),
                      Text(
                        book.author.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: max(7, width * 0.062),
                          letterSpacing: 0.8,
                          color: Colors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class _CoverPainter extends CustomPainter {
  final Color color;
  final int seed;
  _CoverPainter(this.color, this.seed);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final hsl = HSLColor.fromColor(color);
    final deep = hsl
        .withLightness((hsl.lightness * 0.45).clamp(0.08, 0.35))
        .toColor();
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, deep],
        ).createShader(rect),
    );
    final random = Random(seed);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = max(1, size.width * 0.012)
      ..color = Colors.white.withValues(alpha: 0.10);
    switch (seed % 3) {
      case 0: // Concentric arcs.
        final c = Offset(
          size.width * (0.6 + random.nextDouble() * 0.5),
          size.height * 0.85,
        );
        for (
          var r = size.width * 0.2;
          r < size.width * 1.4;
          r += size.width * 0.14
        ) {
          canvas.drawCircle(c, r, paint);
        }
      case 1: // Diagonal rules.
        for (var x = -size.height; x < size.width; x += size.width * 0.12) {
          canvas.drawLine(
            Offset(x, size.height),
            Offset(x + size.height, 0),
            paint,
          );
        }
      default: // Scattered circles.
        paint.style = PaintingStyle.fill;
        for (var i = 0; i < 7; i++) {
          canvas.drawCircle(
            Offset(
              random.nextDouble() * size.width,
              size.height * (0.4 + random.nextDouble() * 0.6),
            ),
            size.width * (0.05 + random.nextDouble() * 0.2),
            paint,
          );
        }
    }
    // A thin spine highlight.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width * 0.035, size.height),
      Paint()..color = Colors.black.withValues(alpha: 0.18),
    );
  }

  @override
  bool shouldRepaint(_CoverPainter old) =>
      old.color != color || old.seed != seed;
}

/// Square avatar for a book account: a cropped cover with an initial.
class BookAvatar extends StatelessWidget {
  final Book book;
  final double size;
  const BookAvatar({super.key, required this.book, this.size = 44});

  @override
  Widget build(BuildContext context) {
    final color = topicColor(book.primaryTopic);
    final initial = book.handle.isNotEmpty ? book.handle[0] : '?';
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            HSLColor.fromColor(color).withLightness(0.25).toColor(),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: serif(
          size: size * 0.48,
          weight: FontWeight.w600,
          color: Colors.white,
          height: 1,
        ),
      ),
    );
  }
}

/// Round avatar for a reader, coloured by their chosen hue.
class ReaderAvatar extends StatelessWidget {
  final String name;
  final int hue;
  final double size;
  const ReaderAvatar({
    super.key,
    required this.name,
    required this.hue,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    final color = HSLColor.fromAHSL(
      1,
      hue.toDouble() % 360,
      0.55,
      0.55,
    ).toColor();
    final initials = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0].toUpperCase())
        .join();
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.22),
      ),
      alignment: Alignment.center,
      child: Text(
        initials.isEmpty ? '?' : initials,
        style: TextStyle(
          fontSize: size * 0.38,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
