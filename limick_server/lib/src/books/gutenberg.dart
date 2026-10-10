import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../util/text.dart';

/// Downloads and parses Project Gutenberg plain-text books.
class Gutenberg {
  static const _userAgent =
      'Limick/1.0 (+https://github.com/sheundiran/limick)';

  /// Downloads [url] fully, resuming with HTTP range requests when the
  /// connection drops. Gutenberg's servers often cut long transfers short.
  static Future<List<int>> download(
    String url, {
    int maxAttempts = 12,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    final bytes = <int>[];
    int? total;
    Object? lastError;
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final client = HttpClient()..userAgent = _userAgent;
      try {
        final request = await client.getUrl(Uri.parse(url)).timeout(timeout);
        if (bytes.isNotEmpty) {
          request.headers.set(
            HttpHeaders.rangeHeader,
            'bytes=${bytes.length}-',
          );
        }
        final response = await request.close().timeout(timeout);
        if (response.statusCode == 404) {
          throw const HttpException('Not found');
        }
        if (response.statusCode == 200) {
          // Server ignored the range, start over.
          bytes.clear();
          total = response.contentLength > 0 ? response.contentLength : null;
        } else if (response.statusCode == 206) {
          final range = response.headers.value(HttpHeaders.contentRangeHeader);
          final size = range?.split('/').last;
          total ??= int.tryParse(size ?? '');
        } else {
          throw HttpException('HTTP ${response.statusCode}');
        }
        await for (final chunk in response.timeout(timeout)) {
          bytes.addAll(chunk);
        }
        if (total == null || bytes.length >= total) return bytes;
      } on HttpException catch (e) {
        if (e.message == 'Not found') rethrow;
        lastError = e;
      } catch (e) {
        lastError = e;
      } finally {
        client.close(force: true);
      }
      await Future.delayed(Duration(milliseconds: 400 * (attempt + 1)));
    }
    throw HttpException(
      'Download failed after $maxAttempts attempts: $lastError',
    );
  }

  static Future<String> fetchBookText(int gutenbergId) async {
    final candidates = [
      'https://www.gutenberg.org/cache/epub/$gutenbergId/pg$gutenbergId.txt',
      'https://www.gutenberg.org/ebooks/$gutenbergId.txt.utf-8',
    ];
    Object? lastError;
    for (final url in candidates) {
      try {
        final bytes = await download(url);
        return utf8.decode(bytes, allowMalformed: true);
      } catch (e) {
        lastError = e;
      }
    }
    throw HttpException('Could not download book $gutenbergId: $lastError');
  }
}

/// A chapter produced by [splitIntoChapters].
class ParsedChapter {
  final String title;
  final String text;
  final String label;
  ParsedChapter(this.title, this.text, [this.label = '']);
  int get wordCount => countWords(text);
}

final _startMarker = RegExp(
  r'^\*\*\*\s*START OF (THE|THIS) PROJECT GUTENBERG E-?BOOK.*$',
  multiLine: true,
  caseSensitive: false,
);
final _endMarker = RegExp(
  r'^\*\*\*\s*END OF (THE|THIS) PROJECT GUTENBERG E-?BOOK.*$',
  multiLine: true,
  caseSensitive: false,
);

/// Removes the Project Gutenberg licence header and footer, leaving only the
/// public-domain work itself.
String stripBoilerplate(String raw) {
  var text = raw.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
  final start = _startMarker.firstMatch(text);
  if (start != null) text = text.substring(start.end);
  final end = _endMarker.firstMatch(text);
  if (end != null) text = text.substring(0, end.start);
  // Some older files also end with "End of the Project Gutenberg EBook".
  final lateEnd = RegExp(
    r'^End of (the )?Project Gutenberg',
    multiLine: true,
    caseSensitive: false,
  ).firstMatch(text);
  if (lateEnd != null) text = text.substring(0, lateEnd.start);
  return text.trim();
}

const _headingWords =
    'CHAPTER|Chapter|BOOK|Book|PART|Part|LETTER|Letter|LECTURE|Lecture|'
    'ESSAY|Essay|SECTION|Section|CANTO|Canto|STAVE|Stave|ADVENTURE|Adventure|'
    'ARTICLE|Article|DIALOGUE|Dialogue|SONG|Song|FEDERALIST|PAPER|Paper';
const _ordinals =
    'FIRST|SECOND|THIRD|FOURTH|FIFTH|SIXTH|SEVENTH|EIGHTH|NINTH|TENTH|'
    'ELEVENTH|TWELFTH|THIRTEENTH|FOURTEENTH|FIFTEENTH|SIXTEENTH|'
    'SEVENTEENTH|EIGHTEENTH|NINETEENTH|TWENTIETH';

/// Heading styles found in Gutenberg texts. Each match yields a "family"
/// key; the most frequent family wins, so nested structures (BOOK I >
/// CHAPTER I) are split at the finer, more frequent level.
final _headingPatterns = <(String, RegExp)>[
  // CHAPTER IV. / Book 2 / FEDERALIST No. 10
  (
    'kw',
    RegExp(
      '^\\s*($_headingWords)\\s+(No\\.\\s*)?([IVXLCDM]+|\\d+|[A-Z][A-Za-z]+(-[A-Za-z]+)?)\\b[.:]?.*\$',
    ),
  ),
  // THE FIRST BOOK
  (
    'ord',
    RegExp(
      '^\\s*(THE\\s+)?($_ordinals)\\s+(BOOK|PART|CHAPTER|LECTURE|ESSAY)\\b.*\$',
    ),
  ),
  // IV. NOISE.
  ('romanTitle', RegExp(r"^\s*[IVXLC]+\.\s+[A-Z][A-Z ,;:'’\-\[\]\d.]{2,}$")),
  // IV.
  ('roman', RegExp(r'^\s*[IVXLC]+\.?\s*$')),
];

final _illustration = RegExp(
  r'\[(Illustration|Footnote|Sidenote)[^\]]*\]',
  dotAll: true,
);

/// "CHAPTER XIV. Recapitulation" and "Chapter 14." both become "CHAPTER 14",
/// so a table-of-contents entry can be matched to its real chapter.
String _label(String heading) {
  final match = RegExp(
    r'^\s*(\w+)\s+(No\.\s*)?([IVXLCDM]+|\d+)\b',
    caseSensitive: false,
  ).firstMatch(heading);
  if (match == null) {
    // "THE TWELFTH BOOK" and "Twelfth Book" share the label "TWELFTH BOOK".
    final words = heading
        .toUpperCase()
        .replaceAll(RegExp(r'[^A-Z ]'), ' ')
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty && w != 'THE');
    return words.take(2).join(' ');
  }
  final numeral = match.group(3)!.toUpperCase();
  final number = int.tryParse(numeral) ?? _romanToInt(numeral);
  return '${match.group(1)!.toUpperCase()} $number';
}

int _romanToInt(String roman) {
  const values = {
    'I': 1,
    'V': 5,
    'X': 10,
    'L': 50,
    'C': 100,
    'D': 500,
    'M': 1000,
  };
  var total = 0;
  for (var i = 0; i < roman.length; i++) {
    final v = values[roman[i]] ?? 0;
    final next = i + 1 < roman.length ? values[roman[i + 1]] ?? 0 : 0;
    total += v < next ? -v : v;
  }
  return total;
}

/// Splits a book into chapters using heading lines, and falls back to
/// evenly sized sections when the book has no recognisable headings.
List<ParsedChapter> splitIntoChapters(String rawBody) {
  final body = rawBody.replaceAll(_illustration, '');
  final lines = body.split('\n');

  // Collect candidate heading lines per family.
  final families = <String, List<int>>{};
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final trimmed = line.trim();
    if (trimmed.isEmpty || trimmed.length > 90) continue;
    final previousBlank = i == 0 || lines[i - 1].trim().isEmpty;
    if (!previousBlank) continue;
    for (final (family, pattern) in _headingPatterns) {
      final match = pattern.firstMatch(line);
      if (match == null) continue;
      final key = family == 'kw'
          ? 'kw:${match.group(1)!.toUpperCase()}'
          : family;
      (families[key] ??= []).add(i);
      break;
    }
  }
  var starts = <int>[];
  if (families.isNotEmpty) {
    final best = families.entries.reduce(
      (a, b) => a.value.length >= b.value.length ? a : b,
    );
    if (best.value.length >= 2) starts = best.value;
  }

  final sections = <ParsedChapter>[];
  if (starts.length >= 2) {
    final opening = _reflow(lines.sublist(0, starts.first).join('\n'));
    for (var c = 0; c < starts.length; c++) {
      final from = starts[c];
      final to = c + 1 < starts.length ? starts[c + 1] : lines.length;
      var title = lines[from].trim();
      var bodyStart = from + 1;
      // A short line right after the heading is usually the chapter's name.
      var j = bodyStart;
      while (j < to && lines[j].trim().isEmpty) {
        j++;
      }
      if (j < to) {
        final next = lines[j].trim();
        final followedByBlank = j + 1 >= to || lines[j + 1].trim().isEmpty;
        final looksLikeHeading = _headingPatterns.any(
          (p) => p.$2.hasMatch(next),
        );
        if (next.length <= 70 && followedByBlank && !looksLikeHeading) {
          title = '$title — $next';
          bodyStart = j + 1;
        }
      }
      final text = _reflow(lines.sublist(bodyStart, to).join('\n'));
      sections.add(ParsedChapter(_tidyTitle(title), text, _label(lines[from])));
    }
    // A table of contents shows up as a run of tiny sections before the
    // first real chapter: drop everything short until the first long one.
    final firstReal = sections.indexWhere((s) => s.wordCount >= 300);
    if (firstReal > 0) {
      sections.removeRange(0, firstReal);
      // The last contents entry swallows the front matter up to the first
      // real heading. It is recognisable because its label appears again.
      final first = sections.first.label;
      if (sections.skip(1).any((s) => s.label == first)) {
        sections.removeAt(0);
      }
    }
    sections.removeWhere((s) => s.wordCount < 40);
    if (countWords(opening) >= 400 && sections.isNotEmpty) {
      sections.insert(0, ParsedChapter('Opening', opening));
    }
  }

  // If one section holds most of the book, the headings were misleading.
  final totalWords = sections.fold<int>(0, (sum, s) => sum + s.wordCount);
  final lopsided =
      totalWords > 20000 && sections.any((s) => s.wordCount > totalWords * 0.4);
  if (sections.length < 2 || lopsided) {
    return _splitEvenly(_reflow(body));
  }
  return sections.expand(_splitLong).take(400).toList();
}

String _tidyTitle(String title) {
  var t = title
      .replaceAll('_', '')
      .replaceAll(RegExp(r'\[\d+\]'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  if (t.endsWith(' —')) t = t.substring(0, t.length - 2);
  // "CHAPTER IV. THE SEA" -> "Chapter IV. The Sea", keeping numerals.
  t = t
      .split(' — ')
      .map((part) {
        if (part != part.toUpperCase() || part.length <= 3) return part;
        return part
            .split(' ')
            .map((w) {
              if (RegExp(r'^[IVXLCDM]+[.:]?$').hasMatch(w)) return w;
              if (w.isEmpty) return w;
              return w[0] + w.substring(1).toLowerCase();
            })
            .join(' ');
      })
      .join(' — ');
  if (t.length <= 64) return t;
  final cut = t.substring(0, 64);
  final space = cut.lastIndexOf(' ');
  return '${cut.substring(0, space > 30 ? space : 64)}…';
}

/// Joins hard-wrapped lines into paragraphs separated by a blank line.
/// Short-line blocks such as verse keep their line breaks.
String _reflow(String raw) {
  final paragraphs = raw
      .split(RegExp(r'\n\s*\n'))
      .map((p) => p.split('\n').map((l) => l.trimRight()).toList())
      .where((p) => p.any((l) => l.trim().isNotEmpty))
      .map((lines) {
        final nonEmpty = lines.where((l) => l.trim().isNotEmpty).toList();
        final average =
            nonEmpty.fold<int>(0, (s, l) => s + l.trim().length) /
            nonEmpty.length;
        final isVerse = nonEmpty.length >= 2 && average < 48;
        final joined = isVerse
            ? nonEmpty.map((l) => l.trim()).join('\n')
            : nonEmpty.map((l) => l.trim()).join(' ');
        return joined
            .replaceAll(RegExp(r'_([^_]+)_'), r'$1')
            .replaceAll(RegExp(r'[ \t]{2,}'), ' ');
      })
      .where((p) => !RegExp(r'^[\s*.\-=]+$').hasMatch(p));
  return paragraphs.join('\n\n').trim();
}

/// Splits text into sections of roughly [target] words at paragraph breaks.
List<ParsedChapter> _splitEvenly(String text, {int target = 3500}) {
  final paragraphs = text.split('\n\n');
  final result = <ParsedChapter>[];
  final buffer = <String>[];
  var words = 0;
  for (final p in paragraphs) {
    buffer.add(p);
    words += countWords(p);
    if (words >= target) {
      result.add(
        ParsedChapter('Part ${result.length + 1}', buffer.join('\n\n')),
      );
      buffer.clear();
      words = 0;
    }
  }
  if (buffer.isNotEmpty) {
    if (words < 300 && result.isNotEmpty) {
      final last = result.removeLast();
      result.add(
        ParsedChapter(last.title, '${last.text}\n\n${buffer.join('\n\n')}'),
      );
    } else {
      result.add(
        ParsedChapter('Part ${result.length + 1}', buffer.join('\n\n')),
      );
    }
  }
  return result;
}

/// Very long chapters are hard to read on a phone, so split them.
Iterable<ParsedChapter> _splitLong(ParsedChapter chapter) sync* {
  if (chapter.wordCount <= 14000) {
    yield chapter;
    return;
  }
  final parts = _splitEvenly(chapter.text, target: 7000);
  for (var i = 0; i < parts.length; i++) {
    yield ParsedChapter(
      '${chapter.title} (${i + 1}/${parts.length})',
      parts[i].text,
    );
  }
}
