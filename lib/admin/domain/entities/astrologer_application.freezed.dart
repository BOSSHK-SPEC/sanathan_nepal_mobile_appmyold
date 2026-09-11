// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AstrologerApplication {

 String get id; String get userId; String get fullName; ApplicationStatus get status; int get experienceYears; DateTime? get submittedAt;/// KYC documents, keyed by kind (`citizenship`, `certificate`, …). The
/// values are media object ids, resolved to a URL only when opened — a
/// reviewer's screen should not fetch every applicant's papers at once.
 Map<String, String> get documents;
/// Create a copy of AstrologerApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerApplicationCopyWith<AstrologerApplication> get copyWith => _$AstrologerApplicationCopyWithImpl<AstrologerApplication>(this as AstrologerApplication, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.status, status) || other.status == status)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&const DeepCollectionEquality().equals(other.documents, documents));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,status,experienceYears,submittedAt,const DeepCollectionEquality().hash(documents));

@override
String toString() {
  return 'AstrologerApplication(id: $id, userId: $userId, fullName: $fullName, status: $status, experienceYears: $experienceYears, submittedAt: $submittedAt, documents: $documents)';
}


}

/// @nodoc
abstract mixin class $AstrologerApplicationCopyWith<$Res>  {
  factory $AstrologerApplicationCopyWith(AstrologerApplication value, $Res Function(AstrologerApplication) _then) = _$AstrologerApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String fullName, ApplicationStatus status, int experienceYears, DateTime? submittedAt, Map<String, String> documents
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? status = null,Object? experienceYears = null,Object? submittedAt = freezed,Object? documents = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}



/// @nodoc


class _AstrologerApplication implements AstrologerApplication {
  const _AstrologerApplication({required this.id, required this.userId, required this.fullName, required this.status, this.experienceYears = 0, this.submittedAt, final  Map<String, String> documents = const <String, String>{}}): _documents = documents;
  

@override final  String id;
@override final  String userId;
@override final  String fullName;
@override final  ApplicationStatus status;
@override@JsonKey() final  int experienceYears;
@override final  DateTime? submittedAt;
/// KYC documents, keyed by kind (`citizenship`, `certificate`, …). The
/// values are media object ids, resolved to a URL only when opened — a
/// reviewer's screen should not fetch every applicant's papers at once.
 final  Map<String, String> _documents;
/// KYC documents, keyed by kind (`citizenship`, `certificate`, …). The
/// values are media object ids, resolved to a URL only when opened — a
/// reviewer's screen should not fetch every applicant's papers at once.
@override@JsonKey() Map<String, String> get documents {
  if (_documents is EqualUnmodifiableMapView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_documents);
}


/// Create a copy of AstrologerApplication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerApplicationCopyWith<_AstrologerApplication> get copyWith => __$AstrologerApplicationCopyWithImpl<_AstrologerApplication>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.status, status) || other.status == status)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&const DeepCollectionEquality().equals(other._documents, _documents));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,status,experienceYears,submittedAt,const DeepCollectionEquality().hash(_documents));

@override
String toString() {
  return 'AstrologerApplication(id: $id, userId: $userId, fullName: $fullName, status: $status, experienceYears: $experienceYears, submittedAt: $submittedAt, documents: $documents)';
}


}

/// @nodoc
abstract mixin class _$AstrologerApplicationCopyWith<$Res> implements $AstrologerApplicationCopyWith<$Res> {
  factory _$AstrologerApplicationCopyWith(_AstrologerApplication value, $Res Function(_AstrologerApplication) _then) = __$AstrologerApplicationCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String fullName, ApplicationStatus status, int experienceYears, DateTime? submittedAt, Map<String, String> documents
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? status = null,Object? experienceYears = null,Object? submittedAt = freezed,Object? documents = null,}) {
  return _then(_AstrologerApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

// dart format on
