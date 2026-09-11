import '../../../../core/calendar/calendar.dart';
import '../entities/calendar_view_mode.dart';

/// Inclusive year range a month grid / picker may navigate for [calendar]
/// in the given [mode].
///
/// Traditional mode = the calendar's own supported range; Gregorian mode =
/// the Gregorian years fully covered by that range (one year trimmed at
/// each end so every day of a shown Gregorian year converts).
({int min, int max}) supportedYears(
  TraditionalCalendar calendar,
  CalendarViewMode mode,
) {
  if (mode == CalendarViewMode.traditional) {
    return (min: calendar.minYear, max: calendar.maxYear);
  }
  final first = calendar.toGregorian(TraditionalDate(calendar.minYear, 1, 1));
  final last = calendar.toGregorian(TraditionalDate(calendar.maxYear, 1, 1));
  return (min: first.year + 1, max: last.year - 1);
}

/// Whether [year] can be shown for [calendar] in [mode].
bool isYearSupported(
  TraditionalCalendar calendar,
  CalendarViewMode mode,
  int year,
) {
  final range = supportedYears(calendar, mode);
  return year >= range.min && year <= range.max;
}
