import 'package:freezed_annotation/freezed_annotation.dart';

import 'horoscope_media.dart';

part 'sign_profile.freezed.dart';

String _pick(
  String code, {
  required String ne,
  required String hi,
  required String en,
}) => switch (code) {
  'ne' => ne,
  'hi' => hi.isNotEmpty ? hi : en,
  _ => en,
};

/// Static "about the sign" content shown inside the expanded "थप विवरण /
/// More Details" area of a sign card (Figma `Group 35717`): the about
/// paragraph ("मेष राशि को बारेमा"), the tabbed sections (मेष राशि को पुरुष /
/// व्यक्तित्व / career horoscope) and the second media clip ("Lucky Color,
/// Number and Stone for Aries Sign").
@freezed
abstract class SignProfile with _$SignProfile {
  const SignProfile._();

  const factory SignProfile({
    required String aboutNe,
    required String aboutEn,
    required List<SignProfileTab> tabs,
    required HoroscopeMedia luckyMedia,
    @Default('') String aboutHi,
  }) = _SignProfile;

  String aboutFor(String languageCode) =>
      _pick(languageCode, ne: aboutNe, hi: aboutHi, en: aboutEn);
}

/// One tab of the sign profile: title, intro paragraph and bullet points
/// (पैसा / स्वास्थ्य / पेशा / सम्बन्ध …).
@freezed
abstract class SignProfileTab with _$SignProfileTab {
  const SignProfileTab._();

  const factory SignProfileTab({
    required String titleNe,
    required String titleEn,
    required String introNe,
    required String introEn,
    @Default('') String titleHi,
    @Default('') String introHi,
    @Default([]) List<SignProfilePoint> points,
  }) = _SignProfileTab;

  String titleFor(String languageCode) =>
      _pick(languageCode, ne: titleNe, hi: titleHi, en: titleEn);
  String introFor(String languageCode) =>
      _pick(languageCode, ne: introNe, hi: introHi, en: introEn);
}

/// Labelled sentence of a profile tab, e.g. `पैसा : …` / `Money : …`.
@freezed
abstract class SignProfilePoint with _$SignProfilePoint {
  const SignProfilePoint._();

  const factory SignProfilePoint({
    required String labelNe,
    required String labelEn,
    required String textNe,
    required String textEn,
    @Default('') String labelHi,
    @Default('') String textHi,
  }) = _SignProfilePoint;

  String labelFor(String languageCode) =>
      _pick(languageCode, ne: labelNe, hi: labelHi, en: labelEn);
  String textFor(String languageCode) =>
      _pick(languageCode, ne: textNe, hi: textHi, en: textEn);
}
