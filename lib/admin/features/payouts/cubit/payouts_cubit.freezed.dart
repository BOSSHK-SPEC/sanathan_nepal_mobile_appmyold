// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payouts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PayoutsState {

 LoadState<List<PendingPayout>> get payouts; String? get decidingId; String? get actionError;/// The status the server returned for the last decision, shown as a
/// confirmation so a reviewer sees the outcome and not just an absence.
 String? get lastOutcome;
/// Create a copy of PayoutsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayoutsStateCopyWith<PayoutsState> get copyWith => _$PayoutsStateCopyWithImpl<PayoutsState>(this as PayoutsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayoutsState&&(identical(other.payouts, payouts) || other.payouts == payouts)&&(identical(other.decidingId, decidingId) || other.decidingId == decidingId)&&(identical(other.actionError, actionError) || other.actionError == actionError)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome));
}


@override
int get hashCode => Object.hash(runtimeType,payouts,decidingId,actionError,lastOutcome);

@override
String toString() {
  return 'PayoutsState(payouts: $payouts, decidingId: $decidingId, actionError: $actionError, lastOutcome: $lastOutcome)';
}


}

/// @nodoc
abstract mixin class $PayoutsStateCopyWith<$Res>  {
  factory $PayoutsStateCopyWith(PayoutsState value, $Res Function(PayoutsState) _then) = _$PayoutsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<PendingPayout>> payouts, String? decidingId, String? actionError, String? lastOutcome
});


$LoadStateCopyWith<List<PendingPayout>, $Res> get payouts;

}
/// @nodoc
class _$PayoutsStateCopyWithImpl<$Res>
    implements $PayoutsStateCopyWith<$Res> {
  _$PayoutsStateCopyWithImpl(this._self, this._then);

  final PayoutsState _self;
  final $Res Function(PayoutsState) _then;

/// Create a copy of PayoutsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? payouts = null,Object? decidingId = freezed,Object? actionError = freezed,Object? lastOutcome = freezed,}) {
  return _then(_self.copyWith(
payouts: null == payouts ? _self.payouts : payouts // ignore: cast_nullable_to_non_nullable
as LoadState<List<PendingPayout>>,decidingId: freezed == decidingId ? _self.decidingId : decidingId // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PayoutsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PendingPayout>, $Res> get payouts {
  
  return $LoadStateCopyWith<List<PendingPayout>, $Res>(_self.payouts, (value) {
    return _then(_self.copyWith(payouts: value));
  });
}
}



/// @nodoc


class _PayoutsState extends PayoutsState {
  const _PayoutsState({this.payouts = const LoadState<List<PendingPayout>>.idle(), this.decidingId, this.actionError, this.lastOutcome}): super._();
  

@override@JsonKey() final  LoadState<List<PendingPayout>> payouts;
@override final  String? decidingId;
@override final  String? actionError;
/// The status the server returned for the last decision, shown as a
/// confirmation so a reviewer sees the outcome and not just an absence.
@override final  String? lastOutcome;

/// Create a copy of PayoutsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayoutsStateCopyWith<_PayoutsState> get copyWith => __$PayoutsStateCopyWithImpl<_PayoutsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayoutsState&&(identical(other.payouts, payouts) || other.payouts == payouts)&&(identical(other.decidingId, decidingId) || other.decidingId == decidingId)&&(identical(other.actionError, actionError) || other.actionError == actionError)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome));
}


@override
int get hashCode => Object.hash(runtimeType,payouts,decidingId,actionError,lastOutcome);

@override
String toString() {
  return 'PayoutsState(payouts: $payouts, decidingId: $decidingId, actionError: $actionError, lastOutcome: $lastOutcome)';
}


}

/// @nodoc
abstract mixin class _$PayoutsStateCopyWith<$Res> implements $PayoutsStateCopyWith<$Res> {
  factory _$PayoutsStateCopyWith(_PayoutsState value, $Res Function(_PayoutsState) _then) = __$PayoutsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<PendingPayout>> payouts, String? decidingId, String? actionError, String? lastOutcome
});


@override $LoadStateCopyWith<List<PendingPayout>, $Res> get payouts;

}
/// @nodoc
class __$PayoutsStateCopyWithImpl<$Res>
    implements _$PayoutsStateCopyWith<$Res> {
  __$PayoutsStateCopyWithImpl(this._self, this._then);

  final _PayoutsState _self;
  final $Res Function(_PayoutsState) _then;

/// Create a copy of PayoutsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? payouts = null,Object? decidingId = freezed,Object? actionError = freezed,Object? lastOutcome = freezed,}) {
  return _then(_PayoutsState(
payouts: null == payouts ? _self.payouts : payouts // ignore: cast_nullable_to_non_nullable
as LoadState<List<PendingPayout>>,decidingId: freezed == decidingId ? _self.decidingId : decidingId // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PayoutsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<PendingPayout>, $Res> get payouts {
  
  return $LoadStateCopyWith<List<PendingPayout>, $Res>(_self.payouts, (value) {
    return _then(_self.copyWith(payouts: value));
  });
}
}

// dart format on
