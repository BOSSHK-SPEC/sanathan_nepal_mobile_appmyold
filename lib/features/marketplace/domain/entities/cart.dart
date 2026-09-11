import 'package:freezed_annotation/freezed_annotation.dart';

import 'product.dart';

part 'cart.freezed.dart';

/// One line in the shopping cart.
@freezed
abstract class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required Product product,
    @Default(1) int quantity,

    /// Chosen values for [Product.options] (e.g. `{'Select Metal': 'Silver'}`).
    @Default({}) Map<String, String> selectedOptions,
  }) = _CartItem;

  double get lineTotal => product.price * quantity;
}

/// Shopping cart aggregate with derived totals.
///
/// Clear a coupon with `copyWith(couponCode: null, discount: 0)`.
@freezed
abstract class Cart with _$Cart {
  const Cart._();

  const factory Cart({
    @Default([]) List<CartItem> items,
    String? couponCode,
    @Default(0) double discount,
    @Default(0) double shippingCost,
  }) = _Cart;

  static const Cart empty = Cart();

  bool get isEmpty => items.isEmpty;
  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);
  double get subtotal => items.fold(0, (sum, i) => sum + i.lineTotal);
  double get total => (subtotal - discount + (items.isEmpty ? 0 : shippingCost))
      .clamp(0, double.infinity);
}
