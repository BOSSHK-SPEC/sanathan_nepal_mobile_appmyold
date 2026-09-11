import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_scope.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/state_widgets.dart';
import 'package:sanathan_nepal_mobile_app/features/content/content_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/entities/article.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/pages/article_details_page.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/pages/article_list_page.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/widgets/article_tag_chip.dart';
import 'package:sanathan_nepal_mobile_app/features/content/presentation/widgets/blog_card.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// Region resolver shared with the DI container; flipped per test.
class _TestRegionResolver implements RegionResolver {
  @override
  Region region = Region.nepal;
  @override
  RegionConfig get config => region.config;
}

void main() {
  final resolver = _TestRegionResolver();

  setUpAll(() {
    GetIt.I.registerSingleton<RegionResolver>(resolver);
    registerContentFeature(GetIt.I);
  });
  tearDownAll(() => GetIt.I.reset());
  setUp(() => resolver.region = Region.nepal);

  Widget app(
    Widget home, {
    Locale locale = const Locale('en'),
    Region region = Region.nepal,
  }) {
    resolver.region = region;
    return RegionScope(
      region: region,
      child: MaterialApp(
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
      ),
    );
  }

  void setPhone(WidgetTester tester) {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  testWidgets('blogs list renders grid cards and filters', (tester) async {
    setPhone(tester);
    await tester.pumpWidget(app(const ArticleListPage(type: ArticleType.blog)));
    await tester.pumpAndSettle();
    expect(find.text('Blogs'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Akshaya Tritiya'), findsOneWidget);
    // Switch to Tags tab: tags render as chips ("All" + seed tags).
    await tester.tap(find.text('Tags'));
    await tester.pumpAndSettle();
    expect(find.byType(ArticleTagChip), findsWidgets);
    expect(find.text('All'), findsOneWidget);
    await tester.tap(find.text('Holi'));
    await tester.pumpAndSettle();
    expect(find.text('Fagu Purnima (Holi)'), findsOneWidget);
    expect(find.text('Akshaya Tritiya'), findsNothing);
    // Back to "All" restores the grid.
    await tester.tap(find.text('All'));
    await tester.pumpAndSettle();
    expect(find.text('Akshaya Tritiya'), findsOneWidget);
  });

  testWidgets('category + tag with no match shows the empty state', (
    tester,
  ) async {
    setPhone(tester);
    await tester.pumpWidget(app(const ArticleListPage(type: ArticleType.blog)));
    await tester.pumpAndSettle();
    // "Sapana ko Fal" category has no "Holi"-tagged post.
    // (first match = the filter radio; the card chip carries the same text)
    await tester.tap(find.text('Sapana ko Fal').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tags'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Holi'));
    await tester.pumpAndSettle();
    expect(find.byType(EmptyView), findsOneWidget);
    expect(find.text('No posts found for this filter.'), findsOneWidget);
    expect(find.byType(BlogCard), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('news list renders in Nepali with Devanagari date', (
    tester,
  ) async {
    setPhone(tester);
    await tester.pumpWidget(
      app(
        const ArticleListPage(type: ArticleType.news),
        locale: const Locale('ne'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('समाचार'), findsOneWidget);
    expect(find.textContaining('२०८०'), findsWidgets);
  });

  testWidgets('list language filter offers the region languages (Nepal)', (
    tester,
  ) async {
    setPhone(tester);
    await tester.pumpWidget(app(const ArticleListPage(type: ArticleType.blog)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    expect(find.text('नेपाली'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('हिन्दी'), findsNothing);
  });

  testWidgets('details page shows body, tags and recent posts', (tester) async {
    setPhone(tester);
    await tester.pumpWidget(
      app(
        const ArticleDetailsPage(
          type: ArticleType.blog,
          id: 'blog-akshaya-tritiya',
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Akshaya Tritiya'), findsOneWidget);
    expect(find.text('Share this post'), findsOneWidget);
    // Toggle shows the Nepal languages and switches content to Nepali.
    expect(find.text('नेपाली'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('हिन्दी'), findsNothing);
    await tester.tap(find.text('नेपाली'));
    await tester.pumpAndSettle();
    expect(find.text('अक्षय तृतीया'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Recent Posts'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Recent Posts'), findsOneWidget);
  });

  group('India region', () {
    testWidgets('blogs list shows Indian articles with Gregorian dates', (
      tester,
    ) async {
      setPhone(tester);
      await tester.pumpWidget(
        app(
          const ArticleListPage(type: ArticleType.blog),
          region: Region.india,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Blogs'), findsOneWidget);
      expect(
        find.text('Kumbh Mela: The Largest Gathering of Faith on Earth'),
        findsOneWidget,
      );
      expect(find.text('Akshaya Tritiya'), findsNothing);
      expect(find.text('January 10, 2025'), findsOneWidget);
      // Language filter offers English | हिन्दी.
      await tester.tap(find.text('Language'));
      await tester.pumpAndSettle();
      expect(find.text('हिन्दी'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
      expect(find.text('नेपाली'), findsNothing);
    });

    testWidgets('details toggle shows हिन्दी/English and switches body', (
      tester,
    ) async {
      setPhone(tester);
      await tester.pumpWidget(
        app(
          const ArticleDetailsPage(
            type: ArticleType.blog,
            id: 'blog-kumbh-mela',
          ),
          region: Region.india,
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Kumbh Mela: The Largest Gathering of Faith on Earth'),
        findsOneWidget,
      );
      expect(find.text('हिन्दी'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
      expect(find.text('नेपाली'), findsNothing);
      await tester.tap(find.text('हिन्दी'));
      await tester.pumpAndSettle();
      expect(
        find.text('कुंभ मेला: धरती पर आस्था का सबसे बड़ा समागम'),
        findsOneWidget,
      );
      // Saka date with Devanagari digits (10 Jan 2025 = Pausha 20, 1946).
      expect(find.textContaining('पौष २०, १९४६'), findsOneWidget);
    });

    testWidgets('news list renders in Hindi locale', (tester) async {
      setPhone(tester);
      await tester.pumpWidget(
        app(
          const ArticleListPage(type: ArticleType.news),
          locale: const Locale('hi'),
          region: Region.india,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('समाचार'), findsOneWidget);
      expect(find.text('श्रेणियाँ'), findsOneWidget);
      expect(
        find.text('श्रावण की भीड़ के लिए उज्जैन में महाकाल लोक तैयार'),
        findsOneWidget,
      );
      // Saka year in Devanagari for 2024 news.
      expect(find.textContaining('१९४६'), findsWidgets);
    });
  });
}
