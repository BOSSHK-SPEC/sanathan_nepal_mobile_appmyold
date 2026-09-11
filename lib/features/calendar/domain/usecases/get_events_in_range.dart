import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/calendar_event.dart';
import '../repositories/calendar_repository.dart';

part 'get_events_in_range.freezed.dart';

/// Parameters for [GetEventsInRange] – an inclusive Gregorian date range.
@freezed
abstract class DateRangeParams with _$DateRangeParams {
  const factory DateRangeParams({
    required DateTime from,
    required DateTime to,
  }) = _DateRangeParams;
}

/// Lists festivals/holidays of the active region between two dates.
class GetEventsInRange
    implements UseCase<List<CalendarEvent>, DateRangeParams> {
  const GetEventsInRange(this._repo);
  final CalendarRepository _repo;

  @override
  Future<Result<List<CalendarEvent>>> call(DateRangeParams params) =>
      _repo.getEvents(from: params.from, to: params.to);
}
