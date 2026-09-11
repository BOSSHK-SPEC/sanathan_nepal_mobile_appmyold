// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_tracking_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderTrackingState {

 LoadState<TrackedOrder> get order; LoadState<TrackedOrder> get returning; ReturnReason? get reason; String get details; Set<String> get selectedItems;
/// Create a copy of OrderTrackingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderTrackingStateCopyWith<OrderTrackingState> get copyWith => _$OrderTrackingStateCopyWithImpl<OrderTrackingState>(this as OrderTrackingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderTrackingState&&(identical(other.order, order) || other.order == order)&&(identical(other.returning, returning) || other.returning == returning)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details)&&const DeepCollectionEquality().equals(other.selectedItems, selectedItems));
}


@override
int get hashCode => Object.hash(runtimeType,order,returning,reason,details,const DeepCollectionEquality().hash(selectedItems));

@override
String toString() {
  return 'OrderTrackingState(order: $order, returning: $returning, reason: $reason, details: $details, selectedItems: $selectedItems)';
}


}

/// @nodoc
abstract mixin class $OrderTrackingStateCopyWith<$Res>  {
  factory $OrderTrackingStateCopyWith(OrderTrackingState value, $Res Function(OrderTrackingState) _then) = _$OrderTrackingStateCopyWithImpl;
@useResult
$Res call({
 LoadState<TrackedOrder> order, LoadState<TrackedOrder> returning, ReturnReason? reason, String details, Set<String> selectedItems
});


$LoadStateCopyWith<TrackedOrder, $Res> get order;$LoadStateCopyWith<TrackedOrder, $Res> get returning;

}
/// @nodoc
class _$OrderTrackingStateCopyWithImpl<$Res>
    implements $OrderTrackingStateCopyWith<$Res> {
  _$OrderTrackingStateCopyWithImpl(this._self, this._then);

  final OrderTrackingState _self;
  final $Res Function(OrderTrackingState) _then;

/// Create a copy of OrderTrackingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? returning = null,Object? reason = freezed,Object? details = null,Object? selectedItems = null,}) {
  return _then(_self.copyWith(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LoadState<TrackedOrder>,returning: null == returning ? _self.returning : returning // ignore: cast_nullable_to_non_nullable
as LoadState<TrackedOrder>,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReturnReason?,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,selectedItems: null == selectedItems ? _self.selectedItems : selectedItems // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}
/// Create a copy of OrderTrackingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<TrackedOrder, $Res> get order {
  
  return $LoadStateCopyWith<TrackedOrder, $Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of OrderTrackingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<TrackedOrder, $Res> get returning {
  
  return $LoadStateCopyWith<TrackedOrder, $Res>(_self.returning, (value) {
    return _then(_self.copyWith(returning: value));
  });
}
}



/// @nodoc


class _OrderTrackingState extends OrderTrackingState {
  const _OrderTrackingState({this.order = const LoadState.idle(), this.returning = const LoadState.idle(), this.reason, this.details = '', final  Set<String> selectedItems = const <String>{}}): _selectedItems = selectedItems,super._();
  

@override@JsonKey() final  LoadState<TrackedOrder> order;
@override@JsonKey() final  LoadState<TrackedOrder> returning;
@override final  ReturnReason? reason;
@override@JsonKey() final  String details;
 final  Set<String> _selectedItems;
@override@JsonKey() Set<String> get selectedItems {
  if (_selectedItems is EqualUnmodifiableSetView) return _selectedItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedItems);
}


/// Create a copy of OrderTrackingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderTrackingStateCopyWith<_OrderTrackingState> get copyWith => __$OrderTrackingStateCopyWithImpl<_OrderTrackingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderTrackingState&&(identical(other.order, order) || other.order == order)&&(identical(other.returning, returning) || other.returning == returning)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details)&&const DeepCollectionEquality().equals(other._selectedItems, _selectedItems));
}


@override
int get hashCode => Object.hash(runtimeType,order,returning,reason,details,const DeepCollectionEquality().hash(_selectedItems));

@override
String toString() {
  return 'OrderTrackingState(order: $order, returning: $returning, reason: $reason, details: $details, selectedItems: $selectedItems)';
}


}

/// @nodoc
abstract mixin class _$OrderTrackingStateCopyWith<$Res> implements $OrderTrackingStateCopyWith<$Res> {
  factory _$OrderTrackingStateCopyWith(_OrderTrackingState value, $Res Function(_OrderTrackingState) _then) = __$OrderTrackingStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<TrackedOrder> order, LoadState<TrackedOrder> returning, ReturnReason? reason, String details, Set<String> selectedItems
});


@override $LoadStateCopyWith<TrackedOrder, $Res> get order;@override $LoadStateCopyWith<TrackedOrder, $Res> get returning;

}
/// @nodoc
class __$OrderTrackingStateCopyWithImpl<$Res>
    implements _$OrderTrackingStateCopyWith<$Res> {
  __$OrderTrackingStateCopyWithImpl(this._self, this._then);

  final _OrderTrackingState _self;
  final $Res Function(_OrderTrackingState) _then;

/// Create a copy of OrderTrackingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? returning = null,Object? reason = freezed,Object? details = null,Object? selectedItems = null,}) {
  return _then(_OrderTrackingState(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as LoadState<TrackedOrder>,returning: null == returning ? _self.returning : returning // ignore: cast_nullable_to_non_nullable
as LoadState<TrackedOrder>,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReturnReason?,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,selectedItems: null == selectedItems ? _self._selectedItems : selectedItems // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

/// Create a copy of OrderTrackingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<TrackedOrder, $Res> get order {
  
  return $LoadStateCopyWith<TrackedOrder, $Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}/// Create a copy of OrderTrackingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<TrackedOrder, $Res> get returning {
  
  return $LoadStateCopyWith<TrackedOrder, $Res>(_self.returning, (value) {
    return _then(_self.copyWith(returning: value));
  });
}
}

// dart format on
