import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/content/content_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/content/content_routes.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/entities/article.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/usecases/get_articles.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/cubit/article_list_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/pages/article_details_page.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/pages/article_list_page.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/widgets/blog_card.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/widgets/latest_articles_section.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

class _MockGetArticles extends Mock implements GetArticles {}

void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<RegionResolver>(
      const FixedRegionResolver(Region.india),
    );
    registerContentFeature(GetIt.I);
  });
  tearDownAll(() => GetIt.I.reset());

  /// Host page embedding the section (as Home would) inside a router so
  /// "See All" / card taps can navigate.
  Widget host(Widget section, {Locale locale = const Locale('en')}) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => Scaffold(body: ListView(children: [section])),
        ),
        ...contentRoutes,
      ],
    );
    return RegionScope(
      region: Region.india,
      child: MaterialApp.router(
        theme: AppTheme.light(),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
  }

  void setPhone(WidgetTester tester) {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  testWidgets('blog section caps items and "See All" opens the blog list', (
    tester,
  ) async {
    setPhone(tester);
    await tester.pumpWidget(
      host(const LatestArticlesSection(type: ArticleType.blog, maxItems: 2)),
    );
    await tester.pumpAndSettle();
    expect(find.text('Latest Blogs'), findsOneWidget);
    expect(find.byType(BlogCard), findsNWidgets(2));
    // Region-aware seed (India).
    expect(
      find.text('Kumbh Mela: The Largest Gathering of Faith on Earth'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('See All'));
    await tester.pumpAndSettle();
    expect(find.byType(ArticleListPage), findsOneWidget);
    expect(find.text('Blogs'), findsOneWidget);
  });

  testWidgets('news section (Hindi) uses onSeeAll and opens details on tap', (
    tester,
  ) async {
    setPhone(tester);
    var seeAllTaps = 0;
    await tester.pumpWidget(
      host(
        LatestArticlesSection(
          type: ArticleType.news,
          maxItems: 3,
          onSeeAll: () => seeAllTaps++,
        ),
        locale: const Locale('hi'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('ताज़ा ख़बरें'), findsOneWidget);
    // Horizontal strip – only the visible cards are built.
    expect(find.byType(BlogCard), findsWidgets);
    await tester.tap(find.text('सभी देखें'));
    await tester.pumpAndSettle();
    expect(seeAllTaps, 1);
    expect(find.byType(ArticleListPage), findsNothing);

    await tester.tap(find.byType(BlogCard).first);
    await tester.pumpAndSettle();
    expect(find.byType(ArticleDetailsPage), findsOneWidget);
    expect(
      GoRouter.of(
        tester.element(find.byType(ArticleDetailsPage)),
      ).routerDelegate.currentConfiguration.last.matchedLocation,
      startsWith(AppRoutes.contentDetailsPath('news', '')),
    );
  });

  testWidgets('failed load shows a compact retry inside the strip', (
    tester,
  ) async {
    setPhone(tester);
    final getArticles = _MockGetArticles();
    when(
      () => getArticles(ArticleType.blog),
    ).thenAnswer((_) async => const Result.failure(NetworkFailure()));
    GetIt.I.pushNewScope(
      init: (sl) =>
          sl.registerFactoryParam<ArticleListCubit, ArticleType, void>(
            (type, _) => ArticleListCubit(getArticles, type: type),
          ),
    );
    addTearDown(GetIt.I.popScope);

    await tester.pumpWidget(
      host(const LatestArticlesSection(type: ArticleType.blog)),
    );
    await tester.pumpAndSettle();
    expect(find.text('Latest Blogs'), findsOneWidget);
    expect(find.byType(BlogCard), findsNothing);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
