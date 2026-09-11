import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/cart_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_listing_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/saved_products_page.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;

  setUp(() {
    stack = MarketplaceTestStack();
  });

  Future<void> pumpSaved(WidgetTester tester, ProductListingCubit cubit) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      wrapPage(
        const SavedProductsView(),
        providers: [
          BlocProvider<ProductListingCubit>(create: (_) => cubit),
          BlocProvider<CartCubit>(create: (_) => stack.cartCubit()..load()),
        ],
      ),
    );
    await settle(tester);
  }

  testWidgets('invites the buyer to browse when nothing is saved', (
    tester,
  ) async {
    await pumpSaved(tester, stack.listingCubit()..load(favouritesOnly: true));

    expect(find.text('Nothing saved yet'), findsOneWidget);
    expect(find.text('Browse the marketplace'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('lists what has been saved, with a count', (tester) async {
    // runAsync so the repository's own delays actually elapse — inside the
    // fake-async zone a Future.delayed would never complete.
    await tester.runAsync(() => saveFirstUnsaved(stack));

    await pumpSaved(tester, stack.listingCubit()..load(favouritesOnly: true));

    expect(find.text('1 saved'), findsOneWidget);
    expect(find.text('Nothing saved yet'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('un-hearting a card takes it off the list', (tester) async {
    final target = (await tester.runAsync(() => saveFirstUnsaved(stack)))!;
    final cubit = stack.listingCubit()..load(favouritesOnly: true);
    await pumpSaved(tester, cubit);
    expect(find.text('1 saved'), findsOneWidget);

    // Driven through the cubit in the real-async zone: awaiting it inside
    // the fake zone would hang on the data source's own delay.
    await tester.runAsync(() => cubit.toggleFavourite(target));
    await settle(tester);

    expect(find.text('Nothing saved yet'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

/// Saves the first not-yet-saved listing and returns its id.
Future<String> saveFirstUnsaved(MarketplaceTestStack stack) async {
  final all = await stack.products.getProducts(const ProductFilter());
  final target = all.valueOrNull!.firstWhere((p) => !p.isFavourite);
  await stack.products.toggleFavourite(target.id);
  return target.id;
}
