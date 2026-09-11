part of 'article_list_cubit.dart';

/// State of the blog / news listing incl. the active filters.
@freezed
abstract class ArticleListState with _$ArticleListState {
  const ArticleListState._();

  const factory ArticleListState({
    required ArticleType type,
    @Default(LoadState.idle()) LoadState<List<Article>> articles,

    /// `null` = all categories.
    String? categoryKey,

    /// `null` = all tags.
    String? tagKey,

    /// `null` = follow the app locale.
    ContentLanguage? language,
  }) = _ArticleListState;

  List<Article> get _loaded => articles.dataOrNull ?? const [];

  /// Articles matching the active category / tag filters.
  List<Article> get filtered => _loaded
      .where((a) => categoryKey == null || a.category.key == categoryKey)
      .where((a) => tagKey == null || a.tags.any((t) => t.key == tagKey))
      .toList();

  /// Distinct categories present in the loaded articles (stable order).
  List<ArticleLabel> get categories =>
      _distinct(_loaded.map((a) => a.category));

  /// Distinct tags present in the loaded articles (stable order).
  List<ArticleLabel> get tags => _distinct(_loaded.expand((a) => a.tags));

  static List<ArticleLabel> _distinct(Iterable<ArticleLabel> labels) {
    final seen = <String>{};
    return labels.where((l) => seen.add(l.key)).toList();
  }
}
