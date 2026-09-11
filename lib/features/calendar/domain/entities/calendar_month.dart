import 'package:freezed_annotation/freezed_annotation.dart';

import 'calendar_day.dart';
import 'calendar_event.dart';
import 'calendar_view_mode.dart';

part 'calendar_month.freezed.dart';

/// A 6×7 month grid in either calendar system.
@freezed
abstract class CalendarMonth with _$CalendarMonth {
  const CalendarMonth._();

  const factory CalendarMonth({
    /// Which system [year]/[month] refer to.
    required CalendarViewMode mode,
    required int year,
    required int month,

    /// Always 42 cells (6 rows × 7 columns) starting on Sunday.
    required List<CalendarDay> days,

    /// Events falling in this month (current-month cells only), sorted by day.
    required List<CalendarEvent> events,
  }) = _CalendarMonth;

  List<CalendarDay> get currentMonthDays =>
      days.where((d) => d.isCurrentMonth).toList(growable: false);

  CalendarDay? get today => days.cast<CalendarDay?>().firstWhere(
    (d) => d!.isToday,
    orElse: () => null,
  );
}
