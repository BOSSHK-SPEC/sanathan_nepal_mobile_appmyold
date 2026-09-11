import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/cart.dart';
import 'product_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

/// Persistence shape of [CartItem].
@freezed
abstract class CartItemModel with _$CartItemModel {
  const CartItemModel._();

  const factory CartItemModel({
    required ProductModel product,
    @Default(1) int quantity,
    @Default({}) Map<String, String> selectedOptions,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  factory CartItemModel.fromEntity(CartItem i) => CartItemModel(
    product: ProductModel.fromEntity(i.product),
    quantity: i.quantity,
    selectedOptions: i.selectedOptions,
  );

  CartItem toEntity() => CartItem(
    product: product.toEntity(),
    quantity: quantity,
    selectedOptions: selectedOptions,
  );
}

/// Persistence shape of [Cart].
@freezed
abstract class CartModel with _$CartModel {
  const CartModel._();

  const factory CartModel({
    @Default([]) List<CartItemModel> items,
    String? couponCode,
    @Default(0) double discount,
    @Default(0) double shippingCost,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  factory CartModel.fromEntity(Cart c) => CartModel(
    items: c.items.map(CartItemModel.fromEntity).toList(),
    couponCode: c.couponCode,
    discount: c.discount,
    shippingCost: c.shippingCost,
  );

  Cart toEntity() => Cart(
    items: items.map((i) => i.toEntity()).toList(),
    couponCode: couponCode,
    discount: discount,
    shippingCost: shippingCost,
  );
}
