import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/session/app_session.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/boost_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/cart_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/marketplace_page.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;
  setUp(() => stack = MarketplaceTestStack());

  Widget build({
    Locale locale = const Locale('en'),
    ThemeData? theme,
    Region region = Region.nepal,
    AppSession session = merchantSession,
  }) => wrapPage(
    const MarketplaceView(),
    locale: locale,
    theme: theme,
    region: region,
    session: session,
    providers: [
      BlocProvider<MarketplaceCubit>(
        create: (_) => stack.marketplaceCubit()..load(),
      ),
      BlocProvider<BoostCubit>(create: (_) => stack.boostCubit()..load()),
      BlocProvider<CartCubit>(create: (_) => stack.cartCubit()..load()),
    ],
  );

  testWidgets('renders chips, tabs, boosted carousel and feed', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(build());
    await settle(tester);

    expect(find.text('Marketplace'), findsOneWidget);
    expect(find.text('Automobiles'), findsOneWidget);
    expect(find.text('Boosted Post'), findsOneWidget);
    expect(find.text('Toyota Rav4 2012'), findsWidgets);
    expect(find.text('Recent'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('SETTING TAB ADS'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('SETTING TAB ADS'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('switching to Boost tab shows the boost flow', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(build());
    await settle(tester);

    await tester.ensureVisible(find.text('Boost Post to sell quickly'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Boost Post to sell quickly'));
    await settle(tester);
    expect(find.text('BOOST ADS'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Next'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Select your Product/Service'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('My Products tab: Add Product button, owner menu and delete', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(build());
    await settle(tester);

    await tester.ensureVisible(find.text('My Products & Services'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My Products & Services'));
    await settle(tester);
    expect(find.text('Add Product'), findsOneWidget);
    expect(find.text('Pearl (मोती)'), findsWidgets);

    // Owner "more" menu on the first own card → Delete → confirm popup.
    await tester.tap(find.byIcon(Icons.more_horiz).first);
    await tester.pumpAndSettle();
    expect(find.text('Edit'), findsOneWidget);
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Delete this product?'), findsOneWidget);
    await tester.tap(find.text('Delete').last);
    await settle(tester);
    expect(find.text('Product deleted'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders in Nepali + dark theme with Devanagari digits', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      build(locale: const Locale('ne'), theme: AppTheme.dark()),
    );
    await settle(tester);
    expect(find.text('बजार'), findsOneWidget);
    expect(find.textContaining('रु. ४०,००,०००'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('India region renders the India seed in ₹ (English + Hindi)', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    stack = MarketplaceTestStack(region: Region.india);
    await tester.pumpWidget(build(region: Region.india));
    await settle(tester);
    expect(find.text('Maruti Suzuki Swift VXi 2019'), findsWidgets);
    expect(find.text('Toyota Rav4 2012'), findsNothing);
    expect(find.textContaining('₹5,25,000'), findsWidgets);
    expect(find.textContaining('रु.'), findsNothing);
    expect(tester.takeException(), isNull);

    stack = MarketplaceTestStack(region: Region.india);
    await tester.pumpWidget(
      build(region: Region.india, locale: const Locale('hi')),
    );
    await settle(tester);
    expect(find.text('बाज़ार'), findsOneWidget);
    expect(find.text('वाहन'), findsOneWidget);
    expect(find.textContaining('₹५,२५,०००'), findsWidgets);
    expect(find.textContaining('मारुति सुज़ुकी स्विफ्ट'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
