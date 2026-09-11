// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchased_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchasedReport {

 String get id; String get productId; ReportKind get kind; String get title; String get profileName; double get pricePaid; DateTime get purchasedAt; ReportStatus get status;/// Present once [status] is ready.
 String? get fileRef; int? get pageCount; DateTime? get readyAt;/// Why generation failed, shown instead of a generic error so support
/// has something to act on.
 String? get failureReason;/// The second profile, for matching reports.
 String? get partnerName;
/// Create a copy of PurchasedReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchasedReportCopyWith<PurchasedReport> get copyWith => _$PurchasedReportCopyWithImpl<PurchasedReport>(this as PurchasedReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchasedReport&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.profileName, profileName) || other.profileName == profileName)&&(identical(other.pricePaid, pricePaid) || other.pricePaid == pricePaid)&&(identical(other.purchasedAt, purchasedAt) || other.purchasedAt == purchasedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.fileRef, fileRef) || other.fileRef == fileRef)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.readyAt, readyAt) || other.readyAt == readyAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.partnerName, partnerName) || other.partnerName == partnerName));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,kind,title,profileName,pricePaid,purchasedAt,status,fileRef,pageCount,readyAt,failureReason,partnerName);

@override
String toString() {
  return 'PurchasedReport(id: $id, productId: $productId, kind: $kind, title: $title, profileName: $profileName, pricePaid: $pricePaid, purchasedAt: $purchasedAt, status: $status, fileRef: $fileRef, pageCount: $pageCount, readyAt: $readyAt, failureReason: $failureReason, partnerName: $partnerName)';
}


}

/// @nodoc
abstract mixin class $PurchasedReportCopyWith<$Res>  {
  factory $PurchasedReportCopyWith(PurchasedReport value, $Res Function(PurchasedReport) _then) = _$PurchasedReportCopyWithImpl;
@useResult
$Res call({
 String id, String productId, ReportKind kind, String title, String profileName, double pricePaid, DateTime purchasedAt, ReportStatus status, String? fileRef, int? pageCount, DateTime? readyAt, String? failureReason, String? partnerName
});




}
/// @nodoc
class _$PurchasedReportCopyWithImpl<$Res>
    implements $PurchasedReportCopyWith<$Res> {
  _$PurchasedReportCopyWithImpl(this._self, this._then);

  final PurchasedReport _self;
  final $Res Function(PurchasedReport) _then;

/// Create a copy of PurchasedReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? kind = null,Object? title = null,Object? profileName = null,Object? pricePaid = null,Object? purchasedAt = null,Object? status = null,Object? fileRef = freezed,Object? pageCount = freezed,Object? readyAt = freezed,Object? failureReason = freezed,Object? partnerName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReportKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,profileName: null == profileName ? _self.profileName : profileName // ignore: cast_nullable_to_non_nullable
as String,pricePaid: null == pricePaid ? _self.pricePaid : pricePaid // ignore: cast_nullable_to_non_nullable
as double,purchasedAt: null == purchasedAt ? _self.purchasedAt : purchasedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReportStatus,fileRef: freezed == fileRef ? _self.fileRef : fileRef // ignore: cast_nullable_to_non_nullable
as String?,pageCount: freezed == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int?,readyAt: freezed == readyAt ? _self.readyAt : readyAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,partnerName: freezed == partnerName ? _self.partnerName : partnerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _PurchasedReport extends PurchasedReport {
  const _PurchasedReport({required this.id, required this.productId, required this.kind, required this.title, required this.profileName, required this.pricePaid, required this.purchasedAt, this.status = ReportStatus.generating, this.fileRef, this.pageCount, this.readyAt, this.failureReason, this.partnerName}): super._();
  

@override final  String id;
@override final  String productId;
@override final  ReportKind kind;
@override final  String title;
@override final  String profileName;
@override final  double pricePaid;
@override final  DateTime purchasedAt;
@override@JsonKey() final  ReportStatus status;
/// Present once [status] is ready.
@override final  String? fileRef;
@override final  int? pageCount;
@override final  DateTime? readyAt;
/// Why generation failed, shown instead of a generic error so support
/// has something to act on.
@override final  String? failureReason;
/// The second profile, for matching reports.
@override final  String? partnerName;

/// Create a copy of PurchasedReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchasedReportCopyWith<_PurchasedReport> get copyWith => __$PurchasedReportCopyWithImpl<_PurchasedReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchasedReport&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.profileName, profileName) || other.profileName == profileName)&&(identical(other.pricePaid, pricePaid) || other.pricePaid == pricePaid)&&(identical(other.purchasedAt, purchasedAt) || other.purchasedAt == purchasedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.fileRef, fileRef) || other.fileRef == fileRef)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.readyAt, readyAt) || other.readyAt == readyAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.partnerName, partnerName) || other.partnerName == partnerName));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,kind,title,profileName,pricePaid,purchasedAt,status,fileRef,pageCount,readyAt,failureReason,partnerName);

@override
String toString() {
  return 'PurchasedReport(id: $id, productId: $productId, kind: $kind, title: $title, profileName: $profileName, pricePaid: $pricePaid, purchasedAt: $purchasedAt, status: $status, fileRef: $fileRef, pageCount: $pageCount, readyAt: $readyAt, failureReason: $failureReason, partnerName: $partnerName)';
}


}

/// @nodoc
abstract mixin class _$PurchasedReportCopyWith<$Res> implements $PurchasedReportCopyWith<$Res> {
  factory _$PurchasedReportCopyWith(_PurchasedReport value, $Res Function(_PurchasedReport) _then) = __$PurchasedReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, ReportKind kind, String title, String profileName, double pricePaid, DateTime purchasedAt, ReportStatus status, String? fileRef, int? pageCount, DateTime? readyAt, String? failureReason, String? partnerName
});




}
/// @nodoc
class __$PurchasedReportCopyWithImpl<$Res>
    implements _$PurchasedReportCopyWith<$Res> {
  __$PurchasedReportCopyWithImpl(this._self, this._then);

  final _PurchasedReport _self;
  final $Res Function(_PurchasedReport) _then;

/// Create a copy of PurchasedReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? kind = null,Object? title = null,Object? profileName = null,Object? pricePaid = null,Object? purchasedAt = null,Object? status = null,Object? fileRef = freezed,Object? pageCount = freezed,Object? readyAt = freezed,Object? failureReason = freezed,Object? partnerName = freezed,}) {
  return _then(_PurchasedReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReportKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,profileName: null == profileName ? _self.profileName : profileName // ignore: cast_nullable_to_non_nullable
as String,pricePaid: null == pricePaid ? _self.pricePaid : pricePaid // ignore: cast_nullable_to_non_nullable
as double,purchasedAt: null == purchasedAt ? _self.purchasedAt : purchasedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReportStatus,fileRef: freezed == fileRef ? _self.fileRef : fileRef // ignore: cast_nullable_to_non_nullable
as String?,pageCount: freezed == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int?,readyAt: freezed == readyAt ? _self.readyAt : readyAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,partnerName: freezed == partnerName ? _self.partnerName : partnerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
