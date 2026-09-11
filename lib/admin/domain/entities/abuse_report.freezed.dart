// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'abuse_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AbuseReport {

 String get id; String get reporterId; String get targetType; String get targetId; ReportReason get reason; String get detail; bool get resolved; DateTime get createdAt;
/// Create a copy of AbuseReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbuseReportCopyWith<AbuseReport> get copyWith => _$AbuseReportCopyWithImpl<AbuseReport>(this as AbuseReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbuseReport&&(identical(other.id, id) || other.id == id)&&(identical(other.reporterId, reporterId) || other.reporterId == reporterId)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.resolved, resolved) || other.resolved == resolved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,reporterId,targetType,targetId,reason,detail,resolved,createdAt);

@override
String toString() {
  return 'AbuseReport(id: $id, reporterId: $reporterId, targetType: $targetType, targetId: $targetId, reason: $reason, detail: $detail, resolved: $resolved, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AbuseReportCopyWith<$Res>  {
  factory $AbuseReportCopyWith(AbuseReport value, $Res Function(AbuseReport) _then) = _$AbuseReportCopyWithImpl;
@useResult
$Res call({
 String id, String reporterId, String targetType, String targetId, ReportReason reason, String detail, bool resolved, DateTime createdAt
});




}
/// @nodoc
class _$AbuseReportCopyWithImpl<$Res>
    implements $AbuseReportCopyWith<$Res> {
  _$AbuseReportCopyWithImpl(this._self, this._then);

  final AbuseReport _self;
  final $Res Function(AbuseReport) _then;

/// Create a copy of AbuseReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reporterId = null,Object? targetType = null,Object? targetId = null,Object? reason = null,Object? detail = null,Object? resolved = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reporterId: null == reporterId ? _self.reporterId : reporterId // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReportReason,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}



/// @nodoc


class _AbuseReport implements AbuseReport {
  const _AbuseReport({required this.id, required this.reporterId, required this.targetType, required this.targetId, required this.reason, this.detail = '', this.resolved = false, required this.createdAt});
  

@override final  String id;
@override final  String reporterId;
@override final  String targetType;
@override final  String targetId;
@override final  ReportReason reason;
@override@JsonKey() final  String detail;
@override@JsonKey() final  bool resolved;
@override final  DateTime createdAt;

/// Create a copy of AbuseReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AbuseReportCopyWith<_AbuseReport> get copyWith => __$AbuseReportCopyWithImpl<_AbuseReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AbuseReport&&(identical(other.id, id) || other.id == id)&&(identical(other.reporterId, reporterId) || other.reporterId == reporterId)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.resolved, resolved) || other.resolved == resolved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,reporterId,targetType,targetId,reason,detail,resolved,createdAt);

@override
String toString() {
  return 'AbuseReport(id: $id, reporterId: $reporterId, targetType: $targetType, targetId: $targetId, reason: $reason, detail: $detail, resolved: $resolved, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AbuseReportCopyWith<$Res> implements $AbuseReportCopyWith<$Res> {
  factory _$AbuseReportCopyWith(_AbuseReport value, $Res Function(_AbuseReport) _then) = __$AbuseReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String reporterId, String targetType, String targetId, ReportReason reason, String detail, bool resolved, DateTime createdAt
});




}
/// @nodoc
class __$AbuseReportCopyWithImpl<$Res>
    implements _$AbuseReportCopyWith<$Res> {
  __$AbuseReportCopyWithImpl(this._self, this._then);

  final _AbuseReport _self;
  final $Res Function(_AbuseReport) _then;

/// Create a copy of AbuseReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reporterId = null,Object? targetType = null,Object? targetId = null,Object? reason = null,Object? detail = null,Object? resolved = null,Object? createdAt = null,}) {
  return _then(_AbuseReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reporterId: null == reporterId ? _self.reporterId : reporterId // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReportReason,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
