// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legal_document_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LegalTextModel {

 String get ne; String get en; String? get hi;
/// Create a copy of LegalTextModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalTextModelCopyWith<LegalTextModel> get copyWith => _$LegalTextModelCopyWithImpl<LegalTextModel>(this as LegalTextModel, _$identity);

  /// Serializes this LegalTextModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalTextModel&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.en, en) || other.en == en)&&(identical(other.hi, hi) || other.hi == hi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ne,en,hi);

@override
String toString() {
  return 'LegalTextModel(ne: $ne, en: $en, hi: $hi)';
}


}

/// @nodoc
abstract mixin class $LegalTextModelCopyWith<$Res>  {
  factory $LegalTextModelCopyWith(LegalTextModel value, $Res Function(LegalTextModel) _then) = _$LegalTextModelCopyWithImpl;
@useResult
$Res call({
 String ne, String en, String? hi
});




}
/// @nodoc
class _$LegalTextModelCopyWithImpl<$Res>
    implements $LegalTextModelCopyWith<$Res> {
  _$LegalTextModelCopyWithImpl(this._self, this._then);

  final LegalTextModel _self;
  final $Res Function(LegalTextModel) _then;

/// Create a copy of LegalTextModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ne = null,Object? en = null,Object? hi = freezed,}) {
  return _then(_self.copyWith(
ne: null == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String,en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,hi: freezed == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _LegalTextModel extends LegalTextModel {
  const _LegalTextModel({this.ne = '', this.en = '', this.hi}): super._();
  factory _LegalTextModel.fromJson(Map<String, dynamic> json) => _$LegalTextModelFromJson(json);

@override@JsonKey() final  String ne;
@override@JsonKey() final  String en;
@override final  String? hi;

/// Create a copy of LegalTextModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalTextModelCopyWith<_LegalTextModel> get copyWith => __$LegalTextModelCopyWithImpl<_LegalTextModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LegalTextModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalTextModel&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.en, en) || other.en == en)&&(identical(other.hi, hi) || other.hi == hi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ne,en,hi);

@override
String toString() {
  return 'LegalTextModel(ne: $ne, en: $en, hi: $hi)';
}


}

/// @nodoc
abstract mixin class _$LegalTextModelCopyWith<$Res> implements $LegalTextModelCopyWith<$Res> {
  factory _$LegalTextModelCopyWith(_LegalTextModel value, $Res Function(_LegalTextModel) _then) = __$LegalTextModelCopyWithImpl;
@override @useResult
$Res call({
 String ne, String en, String? hi
});




}
/// @nodoc
class __$LegalTextModelCopyWithImpl<$Res>
    implements _$LegalTextModelCopyWith<$Res> {
  __$LegalTextModelCopyWithImpl(this._self, this._then);

  final _LegalTextModel _self;
  final $Res Function(_LegalTextModel) _then;

/// Create a copy of LegalTextModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ne = null,Object? en = null,Object? hi = freezed,}) {
  return _then(_LegalTextModel(
ne: null == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String,en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,hi: freezed == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LegalSectionModel {

 LegalTextModel get heading; LegalTextModel get body; int get level;
/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalSectionModelCopyWith<LegalSectionModel> get copyWith => _$LegalSectionModelCopyWithImpl<LegalSectionModel>(this as LegalSectionModel, _$identity);

  /// Serializes this LegalSectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalSectionModel&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.body, body) || other.body == body)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,heading,body,level);

@override
String toString() {
  return 'LegalSectionModel(heading: $heading, body: $body, level: $level)';
}


}

/// @nodoc
abstract mixin class $LegalSectionModelCopyWith<$Res>  {
  factory $LegalSectionModelCopyWith(LegalSectionModel value, $Res Function(LegalSectionModel) _then) = _$LegalSectionModelCopyWithImpl;
@useResult
$Res call({
 LegalTextModel heading, LegalTextModel body, int level
});


$LegalTextModelCopyWith<$Res> get heading;$LegalTextModelCopyWith<$Res> get body;

}
/// @nodoc
class _$LegalSectionModelCopyWithImpl<$Res>
    implements $LegalSectionModelCopyWith<$Res> {
  _$LegalSectionModelCopyWithImpl(this._self, this._then);

  final LegalSectionModel _self;
  final $Res Function(LegalSectionModel) _then;

/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? heading = null,Object? body = null,Object? level = null,}) {
  return _then(_self.copyWith(
heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as LegalTextModel,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as LegalTextModel,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextModelCopyWith<$Res> get heading {
  
  return $LegalTextModelCopyWith<$Res>(_self.heading, (value) {
    return _then(_self.copyWith(heading: value));
  });
}/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextModelCopyWith<$Res> get body {
  
  return $LegalTextModelCopyWith<$Res>(_self.body, (value) {
    return _then(_self.copyWith(body: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _LegalSectionModel extends LegalSectionModel {
  const _LegalSectionModel({required this.heading, required this.body, this.level = 1}): super._();
  factory _LegalSectionModel.fromJson(Map<String, dynamic> json) => _$LegalSectionModelFromJson(json);

@override final  LegalTextModel heading;
@override final  LegalTextModel body;
@override@JsonKey() final  int level;

/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalSectionModelCopyWith<_LegalSectionModel> get copyWith => __$LegalSectionModelCopyWithImpl<_LegalSectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LegalSectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalSectionModel&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.body, body) || other.body == body)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,heading,body,level);

@override
String toString() {
  return 'LegalSectionModel(heading: $heading, body: $body, level: $level)';
}


}

/// @nodoc
abstract mixin class _$LegalSectionModelCopyWith<$Res> implements $LegalSectionModelCopyWith<$Res> {
  factory _$LegalSectionModelCopyWith(_LegalSectionModel value, $Res Function(_LegalSectionModel) _then) = __$LegalSectionModelCopyWithImpl;
@override @useResult
$Res call({
 LegalTextModel heading, LegalTextModel body, int level
});


@override $LegalTextModelCopyWith<$Res> get heading;@override $LegalTextModelCopyWith<$Res> get body;

}
/// @nodoc
class __$LegalSectionModelCopyWithImpl<$Res>
    implements _$LegalSectionModelCopyWith<$Res> {
  __$LegalSectionModelCopyWithImpl(this._self, this._then);

  final _LegalSectionModel _self;
  final $Res Function(_LegalSectionModel) _then;

/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? heading = null,Object? body = null,Object? level = null,}) {
  return _then(_LegalSectionModel(
heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as LegalTextModel,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as LegalTextModel,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextModelCopyWith<$Res> get heading {
  
  return $LegalTextModelCopyWith<$Res>(_self.heading, (value) {
    return _then(_self.copyWith(heading: value));
  });
}/// Create a copy of LegalSectionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextModelCopyWith<$Res> get body {
  
  return $LegalTextModelCopyWith<$Res>(_self.body, (value) {
    return _then(_self.copyWith(body: value));
  });
}
}


/// @nodoc
mixin _$LegalDocumentModel {

 LegalDocumentType get type; LegalTextModel get title; LegalTextModel get intro; DateTime get lastUpdated; List<LegalSectionModel> get sections;
/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalDocumentModelCopyWith<LegalDocumentModel> get copyWith => _$LegalDocumentModelCopyWithImpl<LegalDocumentModel>(this as LegalDocumentModel, _$identity);

  /// Serializes this LegalDocumentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalDocumentModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other.sections, sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,intro,lastUpdated,const DeepCollectionEquality().hash(sections));

@override
String toString() {
  return 'LegalDocumentModel(type: $type, title: $title, intro: $intro, lastUpdated: $lastUpdated, sections: $sections)';
}


}

/// @nodoc
abstract mixin class $LegalDocumentModelCopyWith<$Res>  {
  factory $LegalDocumentModelCopyWith(LegalDocumentModel value, $Res Function(LegalDocumentModel) _then) = _$LegalDocumentModelCopyWithImpl;
@useResult
$Res call({
 LegalDocumentType type, LegalTextModel title, LegalTextModel intro, DateTime lastUpdated, List<LegalSectionModel> sections
});


$LegalTextModelCopyWith<$Res> get title;$LegalTextModelCopyWith<$Res> get intro;

}
/// @nodoc
class _$LegalDocumentModelCopyWithImpl<$Res>
    implements $LegalDocumentModelCopyWith<$Res> {
  _$LegalDocumentModelCopyWithImpl(this._self, this._then);

  final LegalDocumentModel _self;
  final $Res Function(LegalDocumentModel) _then;

/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = null,Object? intro = null,Object? lastUpdated = null,Object? sections = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LegalDocumentType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LegalTextModel,intro: null == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as LegalTextModel,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<LegalSectionModel>,
  ));
}
/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextModelCopyWith<$Res> get title {
  
  return $LegalTextModelCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextModelCopyWith<$Res> get intro {
  
  return $LegalTextModelCopyWith<$Res>(_self.intro, (value) {
    return _then(_self.copyWith(intro: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _LegalDocumentModel extends LegalDocumentModel {
  const _LegalDocumentModel({this.type = LegalDocumentType.privacyPolicy, required this.title, required this.intro, required this.lastUpdated, final  List<LegalSectionModel> sections = const <LegalSectionModel>[]}): _sections = sections,super._();
  factory _LegalDocumentModel.fromJson(Map<String, dynamic> json) => _$LegalDocumentModelFromJson(json);

@override@JsonKey() final  LegalDocumentType type;
@override final  LegalTextModel title;
@override final  LegalTextModel intro;
@override final  DateTime lastUpdated;
 final  List<LegalSectionModel> _sections;
@override@JsonKey() List<LegalSectionModel> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}


/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalDocumentModelCopyWith<_LegalDocumentModel> get copyWith => __$LegalDocumentModelCopyWithImpl<_LegalDocumentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LegalDocumentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalDocumentModel&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other._sections, _sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,intro,lastUpdated,const DeepCollectionEquality().hash(_sections));

@override
String toString() {
  return 'LegalDocumentModel(type: $type, title: $title, intro: $intro, lastUpdated: $lastUpdated, sections: $sections)';
}


}

/// @nodoc
abstract mixin class _$LegalDocumentModelCopyWith<$Res> implements $LegalDocumentModelCopyWith<$Res> {
  factory _$LegalDocumentModelCopyWith(_LegalDocumentModel value, $Res Function(_LegalDocumentModel) _then) = __$LegalDocumentModelCopyWithImpl;
@override @useResult
$Res call({
 LegalDocumentType type, LegalTextModel title, LegalTextModel intro, DateTime lastUpdated, List<LegalSectionModel> sections
});


@override $LegalTextModelCopyWith<$Res> get title;@override $LegalTextModelCopyWith<$Res> get intro;

}
/// @nodoc
class __$LegalDocumentModelCopyWithImpl<$Res>
    implements _$LegalDocumentModelCopyWith<$Res> {
  __$LegalDocumentModelCopyWithImpl(this._self, this._then);

  final _LegalDocumentModel _self;
  final $Res Function(_LegalDocumentModel) _then;

/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? intro = null,Object? lastUpdated = null,Object? sections = null,}) {
  return _then(_LegalDocumentModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LegalDocumentType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LegalTextModel,intro: null == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as LegalTextModel,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<LegalSectionModel>,
  ));
}

/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextModelCopyWith<$Res> get title {
  
  return $LegalTextModelCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of LegalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextModelCopyWith<$Res> get intro {
  
  return $LegalTextModelCopyWith<$Res>(_self.intro, (value) {
    return _then(_self.copyWith(intro: value));
  });
}
}

// dart format on
