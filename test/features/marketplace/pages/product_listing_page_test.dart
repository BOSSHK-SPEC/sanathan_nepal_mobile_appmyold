import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/cart_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_listing_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/product_listing_page.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;
  setUp(() => stack = MarketplaceTestStack());

  testWidgets('shows category title, count and product cards', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      wrapPage(
        const ProductListingView(),
        providers: [
          BlocProvider<ProductListingCubit>(
            create: (_) => stack.listingCubit()..load(categoryId: 'gemstones'),
          ),
          BlocProvider<CartCubit>(create: (_) => stack.cartCubit()..load()),
        ],
      ),
    );
    await settle(tester);

    expect(find.text('GEM STONES'), findsOneWidget);
    expect(find.text('3 products found'), findsOneWidget);
    expect(find.text('Pearl (मोती)'), findsOneWidget);
    expect(find.text('Sort by :'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
