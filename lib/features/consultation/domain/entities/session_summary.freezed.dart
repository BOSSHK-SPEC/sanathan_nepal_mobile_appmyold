// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Remedy {

 RemedyKind get kind; LocalizedText get title; LocalizedText get description;/// Links into the marketplace when the remedy is purchasable.
 String? get productId;
/// Create a copy of Remedy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemedyCopyWith<Remedy> get copyWith => _$RemedyCopyWithImpl<Remedy>(this as Remedy, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Remedy&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,kind,title,description,productId);

@override
String toString() {
  return 'Remedy(kind: $kind, title: $title, description: $description, productId: $productId)';
}


}

/// @nodoc
abstract mixin class $RemedyCopyWith<$Res>  {
  factory $RemedyCopyWith(Remedy value, $Res Function(Remedy) _then) = _$RemedyCopyWithImpl;
@useResult
$Res call({
 RemedyKind kind, LocalizedText title, LocalizedText description, String? productId
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get description;

}
/// @nodoc
class _$RemedyCopyWithImpl<$Res>
    implements $RemedyCopyWith<$Res> {
  _$RemedyCopyWithImpl(this._self, this._then);

  final Remedy _self;
  final $Res Function(Remedy) _then;

/// Create a copy of Remedy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? title = null,Object? description = null,Object? productId = freezed,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RemedyKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedText,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Remedy
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Remedy
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get description {
  
  return $LocalizedTextCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}



/// @nodoc


class _Remedy extends Remedy {
  const _Remedy({required this.kind, required this.title, required this.description, this.productId}): super._();
  

@override final  RemedyKind kind;
@override final  LocalizedText title;
@override final  LocalizedText description;
/// Links into the marketplace when the remedy is purchasable.
@override final  String? productId;

/// Create a copy of Remedy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemedyCopyWith<_Remedy> get copyWith => __$RemedyCopyWithImpl<_Remedy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Remedy&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,kind,title,description,productId);

@override
String toString() {
  return 'Remedy(kind: $kind, title: $title, description: $description, productId: $productId)';
}


}

/// @nodoc
abstract mixin class _$RemedyCopyWith<$Res> implements $RemedyCopyWith<$Res> {
  factory _$RemedyCopyWith(_Remedy value, $Res Function(_Remedy) _then) = __$RemedyCopyWithImpl;
@override @useResult
$Res call({
 RemedyKind kind, LocalizedText title, LocalizedText description, String? productId
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get description;

}
/// @nodoc
class __$RemedyCopyWithImpl<$Res>
    implements _$RemedyCopyWith<$Res> {
  __$RemedyCopyWithImpl(this._self, this._then);

  final _Remedy _self;
  final $Res Function(_Remedy) _then;

/// Create a copy of Remedy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? title = null,Object? description = null,Object? productId = freezed,}) {
  return _then(_Remedy(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RemedyKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedText,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Remedy
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Remedy
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get description {
  
  return $LocalizedTextCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}

/// @nodoc
mixin _$SessionSummary {

 String get consultationId; String get notes; List<Remedy> get remedies;/// Present once a chat transcript or call recording is available.
 bool get hasTranscript; String? get recordingUrl;
/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionSummaryCopyWith<SessionSummary> get copyWith => _$SessionSummaryCopyWithImpl<SessionSummary>(this as SessionSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSummary&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.remedies, remedies)&&(identical(other.hasTranscript, hasTranscript) || other.hasTranscript == hasTranscript)&&(identical(other.recordingUrl, recordingUrl) || other.recordingUrl == recordingUrl));
}


@override
int get hashCode => Object.hash(runtimeType,consultationId,notes,const DeepCollectionEquality().hash(remedies),hasTranscript,recordingUrl);

@override
String toString() {
  return 'SessionSummary(consultationId: $consultationId, notes: $notes, remedies: $remedies, hasTranscript: $hasTranscript, recordingUrl: $recordingUrl)';
}


}

/// @nodoc
abstract mixin class $SessionSummaryCopyWith<$Res>  {
  factory $SessionSummaryCopyWith(SessionSummary value, $Res Function(SessionSummary) _then) = _$SessionSummaryCopyWithImpl;
@useResult
$Res call({
 String consultationId, String notes, List<Remedy> remedies, bool hasTranscript, String? recordingUrl
});




}
/// @nodoc
class _$SessionSummaryCopyWithImpl<$Res>
    implements $SessionSummaryCopyWith<$Res> {
  _$SessionSummaryCopyWithImpl(this._self, this._then);

  final SessionSummary _self;
  final $Res Function(SessionSummary) _then;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? consultationId = null,Object? notes = null,Object? remedies = null,Object? hasTranscript = null,Object? recordingUrl = freezed,}) {
  return _then(_self.copyWith(
consultationId: null == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,remedies: null == remedies ? _self.remedies : remedies // ignore: cast_nullable_to_non_nullable
as List<Remedy>,hasTranscript: null == hasTranscript ? _self.hasTranscript : hasTranscript // ignore: cast_nullable_to_non_nullable
as bool,recordingUrl: freezed == recordingUrl ? _self.recordingUrl : recordingUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _SessionSummary extends SessionSummary {
  const _SessionSummary({required this.consultationId, this.notes = '', final  List<Remedy> remedies = const <Remedy>[], this.hasTranscript = false, this.recordingUrl}): _remedies = remedies,super._();
  

@override final  String consultationId;
@override@JsonKey() final  String notes;
 final  List<Remedy> _remedies;
@override@JsonKey() List<Remedy> get remedies {
  if (_remedies is EqualUnmodifiableListView) return _remedies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_remedies);
}

/// Present once a chat transcript or call recording is available.
@override@JsonKey() final  bool hasTranscript;
@override final  String? recordingUrl;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionSummaryCopyWith<_SessionSummary> get copyWith => __$SessionSummaryCopyWithImpl<_SessionSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionSummary&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._remedies, _remedies)&&(identical(other.hasTranscript, hasTranscript) || other.hasTranscript == hasTranscript)&&(identical(other.recordingUrl, recordingUrl) || other.recordingUrl == recordingUrl));
}


@override
int get hashCode => Object.hash(runtimeType,consultationId,notes,const DeepCollectionEquality().hash(_remedies),hasTranscript,recordingUrl);

@override
String toString() {
  return 'SessionSummary(consultationId: $consultationId, notes: $notes, remedies: $remedies, hasTranscript: $hasTranscript, recordingUrl: $recordingUrl)';
}


}

/// @nodoc
abstract mixin class _$SessionSummaryCopyWith<$Res> implements $SessionSummaryCopyWith<$Res> {
  factory _$SessionSummaryCopyWith(_SessionSummary value, $Res Function(_SessionSummary) _then) = __$SessionSummaryCopyWithImpl;
@override @useResult
$Res call({
 String consultationId, String notes, List<Remedy> remedies, bool hasTranscript, String? recordingUrl
});




}
/// @nodoc
class __$SessionSummaryCopyWithImpl<$Res>
    implements _$SessionSummaryCopyWith<$Res> {
  __$SessionSummaryCopyWithImpl(this._self, this._then);

  final _SessionSummary _self;
  final $Res Function(_SessionSummary) _then;

/// Create a copy of SessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? consultationId = null,Object? notes = null,Object? remedies = null,Object? hasTranscript = null,Object? recordingUrl = freezed,}) {
  return _then(_SessionSummary(
consultationId: null == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,remedies: null == remedies ? _self._remedies : remedies // ignore: cast_nullable_to_non_nullable
as List<Remedy>,hasTranscript: null == hasTranscript ? _self.hasTranscript : hasTranscript // ignore: cast_nullable_to_non_nullable
as bool,recordingUrl: freezed == recordingUrl ? _self.recordingUrl : recordingUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
