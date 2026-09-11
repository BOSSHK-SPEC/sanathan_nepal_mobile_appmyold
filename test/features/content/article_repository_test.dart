import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/content/data/datasources/article_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/content/data/datasources/article_seed.dart';
import 'package:sanathan_nepal_mobile_app/features/content/data/models/article_model.dart';
import 'package:sanathan_nepal_mobile_app/features/content/data/repositories/article_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/entities/article.dart';

/// Resolver whose region can be flipped mid-test.
class _SwitchableResolver implements RegionResolver {
  @override
  Region region = Region.nepal;
  @override
  RegionConfig get config => region.config;
}

void main() {
  group('Nepal region (default)', () {
    late ArticleRepositoryImpl repo;

    setUp(
      () => repo = ArticleRepositoryImpl(
        MockArticleDataSource(const FixedRegionResolver(Region.nepal)),
      ),
    );

    test('lists blogs newest first and news separately', () async {
      final blogs = (await repo.getArticles(ArticleType.blog)).valueOrNull!;
      final news = (await repo.getArticles(ArticleType.news)).valueOrNull!;
      expect(blogs, isNotEmpty);
      expect(news, isNotEmpty);
      expect(blogs.every((a) => a.type == ArticleType.blog), isTrue);
      for (var i = 1; i < blogs.length; i++) {
        expect(blogs[i - 1].publishedAt.isAfter(blogs[i].publishedAt), isTrue);
      }
    });

    test('keeps the Nepal seed unchanged (5 blogs + 4 news)', () async {
      final blogs = (await repo.getArticles(ArticleType.blog)).valueOrNull!;
      final news = (await repo.getArticles(ArticleType.news)).valueOrNull!;
      expect(blogs.length, 5);
      expect(news.length, 4);
      expect(blogs.map((a) => a.id), contains('blog-akshaya-tritiya'));
      expect(news.map((a) => a.id), contains('news-poll-code'));
      // Hindi falls back to English for the Nepal seed.
      final akshaya = blogs.firstWhere((a) => a.id == 'blog-akshaya-tritiya');
      expect(akshaya.title.hi, isNull);
      expect(akshaya.title.forLanguage('hi'), akshaya.title.en);
      expect(akshaya.title.ne, 'अक्षय तृतीया');
    });

    test('related excludes the article itself and respects limit', () async {
      final related = (await repo.getRelated('blog-holi')).valueOrNull!;
      expect(related.length, 2);
      expect(related.any((a) => a.id == 'blog-holi'), isFalse);
      expect(related.every((a) => a.type == ArticleType.blog), isTrue);
    });

    test('toggleLike flips like state and persists in the session', () async {
      final liked = (await repo.toggleLike('news-tech')).valueOrNull!;
      expect(liked.isLiked, isTrue);
      expect(liked.likes, 66);
      final again = (await repo.getArticle('news-tech')).valueOrNull!;
      expect(again.isLiked, isTrue);
    });

    test('unknown id maps to NotFoundFailure', () async {
      final result = await repo.getArticle('missing');
      expect(result.failureOrNull, isA<NotFoundFailure>());
    });

    test('model json round trip', () async {
      final article = (await repo.getArticle('blog-tihar')).valueOrNull!;
      final model = ArticleModel.fromEntity(article);
      expect(ArticleModel.fromJson(model.toJson()), equals(model));
    });
  });

  group('India region', () {
    late ArticleRepositoryImpl repo;

    setUp(
      () => repo = ArticleRepositoryImpl(
        MockArticleDataSource(const FixedRegionResolver(Region.india)),
      ),
    );

    test('serves the Indian seed: 4 blogs + 3 news, newest first', () async {
      final blogs = (await repo.getArticles(ArticleType.blog)).valueOrNull!;
      final news = (await repo.getArticles(ArticleType.news)).valueOrNull!;
      expect(blogs.length, 4);
      expect(news.length, 3);
      expect(blogs.map((a) => a.id), [
        'blog-kumbh-mela',
        'blog-dev-deepawali-varanasi',
        'blog-durga-puja-kolkata',
        'blog-ganesh-chaturthi-mumbai',
      ]);
      expect(
        blogs.map((a) => a.title.en),
        containsAll([
          'Dev Deepawali on the Ghats of Varanasi',
          'Kumbh Mela: The Largest Gathering of Faith on Earth',
          'Ganesh Chaturthi: Ten Days of Bappa in Mumbai',
          'Navratri to Dashami: Durga Puja in Kolkata',
        ]),
      );
      expect(
        news.map((a) => a.title.en),
        containsAll([
          'Surya Tilak graces Ram Lalla as lakhs throng Ayodhya on Ram Navami',
          'Ujjain readies Mahakal Lok for the Shravan crowds',
          'Nehru Trophy boat race returns to Alappuzha as Onam festivities begin',
        ]),
      );
      // Nepal-only stories are not offered in India.
      expect(news.map((a) => a.id), isNot(contains('news-poll-code')));
    });

    test('Indian articles carry Hindi titles and bodies', () async {
      final kumbh = (await repo.getArticle('blog-kumbh-mela')).valueOrNull!;
      expect(kumbh.title.hi, 'कुंभ मेला: धरती पर आस्था का सबसे बड़ा समागम');
      expect(kumbh.title.forLanguage('hi'), kumbh.title.hi);
      expect(kumbh.title.forLanguage('en'), kumbh.title.en);
      // Nepali is not offered in India – falls back to the Hindi (Devanagari).
      expect(kumbh.title.ne, isNull);
      expect(kumbh.title.forLanguage('ne'), kumbh.title.hi);
      expect(kumbh.body.every((p) => p.hi != p.en), isTrue);
      expect(kumbh.category.label.hi, 'त्योहार');
      expect(kumbh.tags.map((t) => t.label.hi), ['कुंभ मेला']);
    });

    test('india seed selector and json round trip', () async {
      expect(articleSeedFor(RegionConfig.india), same(indiaArticleSeed));
      expect(articleSeedFor(RegionConfig.nepal), same(articleSeed));
      final article = (await repo.getArticle(
        'news-ayodhya-ram-navami',
      )).valueOrNull!;
      final model = ArticleModel.fromEntity(article);
      final json = model.toJson();
      expect((json['title'] as Map)['hi'], isNotNull);
      expect(ArticleModel.fromJson(json), equals(model));
    });

    test('unknown Nepal id is not found in India', () async {
      final result = await repo.getArticle('blog-holi');
      expect(result.failureOrNull, isA<NotFoundFailure>());
    });
  });

  test('data source re-reads the region on every call', () async {
    final resolver = _SwitchableResolver();
    final source = MockArticleDataSource(resolver);
    expect((await source.fetchArticles(ArticleType.blog)).length, 5);
    resolver.region = Region.india;
    expect((await source.fetchArticles(ArticleType.blog)).length, 4);
    // Likes are tracked per region for the session.
    await source.toggleLike('blog-kumbh-mela');
    resolver.region = Region.nepal;
    expect((await source.fetchArticle('blog-holi')).isLiked, isFalse);
    resolver.region = Region.india;
    expect((await source.fetchArticle('blog-kumbh-mela')).isLiked, isTrue);
  });
}
