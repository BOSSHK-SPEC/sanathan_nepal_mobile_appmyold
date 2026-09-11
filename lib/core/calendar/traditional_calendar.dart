import 'traditional_date.dart';

/// Contract for a region's traditional (non-Gregorian) calendar system.
///
/// Implementations must be pure & deterministic; the UI decides which one is
/// active through `RegionConfig.calendar`.
abstract interface class TraditionalCalendar {
  /// Stable identifier (`bs`, `saka`).
  String get id;

  /// Era label shown next to years, e.g. "वि.सं." / "B.S." or "शक" / "Saka".
  String eraLabel({required String languageCode});

  /// Calendar name shown in pickers/headers ("Bikram Sambat" / "Indian
  /// National Calendar").
  String displayName({required String languageCode});

  TraditionalDate fromGregorian(DateTime date);
  DateTime toGregorian(TraditionalDate date);

  int daysInMonth(int year, int month);

  /// Inclusive supported year range.
  int get minYear;
  int get maxYear;

  /// 12 month names for the given language code (`en`, `ne`, `hi`).
  List<String> monthNames({required String languageCode});

  String monthName(int month, {required String languageCode}) =>
      monthNames(languageCode: languageCode)[month - 1];

  /// Weekday indexes (0 = Sunday … 6 = Saturday) treated as weekend/holiday
  /// in this calendar's region – Nepal: Saturday, India: Sunday.
  List<int> get weekendWeekdays;

  /// Whether digits should be rendered in Devanagari for [languageCode].
  static bool devanagariDigits(String languageCode) =>
      languageCode == 'ne' || languageCode == 'hi';
}
