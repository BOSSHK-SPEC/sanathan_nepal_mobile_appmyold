import 'package:get_it/get_it.dart';

import '../../app/di/injection.dart';
import '../../core/auth/auth_session_manager.dart';
import '../../core/network/api_client.dart';
import '../auth/cubit/admin_auth_cubit.dart';
import '../data/datasources/admin_auth_data_source.dart';
import '../data/datasources/admin_remote_data_source.dart';
import '../data/repositories/admin_repository_impl.dart';
import '../domain/repositories/admin_repository.dart';
import '../features/applications/cubit/applications_cubit.dart';
import '../features/audit/cubit/audit_cubit.dart';
import '../features/dashboard/cubit/dashboard_cubit.dart';
import '../features/flags/cubit/flags_cubit.dart';
import '../features/moderation/cubit/moderation_cubit.dart';
import '../features/payouts/cubit/payouts_cubit.dart';

/// Wires the console on top of the app's own container.
///
/// [configureDependencies] runs first and unchanged: the console reuses the
/// same `ApiClient` — with its auth, tracing, idempotency and retry chain —
/// the same `AuthSessionManager`, and the profile feature's business use
/// cases. Everything registered here is what the console adds, not a parallel
/// copy of what the app already has.
Future<void> configureAdminDependencies() async {
  await configureDependencies();

  if (sl.isRegistered<AdminRepository>()) return;

  sl
    // --- data -----------------------------------------------------------
    ..registerLazySingleton<AdminRemoteDataSource>(
      () => ApiAdminDataSource(sl<ApiClient>()),
    )
    ..registerLazySingleton<AdminAuthDataSource>(
      () => ApiAdminAuthDataSource(
        client: sl<ApiClient>(),
        session: sl<AuthSessionManager>(),
      ),
    )
    ..registerLazySingleton<AdminRepository>(
      () => AdminRepositoryImpl(sl<AdminRemoteDataSource>()),
    )
    // --- state ------------------------------------------------------------
    // The auth cubit is a singleton because the router listens to it: a new
    // instance per screen would mean the redirect watches a cubit nobody is
    // driving. The page cubits are factories, so leaving and returning to a
    // section refetches instead of showing what was true ten minutes ago.
    ..registerLazySingleton<AdminAuthCubit>(
      () => AdminAuthCubit(sl<AdminAuthDataSource>()),
    )
    ..registerFactory<DashboardCubit>(() => DashboardCubit(sl()))
    ..registerFactory<ApplicationsCubit>(() => ApplicationsCubit(sl()))
    ..registerFactory<ModerationCubit>(() => ModerationCubit(sl()))
    ..registerFactory<PayoutsCubit>(() => PayoutsCubit(sl()))
    ..registerFactory<FlagsCubit>(() => FlagsCubit(sl()))
    ..registerFactory<AuditCubit>(() => AuditCubit(sl()));
}

/// The console's service locator — the app's, deliberately.
GetIt get adminSl => sl;
