import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/calendar/calendar.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/state/load_state.dart';
import '../../../calendar/domain/entities/calendar_view_mode.dart';
import '../../../calendar/domain/services/calendar_year_range.dart';
import '../../domain/entities/conversion_direction.dart';
import '../../domain/entities/converted_date.dart';
import '../../domain/entities/date_parts.dart';
import '../../domain/usecases/convert_gregorian_to_traditional.dart';
import '../../domain/usecases/convert_traditional_to_gregorian.dart';
import '../../../../core/state/app_cubit.dart';

part 'date_converter_cubit.freezed.dart';
part 'date_converter_state.dart';

/// Holds picker values and runs the conversion use cases. The traditional
/// calendar (month lengths, year range, today's date) comes from the active
/// region.
class DateConverterCubit extends AppCubit<DateConverterState> {
  DateConverterCubit({
    required ConvertTraditionalToGregorian convertToGregorian,
    required ConvertGregorianToTraditional convertToTraditional,
    required RegionResolver resolver,
    DateTime Function()? now,
  }) : _toGregorian = convertToGregorian,
       _toTraditional = convertToTraditional,
       _resolver = resolver,
       _now = now ?? DateTime.now,
       super(
         DateConverterState(
           input: _todayParts(
             ConversionDirection.traditionalToGregorian,
             now ?? DateTime.now,
             resolver.config.calendar,
           ),
         ),
       );

  final ConvertTraditionalToGregorian _toGregorian;
  final ConvertGregorianToTraditional _toTraditional;
  final RegionResolver _resolver;
  final DateTime Function() _now;

  TraditionalCalendar get calendar => _resolver.config.calendar;

  /// Picker year range for the current input calendar.
  int get minYear => _range.min;
  int get maxYear => _range.max;
  ({int min, int max}) get _range => supportedYears(
    calendar,
    state.isTraditionalInput
        ? CalendarViewMode.traditional
        : CalendarViewMode.gregorian,
  );

  static DateParts _todayParts(
    ConversionDirection direction,
    DateTime Function() now,
    TraditionalCalendar calendar,
  ) {
    final today = now();
    if (direction == ConversionDirection.gregorianToTraditional) {
      return DateParts(year: today.year, month: today.month, day: today.day);
    }
    final t = calendar.fromGregorian(today);
    return DateParts(year: t.year, month: t.month, day: t.day);
  }

  /// Days in the currently selected input month.
  int daysInMonth(DateParts p) => state.isTraditionalInput
      ? calendar.daysInMonth(p.year, p.month)
      : DateTime(p.year, p.month + 1, 0).day;

  /// Switches which calendar is being converted from, resets the pickers to
  /// today in that calendar and converts straight away.
  ///
  /// Converting here is what keeps the screen whole. Every card below the
  /// picker — the result, the difference, the converted day's events, suva
  /// sait and panchanga, and the ads slot — is rendered only when a result
  /// exists. This used to emit a brand-new state, which dropped the result
  /// along with the direction, so tapping the other radio blanked the bottom
  /// half of the screen until Convert was pressed again.
  ///
  /// The previous result stays on screen while the new one is computed
  /// (`convert` moves it to `loading` carrying the old value), so the section
  /// never collapses and reflows for a frame.
  Future<void> setDirection(ConversionDirection direction) async {
    if (direction == state.direction) return;
    emit(
      state.copyWith(
        direction: direction,
        input: _todayParts(direction, _now, calendar),
      ),
    );
    await convert();
  }

  void setYear(int year) => _setInput(state.input.copyWith(year: year));
  void setMonth(int month) => _setInput(state.input.copyWith(month: month));
  void setDay(int day) => _setInput(state.input.copyWith(day: day));

  void _setInput(DateParts next) {
    final max = daysInMonth(next);
    final clamped = next.day > max ? next.copyWith(day: max) : next;
    emit(state.copyWith(input: clamped));
  }

  /// Resets pickers to today and clears the result ("रद्द गर्नुहोस्").
  void reset() => emit(
    DateConverterState(
      direction: state.direction,
      input: _todayParts(state.direction, _now, calendar),
    ),
  );

  /// Runs the conversion for the current input ("परिवर्तन गर्नुहोस्").
  Future<void> convert() async {
    emit(state.copyWith(result: state.result.toLoading()));
    final result = state.isTraditionalInput
        ? await _toGregorian(state.input)
        : await _toTraditional(state.input);
    if (isClosed) return;
    emit(
      state.copyWith(
        result: result.fold(state.result.toFailed, LoadState.loaded),
      ),
    );
  }
}
