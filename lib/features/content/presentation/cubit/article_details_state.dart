part of 'article_details_cubit.dart';

/// State of the article details page.
@freezed
abstract class ArticleDetailsState with _$ArticleDetailsState {
  const factory ArticleDetailsState({
    @Default(LoadState.idle()) LoadState<Article> article,

    /// "Recent posts" shown under the article.
    @Default(LoadState.idle()) LoadState<List<Article>> related,

    /// `null` = follow the app locale.
    ContentLanguage? language,
  }) = _ArticleDetailsState;
}
