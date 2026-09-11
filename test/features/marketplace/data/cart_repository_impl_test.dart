import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/cart_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/cart_repository_impl.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CartRepositoryImpl', () {
    test('persists items as JSON and reloads them from the store', () async {
      final store = InMemoryKeyValueStore();
      final repo = CartRepositoryImpl(CartLocalDataSource(store));

      await repo.addItem(sampleProduct(id: 'a', price: 100), quantity: 2);
      await repo.addItem(
        sampleProduct(id: 'b', price: 250),
        selectedOptions: const {'Size': 'M'},
      );
      expect(
        store.getString(CartLocalDataSource.storageKey),
        contains('"a"'),
      );

      // Fresh repository over the same store → data survives.
      final reloaded = await CartRepositoryImpl(
        CartLocalDataSource(store),
      ).getCart();
      final cart = reloaded.valueOrNull!;
      expect(cart.items.length, 2);
      expect(cart.items.first.quantity, 2);
      expect(cart.items.last.selectedOptions, {'Size': 'M'});
      expect(cart.subtotal, 450);
      expect(cart.shippingCost, CartLocalDataSource.defaultShipping);
    });

    test(
      'percentage coupon tracks the subtotal, clear empties everything',
      () async {
        final repo = CartRepositoryImpl(
          CartLocalDataSource(InMemoryKeyValueStore()),
        );
        await repo.addItem(sampleProduct(id: 'a', price: 1000));
        var cart = (await repo.applyCoupon('sanatan10')).valueOrNull!;
        expect(cart.discount, 100);
        cart = (await repo.updateQuantity('a', 3)).valueOrNull!;
        expect(cart.discount, 300);
        cart = (await repo.updateQuantity('a', 0)).valueOrNull!;
        expect(cart.isEmpty, isTrue);
        cart = (await repo.clear()).valueOrNull!;
        expect(cart.couponCode, isNull);
      },
    );
  });
}
