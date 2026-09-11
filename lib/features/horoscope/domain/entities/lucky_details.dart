import 'package:freezed_annotation/freezed_annotation.dart';

part 'lucky_details.freezed.dart';

/// Static "lucky" attributes of a zodiac sign shown under the prediction
/// (Figma: "Lucky Details" strip + "More Details" table).
///
/// Hindi variants (`*Hi`) are optional – when empty the `*For('hi')`
/// accessors fall back to English.
@freezed
abstract class LuckyDetails with _$LuckyDetails {
  const LuckyDetails._();

  const factory LuckyDetails({
    /// Lucky numbers, e.g. `[6, 9]`.
    required List<int> numbers,
    required String colorNe,
    required String colorEn,

    /// ARGB colour value of the lucky colour swatch (kept as int so the
    /// domain layer stays free of Flutter imports).
    required int colorValue,
    required List<String> daysNe,
    required List<String> daysEn,
    required String rulingPlanetNe,
    required String rulingPlanetEn,
    required String symbolNe,
    required String symbolEn,
    required String elementNe,
    required String elementEn,
    required String luckyStoneNe,
    required String luckyStoneEn,
    required String unluckyStoneNe,
    required String unluckyStoneEn,
    required String luckyAlphabet,
    required List<int> eventfulYears,
    @Default('') String colorHi,
    @Default([]) List<String> daysHi,
    @Default('') String rulingPlanetHi,
    @Default('') String symbolHi,
    @Default('') String elementHi,
    @Default('') String luckyStoneHi,
    @Default('') String unluckyStoneHi,
  }) = _LuckyDetails;

  String color({required bool nepali}) => nepali ? colorNe : colorEn;
  List<String> days({required bool nepali}) => nepali ? daysNe : daysEn;
  String rulingPlanet({required bool nepali}) =>
      nepali ? rulingPlanetNe : rulingPlanetEn;
  String symbol({required bool nepali}) => nepali ? symbolNe : symbolEn;
  String element({required bool nepali}) => nepali ? elementNe : elementEn;
  String luckyStone({required bool nepali}) =>
      nepali ? luckyStoneNe : luckyStoneEn;
  String unluckyStone({required bool nepali}) =>
      nepali ? unluckyStoneNe : unluckyStoneEn;

  String colorFor(String languageCode) =>
      _pick(languageCode, ne: colorNe, hi: colorHi, en: colorEn);
  List<String> daysFor(String languageCode) => switch (languageCode) {
    'ne' => daysNe,
    'hi' => daysHi.isNotEmpty ? daysHi : daysEn,
    _ => daysEn,
  };
  String rulingPlanetFor(String languageCode) => _pick(
    languageCode,
    ne: rulingPlanetNe,
    hi: rulingPlanetHi,
    en: rulingPlanetEn,
  );
  String symbolFor(String languageCode) =>
      _pick(languageCode, ne: symbolNe, hi: symbolHi, en: symbolEn);
  String elementFor(String languageCode) =>
      _pick(languageCode, ne: elementNe, hi: elementHi, en: elementEn);
  String luckyStoneFor(String languageCode) =>
      _pick(languageCode, ne: luckyStoneNe, hi: luckyStoneHi, en: luckyStoneEn);
  String unluckyStoneFor(String languageCode) => _pick(
    languageCode,
    ne: unluckyStoneNe,
    hi: unluckyStoneHi,
    en: unluckyStoneEn,
  );

  static String _pick(
    String languageCode, {
    required String ne,
    required String hi,
    required String en,
  }) => switch (languageCode) {
    'ne' => ne,
    'hi' => hi.isNotEmpty ? hi : en,
    _ => en,
  };
}
