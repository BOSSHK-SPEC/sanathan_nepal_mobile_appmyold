// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActivityState {

 LoadState<List<AppointmentSummary>> get appointments; LoadState<List<OrderSummary>> get orders;/// Why the last accept / ship / cancel failed. Shown once, then cleared.
 String? get actionError;/// The order with a request in flight. Its buttons are disabled, so a
/// second tap cannot send a second transition.
 String? get pendingOrderId;
/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityStateCopyWith<ActivityState> get copyWith => _$ActivityStateCopyWithImpl<ActivityState>(this as ActivityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityState&&(identical(other.appointments, appointments) || other.appointments == appointments)&&(identical(other.orders, orders) || other.orders == orders)&&(identical(other.actionError, actionError) || other.actionError == actionError)&&(identical(other.pendingOrderId, pendingOrderId) || other.pendingOrderId == pendingOrderId));
}


@override
int get hashCode => Object.hash(runtimeType,appointments,orders,actionError,pendingOrderId);

@override
String toString() {
  return 'ActivityState(appointments: $appointments, orders: $orders, actionError: $actionError, pendingOrderId: $pendingOrderId)';
}


}

/// @nodoc
abstract mixin class $ActivityStateCopyWith<$Res>  {
  factory $ActivityStateCopyWith(ActivityState value, $Res Function(ActivityState) _then) = _$ActivityStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<AppointmentSummary>> appointments, LoadState<List<OrderSummary>> orders, String? actionError, String? pendingOrderId
});


$LoadStateCopyWith<List<AppointmentSummary>, $Res> get appointments;$LoadStateCopyWith<List<OrderSummary>, $Res> get orders;

}
/// @nodoc
class _$ActivityStateCopyWithImpl<$Res>
    implements $ActivityStateCopyWith<$Res> {
  _$ActivityStateCopyWithImpl(this._self, this._then);

  final ActivityState _self;
  final $Res Function(ActivityState) _then;

/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appointments = null,Object? orders = null,Object? actionError = freezed,Object? pendingOrderId = freezed,}) {
  return _then(_self.copyWith(
appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as LoadState<List<AppointmentSummary>>,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as LoadState<List<OrderSummary>>,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,pendingOrderId: freezed == pendingOrderId ? _self.pendingOrderId : pendingOrderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AppointmentSummary>, $Res> get appointments {
  
  return $LoadStateCopyWith<List<AppointmentSummary>, $Res>(_self.appointments, (value) {
    return _then(_self.copyWith(appointments: value));
  });
}/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<OrderSummary>, $Res> get orders {
  
  return $LoadStateCopyWith<List<OrderSummary>, $Res>(_self.orders, (value) {
    return _then(_self.copyWith(orders: value));
  });
}
}



/// @nodoc


class _ActivityState extends ActivityState {
  const _ActivityState({this.appointments = const LoadState.idle(), this.orders = const LoadState.idle(), this.actionError, this.pendingOrderId}): super._();
  

@override@JsonKey() final  LoadState<List<AppointmentSummary>> appointments;
@override@JsonKey() final  LoadState<List<OrderSummary>> orders;
/// Why the last accept / ship / cancel failed. Shown once, then cleared.
@override final  String? actionError;
/// The order with a request in flight. Its buttons are disabled, so a
/// second tap cannot send a second transition.
@override final  String? pendingOrderId;

/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityStateCopyWith<_ActivityState> get copyWith => __$ActivityStateCopyWithImpl<_ActivityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityState&&(identical(other.appointments, appointments) || other.appointments == appointments)&&(identical(other.orders, orders) || other.orders == orders)&&(identical(other.actionError, actionError) || other.actionError == actionError)&&(identical(other.pendingOrderId, pendingOrderId) || other.pendingOrderId == pendingOrderId));
}


@override
int get hashCode => Object.hash(runtimeType,appointments,orders,actionError,pendingOrderId);

@override
String toString() {
  return 'ActivityState(appointments: $appointments, orders: $orders, actionError: $actionError, pendingOrderId: $pendingOrderId)';
}


}

/// @nodoc
abstract mixin class _$ActivityStateCopyWith<$Res> implements $ActivityStateCopyWith<$Res> {
  factory _$ActivityStateCopyWith(_ActivityState value, $Res Function(_ActivityState) _then) = __$ActivityStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<AppointmentSummary>> appointments, LoadState<List<OrderSummary>> orders, String? actionError, String? pendingOrderId
});


@override $LoadStateCopyWith<List<AppointmentSummary>, $Res> get appointments;@override $LoadStateCopyWith<List<OrderSummary>, $Res> get orders;

}
/// @nodoc
class __$ActivityStateCopyWithImpl<$Res>
    implements _$ActivityStateCopyWith<$Res> {
  __$ActivityStateCopyWithImpl(this._self, this._then);

  final _ActivityState _self;
  final $Res Function(_ActivityState) _then;

/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appointments = null,Object? orders = null,Object? actionError = freezed,Object? pendingOrderId = freezed,}) {
  return _then(_ActivityState(
appointments: null == appointments ? _self.appointments : appointments // ignore: cast_nullable_to_non_nullable
as LoadState<List<AppointmentSummary>>,orders: null == orders ? _self.orders : orders // ignore: cast_nullable_to_non_nullable
as LoadState<List<OrderSummary>>,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,pendingOrderId: freezed == pendingOrderId ? _self.pendingOrderId : pendingOrderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AppointmentSummary>, $Res> get appointments {
  
  return $LoadStateCopyWith<List<AppointmentSummary>, $Res>(_self.appointments, (value) {
    return _then(_self.copyWith(appointments: value));
  });
}/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<OrderSummary>, $Res> get orders {
  
  return $LoadStateCopyWith<List<OrderSummary>, $Res>(_self.orders, (value) {
    return _then(_self.copyWith(orders: value));
  });
}
}

// dart format on
