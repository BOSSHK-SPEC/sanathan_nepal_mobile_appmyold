import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sanathan_nepal_mobile_app/app/router/app_routes.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/marketplace_injection.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/marketplace_routes.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/product_details_page.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/product_form_page.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/widgets/product_grid_card.dart';
import 'package:sanathan_nepal_mobile_app/l10n/generated/app_localizations.dart';

/// End-to-end route wiring: the marketplace tab pushes
/// `/marketplace/product/:id`, `/marketplace/product/new` opens the seller
/// form (never the details page) and `/…/:id/edit` opens edit mode.
void main() {
  setUpAll(() {
    GetIt.I
      ..registerSingleton<RegionResolver>(
        const FixedRegionResolver(Region.nepal),
      )
      ..registerSingleton<KeyValueStore>(InMemoryKeyValueStore());
    registerMarketplaceFeature(GetIt.I);
  });
  tearDownAll(() => GetIt.I.reset());

  Widget app(GoRouter router, {ThemeMode mode = ThemeMode.light}) =>
      RegionScope(
        region: Region.nepal,
        child: MaterialApp.router(
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: mode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      );

  GoRouter router(String initial) => GoRouter(
    initialLocation: initial,
    routes: [marketplaceTabRoute, ...marketplaceRoutes],
  );

  void setPhone(WidgetTester tester) {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  Future<void> settle(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();
  }

  testWidgets('tapping a marketplace card opens ProductDetailsPage', (
    tester,
  ) async {
    setPhone(tester);
    await tester.pumpWidget(app(router(AppRoutes.marketplace)));
    await settle(tester);

    final card = find.byType(ProductGridCard).first;
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    final title = (tester.widget<ProductGridCard>(card)).product.title;
    await tester.tap(card);
    await tester.pumpAndSettle();
    await settle(tester);

    expect(find.byType(ProductDetailsPage), findsOneWidget);
    expect(find.text(title), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('/marketplace/product/new opens the form, not the details', (
    tester,
  ) async {
    setPhone(tester);
    await tester.pumpWidget(
      app(router(AppRoutes.productCreate), mode: ThemeMode.dark),
    );
    await settle(tester);
    expect(find.byType(ProductFormPage), findsOneWidget);
    expect(find.byType(ProductDetailsPage), findsNothing);
    expect(find.text('Add Product'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('/marketplace/product/:id/edit opens edit mode', (tester) async {
    setPhone(tester);
    await tester.pumpWidget(app(router(AppRoutes.productEditPath('p4'))));
    await settle(tester);
    expect(find.byType(ProductFormPage), findsOneWidget);
    expect(find.text('Edit Product'), findsOneWidget);
    expect(find.text('Pearl (मोती)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('details of a missing product shows not-found, no crash', (
    tester,
  ) async {
    setPhone(tester);
    await tester.pumpWidget(app(router(AppRoutes.productDetailsPath('nope'))));
    await settle(tester);
    expect(find.text('This product is no longer available.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
