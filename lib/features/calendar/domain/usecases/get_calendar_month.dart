import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/calendar_month.dart';
import '../entities/calendar_view_mode.dart';
import '../repositories/calendar_repository.dart';

part 'get_calendar_month.freezed.dart';

/// Parameters for [GetCalendarMonth].
@freezed
abstract class CalendarMonthParams with _$CalendarMonthParams {
  const factory CalendarMonthParams({
    required int year,
    required int month,
    @Default(CalendarViewMode.traditional) CalendarViewMode mode,
  }) = _CalendarMonthParams;
}

/// Loads a fully-populated month grid (days + events + tithi).
class GetCalendarMonth implements UseCase<CalendarMonth, CalendarMonthParams> {
  const GetCalendarMonth(this._repo);
  final CalendarRepository _repo;

  @override
  Future<Result<CalendarMonth>> call(CalendarMonthParams params) =>
      _repo.getMonth(year: params.year, month: params.month, mode: params.mode);
}
