import '../../app/di/injection.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_puja_data_source.dart';
import 'package:get_it/get_it.dart';

import '../../core/region/region_resolver.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/mock_puja_data_source.dart';
import 'data/datasources/puja_data_source.dart';
import 'data/repositories/puja_repository_impl.dart';
import 'domain/repositories/puja_repository.dart';
import 'domain/usecases/puja_usecases.dart';
import 'presentation/cubit/book_puja_cubit.dart';
import 'presentation/cubit/my_pujas_cubit.dart';
import 'presentation/cubit/puja_booking_cubit.dart';
import 'presentation/cubit/puja_catalogue_cubit.dart';

/// Registers online puja booking.
void registerPujaFeature(GetIt sl) {
  sl
    ..registerLazySingleton<PujaDataSource>(
      () => selectDataSource(
        mock: () =>
            MockPujaDataSource(sl<KeyValueStore>(), sl<RegionResolver>()),
        live: () =>
            ApiPujaDataSource(sl<ApiClient>(), () => activeLanguageCode(sl)),
      ),
    )
    ..registerLazySingleton<PujaRepository>(() => PujaRepositoryImpl(sl()))
    ..registerLazySingleton(() => GetPujaCatalogue(sl()))
    ..registerLazySingleton(() => GetPujaService(sl()))
    ..registerLazySingleton(() => GetPujaTimes(sl()))
    ..registerLazySingleton(() => BookPuja(sl()))
    ..registerLazySingleton(() => GetMyPujas(sl()))
    ..registerLazySingleton(() => GetPujaBooking(sl()))
    ..registerLazySingleton(() => CancelPuja(sl()))
    ..registerFactory(() => PujaCatalogueCubit(getCatalogue: sl()))
    ..registerFactory(() => MyPujasCubit(getMyPujas: sl(), cancel: sl()))
    ..registerFactoryParam<BookPujaCubit, String, void>(
      (serviceId, _) => BookPujaCubit(
        serviceId: serviceId,
        getService: sl(),
        getTimes: sl(),
        bookPuja: sl(),
      ),
    )
    ..registerFactoryParam<PujaBookingCubit, String, void>(
      (bookingId, _) => PujaBookingCubit(
        bookingId: bookingId,
        getBooking: sl(),
        cancel: sl(),
      ),
    );
}
