import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/ad_banner.dart';
import 'package:sanathan_nepal_mobile_app/features/content/content_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/content/content_routes.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/pages/article_details_page.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/pages/article_list_page.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/widgets/blog_card.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/widgets/news_card.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// Entry points → pages: `/blogs`, `/news` and `/content/:type/:id` resolve
/// through [contentRoutes], and list cards push the details route.
void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<RegionResolver>(
      const FixedRegionResolver(Region.nepal),
    );
    registerContentFeature(GetIt.I);
  });
  tearDownAll(() => GetIt.I.reset());

  Widget app(GoRouter router) => RegionScope(
    region: Region.nepal,
    child: MaterialApp.router(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    ),
  );

  GoRouter router(String initial) => GoRouter(
    initialLocation: initial,
    routes: [
      GoRoute(path: '/', builder: (_, _) => const Scaffold()),
      ...contentRoutes,
    ],
  );

  void setPhone(WidgetTester tester, {double width = 375}) {
    tester.view.physicalSize = Size(width, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  testWidgets('AppRoutes.blogs resolves to the blog list (dark theme)', (
    tester,
  ) async {
    setPhone(tester);
    await tester.pumpWidget(app(router(AppRoutes.blogs)));
    await tester.pumpAndSettle();
    expect(find.byType(ArticleListPage), findsOneWidget);
    expect(find.byType(BlogCard), findsWidgets);
    expect(find.byType(NewsCard), findsNothing);
    expect(find.byType(AdBanner), findsOneWidget);
    expect(find.text('BLOGS PAGE ADS'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('AppRoutes.news resolves to the news list', (tester) async {
    setPhone(tester);
    await tester.pumpWidget(app(router(AppRoutes.news)));
    await tester.pumpAndSettle();
    expect(find.byType(ArticleListPage), findsOneWidget);
    expect(find.byType(NewsCard), findsWidgets);
    expect(find.byType(BlogCard), findsNothing);
    expect(find.text('NEWS PAGE ADS'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping a blog card pushes AppRoutes.contentDetails', (
    tester,
  ) async {
    setPhone(tester);
    final r = router(AppRoutes.blogs);
    await tester.pumpWidget(app(r));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BlogCard).first);
    await tester.pumpAndSettle();
    expect(find.byType(ArticleDetailsPage), findsOneWidget);
    expect(
      r.routerDelegate.currentConfiguration.last.matchedLocation,
      startsWith('/content/blog/'),
    );
    expect(find.text('Share this post'), findsOneWidget);
  });

  testWidgets('deep link to an unknown article shows an error, no crash', (
    tester,
  ) async {
    setPhone(tester);
    await tester.pumpWidget(
      app(router(AppRoutes.contentDetailsPath('news', 'nope'))),
    );
    await tester.pumpAndSettle();
    expect(find.byType(ArticleDetailsPage), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('list + details lay out without overflow at 320px', (
    tester,
  ) async {
    setPhone(tester, width: 320);
    final r = router(AppRoutes.blogs);
    await tester.pumpWidget(app(r));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.byType(BlogCard).first);
    await tester.pumpAndSettle();
    expect(find.byType(ArticleDetailsPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
