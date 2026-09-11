import 'package:get_it/get_it.dart';

import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import '../../core/region/region_all.dart';

import 'data/datasources/api_legal_data_source.dart';
import 'data/datasources/legal_local_data_source.dart';
import 'data/repositories/legal_repository_impl.dart';
import 'domain/repositories/legal_repository.dart';
import 'domain/usecases/get_legal_document.dart';
import 'presentation/cubit/legal_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `legal`.
void registerLegalFeature(GetIt sl) {
  sl
    ..registerLazySingleton<LegalLocalDataSource>(
      () => selectDataSource(
        mock: () => MockLegalDataSource(regionResolver: sl<RegionResolver>()),
        live: () => ApiLegalDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<LegalRepository>(() => LegalRepositoryImpl(sl()))
    ..registerLazySingleton(() => GetLegalDocument(sl()))
    ..registerFactory(() => LegalCubit(sl()));
}
