import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/core/widgets/app_text_field.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/order.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/checkout_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/checkout_page.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;
  setUp(() async {
    stack = MarketplaceTestStack();
    await stack.cart.addItem(sampleProduct(id: 'a', price: 400));
  });

  testWidgets('fills the form, confirms and places the order', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      wrapPage(
        const CheckoutView(),
        theme: AppTheme.dark(),
        providers: [
          BlocProvider<CheckoutCubit>(
            create: (_) => stack.checkoutCubit()..load(),
          ),
        ],
      ),
    );
    await settle(tester);

    expect(find.text('Delivery & Payment'), findsOneWidget);
    expect(
      find.textContaining('First Name', findRichText: true),
      findsOneWidget,
    );

    Future<void> type(String label, String value) async {
      final field = find.ancestor(
        of: find.textContaining(label, findRichText: true),
        matching: find.byType(AppTextField),
      );
      await tester.scrollUntilVisible(
        field,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.enterText(
        find.descendant(of: field, matching: find.byType(TextFormField)),
        value,
      );
    }

    await type('First Name', 'Ram');
    await type('Last Name', 'Thapa');
    await type('Street address', 'New Road');
    await type('Town / City', 'Kathmandu');
    await type('Email address', 'ram@example.com');

    await tester.scrollUntilVisible(
      find.text('Cash on Delivery'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('Cash on Delivery'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cash on Delivery'));
    await tester.pump();
    await tester.scrollUntilVisible(
      find.byKey(const Key('confirm_address')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.byKey(const Key('confirm_address')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('confirm_address')));
    await tester.pump();

    await tester.scrollUntilVisible(
      find.text('Place Order'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('Place Order'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Place Order'));
    await settle(tester);

    expect(find.text('Your Order has been confirmed.'), findsOneWidget);
    expect(find.textContaining('#U'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('India region offers UPI / Card / Net banking / COD in ₹', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final india = MarketplaceTestStack(region: Region.india);
    await india.cart.addItem(sampleProduct(id: 'a', price: 400));
    final cubit = india.checkoutCubit();
    await tester.pumpWidget(
      wrapPage(
        const CheckoutView(),
        region: Region.india,
        providers: [BlocProvider<CheckoutCubit>(create: (_) => cubit..load())],
      ),
    );
    await settle(tester);

    await tester.scrollUntilVisible(
      find.text('UPI'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('UPI'), findsOneWidget);
    expect(find.text('Credit / Debit Card'), findsOneWidget);
    expect(find.text('Net Banking'), findsOneWidget);
    expect(find.text('Cash on Delivery'), findsOneWidget);
    expect(find.text('eSewa'), findsNothing);
    expect(find.text('Khalti'), findsNothing);
    expect(cubit.state.paymentMethod, PaymentMethod.upi);
    expect(find.textContaining('State', findRichText: true), findsWidgets);
    expect(find.textContaining('Province', findRichText: true), findsNothing);
    expect(find.text('Delhi'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Place Order'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('₹400.00'), findsWidgets);
    expect(find.textContaining('Rs.'), findsNothing);
    expect(find.textContaining('रु.'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('India + Hindi shows Hindi checkout labels', (tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final india = MarketplaceTestStack(region: Region.india);
    await india.cart.addItem(sampleProduct(id: 'a', price: 400));
    await tester.pumpWidget(
      wrapPage(
        const CheckoutView(),
        region: Region.india,
        locale: const Locale('hi'),
        providers: [
          BlocProvider<CheckoutCubit>(
            create: (_) => india.checkoutCubit()..load(),
          ),
        ],
      ),
    );
    await settle(tester);
    expect(find.text('डिलीवरी और भुगतान'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('भुगतान का तरीका'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('नेट बैंकिंग'), findsOneWidget);
    expect(find.text('कैश ऑन डिलीवरी'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.textContaining('₹४००.००'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('₹४००.००'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
