import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';

/// Likes / un-likes an article and returns the updated entity.
class ToggleArticleLike implements UseCase<Article, String> {
  const ToggleArticleLike(this._repo);
  final ArticleRepository _repo;

  @override
  Future<Result<Article>> call(String params) => _repo.toggleLike(params);
}
