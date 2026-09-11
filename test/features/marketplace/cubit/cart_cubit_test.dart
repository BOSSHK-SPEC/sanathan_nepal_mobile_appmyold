import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/cart.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/cart_cubit.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;
  setUp(() => stack = MarketplaceTestStack());

  group('CartCubit', () {
    blocTest<CartCubit, CartState>(
      'load on an empty store yields an empty cart',
      build: () => stack.cartCubit(),
      act: (c) => c.load(),
      expect: () => const [
        CartState(cart: LoadState.loading()),
        CartState(cart: LoadState.loaded(Cart.empty)),
      ],
    );

    blocTest<CartCubit, CartState>(
      'add / increment / decrement / remove keep totals in sync',
      build: () => stack.cartCubit(),
      act: (c) async {
        await c.load();
        await c.add(sampleProduct(id: 'a', price: 100));
        await c.add(sampleProduct(id: 'b', price: 50));
        await c.increment('a');
        await c.decrement('b');
        await c.remove('b');
      },
      verify: (c) {
        final cart = c.state.cart.dataOrNull!;
        expect(cart.items.length, 1);
        expect(cart.items.single.quantity, 2);
        expect(cart.subtotal, 200);
        expect(cart.total, 200 + 100); // + default shipping
      },
    );

    blocTest<CartCubit, CartState>(
      'applyCoupon marks invalid codes and applies valid ones',
      build: () => stack.cartCubit(),
      act: (c) async {
        await c.load();
        await c.add(sampleProduct(id: 'a', price: 1000));
        c.couponChanged('NOPE');
        await c.applyCoupon();
        c.couponChanged('sanatan10');
        await c.applyCoupon();
      },
      verify: (c) {
        expect(c.state.couponInvalid, isFalse);
        expect(c.state.cart.dataOrNull?.couponCode, 'SANATAN10');
        expect(c.state.cart.dataOrNull?.discount, 100);
      },
    );

    blocTest<CartCubit, CartState>(
      'invalid coupon sets couponInvalid',
      build: () => stack.cartCubit(),
      act: (c) async {
        await c.load();
        c.couponChanged('BAD');
        await c.applyCoupon();
      },
      verify: (c) => expect(c.state.couponInvalid, isTrue),
    );
  });
}
