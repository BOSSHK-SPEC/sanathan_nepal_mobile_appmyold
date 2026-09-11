import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/content/data/datasources/article_seed.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/entities/article.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/usecases/get_articles.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/cubit/article_list_cubit.dart';

class _MockGetArticles extends Mock implements GetArticles {}

void main() {
  late _MockGetArticles getArticles;
  final blogs = articleSeed.where((a) => a.type == ArticleType.blog).toList();

  setUp(() => getArticles = _MockGetArticles());

  blocTest<ArticleListCubit, ArticleListState>(
    'loads blogs and filters by category / tag',
    build: () {
      when(
        () => getArticles(ArticleType.blog),
      ).thenAnswer((_) async => Result.success(blogs));
      return ArticleListCubit(getArticles, type: ArticleType.blog);
    },
    act: (cubit) async {
      await cubit.load();
      cubit
        ..setCategory('sapana_ko_fal')
        ..setCategory(null)
        ..setTag('holi')
        ..setLanguage(ContentLanguage.english);
    },
    verify: (cubit) {
      expect(cubit.state.articles, LoadState.loaded(blogs));
      expect(cubit.state.articles.dataOrNull?.length, blogs.length);
      expect(cubit.state.filtered.map((a) => a.id), ['blog-holi']);
      expect(cubit.state.language, ContentLanguage.english);
      expect(cubit.state.categories.map((c) => c.key), contains('festivals'));
      expect(cubit.state.tags.map((t) => t.key), contains('dashain'));
    },
  );

  blocTest<ArticleListCubit, ArticleListState>(
    'emits failure when the use case fails',
    build: () {
      when(
        () => getArticles(ArticleType.news),
      ).thenAnswer((_) async => const Result.failure(NetworkFailure()));
      return ArticleListCubit(getArticles, type: ArticleType.news);
    },
    act: (cubit) => cubit.load(),
    expect: () => const [
      ArticleListState(type: ArticleType.news, articles: LoadState.loading()),
      ArticleListState(
        type: ArticleType.news,
        articles: LoadState.failed(NetworkFailure()),
      ),
    ],
  );
}
