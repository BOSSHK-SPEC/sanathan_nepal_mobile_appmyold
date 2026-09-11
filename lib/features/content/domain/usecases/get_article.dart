import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';

/// Loads one article by id.
class GetArticle implements UseCase<Article, String> {
  const GetArticle(this._repo);
  final ArticleRepository _repo;

  @override
  Future<Result<Article>> call(String params) => _repo.getArticle(params);
}
