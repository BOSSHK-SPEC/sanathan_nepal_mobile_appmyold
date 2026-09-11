import 'package:get_it/get_it.dart';

import '../../core/region/region_resolver.dart';
import 'data/repositories/date_conversion_repository_impl.dart';
import 'domain/repositories/date_conversion_repository.dart';
import 'domain/usecases/convert_gregorian_to_traditional.dart';
import 'domain/usecases/convert_traditional_to_gregorian.dart';
import 'presentation/cubit/date_converter_cubit.dart';

/// Registers repositories, use cases and blocs for `date_converter`.
///
/// Depends on `CalendarEventsDataSource` registered by the calendar feature
/// (holiday flag of the converted day), on the `RegionResolver` from
/// `app_settings` (traditional calendar, default city, weekend day) and – at
/// widget level – on the events (`DayEventsCubit`) and panchanga
/// (`PanchangaCubit`) features for the sections under the result.
void registerDateConverterFeature(GetIt sl) {
  sl
    ..registerLazySingleton<DateConversionRepository>(
      () => DateConversionRepositoryImpl(sl<RegionResolver>(), sl()),
    )
    ..registerLazySingleton(() => ConvertTraditionalToGregorian(sl()))
    ..registerLazySingleton(() => ConvertGregorianToTraditional(sl()))
    ..registerFactory(
      () => DateConverterCubit(
        convertToGregorian: sl(),
        convertToTraditional: sl(),
        resolver: sl<RegionResolver>(),
      ),
    );
}
