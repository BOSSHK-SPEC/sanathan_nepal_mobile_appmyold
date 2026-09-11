// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrdersListState {

 OrdersScope get scope; LoadState<List<TrackedOrder>> get orders; LoadState<TrackedOrder> get advancing; OrderFilter get filter;
/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrdersListStateCopyWith<OrdersListState> get copyWith => _$OrdersListStateCopyWithImpl<OrdersListState>(this as OrdersListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrdersListState&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.orders, orders) || other.orders == orders)&&(identical(other.advancing, advancing) || other.advancing == advancing)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,scope,orders,advancing,filter);

@override
String toString() {
  return 'OrdersListState(scope: $scope, orders: $orders, advancing: $advancing, filter: $filter)';
}


}

/// @nodoc
abstract mixin class $OrdersListStateCopyWith<$Res>  {
  factory $OrdersListStateCopyWith(OrdersListState value, $Res Function(OrdersListState) _then) = _$OrdersListStateCopyWithImpl;
@useResult
$Res call({
 OrdersScope scope, LoadState<List<TrackedOrder>> orders, LoadState<TrackedOrder> advancing, OrderFilter filter
});


$LoadStateCopyWith<List<TrackedOrder>, $Res> get orders;$LoadStateCopyWith<TrackedOrder, $Res> get advancing;

}
/// @nodoc
class _$OrdersListStateCopyWithImpl<$Res>
    implements $OrdersListStateCopyWith<$Res> {
  _$OrdersListStateCopyWithImpl(this._self, this._then);

  final OrdersListState _self;
  final $Res Function(OrdersListState) _then;

/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scope = null,Object? orders = null,Object? advancing = null,Object? filter = null,}) {
  return _then(_self.copyWith(
scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as OrdersScope,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as LoadState<List<TrackedOrder>>,advancing: null == advancing ? _self.advancing : advancing // ignore: cast_nullable_to_non_nullable
as LoadState<TrackedOrder>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as OrderFilter,
  ));
}
/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<TrackedOrder>, $Res> get orders {
  
  return $LoadStateCopyWith<List<TrackedOrder>, $Res>(_self.orders, (value) {
    return _then(_self.copyWith(orders: value));
  });
}/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<TrackedOrder, $Res> get advancing {
  
  return $LoadStateCopyWith<TrackedOrder, $Res>(_self.advancing, (value) {
    return _then(_self.copyWith(advancing: value));
  });
}
}



/// @nodoc


class _OrdersListState extends OrdersListState {
  const _OrdersListState({required this.scope, this.orders = const LoadState.idle(), this.advancing = const LoadState.idle(), this.filter = OrderFilter.active}): super._();
  

@override final  OrdersScope scope;
@override@JsonKey() final  LoadState<List<TrackedOrder>> orders;
@override@JsonKey() final  LoadState<TrackedOrder> advancing;
@override@JsonKey() final  OrderFilter filter;

/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrdersListStateCopyWith<_OrdersListState> get copyWith => __$OrdersListStateCopyWithImpl<_OrdersListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrdersListState&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.orders, orders) || other.orders == orders)&&(identical(other.advancing, advancing) || other.advancing == advancing)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,scope,orders,advancing,filter);

@override
String toString() {
  return 'OrdersListState(scope: $scope, orders: $orders, advancing: $advancing, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$OrdersListStateCopyWith<$Res> implements $OrdersListStateCopyWith<$Res> {
  factory _$OrdersListStateCopyWith(_OrdersListState value, $Res Function(_OrdersListState) _then) = __$OrdersListStateCopyWithImpl;
@override @useResult
$Res call({
 OrdersScope scope, LoadState<List<TrackedOrder>> orders, LoadState<TrackedOrder> advancing, OrderFilter filter
});


@override $LoadStateCopyWith<List<TrackedOrder>, $Res> get orders;@override $LoadStateCopyWith<TrackedOrder, $Res> get advancing;

}
/// @nodoc
class __$OrdersListStateCopyWithImpl<$Res>
    implements _$OrdersListStateCopyWith<$Res> {
  __$OrdersListStateCopyWithImpl(this._self, this._then);

  final _OrdersListState _self;
  final $Res Function(_OrdersListState) _then;

/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scope = null,Object? orders = null,Object? advancing = null,Object? filter = null,}) {
  return _then(_OrdersListState(
scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as OrdersScope,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as LoadState<List<TrackedOrder>>,advancing: null == advancing ? _self.advancing : advancing // ignore: cast_nullable_to_non_nullable
as LoadState<TrackedOrder>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as OrderFilter,
  ));
}

/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<TrackedOrder>, $Res> get orders {
  
  return $LoadStateCopyWith<List<TrackedOrder>, $Res>(_self.orders, (value) {
    return _then(_self.copyWith(orders: value));
  });
}/// Create a copy of OrdersListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<TrackedOrder, $Res> get advancing {
  
  return $LoadStateCopyWith<TrackedOrder, $Res>(_self.advancing, (value) {
    return _then(_self.copyWith(advancing: value));
  });
}
}

// dart format on
