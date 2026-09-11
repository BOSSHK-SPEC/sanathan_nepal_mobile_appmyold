// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_notice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ComplianceNotice {

 String get id; ComplianceKind get kind; ComplianceSeverity get severity; String get title; String get body; DateTime get issuedAt; ComplianceStatus get status;/// What the astrologer has to do, if anything.
 String? get requiredAction;/// When the required action must be done by. Past this, the notice
/// escalates on the platform side.
 DateTime? get dueBy;/// Amount withheld or charged, in the region's currency.
 double? get penaltyAmount;/// The consultation or order the notice is about, when it has one.
 String? get referenceId; DateTime? get acknowledgedAt;/// Appeals close after a window; a notice past it can still be read but
/// not contested.
 bool get appealable; String? get appealReason; DateTime? get appealedAt; String? get resolutionNote;
/// Create a copy of ComplianceNotice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplianceNoticeCopyWith<ComplianceNotice> get copyWith => _$ComplianceNoticeCopyWithImpl<ComplianceNotice>(this as ComplianceNotice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceNotice&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.requiredAction, requiredAction) || other.requiredAction == requiredAction)&&(identical(other.dueBy, dueBy) || other.dueBy == dueBy)&&(identical(other.penaltyAmount, penaltyAmount) || other.penaltyAmount == penaltyAmount)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.acknowledgedAt, acknowledgedAt) || other.acknowledgedAt == acknowledgedAt)&&(identical(other.appealable, appealable) || other.appealable == appealable)&&(identical(other.appealReason, appealReason) || other.appealReason == appealReason)&&(identical(other.appealedAt, appealedAt) || other.appealedAt == appealedAt)&&(identical(other.resolutionNote, resolutionNote) || other.resolutionNote == resolutionNote));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,severity,title,body,issuedAt,status,requiredAction,dueBy,penaltyAmount,referenceId,acknowledgedAt,appealable,appealReason,appealedAt,resolutionNote);

@override
String toString() {
  return 'ComplianceNotice(id: $id, kind: $kind, severity: $severity, title: $title, body: $body, issuedAt: $issuedAt, status: $status, requiredAction: $requiredAction, dueBy: $dueBy, penaltyAmount: $penaltyAmount, referenceId: $referenceId, acknowledgedAt: $acknowledgedAt, appealable: $appealable, appealReason: $appealReason, appealedAt: $appealedAt, resolutionNote: $resolutionNote)';
}


}

/// @nodoc
abstract mixin class $ComplianceNoticeCopyWith<$Res>  {
  factory $ComplianceNoticeCopyWith(ComplianceNotice value, $Res Function(ComplianceNotice) _then) = _$ComplianceNoticeCopyWithImpl;
@useResult
$Res call({
 String id, ComplianceKind kind, ComplianceSeverity severity, String title, String body, DateTime issuedAt, ComplianceStatus status, String? requiredAction, DateTime? dueBy, double? penaltyAmount, String? referenceId, DateTime? acknowledgedAt, bool appealable, String? appealReason, DateTime? appealedAt, String? resolutionNote
});




}
/// @nodoc
class _$ComplianceNoticeCopyWithImpl<$Res>
    implements $ComplianceNoticeCopyWith<$Res> {
  _$ComplianceNoticeCopyWithImpl(this._self, this._then);

  final ComplianceNotice _self;
  final $Res Function(ComplianceNotice) _then;

/// Create a copy of ComplianceNotice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? severity = null,Object? title = null,Object? body = null,Object? issuedAt = null,Object? status = null,Object? requiredAction = freezed,Object? dueBy = freezed,Object? penaltyAmount = freezed,Object? referenceId = freezed,Object? acknowledgedAt = freezed,Object? appealable = null,Object? appealReason = freezed,Object? appealedAt = freezed,Object? resolutionNote = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ComplianceKind,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as ComplianceSeverity,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ComplianceStatus,requiredAction: freezed == requiredAction ? _self.requiredAction : requiredAction // ignore: cast_nullable_to_non_nullable
as String?,dueBy: freezed == dueBy ? _self.dueBy : dueBy // ignore: cast_nullable_to_non_nullable
as DateTime?,penaltyAmount: freezed == penaltyAmount ? _self.penaltyAmount : penaltyAmount // ignore: cast_nullable_to_non_nullable
as double?,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,acknowledgedAt: freezed == acknowledgedAt ? _self.acknowledgedAt : acknowledgedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,appealable: null == appealable ? _self.appealable : appealable // ignore: cast_nullable_to_non_nullable
as bool,appealReason: freezed == appealReason ? _self.appealReason : appealReason // ignore: cast_nullable_to_non_nullable
as String?,appealedAt: freezed == appealedAt ? _self.appealedAt : appealedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolutionNote: freezed == resolutionNote ? _self.resolutionNote : resolutionNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _ComplianceNotice extends ComplianceNotice {
  const _ComplianceNotice({required this.id, required this.kind, required this.severity, required this.title, required this.body, required this.issuedAt, this.status = ComplianceStatus.open, this.requiredAction, this.dueBy, this.penaltyAmount, this.referenceId, this.acknowledgedAt, this.appealable = true, this.appealReason, this.appealedAt, this.resolutionNote}): super._();
  

@override final  String id;
@override final  ComplianceKind kind;
@override final  ComplianceSeverity severity;
@override final  String title;
@override final  String body;
@override final  DateTime issuedAt;
@override@JsonKey() final  ComplianceStatus status;
/// What the astrologer has to do, if anything.
@override final  String? requiredAction;
/// When the required action must be done by. Past this, the notice
/// escalates on the platform side.
@override final  DateTime? dueBy;
/// Amount withheld or charged, in the region's currency.
@override final  double? penaltyAmount;
/// The consultation or order the notice is about, when it has one.
@override final  String? referenceId;
@override final  DateTime? acknowledgedAt;
/// Appeals close after a window; a notice past it can still be read but
/// not contested.
@override@JsonKey() final  bool appealable;
@override final  String? appealReason;
@override final  DateTime? appealedAt;
@override final  String? resolutionNote;

/// Create a copy of ComplianceNotice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplianceNoticeCopyWith<_ComplianceNotice> get copyWith => __$ComplianceNoticeCopyWithImpl<_ComplianceNotice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplianceNotice&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.requiredAction, requiredAction) || other.requiredAction == requiredAction)&&(identical(other.dueBy, dueBy) || other.dueBy == dueBy)&&(identical(other.penaltyAmount, penaltyAmount) || other.penaltyAmount == penaltyAmount)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId)&&(identical(other.acknowledgedAt, acknowledgedAt) || other.acknowledgedAt == acknowledgedAt)&&(identical(other.appealable, appealable) || other.appealable == appealable)&&(identical(other.appealReason, appealReason) || other.appealReason == appealReason)&&(identical(other.appealedAt, appealedAt) || other.appealedAt == appealedAt)&&(identical(other.resolutionNote, resolutionNote) || other.resolutionNote == resolutionNote));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,severity,title,body,issuedAt,status,requiredAction,dueBy,penaltyAmount,referenceId,acknowledgedAt,appealable,appealReason,appealedAt,resolutionNote);

@override
String toString() {
  return 'ComplianceNotice(id: $id, kind: $kind, severity: $severity, title: $title, body: $body, issuedAt: $issuedAt, status: $status, requiredAction: $requiredAction, dueBy: $dueBy, penaltyAmount: $penaltyAmount, referenceId: $referenceId, acknowledgedAt: $acknowledgedAt, appealable: $appealable, appealReason: $appealReason, appealedAt: $appealedAt, resolutionNote: $resolutionNote)';
}


}

/// @nodoc
abstract mixin class _$ComplianceNoticeCopyWith<$Res> implements $ComplianceNoticeCopyWith<$Res> {
  factory _$ComplianceNoticeCopyWith(_ComplianceNotice value, $Res Function(_ComplianceNotice) _then) = __$ComplianceNoticeCopyWithImpl;
@override @useResult
$Res call({
 String id, ComplianceKind kind, ComplianceSeverity severity, String title, String body, DateTime issuedAt, ComplianceStatus status, String? requiredAction, DateTime? dueBy, double? penaltyAmount, String? referenceId, DateTime? acknowledgedAt, bool appealable, String? appealReason, DateTime? appealedAt, String? resolutionNote
});




}
/// @nodoc
class __$ComplianceNoticeCopyWithImpl<$Res>
    implements _$ComplianceNoticeCopyWith<$Res> {
  __$ComplianceNoticeCopyWithImpl(this._self, this._then);

  final _ComplianceNotice _self;
  final $Res Function(_ComplianceNotice) _then;

/// Create a copy of ComplianceNotice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? severity = null,Object? title = null,Object? body = null,Object? issuedAt = null,Object? status = null,Object? requiredAction = freezed,Object? dueBy = freezed,Object? penaltyAmount = freezed,Object? referenceId = freezed,Object? acknowledgedAt = freezed,Object? appealable = null,Object? appealReason = freezed,Object? appealedAt = freezed,Object? resolutionNote = freezed,}) {
  return _then(_ComplianceNotice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ComplianceKind,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as ComplianceSeverity,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,issuedAt: null == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ComplianceStatus,requiredAction: freezed == requiredAction ? _self.requiredAction : requiredAction // ignore: cast_nullable_to_non_nullable
as String?,dueBy: freezed == dueBy ? _self.dueBy : dueBy // ignore: cast_nullable_to_non_nullable
as DateTime?,penaltyAmount: freezed == penaltyAmount ? _self.penaltyAmount : penaltyAmount // ignore: cast_nullable_to_non_nullable
as double?,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,acknowledgedAt: freezed == acknowledgedAt ? _self.acknowledgedAt : acknowledgedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,appealable: null == appealable ? _self.appealable : appealable // ignore: cast_nullable_to_non_nullable
as bool,appealReason: freezed == appealReason ? _self.appealReason : appealReason // ignore: cast_nullable_to_non_nullable
as String?,appealedAt: freezed == appealedAt ? _self.appealedAt : appealedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolutionNote: freezed == resolutionNote ? _self.resolutionNote : resolutionNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
