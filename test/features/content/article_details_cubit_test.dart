import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/content/data/datasources/article_seed.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/entities/article.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/usecases/get_article.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/usecases/get_related_articles.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/usecases/toggle_article_like.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/cubit/article_details_cubit.dart';

class _MockGetArticle extends Mock implements GetArticle {}

class _MockGetRelated extends Mock implements GetRelatedArticles {}

class _MockToggleLike extends Mock implements ToggleArticleLike {}

void main() {
  late _MockGetArticle getArticle;
  late _MockGetRelated getRelated;
  late _MockToggleLike toggleLike;
  final article = articleSeed.first;
  final related = articleSeed.sublist(1, 3);

  setUp(() {
    getArticle = _MockGetArticle();
    getRelated = _MockGetRelated();
    toggleLike = _MockToggleLike();
  });

  ArticleDetailsCubit build() => ArticleDetailsCubit(
    getArticle: getArticle,
    getRelated: getRelated,
    toggleLike: toggleLike,
  );

  blocTest<ArticleDetailsCubit, ArticleDetailsState>(
    'loads article + related, toggles like and language',
    build: () {
      when(
        () => getArticle(article.id),
      ).thenAnswer((_) async => Result.success(article));
      when(
        () => getRelated(article.id),
      ).thenAnswer((_) async => Result.success(related));
      when(() => toggleLike(article.id)).thenAnswer(
        (_) async => Result.success(
          article.copyWith(isLiked: true, likes: article.likes + 1),
        ),
      );
      return build();
    },
    act: (cubit) async {
      await cubit.load(article.id);
      await cubit.toggleLike();
      cubit.setLanguage(ContentLanguage.nepali);
    },
    expect: () => [
      const ArticleDetailsState(
        article: LoadState.loading(),
        related: LoadState.loading(),
      ),
      ArticleDetailsState(
        article: LoadState.loaded(article),
        related: LoadState.loaded(related),
      ),
      ArticleDetailsState(
        article: LoadState.loaded(
          article.copyWith(isLiked: true, likes: article.likes + 1),
        ),
        related: LoadState.loaded(related),
      ),
      ArticleDetailsState(
        article: LoadState.loaded(
          article.copyWith(isLiked: true, likes: article.likes + 1),
        ),
        related: LoadState.loaded(related),
        language: ContentLanguage.nepali,
      ),
    ],
  );

  blocTest<ArticleDetailsCubit, ArticleDetailsState>(
    'related failure keeps the article readable',
    build: () {
      when(
        () => getArticle(article.id),
      ).thenAnswer((_) async => Result.success(article));
      when(
        () => getRelated(article.id),
      ).thenAnswer((_) async => const Result.failure(ServerFailure()));
      return build();
    },
    act: (cubit) => cubit.load(article.id),
    verify: (cubit) {
      expect(cubit.state.article, LoadState.loaded(article));
      expect(cubit.state.related.isFailed, isTrue);
      expect(cubit.state.related.dataOrNull, isNull);
    },
  );

  blocTest<ArticleDetailsCubit, ArticleDetailsState>(
    'emits failure for unknown id',
    build: () {
      when(
        () => getArticle('nope'),
      ).thenAnswer((_) async => const Result.failure(NotFoundFailure()));
      return build();
    },
    act: (cubit) => cubit.load('nope'),
    expect: () => const [
      ArticleDetailsState(
        article: LoadState.loading(),
        related: LoadState.loading(),
      ),
      ArticleDetailsState(
        article: LoadState.failed(NotFoundFailure()),
        related: LoadState.failed(NotFoundFailure()),
      ),
    ],
  );
}
