import 'package:get_it/get_it.dart';

import '../../core/config/data_source_selector.dart';
import '../../core/network/api_client.dart';
import '../../core/region/region_resolver.dart';
import 'data/datasources/api_article_data_source.dart';
import 'data/datasources/article_data_source.dart';
import 'data/repositories/article_repository_impl.dart';
import 'domain/entities/article.dart';
import 'domain/repositories/article_repository.dart';
import 'domain/usecases/get_article.dart';
import 'domain/usecases/get_articles.dart';
import 'domain/usecases/get_related_articles.dart';
import 'domain/usecases/toggle_article_like.dart';
import 'presentation/cubit/article_details_cubit.dart';
import 'presentation/cubit/article_list_cubit.dart';

/// Registers data sources, repositories, use cases and blocs for `content`.
void registerContentFeature(GetIt sl) {
  sl
    ..registerLazySingleton<ArticleDataSource>(
      () => selectDataSource(
        mock: () => MockArticleDataSource(sl<RegionResolver>()),
        live: () => ApiArticleDataSource(sl<ApiClient>()),
      ),
    )
    ..registerLazySingleton<ArticleRepository>(
      () => ArticleRepositoryImpl(sl()),
    )
    ..registerLazySingleton(() => GetArticles(sl()))
    ..registerLazySingleton(() => GetArticle(sl()))
    ..registerLazySingleton(() => GetRelatedArticles(sl()))
    ..registerLazySingleton(() => ToggleArticleLike(sl()))
    // `param1` = ArticleType (blog | news).
    ..registerFactoryParam<ArticleListCubit, ArticleType, void>(
      (type, _) => ArticleListCubit(sl(), type: type),
    )
    ..registerFactory(
      () => ArticleDetailsCubit(
        getArticle: sl(),
        getRelated: sl(),
        toggleLike: sl(),
      ),
    );
}
