import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/cart_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/cart_page.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;
  setUp(() async {
    stack = MarketplaceTestStack();
    await stack.cart.addItem(sampleProduct(id: 'a', price: 150), quantity: 2);
  });

  testWidgets('lists items, totals and quantity controls', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      wrapPage(
        const CartView(),
        providers: [
          BlocProvider<CartCubit>(create: (_) => stack.cartCubit()..load()),
        ],
      ),
    );
    await settle(tester);

    expect(find.text('Shopping Cart'), findsWidgets);
    expect(find.text('Sample a'), findsOneWidget);
    expect(find.text('Rs. 300.00'), findsOneWidget); // subtotal
    expect(find.text('Checkout'), findsWidgets);

    await tester.tap(find.byIcon(Icons.add));
    await settle(tester);
    expect(find.text('Rs. 450.00'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows empty state', (tester) async {
    await stack.cart.clear();
    await tester.pumpWidget(
      wrapPage(
        const CartView(),
        providers: [
          BlocProvider<CartCubit>(create: (_) => stack.cartCubit()..load()),
        ],
      ),
    );
    await settle(tester);
    expect(find.text('Your cart is empty.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
