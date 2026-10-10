import '../generated/protocol.dart';

/// Maps Library of Congress classes and Gutenberg subjects to Limick topics.
List<Topic> topicsFor({
  required String locc,
  required String subjects,
  required String bookshelves,
}) {
  final found = <Topic>[];
  void add(Topic t) {
    if (!found.contains(t)) found.add(t);
  }

  final text = '$subjects; $bookshelves'.toLowerCase();
  const keywords = <String, Topic>{
    'poetry': Topic.poetry,
    'poems': Topic.poetry,
    'medicine': Topic.medicine,
    'medical': Topic.medicine,
    'nursing': Topic.medicine,
    'health': Topic.medicine,
    'anatomy': Topic.medicine,
    'law': Topic.law,
    'legal': Topic.law,
    'philosophy': Topic.philosophy,
    'ethics': Topic.philosophy,
    'psychology': Topic.psychology,
    'economics': Topic.economics,
    'political science': Topic.politics,
    'politics': Topic.politics,
    'biography': Topic.biography,
    'autobiography': Topic.biography,
    'mathematics': Topic.mathematics,
    'science': Topic.science,
    'technology': Topic.technology,
    'engineering': Topic.technology,
    'religion': Topic.religion,
    'mythology': Topic.religion,
    'history': Topic.history,
    'education': Topic.education,
    'art': Topic.arts,
    'music': Topic.arts,
    'natural history': Topic.nature,
    'nature': Topic.nature,
    'self-help': Topic.selfImprovement,
    'success': Topic.selfImprovement,
    'fiction': Topic.literature,
    'novel': Topic.literature,
  };

  final code = locc.split(';').first.trim().toUpperCase();
  if (code.isNotEmpty) {
    final two = code.length >= 2 ? code.substring(0, 2) : code;
    switch (code[0]) {
      case 'R':
        add(Topic.medicine);
      case 'K':
        add(Topic.law);
      case 'Q':
        add(two == 'QA' ? Topic.mathematics : Topic.science);
        if (two == 'QH' || two == 'QL' || two == 'QK') add(Topic.nature);
      case 'B':
        if (two == 'BF') {
          add(Topic.psychology);
        } else if (two.compareTo('BL') >= 0) {
          add(Topic.religion);
        } else {
          add(Topic.philosophy);
        }
      case 'H':
        add(
          two.compareTo('HB') >= 0 && two.compareTo('HJ') <= 0
              ? Topic.economics
              : Topic.politics,
        );
      case 'J':
        add(Topic.politics);
      case 'D' || 'E' || 'F':
        add(Topic.history);
      case 'C':
        add(two == 'CT' ? Topic.biography : Topic.history);
      case 'T':
        add(Topic.technology);
      case 'N' || 'M':
        add(Topic.arts);
      case 'L':
        add(Topic.education);
      case 'S' || 'G':
        add(Topic.nature);
      case 'P':
        add(Topic.literature);
    }
  }
  for (final entry in keywords.entries) {
    if (text.contains(entry.key)) add(entry.value);
    if (found.length >= 3) break;
  }
  if (found.isEmpty) add(Topic.literature);
  return found;
}

/// Turns "Darwin, Charles, 1809-1882; Huxley, T. H." into
/// ("Charles Darwin", "1809-1882").
({String name, String? years}) parseAuthors(String raw) {
  if (raw.trim().isEmpty) return (name: 'Unknown', years: null);
  final first = raw.split(';').first.trim();
  final parts = first.split(',').map((p) => p.trim()).toList();
  String? years;
  if (parts.isNotEmpty && RegExp(r'\d').hasMatch(parts.last)) {
    years = parts.removeLast().replaceAll(RegExp(r'\[.*?\]'), '').trim();
  }
  parts.removeWhere((p) => p.startsWith('['));
  final name = parts.length >= 2
      ? '${parts.sublist(1).join(' ')} ${parts.first}'.trim()
      : parts.join(' ');
  final cleanName = name.replaceAll(RegExp(r'\s*\[.*?\]'), '').trim();
  // Translators and editors are listed with a role in brackets; only real
  // co-authors earn an "et al.".
  final coAuthors = raw.split(';').skip(1).where((a) => !a.contains('['));
  final extra = coAuthors.isNotEmpty ? ' et al.' : '';
  return (name: '$cleanName$extra'.trim(), years: years);
}
