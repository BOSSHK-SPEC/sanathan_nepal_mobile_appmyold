// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplyOrderActionParams {

 OrderSummary get order; OrderAction get action;
/// Create a copy of ApplyOrderActionParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplyOrderActionParamsCopyWith<ApplyOrderActionParams> get copyWith => _$ApplyOrderActionParamsCopyWithImpl<ApplyOrderActionParams>(this as ApplyOrderActionParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplyOrderActionParams&&(identical(other.order, order) || other.order == order)&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,order,action);

@override
String toString() {
  return 'ApplyOrderActionParams(order: $order, action: $action)';
}


}

/// @nodoc
abstract mixin class $ApplyOrderActionParamsCopyWith<$Res>  {
  factory $ApplyOrderActionParamsCopyWith(ApplyOrderActionParams value, $Res Function(ApplyOrderActionParams) _then) = _$ApplyOrderActionParamsCopyWithImpl;
@useResult
$Res call({
 OrderSummary order, OrderAction action
});


$OrderSummaryCopyWith<$Res> get order;

}
/// @nodoc
class _$ApplyOrderActionParamsCopyWithImpl<$Res>
    implements $ApplyOrderActionParamsCopyWith<$Res> {
  _$ApplyOrderActionParamsCopyWithImpl(this._self, this._then);

  final ApplyOrderActionParams _self;
  final $Res Function(ApplyOrderActionParams) _then;

/// Create a copy of ApplyOrderActionParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? action = null,}) {
  return _then(_self.copyWith(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderSummary,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as OrderAction,
  ));
}
/// Create a copy of ApplyOrderActionParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderSummaryCopyWith<$Res> get order {
  
  return $OrderSummaryCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}



/// @nodoc


class _ApplyOrderActionParams implements ApplyOrderActionParams {
  const _ApplyOrderActionParams({required this.order, required this.action});
  

@override final  OrderSummary order;
@override final  OrderAction action;

/// Create a copy of ApplyOrderActionParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyOrderActionParamsCopyWith<_ApplyOrderActionParams> get copyWith => __$ApplyOrderActionParamsCopyWithImpl<_ApplyOrderActionParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyOrderActionParams&&(identical(other.order, order) || other.order == order)&&(identical(other.action, action) || other.action == action));
}


@override
int get hashCode => Object.hash(runtimeType,order,action);

@override
String toString() {
  return 'ApplyOrderActionParams(order: $order, action: $action)';
}


}

/// @nodoc
abstract mixin class _$ApplyOrderActionParamsCopyWith<$Res> implements $ApplyOrderActionParamsCopyWith<$Res> {
  factory _$ApplyOrderActionParamsCopyWith(_ApplyOrderActionParams value, $Res Function(_ApplyOrderActionParams) _then) = __$ApplyOrderActionParamsCopyWithImpl;
@override @useResult
$Res call({
 OrderSummary order, OrderAction action
});


@override $OrderSummaryCopyWith<$Res> get order;

}
/// @nodoc
class __$ApplyOrderActionParamsCopyWithImpl<$Res>
    implements _$ApplyOrderActionParamsCopyWith<$Res> {
  __$ApplyOrderActionParamsCopyWithImpl(this._self, this._then);

  final _ApplyOrderActionParams _self;
  final $Res Function(_ApplyOrderActionParams) _then;

/// Create a copy of ApplyOrderActionParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? action = null,}) {
  return _then(_ApplyOrderActionParams(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderSummary,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as OrderAction,
  ));
}

/// Create a copy of ApplyOrderActionParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderSummaryCopyWith<$Res> get order {
  
  return $OrderSummaryCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}

/// @nodoc
mixin _$RateOrderParams {

 String get id; int get rating;
/// Create a copy of RateOrderParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateOrderParamsCopyWith<RateOrderParams> get copyWith => _$RateOrderParamsCopyWithImpl<RateOrderParams>(this as RateOrderParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateOrderParams&&(identical(other.id, id) || other.id == id)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode => Object.hash(runtimeType,id,rating);

@override
String toString() {
  return 'RateOrderParams(id: $id, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $RateOrderParamsCopyWith<$Res>  {
  factory $RateOrderParamsCopyWith(RateOrderParams value, $Res Function(RateOrderParams) _then) = _$RateOrderParamsCopyWithImpl;
@useResult
$Res call({
 String id, int rating
});




}
/// @nodoc
class _$RateOrderParamsCopyWithImpl<$Res>
    implements $RateOrderParamsCopyWith<$Res> {
  _$RateOrderParamsCopyWithImpl(this._self, this._then);

  final RateOrderParams _self;
  final $Res Function(RateOrderParams) _then;

/// Create a copy of RateOrderParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? rating = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _RateOrderParams implements RateOrderParams {
  const _RateOrderParams({required this.id, required this.rating});
  

@override final  String id;
@override final  int rating;

/// Create a copy of RateOrderParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateOrderParamsCopyWith<_RateOrderParams> get copyWith => __$RateOrderParamsCopyWithImpl<_RateOrderParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateOrderParams&&(identical(other.id, id) || other.id == id)&&(identical(other.rating, rating) || other.rating == rating));
}


@override
int get hashCode => Object.hash(runtimeType,id,rating);

@override
String toString() {
  return 'RateOrderParams(id: $id, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$RateOrderParamsCopyWith<$Res> implements $RateOrderParamsCopyWith<$Res> {
  factory _$RateOrderParamsCopyWith(_RateOrderParams value, $Res Function(_RateOrderParams) _then) = __$RateOrderParamsCopyWithImpl;
@override @useResult
$Res call({
 String id, int rating
});




}
/// @nodoc
class __$RateOrderParamsCopyWithImpl<$Res>
    implements _$RateOrderParamsCopyWith<$Res> {
  __$RateOrderParamsCopyWithImpl(this._self, this._then);

  final _RateOrderParams _self;
  final $Res Function(_RateOrderParams) _then;

/// Create a copy of RateOrderParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? rating = null,}) {
  return _then(_RateOrderParams(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
