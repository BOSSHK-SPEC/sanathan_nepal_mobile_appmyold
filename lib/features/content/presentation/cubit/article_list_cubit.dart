import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_articles.dart';
import '../../../../core/state/app_cubit.dart';

part 'article_list_cubit.freezed.dart';
part 'article_list_state.dart';

/// Loads and filters the list of blogs or news.
class ArticleListCubit extends AppCubit<ArticleListState> {
  ArticleListCubit(this._getArticles, {required ArticleType type})
    : super(ArticleListState(type: type));

  final GetArticles _getArticles;

  Future<void> load() async {
    emit(state.copyWith(articles: state.articles.toLoading()));
    final result = await _getArticles(state.type);
    emit(
      state.copyWith(
        articles: result.fold(state.articles.toFailed, LoadState.loaded),
      ),
    );
  }

  /// `null` selects "All".
  void setCategory(String? key) => emit(state.copyWith(categoryKey: key));

  /// `null` selects "All".
  void setTag(String? key) => emit(state.copyWith(tagKey: key));

  /// `null` follows the app locale.
  void setLanguage(ContentLanguage? language) =>
      emit(state.copyWith(language: language));
}
