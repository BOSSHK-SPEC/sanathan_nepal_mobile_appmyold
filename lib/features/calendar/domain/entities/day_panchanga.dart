import 'package:freezed_annotation/freezed_annotation.dart';

import 'lunar_day.dart';

part 'day_panchanga.freezed.dart';

/// Vrat days, judged by the tithi prevailing at sunrise.
enum VratKind {
  ekadashi,
  purnima,
  amavasya;

  static VratKind? fromName(String? name) =>
      values.where((v) => v.name == name).firstOrNull;
}

/// A panchanga name in the app's three languages.
@freezed
abstract class PanchangaText with _$PanchangaText {
  const PanchangaText._();

  const factory PanchangaText({
    required String en,
    required String ne,
    @Default('') String hi,
  }) = _PanchangaText;

  /// Hindi falls back to the Devanagari (Nepali) spelling, never to English.
  String resolve(String languageCode) => switch (languageCode) {
    'ne' => ne,
    'hi' => hi.isEmpty ? ne : hi,
    _ => en,
  };
}

/// One day's panchanga as the month grid and the day popup need it.
///
/// From the server's ephemeris calculation, or — when a month has never been
/// fetched and the device is offline — the on-device estimate, which says so
/// through [isApproximate] so the screen can label it.
@freezed
abstract class DayPanchanga with _$DayPanchanga {
  const DayPanchanga._();

  const factory DayPanchanga({
    required DateTime date,

    /// 0–29: 0–14 Shukla (14 = Purnima), 15–29 Krishna (29 = Amavasya).
    required int tithiIndex,
    required PanchangaText tithi,
    required Paksha paksha,

    /// When the sunrise tithi gives way to the next; unknown for an estimate.
    DateTime? tithiEndsAt,
    required PanchangaText nakshatra,
    required PanchangaText yoga,
    required PanchangaText karana,
    required PanchangaText moonRashi,

    /// Purnimanta lunar month — the naming festival tithis use.
    required PanchangaText lunarMonth,
    @Default(false) bool isAdhikaMonth,
    @Default(<VratKind>[]) List<VratKind> vrat,
    required DateTime sunrise,
    required DateTime sunset,
    @Default(false) bool isApproximate,
  }) = _DayPanchanga;

  bool get isVrat => vrat.isNotEmpty;

  PanchangaText get pakshaName => paksha == Paksha.shukla
      ? const PanchangaText(en: 'Shukla', ne: 'शुक्ल')
      : const PanchangaText(en: 'Krishna', ne: 'कृष्ण');
}
