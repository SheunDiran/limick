import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limick_client/limick_client.dart';

/// Limick's look: ink and paper with a single ember accent. Serif for the
/// words that come from books, a clean sans for everything around them.
class Palette {
  final Color background;
  final Color surface;
  final Color raised;
  final Color ink;
  final Color muted;
  final Color faint;
  final Color line;
  final Color accent;
  final Color onAccent;
  final Color good;
  final Color bad;

  const Palette({
    required this.background,
    required this.surface,
    required this.raised,
    required this.ink,
    required this.muted,
    required this.faint,
    required this.line,
    required this.accent,
    required this.onAccent,
    required this.good,
    required this.bad,
  });

  static const dark = Palette(
    background: Color(0xFF0D0D0F),
    surface: Color(0xFF151518),
    raised: Color(0xFF1D1D21),
    ink: Color(0xFFEDE7DC),
    muted: Color(0xFF9C978F),
    faint: Color(0xFF8E8A84),
    line: Color(0xFF26262B),
    accent: Color(0xFFFF6A3D),
    onAccent: Color(0xFF140A06),
    good: Color(0xFF6BCB8B),
    bad: Color(0xFFFF7A7A),
  );

  static const light = Palette(
    background: Color(0xFFF7F2E9),
    surface: Color(0xFFFFFCF6),
    raised: Color(0xFFEFE8DB),
    ink: Color(0xFF1A1714),
    muted: Color(0xFF6E675E),
    faint: Color(0xFF756E63),
    line: Color(0xFFE3DACB),
    accent: Color(0xFFE2471B),
    onAccent: Color(0xFFFFFFFF),
    good: Color(0xFF2E8B57),
    bad: Color(0xFFC8372D),
  );
}

extension PaletteContext on BuildContext {
  Palette get palette => Theme.of(this).brightness == Brightness.dark
      ? Palette.dark
      : Palette.light;
}

/// Serif used for quotes, book titles and the reader.
TextStyle serif({
  double size = 18,
  FontWeight weight = FontWeight.w400,
  Color? color,
  FontStyle? style,
  double height = 1.45,
}) => GoogleFonts.newsreader(
  fontSize: size,
  fontWeight: weight,
  color: color,
  fontStyle: style,
  height: height,
);

ThemeData buildTheme(Brightness brightness) {
  final p = brightness == Brightness.dark ? Palette.dark : Palette.light;
  final base = ThemeData(brightness: brightness, useMaterial3: true);
  final text = GoogleFonts.instrumentSansTextTheme(base.textTheme).apply(
    bodyColor: p.ink,
    displayColor: p.ink,
  );
  return base.copyWith(
    scaffoldBackgroundColor: p.background,
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: p.accent,
          brightness: brightness,
        ).copyWith(
          primary: p.accent,
          onPrimary: p.onAccent,
          surface: p.surface,
          onSurface: p.ink,
          outline: p.line,
          error: p.bad,
        ),
    textTheme: text.copyWith(
      bodyLarge: text.bodyLarge?.copyWith(fontSize: 16, height: 1.5),
      bodyMedium: text.bodyMedium?.copyWith(fontSize: 15, height: 1.45),
      bodySmall: text.bodySmall?.copyWith(color: p.muted),
      titleLarge: serif(
        size: 26,
        weight: FontWeight.w600,
        color: p.ink,
        height: 1.2,
      ),
      headlineMedium: serif(
        size: 34,
        weight: FontWeight.w600,
        color: p.ink,
        height: 1.1,
      ),
      headlineLarge: serif(
        size: 46,
        weight: FontWeight.w500,
        color: p.ink,
        height: 1.05,
      ),
    ),
    dividerTheme: DividerThemeData(color: p.line, thickness: 1, space: 1),
    iconTheme: IconThemeData(color: p.muted, size: 22),
    splashFactory: InkSparkle.splashFactory,
    appBarTheme: AppBarTheme(
      backgroundColor: p.background,
      surfaceTintColor: Colors.transparent,
      foregroundColor: p.ink,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.instrumentSans(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: p.ink,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: p.surface,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      dragHandleColor: p.faint,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: p.surface,
      surfaceTintColor: Colors.transparent,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: p.ink,
      contentTextStyle: GoogleFonts.instrumentSans(
        color: p.background,
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: p.raised,
      hintStyle: TextStyle(color: p.faint),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: p.accent, width: 1.2),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: p.ink,
        foregroundColor: p.background,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: GoogleFonts.instrumentSans(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: p.ink,
        side: BorderSide(color: p.line),
        minimumSize: const Size(0, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: GoogleFonts.instrumentSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: p.accent,
        textStyle: GoogleFonts.instrumentSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: p.background,
      surfaceTintColor: Colors.transparent,
      indicatorColor: p.raised,
      height: 64,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      iconTheme: WidgetStateProperty.resolveWith(
        (s) => IconThemeData(
          color: s.contains(WidgetState.selected) ? p.ink : p.faint,
          size: 24,
        ),
      ),
    ),
  );
}

/// One colour per topic, used for generated covers and small accents.
Color topicColor(Topic topic) => switch (topic) {
  Topic.medicine => const Color(0xFF3FA796),
  Topic.law => const Color(0xFF8A6FDF),
  Topic.science => const Color(0xFF4C8DF6),
  Topic.philosophy => const Color(0xFFD9A441),
  Topic.psychology => const Color(0xFFDA6FA5),
  Topic.economics => const Color(0xFF5AAE5F),
  Topic.history => const Color(0xFFB9784A),
  Topic.literature => const Color(0xFFE0614A),
  Topic.poetry => const Color(0xFFC26DD8),
  Topic.mathematics => const Color(0xFF3CB4D6),
  Topic.technology => const Color(0xFF7D8BA6),
  Topic.religion => const Color(0xFFCF9A5C),
  Topic.politics => const Color(0xFFD45460),
  Topic.biography => const Color(0xFF9C8F7A),
  Topic.selfImprovement => const Color(0xFFE8B23A),
  Topic.arts => const Color(0xFFE5739B),
  Topic.education => const Color(0xFF6C9BD2),
  Topic.nature => const Color(0xFF6BAF6E),
};

String topicLabel(Topic topic) => switch (topic) {
  Topic.medicine => 'Medicine',
  Topic.law => 'Law',
  Topic.science => 'Science',
  Topic.philosophy => 'Philosophy',
  Topic.psychology => 'Psychology',
  Topic.economics => 'Economics',
  Topic.history => 'History',
  Topic.literature => 'Literature',
  Topic.poetry => 'Poetry',
  Topic.mathematics => 'Mathematics',
  Topic.technology => 'Technology',
  Topic.religion => 'Religion & Myth',
  Topic.politics => 'Politics',
  Topic.biography => 'Biography',
  Topic.selfImprovement => 'Self-improvement',
  Topic.arts => 'Arts',
  Topic.education => 'Education',
  Topic.nature => 'Nature',
};
