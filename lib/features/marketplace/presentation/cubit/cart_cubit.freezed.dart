// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartState {

 LoadState<Cart> get cart; String get couponInput; bool get couponInvalid;
/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartStateCopyWith<CartState> get copyWith => _$CartStateCopyWithImpl<CartState>(this as CartState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartState&&(identical(other.cart, cart) || other.cart == cart)&&(identical(other.couponInput, couponInput) || other.couponInput == couponInput)&&(identical(other.couponInvalid, couponInvalid) || other.couponInvalid == couponInvalid));
}


@override
int get hashCode => Object.hash(runtimeType,cart,couponInput,couponInvalid);

@override
String toString() {
  return 'CartState(cart: $cart, couponInput: $couponInput, couponInvalid: $couponInvalid)';
}


}

/// @nodoc
abstract mixin class $CartStateCopyWith<$Res>  {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) _then) = _$CartStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Cart> cart, String couponInput, bool couponInvalid
});


$LoadStateCopyWith<Cart, $Res> get cart;

}
/// @nodoc
class _$CartStateCopyWithImpl<$Res>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._self, this._then);

  final CartState _self;
  final $Res Function(CartState) _then;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cart = null,Object? couponInput = null,Object? couponInvalid = null,}) {
  return _then(_self.copyWith(
cart: null == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as LoadState<Cart>,couponInput: null == couponInput ? _self.couponInput : couponInput // ignore: cast_nullable_to_non_nullable
as String,couponInvalid: null == couponInvalid ? _self.couponInvalid : couponInvalid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Cart, $Res> get cart {
  
  return $LoadStateCopyWith<Cart, $Res>(_self.cart, (value) {
    return _then(_self.copyWith(cart: value));
  });
}
}



/// @nodoc


class _CartState implements CartState {
  const _CartState({this.cart = const LoadState.idle(), this.couponInput = '', this.couponInvalid = false});
  

@override@JsonKey() final  LoadState<Cart> cart;
@override@JsonKey() final  String couponInput;
@override@JsonKey() final  bool couponInvalid;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartStateCopyWith<_CartState> get copyWith => __$CartStateCopyWithImpl<_CartState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartState&&(identical(other.cart, cart) || other.cart == cart)&&(identical(other.couponInput, couponInput) || other.couponInput == couponInput)&&(identical(other.couponInvalid, couponInvalid) || other.couponInvalid == couponInvalid));
}


@override
int get hashCode => Object.hash(runtimeType,cart,couponInput,couponInvalid);

@override
String toString() {
  return 'CartState(cart: $cart, couponInput: $couponInput, couponInvalid: $couponInvalid)';
}


}

/// @nodoc
abstract mixin class _$CartStateCopyWith<$Res> implements $CartStateCopyWith<$Res> {
  factory _$CartStateCopyWith(_CartState value, $Res Function(_CartState) _then) = __$CartStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Cart> cart, String couponInput, bool couponInvalid
});


@override $LoadStateCopyWith<Cart, $Res> get cart;

}
/// @nodoc
class __$CartStateCopyWithImpl<$Res>
    implements _$CartStateCopyWith<$Res> {
  __$CartStateCopyWithImpl(this._self, this._then);

  final _CartState _self;
  final $Res Function(_CartState) _then;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cart = null,Object? couponInput = null,Object? couponInvalid = null,}) {
  return _then(_CartState(
cart: null == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as LoadState<Cart>,couponInput: null == couponInput ? _self.couponInput : couponInput // ignore: cast_nullable_to_non_nullable
as String,couponInvalid: null == couponInvalid ? _self.couponInvalid : couponInvalid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Cart, $Res> get cart {
  
  return $LoadStateCopyWith<Cart, $Res>(_self.cart, (value) {
    return _then(_self.copyWith(cart: value));
  });
}
}

// dart format on
