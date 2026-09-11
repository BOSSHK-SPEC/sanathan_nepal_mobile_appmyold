// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutState {

 LoadState<Cart> get cart; PaymentMethod get paymentMethod; bool get shipToDifferentAddress; bool get addressConfirmed;/// Placed order (loading while submitting).
 LoadState<Order> get order;
/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutStateCopyWith<CheckoutState> get copyWith => _$CheckoutStateCopyWithImpl<CheckoutState>(this as CheckoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState&&(identical(other.cart, cart) || other.cart == cart)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.shipToDifferentAddress, shipToDifferentAddress) || other.shipToDifferentAddress == shipToDifferentAddress)&&(identical(other.addressConfirmed, addressConfirmed) || other.addressConfirmed == addressConfirmed)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,cart,paymentMethod,shipToDifferentAddress,addressConfirmed,order);

@override
String toString() {
  return 'CheckoutState(cart: $cart, paymentMethod: $paymentMethod, shipToDifferentAddress: $shipToDifferentAddress, addressConfirmed: $addressConfirmed, order: $order)';
}


}

/// @nodoc
abstract mixin class $CheckoutStateCopyWith<$Res>  {
  factory $CheckoutStateCopyWith(CheckoutState value, $Res Function(CheckoutState) _then) = _$CheckoutStateCopyWithImpl;
@useResult
$Res call({
 LoadState<Cart> cart, PaymentMethod paymentMethod, bool shipToDifferentAddress, bool addressConfirmed, LoadState<Order> order
});


$LoadStateCopyWith<Cart, $Res> get cart;$LoadStateCopyWith<Order, $Res> get order;

}
/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._self, this._then);

  final CheckoutState _self;
  final $Res Function(CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cart = null,Object? paymentMethod = null,Object? shipToDifferentAddress = null,Object? addressConfirmed = null,Object? order = null,}) {
  return _then(_self.copyWith(
cart: null == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as LoadState<Cart>,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,shipToDifferentAddress: null == shipToDifferentAddress ? _self.shipToDifferentAddress : shipToDifferentAddress // ignore: cast_nullable_to_non_nullable
as bool,addressConfirmed: null == addressConfirmed ? _self.addressConfirmed : addressConfirmed // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LoadState<Order>,
  ));
}
/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Cart, $Res> get cart {
  
  return $LoadStateCopyWith<Cart, $Res>(_self.cart, (value) {
    return _then(_self.copyWith(cart: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Order, $Res> get order {
  
  return $LoadStateCopyWith<Order, $Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}



/// @nodoc


class _CheckoutState extends CheckoutState {
  const _CheckoutState({this.cart = const LoadState.idle(), this.paymentMethod = PaymentMethod.esewa, this.shipToDifferentAddress = false, this.addressConfirmed = false, this.order = const LoadState.idle()}): super._();
  

@override@JsonKey() final  LoadState<Cart> cart;
@override@JsonKey() final  PaymentMethod paymentMethod;
@override@JsonKey() final  bool shipToDifferentAddress;
@override@JsonKey() final  bool addressConfirmed;
/// Placed order (loading while submitting).
@override@JsonKey() final  LoadState<Order> order;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutStateCopyWith<_CheckoutState> get copyWith => __$CheckoutStateCopyWithImpl<_CheckoutState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutState&&(identical(other.cart, cart) || other.cart == cart)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.shipToDifferentAddress, shipToDifferentAddress) || other.shipToDifferentAddress == shipToDifferentAddress)&&(identical(other.addressConfirmed, addressConfirmed) || other.addressConfirmed == addressConfirmed)&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,cart,paymentMethod,shipToDifferentAddress,addressConfirmed,order);

@override
String toString() {
  return 'CheckoutState(cart: $cart, paymentMethod: $paymentMethod, shipToDifferentAddress: $shipToDifferentAddress, addressConfirmed: $addressConfirmed, order: $order)';
}


}

/// @nodoc
abstract mixin class _$CheckoutStateCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory _$CheckoutStateCopyWith(_CheckoutState value, $Res Function(_CheckoutState) _then) = __$CheckoutStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<Cart> cart, PaymentMethod paymentMethod, bool shipToDifferentAddress, bool addressConfirmed, LoadState<Order> order
});


@override $LoadStateCopyWith<Cart, $Res> get cart;@override $LoadStateCopyWith<Order, $Res> get order;

}
/// @nodoc
class __$CheckoutStateCopyWithImpl<$Res>
    implements _$CheckoutStateCopyWith<$Res> {
  __$CheckoutStateCopyWithImpl(this._self, this._then);

  final _CheckoutState _self;
  final $Res Function(_CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cart = null,Object? paymentMethod = null,Object? shipToDifferentAddress = null,Object? addressConfirmed = null,Object? order = null,}) {
  return _then(_CheckoutState(
cart: null == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as LoadState<Cart>,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,shipToDifferentAddress: null == shipToDifferentAddress ? _self.shipToDifferentAddress : shipToDifferentAddress // ignore: cast_nullable_to_non_nullable
as bool,addressConfirmed: null == addressConfirmed ? _self.addressConfirmed : addressConfirmed // ignore: cast_nullable_to_non_nullable
as bool,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LoadState<Order>,
  ));
}

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Cart, $Res> get cart {
  
  return $LoadStateCopyWith<Cart, $Res>(_self.cart, (value) {
    return _then(_self.copyWith(cart: value));
  });
}/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<Order, $Res> get order {
  
  return $LoadStateCopyWith<Order, $Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}

// dart format on
