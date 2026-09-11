import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_text.freezed.dart';

/// Multilingual (Nepali / English / Hindi) text value.
///
/// Lives in core because every content-bearing feature needs it —
/// astrologer bios, service names, consultation notes, festival copy.
/// [hi] is optional; [forLanguage] falls back to English when no
/// dedicated Hindi translation exists.
@freezed
abstract class LocalizedText with _$LocalizedText {
  const LocalizedText._();

  const factory LocalizedText({
    required String ne,
    required String en,

    /// Hindi text – `null` when no dedicated translation was provided.
    String? hi,
  }) = _LocalizedText;

  /// Same text in every language (names, e-mails, URLs…).
  factory LocalizedText.same(String value) =>
      LocalizedText(ne: value, en: value, hi: value);

  /// Legacy two-way lookup kept for callers that only know "Nepali or not".
  String of({required bool nepali}) => nepali ? ne : en;

  /// Text for a BCP-47 language code (`ne`, `hi`, anything else → English).
  String forLanguage(String languageCode) => switch (languageCode) {
    'ne' => ne,
    'hi' => hi ?? en,
    _ => en,
  };
}
