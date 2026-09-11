import 'package:get_it/get_it.dart';

import '../../core/session/session_refresher.dart';
import '../../core/session/session_resolver.dart';
import '../../core/session/session_source.dart';
import 'data/services/session_cubit_refresher.dart';
import 'data/services/session_cubit_resolver.dart';
import 'presentation/cubit/session_cubit.dart';

/// Session is app-global, so the cubit is a singleton (unlike screen cubits).
///
/// Must be registered *after* the feature that provides [SessionSource]
/// (profile), since the cubit resolves it lazily on first use.
void registerSessionFeature(GetIt sl) {
  sl
    ..registerLazySingleton(() => SessionCubit(source: sl<SessionSource>()))
    ..registerLazySingleton<SessionRefresher>(
      () => SessionCubitRefresher(sl<SessionCubit>()),
    )
    ..registerLazySingleton<SessionResolver>(
      () => SessionCubitResolver(sl<SessionCubit>()),
    );
}
