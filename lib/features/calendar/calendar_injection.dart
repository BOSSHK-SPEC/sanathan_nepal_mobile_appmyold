import 'package:get_it/get_it.dart';

import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import '../../core/region/region_resolver.dart';
import '../../core/storage/bounded_json_cache.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/api_calendar_events_data_source.dart';
import 'data/datasources/api_panchanga_days_data_source.dart';
import 'data/datasources/approximate_panchanga_days_data_source.dart';
import 'data/datasources/calendar_events_data_source.dart';
import 'data/datasources/panchanga_days_data_source.dart';
import 'data/datasources/regional_calendar_events_data_source.dart';
import 'data/repositories/calendar_repository_impl.dart';
import 'domain/entities/calendar_view_mode.dart';
import 'domain/repositories/calendar_repository.dart';
import 'domain/usecases/get_calendar_month.dart';
import 'domain/usecases/get_events_in_range.dart';
import 'presentation/cubit/calendar_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `calendar`.
///
/// Requires a [RegionResolver] (registered by `app_settings`) – it selects
/// the traditional calendar, the weekend day and the festival dataset.
void registerCalendarFeature(GetIt sl) {
  sl
    ..registerLazySingleton<CalendarEventsDataSource>(
      () => selectDataSource(
        mock: () => RegionalCalendarEventsDataSource(sl<RegionResolver>()),
        live: () => ApiCalendarEventsDataSource(sl<ApiClient>()),
      ),
    )
    // Per-day panchanga for the grid and the day popup: the server's
    // ephemeris calculation, cached per month for offline use, with the
    // labelled on-device estimate only for a month never fetched.
    ..registerLazySingleton<PanchangaDaysDataSource>(
      () => selectDataSource(
        mock: () => ApproximatePanchangaDaysDataSource(sl<RegionResolver>()),
        live: () => ApiPanchangaDaysDataSource(
          client: sl<ApiClient>(),
          cache: BoundedJsonCache(
            sl<KeyValueStore>(),
            namespace: 'panchanga.range.v1',
            maxEntries: 36,
          ),
          resolver: sl<RegionResolver>(),
          fallback: ApproximatePanchangaDaysDataSource(sl<RegionResolver>()),
        ),
      ),
    )
    ..registerLazySingleton<CalendarRepository>(
      () => CalendarRepositoryImpl(
        sl(),
        sl<RegionResolver>(),
        panchanga: sl<PanchangaDaysDataSource>(),
      ),
    )
    ..registerLazySingleton(() => GetCalendarMonth(sl()))
    ..registerLazySingleton(() => GetEventsInRange(sl()))
    // `param1` (optional) = initial CalendarViewMode; null → region default
    // (Nepal: traditional / B.S., India: Gregorian).
    ..registerFactoryParam<CalendarCubit, CalendarViewMode?, void>(
      (mode, _) => CalendarCubit(
        getMonth: sl(),
        resolver: sl<RegionResolver>(),
        initialMode: mode,
      ),
    );
}
