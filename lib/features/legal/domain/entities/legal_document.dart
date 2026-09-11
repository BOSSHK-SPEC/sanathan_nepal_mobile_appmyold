import 'package:freezed_annotation/freezed_annotation.dart';

part 'legal_document.freezed.dart';

/// Which legal document is being displayed.
enum LegalDocumentType {
  privacyPolicy('privacy'),
  termsConditions('terms');

  const LegalDocumentType(this.code);
  final String code;

  static LegalDocumentType fromCode(String? code) => LegalDocumentType.values
      .firstWhere((t) => t.code == code, orElse: () => privacyPolicy);
}

/// A localised piece of legal text (Nepali / English / optional Hindi).
///
/// Hindi is optional: when it is missing the English text is shown for the
/// `hi` locale (legal copy is only partially translated – headings and short
/// summaries).
@freezed
abstract class LegalText with _$LegalText {
  const LegalText._();

  const factory LegalText({
    required String ne,
    required String en,
    String? hi,
  }) = _LegalText;

  /// Builds a body whose Hindi variant is a short Hindi summary followed by
  /// the full (authoritative) English wording.
  factory LegalText.withHindiSummary({
    required String ne,
    required String en,
    required String hiSummary,
  }) => LegalText(ne: ne, en: en, hi: '$hiSummary\n\n$en');

  /// Resolves the text for the active language.
  String of({required bool nepali}) => nepali ? ne : en;

  /// Resolves the text for a language code (`ne`, `en`, `hi`).
  String resolve(String languageCode) => switch (languageCode) {
    'ne' => ne,
    'hi' => hi ?? en,
    _ => en,
  };
}

/// One headed section of a legal document. `level` 1 = "1. Heading",
/// `level` 2 = "1.1 Sub heading" (rendered smaller / indented).
@freezed
abstract class LegalSection with _$LegalSection {
  const factory LegalSection({
    required LegalText heading,
    required LegalText body,
    @Default(1) int level,
  }) = _LegalSection;
}

/// A complete legal document (Privacy Policy / Terms & Conditions).
@freezed
abstract class LegalDocument with _$LegalDocument {
  const factory LegalDocument({
    required LegalDocumentType type,
    required LegalText title,
    required LegalText intro,
    required DateTime lastUpdated,
    required List<LegalSection> sections,
  }) = _LegalDocument;
}
