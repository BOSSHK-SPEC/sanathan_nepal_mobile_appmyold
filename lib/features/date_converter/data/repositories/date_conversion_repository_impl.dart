import '../../../../core/calendar/calendar.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../../calendar/data/datasources/calendar_events_data_source.dart';
import '../../../calendar/domain/entities/calendar_view_mode.dart';
import '../../../calendar/domain/services/calendar_year_range.dart';
import '../../../calendar/domain/services/panchanga_approximator.dart';
import '../../domain/entities/conversion_direction.dart';
import '../../domain/entities/converted_date.dart';
import '../../domain/entities/date_parts.dart';
import '../../domain/repositories/date_conversion_repository.dart';

/// Validates input, converts with the active region's
/// `TraditionalCalendar` (`RegionResolver.config.calendar`) and decorates the
/// result with Panchanga (region default city) + events.
class DateConversionRepositoryImpl implements DateConversionRepository {
  DateConversionRepositoryImpl(
    this._resolver,
    this._events, {
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final RegionResolver _resolver;
  final CalendarEventsDataSource _events;
  final DateTime Function() _now;

  @override
  Future<Result<ConvertedDate>> traditionalToGregorian(DateParts t) {
    final calendar = _resolver.config.calendar;
    final range = supportedYears(calendar, CalendarViewMode.traditional);
    if (t.year < range.min || t.year > range.max) {
      return Future.value(
        Result.failure(
          ValidationFailure(
            '${calendar.eraLabel(languageCode: 'en')} year must be between '
            '${range.min} and ${range.max}',
          ),
        ),
      );
    }
    if (t.month < 1 || t.month > 12) {
      return Future.value(
        const Result.failure(ValidationFailure('Invalid month')),
      );
    }
    final maxDay = calendar.daysInMonth(t.year, t.month);
    if (t.day < 1 || t.day > maxDay) {
      return Future.value(
        Result.failure(ValidationFailure('Day must be 1–$maxDay')),
      );
    }
    return guard(() async {
      final traditional = TraditionalDate(t.year, t.month, t.day);
      final ad = calendar.toGregorian(traditional);
      return _build(
        ConversionDirection.traditionalToGregorian,
        traditional,
        ad,
      );
    });
  }

  @override
  Future<Result<ConvertedDate>> gregorianToTraditional(DateParts g) {
    final calendar = _resolver.config.calendar;
    if (g.month < 1 || g.month > 12) {
      return Future.value(
        const Result.failure(ValidationFailure('Invalid month')),
      );
    }
    final maxDay = DateTime(g.year, g.month + 1, 0).day;
    if (g.day < 1 || g.day > maxDay) {
      return Future.value(
        Result.failure(ValidationFailure('Day must be 1–$maxDay')),
      );
    }
    if (!isYearSupported(calendar, CalendarViewMode.gregorian, g.year)) {
      return Future.value(
        const Result.failure(
          ValidationFailure('Date outside the supported range'),
        ),
      );
    }
    return guard(() async {
      final date = DateTime(g.year, g.month, g.day);
      final traditional = calendar.fromGregorian(date);
      return _build(
        ConversionDirection.gregorianToTraditional,
        traditional,
        date,
      );
    });
  }

  Future<ConvertedDate> _build(
    ConversionDirection direction,
    TraditionalDate traditional,
    DateTime ad,
  ) async {
    final config = _resolver.config;
    final date = DateTime(ad.year, ad.month, ad.day);
    final events = (await _events.fetchEvents(
      from: date,
      to: date,
    )).map((m) => m.toEntity()).toList(growable: false);
    final today = _now();
    return ConvertedDate(
      direction: direction,
      traditional: traditional,
      ad: date,
      panchanga: PanchangaApproximator.forRegion(date, config),
      events: events,
      today: DateTime(today.year, today.month, today.day),
      isWeekend: config.weekendWeekdays.contains(date.weekday % 7),
    );
  }
}
