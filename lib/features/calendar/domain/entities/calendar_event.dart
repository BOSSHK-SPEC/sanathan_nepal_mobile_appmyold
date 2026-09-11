import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';

/// A festival / holiday / user event pinned to a Gregorian date.
///
/// Titles are trilingual; Hindi falls back to the Nepali (Devanagari) text
/// when no dedicated Hindi title exists.
@freezed
abstract class CalendarEvent with _$CalendarEvent {
  const CalendarEvent._();

  const factory CalendarEvent({
    required String id,

    /// Gregorian date (date-only, local).
    required DateTime date,
    required String titleNe,
    required String titleEn,
    @Default('') String titleHi,
    @Default('') String descriptionNe,
    @Default('') String descriptionEn,
    @Default('') String descriptionHi,

    /// Lunar day name shown as a chip on the event card (e.g. "पूर्णिमा").
    @Default('') String tithiNe,
    @Default('') String tithiEn,

    /// Public holiday → rendered in `AppColors.holiday`.
    @Default(false) bool isHoliday,
    String? imageUrl,
  }) = _CalendarEvent;

  String title({required String languageCode}) => switch (languageCode) {
    'ne' => titleNe,
    'hi' => titleHi.isNotEmpty ? titleHi : titleNe,
    _ => titleEn,
  };

  String description({required String languageCode}) => switch (languageCode) {
    'ne' => descriptionNe,
    'hi' => descriptionHi.isNotEmpty ? descriptionHi : descriptionNe,
    _ => descriptionEn,
  };

  /// Tithi label – Devanagari for Nepali / Hindi.
  String tithi({required String languageCode}) =>
      languageCode == 'ne' || languageCode == 'hi' ? tithiNe : tithiEn;

  bool isOn(DateTime day) =>
      date.year == day.year && date.month == day.month && date.day == day.day;
}
