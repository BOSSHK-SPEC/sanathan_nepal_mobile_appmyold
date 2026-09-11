import '../../core/config/data_source_selector.dart';
import 'data/datasources/api_notification_prefs_data_source.dart';
import 'package:get_it/get_it.dart';

import '../../core/auth/auth_session_manager.dart';
import '../../core/network/api_client.dart';
import '../../core/region/region_resolver.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/api_auth_data_source.dart';
import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/datasources/mock_auth_data_source.dart';
import 'data/datasources/notification_prefs_local_data_source.dart';
import 'data/datasources/onboarding_progress_local_data_source.dart';
import 'data/repositories/onboarding_progress_repository_impl.dart';
import 'data/services/auth_presence_impl.dart';
import 'domain/repositories/auth_presence.dart';
import 'domain/repositories/onboarding_progress_repository.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/notification_prefs_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/notification_prefs_repository.dart';
import 'domain/usecases/get_notification_prefs.dart';
import 'domain/usecases/save_notification_prefs.dart';
import 'domain/usecases/sign_in_with_apple.dart';
import 'domain/usecases/sign_in_with_google.dart';
import 'domain/usecases/sign_in_with_phone.dart';
import 'domain/usecases/submit_profile.dart';
import 'domain/usecases/verify_otp.dart';
import 'presentation/cubit/auth_cubit.dart';
import 'presentation/cubit/notification_prefs_cubit.dart';
import 'presentation/cubit/profile_details_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `onboarding`.
void registerOnboardingFeature(GetIt sl) {
  sl
    // Data sources
    // The one line that decides mock or live. Everything above the data
    // source — repository, use cases, cubits, widgets — is unchanged either way.
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => selectDataSource(
        mock: () => MockAuthDataSource(regions: sl<RegionResolver>()),
        live: () => ApiAuthDataSource(
          client: sl<ApiClient>(),
          session: sl<AuthSessionManager>(),
          regions: sl<RegionResolver>(),
          store: sl<KeyValueStore>(),
        ),
      ),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<KeyValueStore>()),
    )
    ..registerLazySingleton<NotificationPrefsLocalDataSource>(
      () => selectDataSource(
        mock: () => NotificationPrefsLocalDataSourceImpl(sl<KeyValueStore>()),
        // Written through to the server, which is what actually sends: a
        // preference the push worker never hears about does nothing.
        live: () => ApiNotificationPrefsDataSource(
          client: sl<ApiClient>(),
          local: NotificationPrefsLocalDataSourceImpl(sl<KeyValueStore>()),
        ),
      ),
    )
    ..registerLazySingleton<OnboardingProgressLocalDataSource>(
      () => OnboardingProgressLocalDataSourceImpl(sl<KeyValueStore>()),
    )
    // Whether a login survived a restart. Live reads the refresh token; mock
    // has no tokens, so it reads the mock sign-in's own flag.
    ..registerLazySingleton<AuthPresence>(
      () => selectDataSource<AuthPresence>(
        mock: () => LocalAuthPresence(sl<AuthLocalDataSource>()),
        live: () => SessionAuthPresence(sl<AuthSessionManager>()),
      ),
    )
    // Repositories
    ..registerLazySingleton<OnboardingProgressRepository>(
      () => OnboardingProgressRepositoryImpl(sl()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remote: sl(), local: sl()),
    )
    ..registerLazySingleton<NotificationPrefsRepository>(
      () => NotificationPrefsRepositoryImpl(sl()),
    )
    // Use cases
    ..registerLazySingleton(() => SignInWithGoogle(sl()))
    ..registerLazySingleton(() => SignInWithApple(sl()))
    ..registerLazySingleton(() => SignInWithPhone(sl(), sl<RegionResolver>()))
    ..registerLazySingleton(() => VerifyOtp(sl()))
    ..registerLazySingleton(() => SubmitProfile(sl()))
    ..registerLazySingleton(() => GetNotificationPrefs(sl()))
    ..registerLazySingleton(() => SaveNotificationPrefs(sl()))
    // Cubits
    ..registerFactory(
      () => AuthCubit(
        signInWithGoogle: sl(),
        signInWithApple: sl(),
        signInWithPhone: sl(),
        verifyOtp: sl(),
      ),
    )
    ..registerFactory(
      () => ProfileDetailsCubit(
        submitProfile: sl(),
        // Restores a half-filled form after the app was closed mid-way.
        progress: sl<OnboardingProgressRepository>(),
      ),
    )
    ..registerFactory(
      () => NotificationPrefsCubit(getPrefs: sl(), savePrefs: sl()),
    );
}
