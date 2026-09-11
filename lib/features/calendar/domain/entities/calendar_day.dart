import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/calendar/traditional_date.dart';
import 'calendar_event.dart';
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

    /// Approximate tithi/paksha for this day.
    required LunarDay lunarDay,
    @Default(<CalendarEvent>[]) List<CalendarEvent> events,
  }) = _CalendarDay;

  /// 0 = Sunday … 6 = Saturday.
  int get weekdayIndex => ad.weekday % 7;
  bool get hasHolidayEvent => events.any((e) => e.isHoliday);

  /// Weekend days and public holidays are rendered in the holiday colour.
  bool get isHoliday => isWeekend || hasHolidayEvent;
  bool get hasEvents => events.isNotEmpty;
}
