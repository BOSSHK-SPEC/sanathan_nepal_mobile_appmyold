// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KycDocument {

 KycDocumentKind get kind; DocumentStatus get status;/// Local path or URL of the uploaded file.
 String? get fileRef;/// Reviewer's reason when [status] is rejected.
 String? get rejectionReason;
/// Create a copy of KycDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KycDocumentCopyWith<KycDocument> get copyWith => _$KycDocumentCopyWithImpl<KycDocument>(this as KycDocument, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycDocument&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&(identical(other.fileRef, fileRef) || other.fileRef == fileRef)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}


@override
int get hashCode => Object.hash(runtimeType,kind,status,fileRef,rejectionReason);

@override
String toString() {
  return 'KycDocument(kind: $kind, status: $status, fileRef: $fileRef, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class $KycDocumentCopyWith<$Res>  {
  factory $KycDocumentCopyWith(KycDocument value, $Res Function(KycDocument) _then) = _$KycDocumentCopyWithImpl;
@useResult
$Res call({
 KycDocumentKind kind, DocumentStatus status, String? fileRef, String? rejectionReason
});




}
/// @nodoc
class _$KycDocumentCopyWithImpl<$Res>
    implements $KycDocumentCopyWith<$Res> {
  _$KycDocumentCopyWithImpl(this._self, this._then);

  final KycDocument _self;
  final $Res Function(KycDocument) _then;

/// Create a copy of KycDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? status = null,Object? fileRef = freezed,Object? rejectionReason = freezed,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as KycDocumentKind,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,fileRef: freezed == fileRef ? _self.fileRef : fileRef // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _KycDocument extends KycDocument {
  const _KycDocument({required this.kind, this.status = DocumentStatus.missing, this.fileRef, this.rejectionReason}): super._();
  

@override final  KycDocumentKind kind;
@override@JsonKey() final  DocumentStatus status;
/// Local path or URL of the uploaded file.
@override final  String? fileRef;
/// Reviewer's reason when [status] is rejected.
@override final  String? rejectionReason;

/// Create a copy of KycDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycDocumentCopyWith<_KycDocument> get copyWith => __$KycDocumentCopyWithImpl<_KycDocument>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycDocument&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&(identical(other.fileRef, fileRef) || other.fileRef == fileRef)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}


@override
int get hashCode => Object.hash(runtimeType,kind,status,fileRef,rejectionReason);

@override
String toString() {
  return 'KycDocument(kind: $kind, status: $status, fileRef: $fileRef, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class _$KycDocumentCopyWith<$Res> implements $KycDocumentCopyWith<$Res> {
  factory _$KycDocumentCopyWith(_KycDocument value, $Res Function(_KycDocument) _then) = __$KycDocumentCopyWithImpl;
@override @useResult
$Res call({
 KycDocumentKind kind, DocumentStatus status, String? fileRef, String? rejectionReason
});




}
/// @nodoc
class __$KycDocumentCopyWithImpl<$Res>
    implements _$KycDocumentCopyWith<$Res> {
  __$KycDocumentCopyWithImpl(this._self, this._then);

  final _KycDocument _self;
  final $Res Function(_KycDocument) _then;

/// Create a copy of KycDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? status = null,Object? fileRef = freezed,Object? rejectionReason = freezed,}) {
  return _then(_KycDocument(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as KycDocumentKind,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DocumentStatus,fileRef: freezed == fileRef ? _self.fileRef : fileRef // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AstrologerApplication {

 ApplicationStatus get status; String get fullName; String get phone; String get email; int get experienceYears; String get bio; List<Specialty> get specialties; List<String> get languageCodes;/// Per-minute rate by channel; an omitted channel is not offered.
 Map<ConsultChannel, double> get ratePerMinute; List<KycDocument> get documents; String? get introVideoRef;/// Timestamped acceptance of the commission and conduct terms.
 DateTime? get termsAcceptedAt; String get termsVersion; DateTime? get submittedAt; DateTime? get reviewedAt;/// Set when the reviewer rejects or asks for more.
 String? get reviewerNote;
/// Create a copy of AstrologerApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerApplicationCopyWith<AstrologerApplication> get copyWith => _$AstrologerApplicationCopyWithImpl<AstrologerApplication>(this as AstrologerApplication, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerApplication&&(identical(other.status, status) || other.status == status)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.bio, bio) || other.bio == bio)&&const DeepCollectionEquality().equals(other.specialties, specialties)&&const DeepCollectionEquality().equals(other.languageCodes, languageCodes)&&const DeepCollectionEquality().equals(other.ratePerMinute, ratePerMinute)&&const DeepCollectionEquality().equals(other.documents, documents)&&(identical(other.introVideoRef, introVideoRef) || other.introVideoRef == introVideoRef)&&(identical(other.termsAcceptedAt, termsAcceptedAt) || other.termsAcceptedAt == termsAcceptedAt)&&(identical(other.termsVersion, termsVersion) || other.termsVersion == termsVersion)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewerNote, reviewerNote) || other.reviewerNote == reviewerNote));
}


@override
int get hashCode => Object.hash(runtimeType,status,fullName,phone,email,experienceYears,bio,const DeepCollectionEquality().hash(specialties),const DeepCollectionEquality().hash(languageCodes),const DeepCollectionEquality().hash(ratePerMinute),const DeepCollectionEquality().hash(documents),introVideoRef,termsAcceptedAt,termsVersion,submittedAt,reviewedAt,reviewerNote);

@override
String toString() {
  return 'AstrologerApplication(status: $status, fullName: $fullName, phone: $phone, email: $email, experienceYears: $experienceYears, bio: $bio, specialties: $specialties, languageCodes: $languageCodes, ratePerMinute: $ratePerMinute, documents: $documents, introVideoRef: $introVideoRef, termsAcceptedAt: $termsAcceptedAt, termsVersion: $termsVersion, submittedAt: $submittedAt, reviewedAt: $reviewedAt, reviewerNote: $reviewerNote)';
}


}

/// @nodoc
abstract mixin class $AstrologerApplicationCopyWith<$Res>  {
  factory $AstrologerApplicationCopyWith(AstrologerApplication value, $Res Function(AstrologerApplication) _then) = _$AstrologerApplicationCopyWithImpl;
@useResult
$Res call({
 ApplicationStatus status, String fullName, String phone, String email, int experienceYears, String bio, List<Specialty> specialties, List<String> languageCodes, Map<ConsultChannel, double> ratePerMinute, List<KycDocument> documents, String? introVideoRef, DateTime? termsAcceptedAt, String termsVersion, DateTime? submittedAt, DateTime? reviewedAt, String? reviewerNote
});




}
/// @nodoc
class _$AstrologerApplicationCopyWithImpl<$Res>
    implements $AstrologerApplicationCopyWith<$Res> {
  _$AstrologerApplicationCopyWithImpl(this._self, this._then);

  final AstrologerApplication _self;
  final $Res Function(AstrologerApplication) _then;

/// Create a copy of AstrologerApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? fullName = null,Object? phone = null,Object? email = null,Object? experienceYears = null,Object? bio = null,Object? specialties = null,Object? languageCodes = null,Object? ratePerMinute = null,Object? documents = null,Object? introVideoRef = freezed,Object? termsAcceptedAt = freezed,Object? termsVersion = null,Object? submittedAt = freezed,Object? reviewedAt = freezed,Object? reviewerNote = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,specialties: null == specialties ? _self.specialties : specialties // ignore: cast_nullable_to_non_nullable
as List<Specialty>,languageCodes: null == languageCodes ? _self.languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,ratePerMinute: null == ratePerMinute ? _self.ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as Map<ConsultChannel, double>,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<KycDocument>,introVideoRef: freezed == introVideoRef ? _self.introVideoRef : introVideoRef // ignore: cast_nullable_to_non_nullable
as String?,termsAcceptedAt: freezed == termsAcceptedAt ? _self.termsAcceptedAt : termsAcceptedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,termsVersion: null == termsVersion ? _self.termsVersion : termsVersion // ignore: cast_nullable_to_non_nullable
as String,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewerNote: freezed == reviewerNote ? _self.reviewerNote : reviewerNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _AstrologerApplication extends AstrologerApplication {
  const _AstrologerApplication({this.status = ApplicationStatus.notStarted, this.fullName = '', this.phone = '', this.email = '', this.experienceYears = 0, this.bio = '', final  List<Specialty> specialties = const <Specialty>[], final  List<String> languageCodes = const <String>[], final  Map<ConsultChannel, double> ratePerMinute = const <ConsultChannel, double>{}, final  List<KycDocument> documents = const <KycDocument>[], this.introVideoRef, this.termsAcceptedAt, this.termsVersion = '', this.submittedAt, this.reviewedAt, this.reviewerNote}): _specialties = specialties,_languageCodes = languageCodes,_ratePerMinute = ratePerMinute,_documents = documents,super._();
  

@override@JsonKey() final  ApplicationStatus status;
@override@JsonKey() final  String fullName;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String email;
@override@JsonKey() final  int experienceYears;
@override@JsonKey() final  String bio;
 final  List<Specialty> _specialties;
@override@JsonKey() List<Specialty> get specialties {
  if (_specialties is EqualUnmodifiableListView) return _specialties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specialties);
}

 final  List<String> _languageCodes;
@override@JsonKey() List<String> get languageCodes {
  if (_languageCodes is EqualUnmodifiableListView) return _languageCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languageCodes);
}

/// Per-minute rate by channel; an omitted channel is not offered.
 final  Map<ConsultChannel, double> _ratePerMinute;
/// Per-minute rate by channel; an omitted channel is not offered.
@override@JsonKey() Map<ConsultChannel, double> get ratePerMinute {
  if (_ratePerMinute is EqualUnmodifiableMapView) return _ratePerMinute;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratePerMinute);
}

 final  List<KycDocument> _documents;
@override@JsonKey() List<KycDocument> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

@override final  String? introVideoRef;
/// Timestamped acceptance of the commission and conduct terms.
@override final  DateTime? termsAcceptedAt;
@override@JsonKey() final  String termsVersion;
@override final  DateTime? submittedAt;
@override final  DateTime? reviewedAt;
/// Set when the reviewer rejects or asks for more.
@override final  String? reviewerNote;

/// Create a copy of AstrologerApplication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerApplicationCopyWith<_AstrologerApplication> get copyWith => __$AstrologerApplicationCopyWithImpl<_AstrologerApplication>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerApplication&&(identical(other.status, status) || other.status == status)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.bio, bio) || other.bio == bio)&&const DeepCollectionEquality().equals(other._specialties, _specialties)&&const DeepCollectionEquality().equals(other._languageCodes, _languageCodes)&&const DeepCollectionEquality().equals(other._ratePerMinute, _ratePerMinute)&&const DeepCollectionEquality().equals(other._documents, _documents)&&(identical(other.introVideoRef, introVideoRef) || other.introVideoRef == introVideoRef)&&(identical(other.termsAcceptedAt, termsAcceptedAt) || other.termsAcceptedAt == termsAcceptedAt)&&(identical(other.termsVersion, termsVersion) || other.termsVersion == termsVersion)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewerNote, reviewerNote) || other.reviewerNote == reviewerNote));
}


@override
int get hashCode => Object.hash(runtimeType,status,fullName,phone,email,experienceYears,bio,const DeepCollectionEquality().hash(_specialties),const DeepCollectionEquality().hash(_languageCodes),const DeepCollectionEquality().hash(_ratePerMinute),const DeepCollectionEquality().hash(_documents),introVideoRef,termsAcceptedAt,termsVersion,submittedAt,reviewedAt,reviewerNote);

@override
String toString() {
  return 'AstrologerApplication(status: $status, fullName: $fullName, phone: $phone, email: $email, experienceYears: $experienceYears, bio: $bio, specialties: $specialties, languageCodes: $languageCodes, ratePerMinute: $ratePerMinute, documents: $documents, introVideoRef: $introVideoRef, termsAcceptedAt: $termsAcceptedAt, termsVersion: $termsVersion, submittedAt: $submittedAt, reviewedAt: $reviewedAt, reviewerNote: $reviewerNote)';
}


}

/// @nodoc
abstract mixin class _$AstrologerApplicationCopyWith<$Res> implements $AstrologerApplicationCopyWith<$Res> {
  factory _$AstrologerApplicationCopyWith(_AstrologerApplication value, $Res Function(_AstrologerApplication) _then) = __$AstrologerApplicationCopyWithImpl;
@override @useResult
$Res call({
 ApplicationStatus status, String fullName, String phone, String email, int experienceYears, String bio, List<Specialty> specialties, List<String> languageCodes, Map<ConsultChannel, double> ratePerMinute, List<KycDocument> documents, String? introVideoRef, DateTime? termsAcceptedAt, String termsVersion, DateTime? submittedAt, DateTime? reviewedAt, String? reviewerNote
});




}
/// @nodoc
class __$AstrologerApplicationCopyWithImpl<$Res>
    implements _$AstrologerApplicationCopyWith<$Res> {
  __$AstrologerApplicationCopyWithImpl(this._self, this._then);

  final _AstrologerApplication _self;
  final $Res Function(_AstrologerApplication) _then;

/// Create a copy of AstrologerApplication
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? fullName = null,Object? phone = null,Object? email = null,Object? experienceYears = null,Object? bio = null,Object? specialties = null,Object? languageCodes = null,Object? ratePerMinute = null,Object? documents = null,Object? introVideoRef = freezed,Object? termsAcceptedAt = freezed,Object? termsVersion = null,Object? submittedAt = freezed,Object? reviewedAt = freezed,Object? reviewerNote = freezed,}) {
  return _then(_AstrologerApplication(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,bio: null == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String,specialties: null == specialties ? _self._specialties : specialties // ignore: cast_nullable_to_non_nullable
as List<Specialty>,languageCodes: null == languageCodes ? _self._languageCodes : languageCodes // ignore: cast_nullable_to_non_nullable
as List<String>,ratePerMinute: null == ratePerMinute ? _self._ratePerMinute : ratePerMinute // ignore: cast_nullable_to_non_nullable
as Map<ConsultChannel, double>,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<KycDocument>,introVideoRef: freezed == introVideoRef ? _self.introVideoRef : introVideoRef // ignore: cast_nullable_to_non_nullable
as String?,termsAcceptedAt: freezed == termsAcceptedAt ? _self.termsAcceptedAt : termsAcceptedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,termsVersion: null == termsVersion ? _self.termsVersion : termsVersion // ignore: cast_nullable_to_non_nullable
as String,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewerNote: freezed == reviewerNote ? _self.reviewerNote : reviewerNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
