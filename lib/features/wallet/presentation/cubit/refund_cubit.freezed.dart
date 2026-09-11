// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refund_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RefundState {

 String get transactionId; RefundReason? get reason; String get details; LoadState<RefundRequest> get submission;
/// Create a copy of RefundState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefundStateCopyWith<RefundState> get copyWith => _$RefundStateCopyWithImpl<RefundState>(this as RefundState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefundState&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hash(runtimeType,transactionId,reason,details,submission);

@override
String toString() {
  return 'RefundState(transactionId: $transactionId, reason: $reason, details: $details, submission: $submission)';
}


}

/// @nodoc
abstract mixin class $RefundStateCopyWith<$Res>  {
  factory $RefundStateCopyWith(RefundState value, $Res Function(RefundState) _then) = _$RefundStateCopyWithImpl;
@useResult
$Res call({
 String transactionId, RefundReason? reason, String details, LoadState<RefundRequest> submission
});


$LoadStateCopyWith<RefundRequest, $Res> get submission;

}
/// @nodoc
class _$RefundStateCopyWithImpl<$Res>
    implements $RefundStateCopyWith<$Res> {
  _$RefundStateCopyWithImpl(this._self, this._then);

  final RefundState _self;
  final $Res Function(RefundState) _then;

/// Create a copy of RefundState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? reason = freezed,Object? details = null,Object? submission = null,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RefundReason?,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<RefundRequest>,
  ));
}
/// Create a copy of RefundState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<RefundRequest, $Res> get submission {
  
  return $LoadStateCopyWith<RefundRequest, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}



/// @nodoc


class _RefundState extends RefundState {
  const _RefundState({required this.transactionId, this.reason, this.details = '', this.submission = const LoadState.idle()}): super._();
  

@override final  String transactionId;
@override final  RefundReason? reason;
@override@JsonKey() final  String details;
@override@JsonKey() final  LoadState<RefundRequest> submission;

/// Create a copy of RefundState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefundStateCopyWith<_RefundState> get copyWith => __$RefundStateCopyWithImpl<_RefundState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefundState&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hash(runtimeType,transactionId,reason,details,submission);

@override
String toString() {
  return 'RefundState(transactionId: $transactionId, reason: $reason, details: $details, submission: $submission)';
}


}

/// @nodoc
abstract mixin class _$RefundStateCopyWith<$Res> implements $RefundStateCopyWith<$Res> {
  factory _$RefundStateCopyWith(_RefundState value, $Res Function(_RefundState) _then) = __$RefundStateCopyWithImpl;
@override @useResult
$Res call({
 String transactionId, RefundReason? reason, String details, LoadState<RefundRequest> submission
});


@override $LoadStateCopyWith<RefundRequest, $Res> get submission;

}
/// @nodoc
class __$RefundStateCopyWithImpl<$Res>
    implements _$RefundStateCopyWith<$Res> {
  __$RefundStateCopyWithImpl(this._self, this._then);

  final _RefundState _self;
  final $Res Function(_RefundState) _then;

/// Create a copy of RefundState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? reason = freezed,Object? details = null,Object? submission = null,}) {
  return _then(_RefundState(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RefundReason?,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<RefundRequest>,
  ));
}

/// Create a copy of RefundState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<RefundRequest, $Res> get submission {
  
  return $LoadStateCopyWith<RefundRequest, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}

// dart format on
