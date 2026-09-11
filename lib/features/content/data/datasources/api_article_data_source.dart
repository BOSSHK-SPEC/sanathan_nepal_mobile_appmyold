import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../domain/entities/article.dart';
import '../models/article_model.dart';
import 'article_data_source.dart';

/// Articles served by the backend.
///
/// The server returns localized text as `{en, ne, hi}` objects, which is
/// exactly the shape `ArticleTextModel` already parses — so the mapping here is
/// structural rather than a translation layer.
class ApiArticleDataSource implements ArticleDataSource {
  const ApiArticleDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<ArticleModel>> fetchArticles(ArticleType type) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.articles,
          query: {'type': type.code},
        );
        return asJsonList(response).map(_toModel).toList(growable: false);
      });

  @override
  Future<ArticleModel> fetchArticle(String id) => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.article(id));
    return _toModel(asJsonMap(response));
  });

  @override
  Future<ArticleModel> toggleLike(String id) => guardApi(() async {
    final response = await _client.post<dynamic>(ApiEndpoints.articleLike(id));
    return _toModel(asJsonMap(response));
  });

  ArticleModel _toModel(Map<String, dynamic> json) => ArticleModel(
    id: json['id'] as String? ?? '',
    type: ArticleType.fromCode(json['type'] as String?),
    title: _text(json['title']),
    excerpt: _text(json['excerpt']),
    body: _textList(json['body']),
    category: ArticleLabelModel(
      key: json['categoryKey'] as String? ?? '',
      label: _text(json['categoryLabel']),
    ),
    tags: _labels(json['tags']),
    publishedAt: ApiTime.instantOr(json['publishedAt'], DateTime.now()),
    author: _text(json['author']),
    readTimeMinutes: (json['readTimeMinutes'] as num?)?.toInt() ?? 3,
    imageAsset: json['imageKey'] as String?,
    likes: (json['likeCount'] as num?)?.toInt() ?? 0,
    isLiked: json['isLiked'] as bool? ?? false,
  );

  ArticleTextModel _text(Object? raw) {
    if (raw is Map) {
      return ArticleTextModel(
        en: raw['en'] as String? ?? '',
        ne: raw['ne'] as String?,
        hi: raw['hi'] as String?,
      );
    }
    // A plain string is treated as English — the guaranteed fallback the
    // server promises for every localized field.
    if (raw is String) return ArticleTextModel(en: raw);
    return const ArticleTextModel();
  }

  List<ArticleTextModel> _textList(Object? raw) {
    if (raw is! List) return const [];
    return raw.map(_text).toList(growable: false);
  }

  List<ArticleLabelModel> _labels(Object? raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map(
          (entry) => ArticleLabelModel(
            key: entry['key'] as String? ?? '',
            label: _text(entry['label']),
          ),
        )
        .toList(growable: false);
  }
}
