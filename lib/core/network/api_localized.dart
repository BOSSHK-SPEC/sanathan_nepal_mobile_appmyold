import '../utils/localized_text.dart';

/// Reads the server's `{en, ne, hi}` translation object.
///
/// Every module on the API sends multilingual copy in this one shape, so the
/// parsing (and the fallback rules) belong here rather than being written a
/// little differently in each data source.
///
/// A bare string is accepted too: some fields — a person's name, a temple —
/// are stored untranslated, and treating them as "the same in every language"
/// is what the app should render.
LocalizedText asLocalizedText(Object? raw) {
  if (raw is String) return LocalizedText.same(raw);
  if (raw is! Map) return const LocalizedText(en: '', ne: '');

  final en = raw['en']?.toString() ?? '';
  final ne = raw['ne']?.toString();
  final hi = raw['hi']?.toString();
  return LocalizedText(
    en: en,
    // English is the only translation guaranteed to exist; falling back to it
    // beats rendering an empty label to a Nepali reader.
    ne: ne == null || ne.isEmpty ? en : ne,
    hi: hi == null || hi.isEmpty ? null : hi,
  );
}

/// The same payload as a plain map, for entities that hold one language's
/// string rather than a [LocalizedText].
Map<String, String> asLocalizedMap(Object? raw) {
  if (raw is String) return {'en': raw};
  if (raw is! Map) return const {};
  return {
    for (final entry in raw.entries) entry.key.toString(): '${entry.value}',
  };
}

/// One language out of a translation object, falling back to English and then
/// to any translation that exists — an unlocalised label is better than none.
String localizedFor(Object? raw, String languageCode) {
  final map = asLocalizedMap(raw);
  final value = map[languageCode] ?? map['en'];
  if (value != null && value.isNotEmpty) return value;
  return map.values.firstWhere((v) => v.isNotEmpty, orElse: () => '');
}
