import 'package:get_it/get_it.dart';

import '../../app/di/injection.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import '../../core/region/region_resolver.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/account_data_source.dart';
import 'data/datasources/api_account_data_source.dart';
import 'data/datasources/mock_account_data_source.dart';
import 'data/repositories/account_repository_impl.dart';
import 'domain/repositories/account_repository.dart';
import 'domain/usecases/account_usecases.dart';
import 'presentation/cubit/account_cubits.dart';

/// Registers addresses, security, privacy, support, offers and referrals.
void registerAccountFeature(GetIt sl) {
  sl
    ..registerLazySingleton<AccountDataSource>(
      () => selectDataSource(
        mock: () =>
            MockAccountDataSource(sl<KeyValueStore>(), sl<RegionResolver>()),
        live: () =>
            ApiAccountDataSource(sl<ApiClient>(), () => activeLanguageCode(sl)),
      ),
    )
    ..registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetAddresses(sl()))
    ..registerLazySingleton(() => SaveAddress(sl()))
    ..registerLazySingleton(() => DeleteAddress(sl()))
    ..registerLazySingleton(() => SetDefaultAddress(sl()))
    ..registerLazySingleton(() => GetSecuritySettings(sl()))
    ..registerLazySingleton(() => UpdateSecuritySettings(sl()))
    ..registerLazySingleton(() => GetDevices(sl()))
    ..registerLazySingleton(() => RevokeDevice(sl()))
    ..registerLazySingleton(() => RevokeAllOtherDevices(sl()))
    ..registerLazySingleton(() => GetDataRequests(sl()))
    ..registerLazySingleton(() => RequestData(sl()))
    ..registerLazySingleton(() => GetTickets(sl()))
    ..registerLazySingleton(() => GetTicket(sl()))
    ..registerLazySingleton(() => CreateTicket(sl()))
    ..registerLazySingleton(() => ReplyToTicket(sl()))
    ..registerLazySingleton(() => GetOffers(sl()))
    ..registerLazySingleton(() => GetReferral(sl()))
    ..registerFactory(
      () => AddressesCubit(
        getAddresses: sl(),
        saveAddress: sl(),
        deleteAddress: sl(),
        setDefault: sl(),
      ),
    )
    ..registerFactory(
      () => SecurityCubit(
        getSettings: sl(),
        updateSettings: sl(),
        getDevices: sl(),
        revokeDevice: sl(),
        revokeAll: sl(),
      ),
    )
    ..registerFactory(() => PrivacyCubit(getRequests: sl(), requestData: sl()))
    ..registerFactory(
      () => SupportTicketsCubit(
        getTickets: sl(),
        createTicket: sl(),
        replyToTicket: sl(),
      ),
    )
    ..registerFactory(() => OffersCubit(getOffers: sl(), getReferral: sl()));
}
