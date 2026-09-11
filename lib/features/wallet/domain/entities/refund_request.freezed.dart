// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refund_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RefundDraft {

/// Transaction being disputed.
 String get transactionId; RefundReason get reason; String get details;
/// Create a copy of RefundDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefundDraftCopyWith<RefundDraft> get copyWith => _$RefundDraftCopyWithImpl<RefundDraft>(this as RefundDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefundDraft&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,transactionId,reason,details);

@override
String toString() {
  return 'RefundDraft(transactionId: $transactionId, reason: $reason, details: $details)';
}


}

/// @nodoc
abstract mixin class $RefundDraftCopyWith<$Res>  {
  factory $RefundDraftCopyWith(RefundDraft value, $Res Function(RefundDraft) _then) = _$RefundDraftCopyWithImpl;
@useResult
$Res call({
 String transactionId, RefundReason reason, String details
});




}
/// @nodoc
class _$RefundDraftCopyWithImpl<$Res>
    implements $RefundDraftCopyWith<$Res> {
  _$RefundDraftCopyWithImpl(this._self, this._then);

  final RefundDraft _self;
  final $Res Function(RefundDraft) _then;

/// Create a copy of RefundDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? reason = null,Object? details = null,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RefundReason,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _RefundDraft implements RefundDraft {
  const _RefundDraft({required this.transactionId, required this.reason, this.details = ''});
  

/// Transaction being disputed.
@override final  String transactionId;
@override final  RefundReason reason;
@override@JsonKey() final  String details;

/// Create a copy of RefundDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefundDraftCopyWith<_RefundDraft> get copyWith => __$RefundDraftCopyWithImpl<_RefundDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefundDraft&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details));
}


@override
int get hashCode => Object.hash(runtimeType,transactionId,reason,details);

@override
String toString() {
  return 'RefundDraft(transactionId: $transactionId, reason: $reason, details: $details)';
}


}

/// @nodoc
abstract mixin class _$RefundDraftCopyWith<$Res> implements $RefundDraftCopyWith<$Res> {
  factory _$RefundDraftCopyWith(_RefundDraft value, $Res Function(_RefundDraft) _then) = __$RefundDraftCopyWithImpl;
@override @useResult
$Res call({
 String transactionId, RefundReason reason, String details
});




}
/// @nodoc
class __$RefundDraftCopyWithImpl<$Res>
    implements _$RefundDraftCopyWith<$Res> {
  __$RefundDraftCopyWithImpl(this._self, this._then);

  final _RefundDraft _self;
  final $Res Function(_RefundDraft) _then;

/// Create a copy of RefundDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? reason = null,Object? details = null,}) {
  return _then(_RefundDraft(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RefundReason,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$RefundRequest {

 String get id; String get transactionId; RefundReason get reason; RefundStatus get status; double get amount; DateTime get createdAt; String get details; DateTime? get resolvedAt; String? get resolutionNote;
/// Create a copy of RefundRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefundRequestCopyWith<RefundRequest> get copyWith => _$RefundRequestCopyWithImpl<RefundRequest>(this as RefundRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefundRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.details, details) || other.details == details)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.resolutionNote, resolutionNote) || other.resolutionNote == resolutionNote));
}


@override
int get hashCode => Object.hash(runtimeType,id,transactionId,reason,status,amount,createdAt,details,resolvedAt,resolutionNote);

@override
String toString() {
  return 'RefundRequest(id: $id, transactionId: $transactionId, reason: $reason, status: $status, amount: $amount, createdAt: $createdAt, details: $details, resolvedAt: $resolvedAt, resolutionNote: $resolutionNote)';
}


}

/// @nodoc
abstract mixin class $RefundRequestCopyWith<$Res>  {
  factory $RefundRequestCopyWith(RefundRequest value, $Res Function(RefundRequest) _then) = _$RefundRequestCopyWithImpl;
@useResult
$Res call({
 String id, String transactionId, RefundReason reason, RefundStatus status, double amount, DateTime createdAt, String details, DateTime? resolvedAt, String? resolutionNote
});




}
/// @nodoc
class _$RefundRequestCopyWithImpl<$Res>
    implements $RefundRequestCopyWith<$Res> {
  _$RefundRequestCopyWithImpl(this._self, this._then);

  final RefundRequest _self;
  final $Res Function(RefundRequest) _then;

/// Create a copy of RefundRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? transactionId = null,Object? reason = null,Object? status = null,Object? amount = null,Object? createdAt = null,Object? details = null,Object? resolvedAt = freezed,Object? resolutionNote = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RefundReason,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RefundStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolutionNote: freezed == resolutionNote ? _self.resolutionNote : resolutionNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _RefundRequest extends RefundRequest {
  const _RefundRequest({required this.id, required this.transactionId, required this.reason, required this.status, required this.amount, required this.createdAt, this.details = '', this.resolvedAt, this.resolutionNote}): super._();
  

@override final  String id;
@override final  String transactionId;
@override final  RefundReason reason;
@override final  RefundStatus status;
@override final  double amount;
@override final  DateTime createdAt;
@override@JsonKey() final  String details;
@override final  DateTime? resolvedAt;
@override final  String? resolutionNote;

/// Create a copy of RefundRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefundRequestCopyWith<_RefundRequest> get copyWith => __$RefundRequestCopyWithImpl<_RefundRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefundRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.details, details) || other.details == details)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt)&&(identical(other.resolutionNote, resolutionNote) || other.resolutionNote == resolutionNote));
}


@override
int get hashCode => Object.hash(runtimeType,id,transactionId,reason,status,amount,createdAt,details,resolvedAt,resolutionNote);

@override
String toString() {
  return 'RefundRequest(id: $id, transactionId: $transactionId, reason: $reason, status: $status, amount: $amount, createdAt: $createdAt, details: $details, resolvedAt: $resolvedAt, resolutionNote: $resolutionNote)';
}


}

/// @nodoc
abstract mixin class _$RefundRequestCopyWith<$Res> implements $RefundRequestCopyWith<$Res> {
  factory _$RefundRequestCopyWith(_RefundRequest value, $Res Function(_RefundRequest) _then) = __$RefundRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String transactionId, RefundReason reason, RefundStatus status, double amount, DateTime createdAt, String details, DateTime? resolvedAt, String? resolutionNote
});




}
/// @nodoc
class __$RefundRequestCopyWithImpl<$Res>
    implements _$RefundRequestCopyWith<$Res> {
  __$RefundRequestCopyWithImpl(this._self, this._then);

  final _RefundRequest _self;
  final $Res Function(_RefundRequest) _then;

/// Create a copy of RefundRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? transactionId = null,Object? reason = null,Object? status = null,Object? amount = null,Object? createdAt = null,Object? details = null,Object? resolvedAt = freezed,Object? resolutionNote = freezed,}) {
  return _then(_RefundRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as RefundReason,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RefundStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolutionNote: freezed == resolutionNote ? _self.resolutionNote : resolutionNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
