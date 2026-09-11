// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderSummary {

 String get id; String get productName;/// Order price in the region currency (NPR / INR).
 double get price;/// Seller name for purchases, buyer name for sales.
 String get counterpartyName;/// Business/user id of the counterparty (used by "Visit Seller Profile").
 String get counterpartyId; OrderRole get role; OrderStatus get status; DateTime get updatedAt;/// Seller's listed price (S.P) shown on sales cards.
 double? get sellingPrice;/// Buyer rating (1–5) once the purchase is completed.
 int? get rating; String? get imageUrl;
/// Create a copy of OrderSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderSummaryCopyWith<OrderSummary> get copyWith => _$OrderSummaryCopyWithImpl<OrderSummary>(this as OrderSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.price, price) || other.price == price)&&(identical(other.counterpartyName, counterpartyName) || other.counterpartyName == counterpartyName)&&(identical(other.counterpartyId, counterpartyId) || other.counterpartyId == counterpartyId)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.sellingPrice, sellingPrice) || other.sellingPrice == sellingPrice)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,productName,price,counterpartyName,counterpartyId,role,status,updatedAt,sellingPrice,rating,imageUrl);

@override
String toString() {
  return 'OrderSummary(id: $id, productName: $productName, price: $price, counterpartyName: $counterpartyName, counterpartyId: $counterpartyId, role: $role, status: $status, updatedAt: $updatedAt, sellingPrice: $sellingPrice, rating: $rating, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $OrderSummaryCopyWith<$Res>  {
  factory $OrderSummaryCopyWith(OrderSummary value, $Res Function(OrderSummary) _then) = _$OrderSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String productName, double price, String counterpartyName, String counterpartyId, OrderRole role, OrderStatus status, DateTime updatedAt, double? sellingPrice, int? rating, String? imageUrl
});




}
/// @nodoc
class _$OrderSummaryCopyWithImpl<$Res>
    implements $OrderSummaryCopyWith<$Res> {
  _$OrderSummaryCopyWithImpl(this._self, this._then);

  final OrderSummary _self;
  final $Res Function(OrderSummary) _then;

/// Create a copy of OrderSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productName = null,Object? price = null,Object? counterpartyName = null,Object? counterpartyId = null,Object? role = null,Object? status = null,Object? updatedAt = null,Object? sellingPrice = freezed,Object? rating = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,counterpartyName: null == counterpartyName ? _self.counterpartyName : counterpartyName // ignore: cast_nullable_to_non_nullable
as String,counterpartyId: null == counterpartyId ? _self.counterpartyId : counterpartyId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as OrderRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sellingPrice: freezed == sellingPrice ? _self.sellingPrice : sellingPrice // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _OrderSummary implements OrderSummary {
  const _OrderSummary({required this.id, required this.productName, required this.price, required this.counterpartyName, required this.counterpartyId, required this.role, required this.status, required this.updatedAt, this.sellingPrice, this.rating, this.imageUrl});
  

@override final  String id;
@override final  String productName;
/// Order price in the region currency (NPR / INR).
@override final  double price;
/// Seller name for purchases, buyer name for sales.
@override final  String counterpartyName;
/// Business/user id of the counterparty (used by "Visit Seller Profile").
@override final  String counterpartyId;
@override final  OrderRole role;
@override final  OrderStatus status;
@override final  DateTime updatedAt;
/// Seller's listed price (S.P) shown on sales cards.
@override final  double? sellingPrice;
/// Buyer rating (1–5) once the purchase is completed.
@override final  int? rating;
@override final  String? imageUrl;

/// Create a copy of OrderSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderSummaryCopyWith<_OrderSummary> get copyWith => __$OrderSummaryCopyWithImpl<_OrderSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.price, price) || other.price == price)&&(identical(other.counterpartyName, counterpartyName) || other.counterpartyName == counterpartyName)&&(identical(other.counterpartyId, counterpartyId) || other.counterpartyId == counterpartyId)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.sellingPrice, sellingPrice) || other.sellingPrice == sellingPrice)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,productName,price,counterpartyName,counterpartyId,role,status,updatedAt,sellingPrice,rating,imageUrl);

@override
String toString() {
  return 'OrderSummary(id: $id, productName: $productName, price: $price, counterpartyName: $counterpartyName, counterpartyId: $counterpartyId, role: $role, status: $status, updatedAt: $updatedAt, sellingPrice: $sellingPrice, rating: $rating, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$OrderSummaryCopyWith<$Res> implements $OrderSummaryCopyWith<$Res> {
  factory _$OrderSummaryCopyWith(_OrderSummary value, $Res Function(_OrderSummary) _then) = __$OrderSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String productName, double price, String counterpartyName, String counterpartyId, OrderRole role, OrderStatus status, DateTime updatedAt, double? sellingPrice, int? rating, String? imageUrl
});




}
/// @nodoc
class __$OrderSummaryCopyWithImpl<$Res>
    implements _$OrderSummaryCopyWith<$Res> {
  __$OrderSummaryCopyWithImpl(this._self, this._then);

  final _OrderSummary _self;
  final $Res Function(_OrderSummary) _then;

/// Create a copy of OrderSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productName = null,Object? price = null,Object? counterpartyName = null,Object? counterpartyId = null,Object? role = null,Object? status = null,Object? updatedAt = null,Object? sellingPrice = freezed,Object? rating = freezed,Object? imageUrl = freezed,}) {
  return _then(_OrderSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,counterpartyName: null == counterpartyName ? _self.counterpartyName : counterpartyName // ignore: cast_nullable_to_non_nullable
as String,counterpartyId: null == counterpartyId ? _self.counterpartyId : counterpartyId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as OrderRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sellingPrice: freezed == sellingPrice ? _self.sellingPrice : sellingPrice // ignore: cast_nullable_to_non_nullable
as double?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
