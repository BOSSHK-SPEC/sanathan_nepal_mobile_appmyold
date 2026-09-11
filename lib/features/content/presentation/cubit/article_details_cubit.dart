import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_article.dart';
import '../../domain/usecases/get_related_articles.dart';
import '../../domain/usecases/toggle_article_like.dart';
import '../../../../core/state/app_cubit.dart';

part 'article_details_cubit.freezed.dart';
part 'article_details_state.dart';

/// Loads one article, its "recent posts" and handles like / language.
class ArticleDetailsCubit extends AppCubit<ArticleDetailsState> {
  ArticleDetailsCubit({
    required GetArticle getArticle,
    required GetRelatedArticles getRelated,
    required ToggleArticleLike toggleLike,
  }) : _getArticle = getArticle,
       _getRelated = getRelated,
       _toggleLike = toggleLike,
       super(const ArticleDetailsState());

  final GetArticle _getArticle;
  final GetRelatedArticles _getRelated;
  final ToggleArticleLike _toggleLike;

  Future<void> load(String id) async {
    emit(
      state.copyWith(
        article: state.article.toLoading(),
        related: state.related.toLoading(),
      ),
    );
    final result = await _getArticle(id);
    switch (result) {
      case ResultFailure(:final failure):
        emit(
          state.copyWith(
            article: state.article.toFailed(failure),
            related: state.related.toFailed(failure),
          ),
        );
      case Success(value: final article):
        final related = await _getRelated(id);
        emit(
          state.copyWith(
            article: LoadState.loaded(article),
            related: related.fold(state.related.toFailed, LoadState.loaded),
          ),
        );
    }
  }

  /// Toggles the like on the loaded article; failures keep the current
  /// article (the like is best-effort UI feedback).
  Future<void> toggleLike() async {
    final article = state.article.dataOrNull;
    if (article == null) return;
    final result = await _toggleLike(article.id);
    result.fold(
      (_) {},
      (updated) => emit(state.copyWith(article: LoadState.loaded(updated))),
    );
  }

  void setLanguage(ContentLanguage? language) =>
      emit(state.copyWith(language: language));
}
