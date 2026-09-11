import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/cart_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_details_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/product_details_page.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/widgets/product_hero.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;
  setUp(() {
    stack = MarketplaceTestStack();
    // The details body resolves its reviews block through the locator.
    stack.installReviewLocator();
  });
  tearDown(GetIt.instance.reset);

  Widget build(
    String id, {
    ThemeData? theme,
    Locale locale = const Locale('en'),
    Region region = Region.nepal,
    MarketplaceTestStack? withStack,
  }) {
    final s = withStack ?? stack;
    s.installReviewLocator();
    return wrapPage(
      const ProductDetailsView(),
      theme: theme,
      locale: locale,
      region: region,
      providers: [
        BlocProvider<ProductDetailsCubit>(
          create: (_) => s.detailsCubit()..load(id),
        ),
        BlocProvider<CartCubit>(create: (_) => s.cartCubit()..load()),
      ],
    );
  }

  void setPhone(WidgetTester tester, {double width = 375}) {
    tester.view.physicalSize = Size(width, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  testWidgets('light / Nepali: hero, title + price row, options, long '
      'description and General card (own listing shows Edit)', (tester) async {
    setPhone(tester);
    await tester.pumpWidget(build('p4', locale: const Locale('ne')));
    await settle(tester);

    expect(find.byType(ProductHero), findsOneWidget);
    expect(find.text('मोती (Pearl)'), findsOneWidget);
    expect(find.text('रु. १५,०००.००'), findsOneWidget);
    expect(find.text('Dr. Uttam Upadhyaya'), findsWidgets);
    // Own listing → Edit in the bottom bar, no square buy buttons.
    expect(find.text('सम्पादन'), findsOneWidget);
    expect(find.text('कार्टमा थप्नुहोस्'), findsNothing);
    expect(tester.takeException(), isNull);

    final scrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('Caret : ५'),
      200,
      scrollable: scrollable,
    );
    await tester.ensureVisible(find.text('७').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('७').first);
    await tester.pump();
    expect(find.text('Caret : ७'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('मोती कसले धारण गर्ने ?'),
      300,
      scrollable: scrollable,
    );
    expect(find.text('मोती कसले धारण गर्ने ?'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('सामान्य'),
      300,
      scrollable: scrollable,
    );
    expect(find.text('सामान्य'), findsOneWidget);
    // Scrolling brought the reviews block into view; let its fetch finish
    // so no timer is left pending at teardown.
    await settle(tester);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dark / English: comments tab, Add to Cart, Buy Now, videos', (
    tester,
  ) async {
    setPhone(tester);
    await tester.pumpWidget(build('p3', theme: AppTheme.dark()));
    await settle(tester);

    expect(find.textContaining('| Used'), findsOneWidget);
    final scrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('Comments'),
      200,
      scrollable: scrollable,
    );
    await tester.ensureVisible(find.text('Comments'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Comments'));
    await tester.pump();
    expect(find.text('I want to purchase this product.'), findsOneWidget);
    expect(find.text('Comment...'), findsOneWidget);

    await tester.ensureVisible(find.text('Description'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Description'));
    await tester.pump();
    await tester.scrollUntilVisible(
      find.text('Buy Now'),
      200,
      scrollable: scrollable,
    );
    expect(find.text('Buy Now'), findsOneWidget);
    await tester.ensureVisible(find.text('Add to Cart').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to Cart').first);
    await settle(tester);
    expect(find.text('Added to cart'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('India region prices in ₹', (tester) async {
    setPhone(tester);
    final india = MarketplaceTestStack(region: Region.india);
    await tester.pumpWidget(
      build('ip4', region: Region.india, withStack: india),
    );
    await settle(tester);
    expect(find.textContaining('₹'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('pearl listing renders the Product Videos card', (tester) async {
    setPhone(tester);
    await tester.pumpWidget(build('p4'));
    await settle(tester);
    await tester.scrollUntilVisible(
      find.text('Product Videos'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Product Videos'), findsOneWidget);
    await settle(tester);
    expect(tester.takeException(), isNull);
  });

  testWidgets('unknown id shows the not-found state instead of crashing', (
    tester,
  ) async {
    setPhone(tester, width: 320);
    await tester.pumpWidget(build('does-not-exist'));
    await settle(tester);
    expect(find.text('This product is no longer available.'), findsOneWidget);
    expect(find.text('Back to Marketplace'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
