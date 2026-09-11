// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_cart_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateCartItemParams {

 String get productId; int get quantity;
/// Create a copy of UpdateCartItemParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCartItemParamsCopyWith<UpdateCartItemParams> get copyWith => _$UpdateCartItemParamsCopyWithImpl<UpdateCartItemParams>(this as UpdateCartItemParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCartItemParams&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,productId,quantity);

@override
String toString() {
  return 'UpdateCartItemParams(productId: $productId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $UpdateCartItemParamsCopyWith<$Res>  {
  factory $UpdateCartItemParamsCopyWith(UpdateCartItemParams value, $Res Function(UpdateCartItemParams) _then) = _$UpdateCartItemParamsCopyWithImpl;
@useResult
$Res call({
 String productId, int quantity
});




}
/// @nodoc
class _$UpdateCartItemParamsCopyWithImpl<$Res>
    implements $UpdateCartItemParamsCopyWith<$Res> {
  _$UpdateCartItemParamsCopyWithImpl(this._self, this._then);

  final UpdateCartItemParams _self;
  final $Res Function(UpdateCartItemParams) _then;

/// Create a copy of UpdateCartItemParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? quantity = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _UpdateCartItemParams implements UpdateCartItemParams {
  const _UpdateCartItemParams({required this.productId, required this.quantity});
  

@override final  String productId;
@override final  int quantity;

/// Create a copy of UpdateCartItemParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCartItemParamsCopyWith<_UpdateCartItemParams> get copyWith => __$UpdateCartItemParamsCopyWithImpl<_UpdateCartItemParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCartItemParams&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,productId,quantity);

@override
String toString() {
  return 'UpdateCartItemParams(productId: $productId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$UpdateCartItemParamsCopyWith<$Res> implements $UpdateCartItemParamsCopyWith<$Res> {
  factory _$UpdateCartItemParamsCopyWith(_UpdateCartItemParams value, $Res Function(_UpdateCartItemParams) _then) = __$UpdateCartItemParamsCopyWithImpl;
@override @useResult
$Res call({
 String productId, int quantity
});




}
/// @nodoc
class __$UpdateCartItemParamsCopyWithImpl<$Res>
    implements _$UpdateCartItemParamsCopyWith<$Res> {
  __$UpdateCartItemParamsCopyWithImpl(this._self, this._then);

  final _UpdateCartItemParams _self;
  final $Res Function(_UpdateCartItemParams) _then;

/// Create a copy of UpdateCartItemParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? quantity = null,}) {
  return _then(_UpdateCartItemParams(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
