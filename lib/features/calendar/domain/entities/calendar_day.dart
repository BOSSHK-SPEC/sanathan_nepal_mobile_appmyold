import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/calendar/traditional_date.dart';
import 'calendar_event.dart';
import 'day_panchanga.dart';
import 'lunar_day.dart';

part 'calendar_day.freezed.dart';

/// One cell of the month grid – carries both calendar systems (Gregorian and
/// the region's traditional calendar) so the UI can flip between primary
/// renderings without recomputing.
@freezed
abstract class CalendarDay with _$CalendarDay {
  const CalendarDay._();

  const factory CalendarDay({
    /// Date in the region's traditional calendar (BS / Saka).
    required TraditionalDate traditional,
    required DateTime ad,

    /// False for the leading/trailing filler days of adjacent months.
    required bool isCurrentMonth,
    required bool isToday,

    /// Weekly rest day of the region (Saturday in Nepal, Sunday in India) –
    /// decided by `RegionConfig.weekendWeekdays`.
    required bool isWeekend,

    /// Mean-motion tithi/paksha estimate. Kept for callers that have nothing
    /// better; anything shown to a reader should prefer [panchanga].
    required LunarDay lunarDay,
    @Default(<CalendarEvent>[]) List<CalendarEvent> events,

    /// The day's panchanga — the server's ephemeris calculation, or an
    /// estimate marked `isApproximate`. `null` only when it could not be
    /// loaded at all.
    DayPanchanga? panchanga,
  }) = _CalendarDay;

  /// The panchanga only when it is the server's calculation. Markers and
  /// chips that carry no "approximate" label use this, so an estimate is
  /// never presented as fact.
  DayPanchanga? get exactPanchanga =>
      panchanga?.isApproximate == false ? panchanga : null;

  /// 0 = Sunday … 6 = Saturday.
  int get weekdayIndex => ad.weekday % 7;
  bool get hasHolidayEvent => events.any((e) => e.isHoliday);

  /// Weekend days and public holidays are rendered in the holiday colour.
  bool get isHoliday => isWeekend || hasHolidayEvent;
  bool get hasEvents => events.isNotEmpty;
}
