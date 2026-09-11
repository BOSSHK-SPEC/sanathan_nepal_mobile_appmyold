import 'package:get_it/get_it.dart';

import '../../core/system/app_status.dart';
import '../../core/system/connectivity.dart';
import 'presentation/cubit/system_cubit.dart';

/// Registers app-wide availability and connectivity.
///
/// Both sources are stubs today. Swapping in remote config and
/// `connectivity_plus` is a change to these two lines — the gate, the banner
/// and every screen stay as they are.
void registerSystemFeature(GetIt sl) {
  sl
    ..registerLazySingleton<AppStatusSource>(AlwaysAvailableStatusSource.new)
    ..registerLazySingleton<ConnectivityStatus>(AlwaysOnlineConnectivity.new)
    ..registerLazySingleton(
      () => SystemCubit(
        statusSource: sl<AppStatusSource>(),
        connectivity: sl<ConnectivityStatus>(),
      ),
    );
}
