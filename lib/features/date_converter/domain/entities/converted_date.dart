import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../calendar/domain/entities/calendar_event.dart';
import '../../../calendar/domain/entities/panchanga_info.dart';
import 'conversion_direction.dart';

part 'converted_date.freezed.dart';

/// Result of a traditional ⇄ Gregorian conversion plus the day's decoration
/// data.
@freezed
abstract class ConvertedDate with _$ConvertedDate {
  const ConvertedDate._();

  const factory ConvertedDate({
    required ConversionDirection direction,

    /// Date in the region's traditional calendar (BS / Saka).
    required TraditionalDate traditional,
    required DateTime ad,
    required PanchangaInfo panchanga,

    /// Reference "today" (AD, date only) used for the difference / age section.
    required DateTime today,

    /// Region weekend day (Saturday in Nepal, Sunday in India).
    required bool isWeekend,
    @Default(<CalendarEvent>[]) List<CalendarEvent> events,
  }) = _ConvertedDate;

  /// 0 = Sunday … 6 = Saturday.
  int get weekdayIndex => ad.weekday % 7;
  bool get isHoliday => isWeekend || events.any((e) => e.isHoliday);
  bool get isToday =>
      ad.year == today.year && ad.month == today.month && ad.day == today.day;

  /// Signed day difference from today (negative = past).
  int get daysFromToday => DateTime(
    ad.year,
    ad.month,
    ad.day,
  ).difference(DateTime(today.year, today.month, today.day)).inDays;

  /// Shaka (Saka) year of [ad] – exact per the Indian national calendar.
  int get shakaSamvat => const SakaCalendar().fromGregorian(ad).year;

  /// Vikram Samvat year (North-Indian reckoning, ≈ Shaka + 135).
  int get vikramSamvat => VikramSamvat.yearFor(ad);

  /// Nepal Sambat ≈ Bikram Sambat − 936 (as in the Figma) – Nepal only.
  int get nepalSambat =>
      const BikramSambatCalendar().fromGregorian(ad).year - 936;

  /// Age (or countdown) as whole years / months / days between [ad] and today.
  ({int years, int months, int days}) get ageBreakdown {
    var from = DateTime(ad.year, ad.month, ad.day);
    var to = DateTime(today.year, today.month, today.day);
    if (from.isAfter(to)) {
      final t = from;
      from = to;
      to = t;
    }
    var years = to.year - from.year;
    var months = to.month - from.month;
    var days = to.day - from.day;
    if (days < 0) {
      months--;
      days += DateTime(to.year, to.month, 0).day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }
    return (years: years, months: months, days: days);
  }
}
