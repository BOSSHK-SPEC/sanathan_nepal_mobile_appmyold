import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';

/// "Recent posts" shown under an article (same type, excluding itself).
class GetRelatedArticles implements UseCase<List<Article>, String> {
  const GetRelatedArticles(this._repo);
  final ArticleRepository _repo;

  @override
  Future<Result<List<Article>>> call(String params) => _repo.getRelated(params);
}
