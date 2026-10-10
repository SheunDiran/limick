/// Text helpers shared by ingestion, generation and the social features.
library;

final _whitespace = RegExp(r'\s+');

/// Collapses whitespace and normalises typographic quotes and dashes, so that
/// a quote produced by the model can be matched against the source text.
String normalizeForMatch(String input) {
  return input
      .replaceAll(RegExp('[‘’‛′]'), "'")
      .replaceAll(RegExp('[“”‟″]'), '"')
      .replaceAll(RegExp('[–—]'), '-')
      .replaceAll('_', '')
      .replaceAll(_whitespace, ' ')
      .trim()
      .toLowerCase();
}

/// Returns the character range of [quote] inside [source], ignoring
/// differences in whitespace, quote style and case. Null if not present.
({int start, int end})? findQuote(String source, String quote) {
  final target = normalizeForMatch(quote);
  if (target.length < 12) return null;

  // Build the normalised source while remembering where each normalised
  // character came from, so the match maps back to original offsets.
  final buffer = StringBuffer();
  final origin = <int>[];
  var lastWasSpace = true;
  for (var i = 0; i < source.length; i++) {
    var c = source[i];
    if ('‘’‛′'.contains(c)) c = "'";
    if ('“”‟″'.contains(c)) c = '"';
    if ('–—'.contains(c)) c = '-';
    if (c == '_') continue;
    if (c.trim().isEmpty) {
      if (lastWasSpace) continue;
      c = ' ';
      lastWasSpace = true;
    } else {
      lastWasSpace = false;
    }
    buffer.write(c.toLowerCase());
    origin.add(i);
  }
  final haystack = buffer.toString();
  final index = haystack.indexOf(target);
  if (index < 0) return null;
  return (start: origin[index], end: origin[index + target.length - 1] + 1);
}

/// Whether [word] appears as a whole word in [text], case-insensitively.
bool containsWord(String text, String word) {
  final escaped = RegExp.escape(word.trim());
  if (escaped.isEmpty) return false;
  return RegExp('\\b$escaped\\b', caseSensitive: false).hasMatch(text);
}

int countWords(String text) =>
    text.trim().isEmpty ? 0 : text.trim().split(_whitespace).length;

/// Turns a title like "On the Origin of Species" into "OriginOfSpecies".
String handleFromTitle(String title) {
  const leading = {'the', 'a', 'an', 'on', 'of', 'concerning'};
  final main = title.split(RegExp(r'[:;]')).first;
  final words = main
      .replaceAll(RegExp(r"[^A-Za-z0-9 ]"), ' ')
      .split(_whitespace)
      .where((w) => w.isNotEmpty)
      .toList();
  // Drop leading filler ("On the Origin..."), but never every word.
  while (words.length > 1 && leading.contains(words.first.toLowerCase())) {
    words.removeAt(0);
  }
  var handle = words
      .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
      .join();
  if (handle.isEmpty) handle = 'Book';
  if (handle.length > 24) handle = handle.substring(0, 24);
  return handle;
}

/// Lowercase handle for users: letters, digits and underscores, 3–20 chars.
final userHandlePattern = RegExp(r'^[a-z0-9_]{3,20}$');

String suggestUserHandle(String source) {
  var base = source
      .toLowerCase()
      .split('@')
      .first
      .replaceAll(RegExp(r'[^a-z0-9_]'), '');
  if (base.length < 3) base = 'reader$base';
  if (base.length > 16) base = base.substring(0, 16);
  return base;
}

const _blocked = [
  'fuck',
  'shit',
  'cunt',
  'bitch',
  'nigger',
  'faggot',
  'retard',
  'whore',
  'slut',
];

/// Masks a short list of slurs and profanity. Moderation by report and block
/// remains the main tool; this only keeps the obvious out of public rooms.
String maskProfanity(String input) {
  var output = input;
  for (final word in _blocked) {
    output = output.replaceAllMapped(
      RegExp('\\b$word\\w*', caseSensitive: false),
      (m) => '${m[0]![0]}${'*' * (m[0]!.length - 1)}',
    );
  }
  return output;
}

/// Trims, collapses runs of blank lines and enforces a length limit.
String cleanUserText(String input, {required int maxLength}) {
  final trimmed = input
      .replaceAll('\r\n', '\n')
      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
      .trim();
  return trimmed.length > maxLength ? trimmed.substring(0, maxLength) : trimmed;
}
