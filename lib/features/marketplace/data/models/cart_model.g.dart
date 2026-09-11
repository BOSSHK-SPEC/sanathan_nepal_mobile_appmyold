// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    _CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      selectedOptions:
          (json['selected_options'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$CartItemModelToJson(_CartItemModel instance) =>
    <String, dynamic>{
      'product': instance.product.toJson(),
      'quantity': instance.quantity,
      'selected_options': instance.selectedOptions,
    };

_CartModel _$CartModelFromJson(Map<String, dynamic> json) => _CartModel(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  couponCode: json['coupon_code'] as String?,
  discount: (json['discount'] as num?)?.toDouble() ?? 0,
  shippingCost: (json['shipping_cost'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$CartModelToJson(_CartModel instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'coupon_code': ?instance.couponCode,
      'discount': instance.discount,
      'shipping_cost': instance.shippingCost,
    };
