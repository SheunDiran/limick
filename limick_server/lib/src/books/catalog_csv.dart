/// Minimal RFC 4180 CSV parser: quoted fields, escaped quotes and embedded
/// newlines, which the Gutenberg catalogue uses heavily.
Iterable<List<String>> parseCsv(String input) sync* {
  var field = StringBuffer();
  var row = <String>[];
  var inQuotes = false;
  for (var i = 0; i < input.length; i++) {
    final c = input[i];
    if (inQuotes) {
      if (c == '"') {
        if (i + 1 < input.length && input[i + 1] == '"') {
          field.write('"');
          i++;
        } else {
          inQuotes = false;
        }
      } else {
        field.write(c);
      }
      continue;
    }
    switch (c) {
      case '"':
        inQuotes = true;
      case ',':
        row.add(field.toString());
        field = StringBuffer();
      case '\n':
        row.add(field.toString());
        field = StringBuffer();
        yield row;
        row = <String>[];
      case '\r':
        break;
      default:
        field.write(c);
    }
  }
  if (field.isNotEmpty || row.isNotEmpty) {
    row.add(field.toString());
    yield row;
  }
}
