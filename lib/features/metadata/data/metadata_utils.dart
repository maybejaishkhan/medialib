/// Small shared helpers for metadata providers.
library;

/// Removes HTML tags and decodes a few common entities from provider text.
String stripHtml(String input) => input
    .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
    .replaceAll(RegExp('<[^>]+>'), '')
    .replaceAll('&nbsp;', ' ')
    .replaceAll('&amp;', '&')
    .replaceAll('&quot;', '"')
    .replaceAll('&#039;', "'")
    .replaceAll(RegExp(r'\n{3,}'), '\n\n')
    .trim();

/// Builds a [DateTime] from optional year/month/day components.
DateTime? dateFromParts(int? year, [int? month, int? day]) {
  if (year == null) return null;
  return DateTime(year, month ?? 1, day ?? 1);
}

/// Parses a date from a string, returning null when it cannot be parsed.
DateTime? parseDate(Object? value) {
  if (value is! String || value.isEmpty) return null;
  return DateTime.tryParse(value);
}

/// Joins non-empty creator names with ", ".
String? joinCreators(Iterable<String?> names) {
  final cleaned = names
      .whereType<String>()
      .map((name) => name.trim())
      .where((name) => name.isNotEmpty)
      .toList();
  return cleaned.isEmpty ? null : cleaned.join(', ');
}
