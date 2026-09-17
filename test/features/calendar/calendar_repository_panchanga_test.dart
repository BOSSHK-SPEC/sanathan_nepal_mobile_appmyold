import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/approximate_panchanga_days_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/panchanga_days_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/regional_calendar_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/models/day_panchanga_model.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/domain/entities/calendar_view_mode.dart';

import 'day_panchanga_test.dart' show kathmanduSummary;

/// A server day for every date asked for.
class _ServerDays implements PanchangaDaysDataSource {
  int calls = 0;

  @override
  Future<List<DayPanchangaModel>> fetchRange({
    required DateTime from,
    required DateTime to,
  }) async {
    calls++;
    return [
      for (
        var d = from;
        !d.isAfter(to);
        d = DateTime(d.year, d.month, d.day + 1)
      )
        DayPanchangaModel.fromWire(
          kathmanduSummary(
            date:
                '${d.year}-${d.month.toString().padLeft(2, '0')}-'
                '${d.day.toString().padLeft(2, '0')}',
          ),
        )!,
    ];
  }
}

class _Unreachable implements PanchangaDaysDataSource {
  @override
  Future<List<DayPanchangaModel>> fetchRange({
    required DateTime from,
    required DateTime to,
  }) => Future.error(StateError('offline'));
}

void main() {
  const resolver = FixedRegionResolver(Region.nepal);
  final events = RegionalCalendarEventsDataSource(resolver);

  CalendarRepositoryImpl repo(PanchangaDaysDataSource? panchanga) =>
      CalendarRepositoryImpl(
        events,
        resolver,
        panchanga: panchanga,
        now: () => DateTime(2026, 9, 14),
      );

  Future<List<dynamic>> days(CalendarRepositoryImpl r) async {
    final result = await r.getMonth(
      year: 2026,
      month: 9,
      mode: CalendarViewMode.gregorian,
    );
    return result.valueOrNull!.days;
  }

  test('attaches each day its own server panchanga, in one request', () async {
    final source = _ServerDays();
    final grid = await days(repo(source));
    expect(source.calls, 1);
    expect(grid, hasLength(42));
    for (final day in grid) {
      expect(day.panchanga?.date, day.ad);
      expect(day.exactPanchanga, isNotNull);
    }
  });

  test('still loads the month when panchanga cannot be reached', () async {
    final grid = await days(repo(_Unreachable()));
    expect(grid, hasLength(42));
    expect(grid.every((d) => d.panchanga == null), isTrue);
  });

  test('never treats the estimate as exact', () async {
    final grid = await days(
      repo(const ApproximatePanchangaDaysDataSource(resolver)),
    );
    expect(grid.every((d) => d.panchanga != null), isTrue);
    expect(grid.every((d) => d.exactPanchanga == null), isTrue);
  });

  test('works without a panchanga source at all', () async {
    final grid = await days(repo(null));
    expect(grid.every((d) => d.panchanga == null), isTrue);
  });
}
