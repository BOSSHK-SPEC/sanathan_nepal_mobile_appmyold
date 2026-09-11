import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/article_repository.dart';
import '../datasources/article_data_source.dart';

/// [ArticleRepository] delegating to an [ArticleDataSource].
class ArticleRepositoryImpl implements ArticleRepository {
  ArticleRepositoryImpl(this._source);
  final ArticleDataSource _source;

  @override
  Future<Result<List<Article>>> getArticles(ArticleType type) =>
      guard(() async {
        final list = await _source.fetchArticles(type);
        return list.map((a) => a.toEntity()).toList();
      });

  @override
  Future<Result<Article>> getArticle(String id) =>
      guard(() async => (await _source.fetchArticle(id)).toEntity());

  @override
  Future<Result<List<Article>>> getRelated(String id, {int limit = 2}) =>
      guard(() async {
        final article = await _source.fetchArticle(id);
        final all = await _source.fetchArticles(article.type);
        return all
            .where((a) => a.id != id)
            .take(limit)
            .map((a) => a.toEntity())
            .toList();
      });

  @override
  Future<Result<Article>> toggleLike(String id) =>
      guard(() async => (await _source.toggleLike(id)).toEntity());
}
