import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/events/data_changes.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/order.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/checkout_cubit.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;
  const address = ShippingAddress(
    firstName: 'Ram',
    lastName: 'Thapa',
    country: 'Nepal',
    street: 'New Road',
    city: 'Kathmandu',
    province: 'Bagmati',
    email: 'ram@example.com',
  );

  setUp(() async {
    stack = MarketplaceTestStack();
    await stack.cart.addItem(sampleProduct(id: 'a', price: 400));
  });

  group('CheckoutCubit', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'load reads the cart',
      build: () => stack.checkoutCubit(),
      act: (c) => c.load(),
      verify: (c) {
        expect(c.state.cart.isLoaded, isTrue);
        expect(c.state.cart.dataOrNull?.subtotal, 400);
      },
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'placeOrder is ignored until the address is confirmed',
      build: () => stack.checkoutCubit(),
      act: (c) async {
        await c.load();
        await c.placeOrder(address: address);
      },
      verify: (c) => expect(c.state.order.isIdle, isTrue),
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'placeOrder succeeds, clears the cart and keeps the payment method',
      build: () => stack.checkoutCubit(),
      act: (c) async {
        await c.load();
        c.setPaymentMethod(PaymentMethod.cashOnDelivery);
        c.toggleAddressConfirmed(true);
        await c.placeOrder(address: address, notes: 'ring bell');
      },
      wait: const Duration(milliseconds: 600),
      verify: (c) async {
        expect(c.state.order.isLoaded, isTrue);
        final order = c.state.order.dataOrNull;
        expect(order?.total, 500);
        expect(order?.paymentMethod, PaymentMethod.cashOnDelivery);
        expect(order?.status, 'pending');
        expect(c.state.cart.dataOrNull?.isEmpty, isTrue);
        expect((await stack.cart.getCart()).valueOrNull!.isEmpty, isTrue);
      },
    );

    group('tells the order lists', () {
      // Profile › Activities stays alive in the bottom bar and loaded before
      // this order existed; without the signal the order never appeared there.
      late DataChanges changes;
      late List<DataTopic> announced;
      setUp(() {
        changes = DataChanges();
        announced = [];
        changes.stream.listen(announced.add);
      });
      tearDown(() => changes.dispose());

      blocTest<CheckoutCubit, CheckoutState>(
        'when an order is placed',
        build: () => stack.checkoutCubit(changes: changes),
        act: (c) async {
          await c.load();
          c.toggleAddressConfirmed(true);
          await c.placeOrder(address: address);
        },
        wait: const Duration(milliseconds: 600),
        verify: (c) {
          expect(c.state.order.isLoaded, isTrue);
          expect(announced, [DataTopic.orders]);
        },
      );

      blocTest<CheckoutCubit, CheckoutState>(
        'and says nothing when no order was placed',
        build: () => stack.checkoutCubit(changes: changes),
        act: (c) async {
          await c.load();
          // Address not confirmed: the order is never sent.
          await c.placeOrder(address: address);
        },
        verify: (c) {
          expect(c.state.order.isIdle, isTrue);
          expect(announced, isEmpty);
        },
      );
    });
  });
}
