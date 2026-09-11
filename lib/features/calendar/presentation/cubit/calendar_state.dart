part of 'calendar_cubit.dart';

/// UI state for the Patro month view.
@freezed
abstract class CalendarState with _$CalendarState {
  const CalendarState._();

  const factory CalendarState({
    /// Which calendar system [year]/[month] refer to.
    @Default(CalendarViewMode.traditional) CalendarViewMode viewMode,
    required int year,
    required int month,
    @Default(LoadState.idle()) LoadState<CalendarMonth> calendarMonth,
    CalendarDay? selectedDay,
  }) = _CalendarState;

  /// Cells of the loaded (or stale) month – empty until the first load.
  List<CalendarDay> get days => calendarMonth.dataOrNull?.days ?? const [];

  /// Events of the loaded (or stale) month.
  List<CalendarEvent> get events =>
      calendarMonth.dataOrNull?.events ?? const [];
}
