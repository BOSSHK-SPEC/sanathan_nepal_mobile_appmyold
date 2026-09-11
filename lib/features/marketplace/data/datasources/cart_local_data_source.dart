import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/product.dart';
import '../models/cart_model.dart';
import 'cart_data_source.dart';

/// An on-device cart, for demo mode and for running with no server.
///
/// It owns the rules the server would otherwise apply — flat delivery, the
/// demo coupon table, keeping a percentage discount in step with the subtotal.
/// Those live here rather than in the repository because they exist only to
/// stand in for a server: against a real one the server decides all three, and
/// a repository holding a second opinion would quietly contradict it.
class CartLocalDataSource implements CartDataSource {
  CartLocalDataSource(this._store);

  final KeyValueStore _store;

  /// Read-through cache so the cart survives repeated reads without touching
  /// storage; writes keep it in step.
  CartModel? _cache;

  static const String storageKey = 'marketplace.cart';

  /// Flat delivery charge applied to a non-empty cart.
  static const double defaultShipping = 100;

  /// Demo codes → discount. A value under 1 is a fraction of the subtotal.
  static const Map<String, double> coupons = {'SANATAN10': 0.10, 'PUJA50': 50};

  @override
  Future<CartModel> read() async => _read();

  @override
  Future<CartModel> addItem(
    Product product, {
    int quantity = 1,
    Map<String, String> selectedOptions = const {},
  }) => _mutate((cart) {
    final items = [...cart.items];
    final index = items.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + quantity,
        selectedOptions: selectedOptions.isEmpty
            ? items[index].selectedOptions
            : selectedOptions,
      );
    } else {
      items.add(
        CartItem(
          product: product,
          quantity: quantity,
          selectedOptions: selectedOptions,
        ),
      );
    }
    return cart.copyWith(items: items, shippingCost: defaultShipping);
  });

  @override
  Future<CartModel> setQuantity(String productId, int quantity) =>
      _mutate((cart) {
        final items = [
          for (final i in cart.items)
            if (i.product.id == productId)
              (quantity > 0 ? i.copyWith(quantity: quantity) : null)
            else
              i,
        ].whereType<CartItem>().toList();
        return cart.copyWith(items: items);
      });

  @override
  Future<CartModel> removeItem(String productId) => _mutate(
    (cart) => cart.copyWith(
      items: cart.items.where((i) => i.product.id != productId).toList(),
    ),
  );

  @override
  Future<CartModel> applyCoupon(String code) => _mutate((cart) {
    final key = code.trim().toUpperCase();
    final value = coupons[key];
    if (value == null) return cart.copyWith(couponCode: null, discount: 0);
    final discount = value < 1 ? cart.subtotal * value : value;
    return cart.copyWith(couponCode: key, discount: discount);
  });

  @override
  Future<CartModel> clear() => _mutate((_) => Cart.empty);

  CartModel _read() {
    if (_cache != null) return _cache!;
    final raw = _store.getString(storageKey);
    if (raw == null || raw.isEmpty) return _cache = const CartModel();
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return _cache = CartModel.fromJson(json);
    } on FormatException {
      throw const CacheException('Corrupt cart data');
    } on TypeError {
      throw const CacheException('Corrupt cart data');
    }
  }

  Future<CartModel> _mutate(Cart Function(Cart current) change) async {
    final next = _recompute(change(_read().toEntity()));
    final model = CartModel.fromEntity(next);
    _cache = model;
    final ok = await _store.setString(storageKey, jsonEncode(model.toJson()));
    if (!ok) throw const CacheException('Could not save cart');
    return model;
  }

  /// Keeps a percentage coupon in step with a subtotal that has since changed.
  Cart _recompute(Cart cart) {
    final code = cart.couponCode;
    if (code == null) return cart;
    final value = coupons[code];
    if (value == null) return cart.copyWith(couponCode: null, discount: 0);
    return cart.copyWith(discount: value < 1 ? cart.subtotal * value : value);
  }
}
