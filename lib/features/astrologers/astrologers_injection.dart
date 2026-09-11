import 'package:get_it/get_it.dart';

import '../../core/region/region_resolver.dart';
import '../../core/storage/key_value_store.dart';
import 'data/datasources/astrologer_data_source.dart';
import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import 'data/datasources/api_astrologer_data_source.dart';
import 'data/datasources/mock_astrologer_data_source.dart';
import 'data/repositories/astrologer_repository_impl.dart';
import 'domain/repositories/astrologer_repository.dart';
import 'domain/usecases/get_astrologer.dart';
import 'domain/usecases/get_astrologer_reviews.dart';
import 'domain/usecases/get_astrologers.dart';
import 'domain/usecases/get_consult_languages.dart';
import 'domain/usecases/manage_recent_searches.dart';
import 'domain/usecases/report_astrologer.dart';
import 'domain/usecases/reviewable_consultation.dart';
import 'domain/usecases/submit_astrologer_review.dart';
import 'domain/entities/astrologer_filter.dart';
import 'domain/usecases/toggle_follow_astrologer.dart';
import 'presentation/cubit/astrologer_list_cubit.dart';
import 'presentation/cubit/astrologer_profile_cubit.dart';
import 'presentation/cubit/write_review_cubit.dart';

/// Registers data sources, repositories, use cases and cubits for
/// `astrologers`.
void registerAstrologersFeature(GetIt sl) {
  sl
    ..registerLazySingleton<AstrologerDataSource>(
      () => selectDataSource(
        mock: () =>
            MockAstrologerDataSource(sl<KeyValueStore>(), sl<RegionResolver>()),
        live: () => ApiAstrologerDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<AstrologerRepository>(
      () => AstrologerRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetAstrologers(sl()))
    ..registerLazySingleton(() => GetAstrologer(sl()))
    ..registerLazySingleton(() => GetAstrologerReviews(sl()))
    ..registerLazySingleton(() => SubmitAstrologerReview(sl()))
    ..registerLazySingleton(() => ToggleFollowAstrologer(sl()))
    ..registerLazySingleton(() => ReportAstrologer(sl()))
    ..registerLazySingleton(() => GetReviewableConsultation(sl()))
    ..registerLazySingleton(() => GetConsultLanguages(sl()))
    ..registerLazySingleton(() => GetRecentSearches(sl()))
    ..registerLazySingleton(() => SaveRecentSearch(sl()))
    ..registerLazySingleton(() => ClearRecentSearches(sl()))
    // The param is the starting filter — the Following screen passes a
    // following-only one, discovery passes nothing.
    ..registerFactoryParam<AstrologerListCubit, AstrologerFilter?, void>(
      (initialFilter, _) => AstrologerListCubit(
        getAstrologers: sl(),
        getLanguages: sl(),
        toggleFollow: sl(),
        getRecentSearches: sl(),
        saveRecentSearch: sl(),
        clearRecentSearches: sl(),
        initialFilter: initialFilter,
      ),
    )
    ..registerFactoryParam<AstrologerProfileCubit, String, void>(
      (astrologerId, _) => AstrologerProfileCubit(
        astrologerId: astrologerId,
        getAstrologer: sl(),
        getReviews: sl(),
        toggleFollow: sl(),
        report: sl(),
        reviewableConsultation: sl(),
      ),
    )
    ..registerFactoryParam<WriteReviewCubit, String, String?>(
      (astrologerId, consultationId) => WriteReviewCubit(
        astrologerId: astrologerId,
        consultationId: consultationId,
        submitReview: sl(),
      ),
    );
}
