import 'package:get_it/get_it.dart';
import '../../core/events/data_changes.dart';
import '../../core/session/session_sync.dart';
import 'data/session/profile_session_sync.dart';
import 'data/session/server_role_granter.dart';

import '../../core/auth/auth_session_manager.dart';
import '../../core/config/app_environment.dart';
import '../../core/region/region_resolver.dart';
import '../../core/session/role_granter.dart';
import '../../core/session/session_refresher.dart';
import '../../core/session/session_source.dart';
import '../../core/storage/key_value_store.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_profile_data_sources.dart';
import 'data/datasources/mock_activity_data_source.dart';
import 'data/datasources/mock_business_data_source.dart';
import 'data/datasources/mock_favourites_data_source.dart';
import 'data/datasources/profile_local_data_source.dart';
import 'data/repositories/activity_repository_impl.dart';
import 'data/session/profile_role_granter.dart';
import 'data/session/profile_session_source.dart';
import 'data/repositories/business_repository_impl.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'domain/repositories/activity_repository.dart';
import 'domain/repositories/business_repository.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecases/delete_account.dart';
import 'domain/usecases/get_appointments.dart';
import 'domain/usecases/get_business_profile.dart';
import 'domain/usecases/get_businesses.dart';
import 'domain/usecases/get_my_business.dart';
import 'domain/usecases/get_favourite_products.dart';
import 'domain/usecases/get_orders.dart';
import 'domain/usecases/get_user_profile.dart';
import 'domain/usecases/logout.dart';
import 'domain/usecases/set_business_status.dart';
import 'domain/usecases/update_order.dart';
import 'domain/usecases/update_user_profile.dart';
import 'domain/usecases/upsert_business_profile.dart';
import 'presentation/cubit/activity_cubit.dart';
import 'presentation/cubit/admin_businesses_cubit.dart';
import 'presentation/cubit/business_form_cubit.dart';
import 'presentation/cubit/business_profile_cubit.dart';
import 'presentation/cubit/edit_profile_cubit.dart';
import 'presentation/cubit/profile_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `profile`.
void registerProfileFeature(GetIt sl) {
  sl
    // Data sources
    // The cache behind the profile. It seeds a demo user only in the mock
    // build; against a real backend an empty cache stays empty until the
    // server answers.
    ..registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(
        sl<KeyValueStore>(),
        sl<RegionResolver>(),
        seedWhenEmpty: AppEnvironment.useMockData,
      ),
    )
    ..registerLazySingleton<ApiProfileDataSource>(
      () => ApiProfileDataSource(sl<ApiClient>()),
    )
    ..registerLazySingleton<FavouritesDataSource>(
      () => selectDataSource(
        mock: () => MockFavouritesDataSource(sl<RegionResolver>()),
        live: () =>
            ApiFavouritesDataSource(sl<ApiClient>(), sl<RegionResolver>()),
      ),
    )
    ..registerLazySingleton<BusinessDataSource>(
      () => selectDataSource(
        mock: () =>
            MockBusinessDataSource(sl<KeyValueStore>(), sl<RegionResolver>()),
        live: () => ApiBusinessDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<ActivityDataSource>(
      () => selectDataSource(
        mock: MockActivityDataSource.new,
        live: () => ApiActivityDataSource(sl<ApiClient>()),
      ),
    )
    // Session: the profile owns how a stored role becomes runtime roles.
    ..registerLazySingleton<SessionSource>(
      () => ProfileSessionSource(sl<ProfileLocalDataSource>()),
    )
    // Live, a role is never granted on the device: the granter asks the
    // server what the account holds. Mock keeps the local grant, because the
    // mock is the server there.
    ..registerLazySingleton<RoleGranter>(
      () => selectDataSource<RoleGranter>(
        mock: () => ProfileRoleGranter(sl<ProfileLocalDataSource>()),
        live: () => ServerRoleGranter(sl<SessionSync>()),
      ),
    )
    ..registerLazySingleton<SessionSync>(
      () => ProfileSessionSync(
        profiles: sl<ProfileRepository>(),
        local: sl<ProfileLocalDataSource>(),
        refresher: sl<SessionRefresher>(),
      ),
    )
    // Repositories
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        local: sl(),
        favourites: sl(),
        // Registered later by the session feature; resolved lazily.
        sessionRefresher: sl<SessionRefresher>(),
        // Null under mocks, so the seeded profile keeps working offline and in
        // tests; live, the server is the source of truth for name, contact
        // details and — most importantly — roles.
        remote: selectDataSource<ApiProfileDataSource?>(
          mock: () => null,
          live: () => sl<ApiProfileDataSource>(),
        ),
        session: selectDataSource<AuthSessionManager?>(
          mock: () => null,
          live: () => sl<AuthSessionManager>(),
        ),
      ),
    )
    ..registerLazySingleton<BusinessRepository>(
      () => BusinessRepositoryImpl(sl()),
    )
    ..registerLazySingleton<ActivityRepository>(
      () => ActivityRepositoryImpl(sl()),
    )
    // Use cases
    ..registerLazySingleton(() => GetUserProfile(sl()))
    ..registerLazySingleton(() => UpdateUserProfile(sl()))
    ..registerLazySingleton(() => GetFavouriteProducts(sl()))
    ..registerLazySingleton(() => Logout(sl()))
    ..registerLazySingleton(() => DeleteAccount(sl()))
    ..registerLazySingleton(() => GetBusinessProfile(sl()))
    ..registerLazySingleton(() => GetBusinesses(sl()))
    ..registerLazySingleton(() => GetMyBusiness(sl()))
    ..registerLazySingleton(() => UpsertBusinessProfile(sl()))
    ..registerLazySingleton(() => SetBusinessStatus(sl()))
    ..registerLazySingleton(() => GetAppointments(sl()))
    ..registerLazySingleton(() => GetOrders(sl()))
    ..registerLazySingleton(() => ApplyOrderAction(sl()))
    ..registerLazySingleton(() => RateOrder(sl()))
    // Cubits
    ..registerFactory(
      () => ProfileCubit(
        getProfile: sl(),
        getFavourites: sl(),
        logout: sl(),
        deleteAccount: sl(),
      ),
    )
    ..registerFactory(
      () => EditProfileCubit(getProfile: sl(), updateProfile: sl()),
    )
    ..registerFactory(
      () => BusinessProfileCubit(
        getBusiness: sl(),
        getMyBusiness: sl(),
        setStatus: sl(),
        upsertBusiness: sl(),
        repository: sl(),
        roles: sl<RoleGranter>(),
        sessionRefresher: sl<SessionRefresher>(),
      ),
    )
    ..registerFactory(
      () => AdminBusinessesCubit(getBusinesses: sl(), setStatus: sl()),
    )
    ..registerFactoryParam<BusinessFormCubit, String, void>(
      (id, _) => BusinessFormCubit(
        getBusiness: sl(),
        getMyBusiness: sl(),
        upsertBusiness: sl(),
        businessId: id,
      ),
    )
    ..registerFactory(
      () => ActivityCubit(
        getAppointments: sl(),
        getOrders: sl(),
        applyOrderAction: sl(),
        rateOrder: sl(),
        // Absent in tests that wire this feature on its own.
        changes: sl.isRegistered<DataChanges>() ? sl<DataChanges>() : null,
      ),
    );
}
