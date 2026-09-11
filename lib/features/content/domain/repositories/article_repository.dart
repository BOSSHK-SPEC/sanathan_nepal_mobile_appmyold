import '../../../../core/utils/result.dart';
import '../entities/article.dart';

/// Access to blog / news articles.
abstract interface class ArticleRepository {
  Future<Result<List<Article>>> getArticles(ArticleType type);
  Future<Result<Article>> getArticle(String id);
  Future<Result<List<Article>>> getRelated(String id, {int limit = 2});
  Future<Result<Article>> toggleLike(String id);
}
