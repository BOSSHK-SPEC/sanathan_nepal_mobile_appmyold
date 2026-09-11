import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../domain/entities/article.dart';
import '../models/article_model.dart';
import 'article_seed.dart';

/// I/O contract for articles (remote CMS later).
abstract interface class ArticleDataSource {
  Future<List<ArticleModel>> fetchArticles(ArticleType type);
  Future<ArticleModel> fetchArticle(String id);
  Future<ArticleModel> toggleLike(String id);
}

/// Deterministic in-memory articles (Figma Blogs `1489:3694`, News
/// `1506:2769`). The seed is chosen per active region (Nepal / India) on
/// every call; likes are kept in memory for the session, per region. The
/// store holds domain entities and hands out models at the boundary.
class MockArticleDataSource implements ArticleDataSource {
  MockArticleDataSource(this._resolver);

  final RegionResolver _resolver;
  final Map<Region, List<Article>> _byRegion = {};

  /// Region is read at call time – it can change while the app runs.
  List<Article> get _articles {
    final region = _resolver.region;
    return _byRegion.putIfAbsent(
      region,
      () => List.of(articleSeedFor(region.config)),
    );
  }

  @override
  Future<List<ArticleModel>> fetchArticles(ArticleType type) async {
    final list = _articles.where((a) => a.type == type).toList()
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    return list.map(ArticleModel.fromEntity).toList();
  }

  @override
  Future<ArticleModel> fetchArticle(String id) async {
    final match = _articles.where((a) => a.id == id);
    if (match.isEmpty) throw const NotFoundException('Article not found');
    return ArticleModel.fromEntity(match.first);
  }

  @override
  Future<ArticleModel> toggleLike(String id) async {
    final articles = _articles;
    final index = articles.indexWhere((a) => a.id == id);
    if (index < 0) throw const NotFoundException('Article not found');
    final current = articles[index];
    final updated = current.copyWith(
      isLiked: !current.isLiked,
      likes: current.isLiked ? current.likes - 1 : current.likes + 1,
    );
    articles[index] = updated;
    return ArticleModel.fromEntity(updated);
  }
}
