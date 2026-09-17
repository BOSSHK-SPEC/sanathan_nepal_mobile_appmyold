import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/panchanga_days_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/regional_calendar_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/models/day_panchanga_model.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/data/repositories/date_conversion_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/date_converter/domain/entities/date_parts.dart';

import '../calendar/day_panchanga_test.dart' show kathmanduSummary;

class _Server implements PanchangaDaysDataSource {
  @override
  Future<List<DayPanchangaModel>> fetchRange({
    required DateTime from,
    required DateTime to,
  }) async => [DayPanchangaModel.fromWire(kathmanduSummary())!];
}

class _Offline implements PanchangaDaysDataSource {
  @override
  Future<List<DayPanchangaModel>> fetchRange({
    required DateTime from,
    required DateTime to,
  }) => Future.error(StateError('offline'));
}

/// The converter's result card showed sunrise and sunset from the on-device
/// estimate, a few minutes out. These pin that it uses the server's
/// calculation and marks the estimate when that is all there is.
void main() {
  const resolver = FixedRegionResolver(Region.nepal);
  final events = RegionalCalendarEventsDataSource(resolver);
  const date = DateParts(year: 2026, month: 9, day: 14);

  test('uses the server calculation for the converted day', () async {
    final repo = DateConversionRepositoryImpl(
      resolver,
      events,
      panchanga: _Server(),
      now: () => DateTime(2026, 9, 14),
    );
    final result = (await repo.gregorianToTraditional(date)).valueOrNull!;
    expect(result.panchanga.isApproximate, isFalse);
    expect(result.panchanga.sunrise, DateTime(2026, 9, 14, 5, 48, 22));
    expect(result.panchanga.nakshatraEn, 'Chitra');
    expect(result.panchanga.lunarDay.tithiIndex, 3);
  });

  test('falls back to the estimate, marked approximate, when offline', () async {
    final repo = DateConversionRepositoryImpl(
      resolver,
      events,
      panchanga: _Offline(),
      now: () => DateTime(2026, 9, 14),
    );
    final result = (await repo.gregorianToTraditional(date)).valueOrNull!;
    expect(result.panchanga.isApproximate, isTrue);
  });
}
