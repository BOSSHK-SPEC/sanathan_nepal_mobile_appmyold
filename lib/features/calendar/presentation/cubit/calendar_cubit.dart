import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/entities/calendar_month.dart';
import '../../domain/entities/calendar_view_mode.dart';
import '../../domain/services/calendar_year_range.dart';
import '../../domain/usecases/get_calendar_month.dart';
import '../../../../core/state/app_cubit.dart';

part 'calendar_cubit.freezed.dart';
part 'calendar_state.dart';

/// Drives the month grid: navigation, traditional/Gregorian toggle and day
/// selection. The traditional calendar and the default view mode come from
/// the active region (`RegionResolver`).
class CalendarCubit extends AppCubit<CalendarState> {
  CalendarCubit({
    required GetCalendarMonth getMonth,
    required RegionResolver resolver,
    DateTime Function()? now,
    CalendarViewMode? initialMode,
  }) : _getMonth = getMonth,
       _resolver = resolver,
       _now = now ?? DateTime.now,
       super(
         _initialState(
           now ?? DateTime.now,
           resolver.config.calendar,
           initialMode ?? resolver.config.defaultCalendarViewMode,
         ),
       );

  final GetCalendarMonth _getMonth;
  final RegionResolver _resolver;
  final DateTime Function() _now;

  TraditionalCalendar get _calendar => _resolver.config.calendar;

  static CalendarState _initialState(
    DateTime Function() now,
    TraditionalCalendar calendar,
    CalendarViewMode mode,
  ) {
    final ym = _yearMonthOf(now(), calendar, mode);
    return CalendarState(year: ym.year, month: ym.month, viewMode: mode);
  }

  /// Year/month of [date] in the given [mode].
  static ({int year, int month}) _yearMonthOf(
    DateTime date,
    TraditionalCalendar calendar,
    CalendarViewMode mode,
  ) {
    if (mode == CalendarViewMode.gregorian) {
      return (year: date.year, month: date.month);
    }
    final t = calendar.fromGregorian(date);
    return (year: t.year, month: t.month);
  }

  /// Loads the month currently referenced by the state.
  Future<void> load() => _loadMonth(state.year, state.month, state.viewMode);

  Future<void> nextMonth() {
    var y = state.year;
    var m = state.month + 1;
    if (m > 12) {
      m = 1;
      y++;
    }
    return _loadMonth(y, m, state.viewMode);
  }

  Future<void> previousMonth() {
    var y = state.year;
    var m = state.month - 1;
    if (m < 1) {
      m = 12;
      y--;
    }
    return _loadMonth(y, m, state.viewMode);
  }

  /// Jumps back to the month containing today (in the active view mode).
  Future<void> goToToday() => jumpToDate(_now());

  /// Jumps to an arbitrary [year]/[month] in the active view mode.
  Future<void> jumpTo({required int year, required int month}) =>
      _loadMonth(year, month, state.viewMode);

  /// Jumps to the month containing the Gregorian [date] in the active view
  /// mode.
  Future<void> jumpToDate(DateTime date) {
    final ym = _yearMonthOf(date, _calendar, state.viewMode);
    return _loadMonth(ym.year, ym.month, state.viewMode);
  }

  /// Switches between the traditional and Gregorian calendars keeping the
  /// same anchor date.
  Future<void> setViewMode(CalendarViewMode mode) {
    if (mode == state.viewMode) return Future.value();
    final ym = _yearMonthOf(_anchorDate(), _calendar, mode);
    return _loadMonth(ym.year, ym.month, mode);
  }

  void selectDay(CalendarDay day) => emit(state.copyWith(selectedDay: day));

  void clearSelection() => emit(state.copyWith(selectedDay: null));

  /// A representative date of the current month – today if visible, else the
  /// first day of the month.
  DateTime _anchorDate() {
    final month = state.calendarMonth.dataOrNull;
    final today = month?.today;
    if (today != null) return today.ad;
    final first = month?.currentMonthDays.firstOrNull;
    if (first != null) return first.ad;
    return state.viewMode == CalendarViewMode.gregorian
        ? DateTime(state.year, state.month)
        : _calendar.toGregorian(TraditionalDate(state.year, state.month, 1));
  }

  Future<void> _loadMonth(int year, int month, CalendarViewMode mode) async {
    if (!isYearSupported(_calendar, mode, year)) return;
    emit(
      state.copyWith(
        calendarMonth: state.calendarMonth.toLoading(),
        year: year,
        month: month,
        viewMode: mode,
        selectedDay: null,
      ),
    );
    final result = await _getMonth(
      CalendarMonthParams(year: year, month: month, mode: mode),
    );
    if (isClosed) return;
    emit(
      state.copyWith(
        calendarMonth: result.fold(
          state.calendarMonth.toFailed,
          LoadState.loaded,
        ),
      ),
    );
  }
}
