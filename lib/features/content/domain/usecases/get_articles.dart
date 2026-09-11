import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/article.dart';
import '../repositories/article_repository.dart';

/// Lists all articles of one [ArticleType], newest first.
class GetArticles implements UseCase<List<Article>, ArticleType> {
  const GetArticles(this._repo);
  final ArticleRepository _repo;

  @override
  Future<Result<List<Article>>> call(ArticleType params) =>
      _repo.getArticles(params);
}
