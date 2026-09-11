import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
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
  });
}
