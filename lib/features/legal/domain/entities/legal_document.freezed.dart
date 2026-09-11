// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legal_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LegalText {

 String get ne; String get en; String? get hi;
/// Create a copy of LegalText
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalTextCopyWith<LegalText> get copyWith => _$LegalTextCopyWithImpl<LegalText>(this as LegalText, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalText&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.en, en) || other.en == en)&&(identical(other.hi, hi) || other.hi == hi));
}


@override
int get hashCode => Object.hash(runtimeType,ne,en,hi);

@override
String toString() {
  return 'LegalText(ne: $ne, en: $en, hi: $hi)';
}


}

/// @nodoc
abstract mixin class $LegalTextCopyWith<$Res>  {
  factory $LegalTextCopyWith(LegalText value, $Res Function(LegalText) _then) = _$LegalTextCopyWithImpl;
@useResult
$Res call({
 String ne, String en, String? hi
});




}
/// @nodoc
class _$LegalTextCopyWithImpl<$Res>
    implements $LegalTextCopyWith<$Res> {
  _$LegalTextCopyWithImpl(this._self, this._then);

  final LegalText _self;
  final $Res Function(LegalText) _then;

/// Create a copy of LegalText
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


class _LegalText extends LegalText {
  const _LegalText({required this.ne, required this.en, this.hi}): super._();
  

@override final  String ne;
@override final  String en;
@override final  String? hi;

/// Create a copy of LegalText
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalTextCopyWith<_LegalText> get copyWith => __$LegalTextCopyWithImpl<_LegalText>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalText&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.en, en) || other.en == en)&&(identical(other.hi, hi) || other.hi == hi));
}


@override
int get hashCode => Object.hash(runtimeType,ne,en,hi);

@override
String toString() {
  return 'LegalText(ne: $ne, en: $en, hi: $hi)';
}


}

/// @nodoc
abstract mixin class _$LegalTextCopyWith<$Res> implements $LegalTextCopyWith<$Res> {
  factory _$LegalTextCopyWith(_LegalText value, $Res Function(_LegalText) _then) = __$LegalTextCopyWithImpl;
@override @useResult
$Res call({
 String ne, String en, String? hi
});




}
/// @nodoc
class __$LegalTextCopyWithImpl<$Res>
    implements _$LegalTextCopyWith<$Res> {
  __$LegalTextCopyWithImpl(this._self, this._then);

  final _LegalText _self;
  final $Res Function(_LegalText) _then;

/// Create a copy of LegalText
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ne = null,Object? en = null,Object? hi = freezed,}) {
  return _then(_LegalText(
ne: null == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String,en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,hi: freezed == hi ? _self.hi : hi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$LegalSection {

 LegalText get heading; LegalText get body; int get level;
/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalSectionCopyWith<LegalSection> get copyWith => _$LegalSectionCopyWithImpl<LegalSection>(this as LegalSection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalSection&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.body, body) || other.body == body)&&(identical(other.level, level) || other.level == level));
}


@override
int get hashCode => Object.hash(runtimeType,heading,body,level);

@override
String toString() {
  return 'LegalSection(heading: $heading, body: $body, level: $level)';
}


}

/// @nodoc
abstract mixin class $LegalSectionCopyWith<$Res>  {
  factory $LegalSectionCopyWith(LegalSection value, $Res Function(LegalSection) _then) = _$LegalSectionCopyWithImpl;
@useResult
$Res call({
 LegalText heading, LegalText body, int level
});


$LegalTextCopyWith<$Res> get heading;$LegalTextCopyWith<$Res> get body;

}
/// @nodoc
class _$LegalSectionCopyWithImpl<$Res>
    implements $LegalSectionCopyWith<$Res> {
  _$LegalSectionCopyWithImpl(this._self, this._then);

  final LegalSection _self;
  final $Res Function(LegalSection) _then;

/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? heading = null,Object? body = null,Object? level = null,}) {
  return _then(_self.copyWith(
heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as LegalText,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as LegalText,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextCopyWith<$Res> get heading {
  
  return $LegalTextCopyWith<$Res>(_self.heading, (value) {
    return _then(_self.copyWith(heading: value));
  });
}/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextCopyWith<$Res> get body {
  
  return $LegalTextCopyWith<$Res>(_self.body, (value) {
    return _then(_self.copyWith(body: value));
  });
}
}



/// @nodoc


class _LegalSection implements LegalSection {
  const _LegalSection({required this.heading, required this.body, this.level = 1});
  

@override final  LegalText heading;
@override final  LegalText body;
@override@JsonKey() final  int level;

/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalSectionCopyWith<_LegalSection> get copyWith => __$LegalSectionCopyWithImpl<_LegalSection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalSection&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.body, body) || other.body == body)&&(identical(other.level, level) || other.level == level));
}


@override
int get hashCode => Object.hash(runtimeType,heading,body,level);

@override
String toString() {
  return 'LegalSection(heading: $heading, body: $body, level: $level)';
}


}

/// @nodoc
abstract mixin class _$LegalSectionCopyWith<$Res> implements $LegalSectionCopyWith<$Res> {
  factory _$LegalSectionCopyWith(_LegalSection value, $Res Function(_LegalSection) _then) = __$LegalSectionCopyWithImpl;
@override @useResult
$Res call({
 LegalText heading, LegalText body, int level
});


@override $LegalTextCopyWith<$Res> get heading;@override $LegalTextCopyWith<$Res> get body;

}
/// @nodoc
class __$LegalSectionCopyWithImpl<$Res>
    implements _$LegalSectionCopyWith<$Res> {
  __$LegalSectionCopyWithImpl(this._self, this._then);

  final _LegalSection _self;
  final $Res Function(_LegalSection) _then;

/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? heading = null,Object? body = null,Object? level = null,}) {
  return _then(_LegalSection(
heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as LegalText,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as LegalText,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextCopyWith<$Res> get heading {
  
  return $LegalTextCopyWith<$Res>(_self.heading, (value) {
    return _then(_self.copyWith(heading: value));
  });
}/// Create a copy of LegalSection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextCopyWith<$Res> get body {
  
  return $LegalTextCopyWith<$Res>(_self.body, (value) {
    return _then(_self.copyWith(body: value));
  });
}
}

/// @nodoc
mixin _$LegalDocument {

 LegalDocumentType get type; LegalText get title; LegalText get intro; DateTime get lastUpdated; List<LegalSection> get sections;
/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LegalDocumentCopyWith<LegalDocument> get copyWith => _$LegalDocumentCopyWithImpl<LegalDocument>(this as LegalDocument, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LegalDocument&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other.sections, sections));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,intro,lastUpdated,const DeepCollectionEquality().hash(sections));

@override
String toString() {
  return 'LegalDocument(type: $type, title: $title, intro: $intro, lastUpdated: $lastUpdated, sections: $sections)';
}


}

/// @nodoc
abstract mixin class $LegalDocumentCopyWith<$Res>  {
  factory $LegalDocumentCopyWith(LegalDocument value, $Res Function(LegalDocument) _then) = _$LegalDocumentCopyWithImpl;
@useResult
$Res call({
 LegalDocumentType type, LegalText title, LegalText intro, DateTime lastUpdated, List<LegalSection> sections
});


$LegalTextCopyWith<$Res> get title;$LegalTextCopyWith<$Res> get intro;

}
/// @nodoc
class _$LegalDocumentCopyWithImpl<$Res>
    implements $LegalDocumentCopyWith<$Res> {
  _$LegalDocumentCopyWithImpl(this._self, this._then);

  final LegalDocument _self;
  final $Res Function(LegalDocument) _then;

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = null,Object? intro = null,Object? lastUpdated = null,Object? sections = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LegalDocumentType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LegalText,intro: null == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as LegalText,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<LegalSection>,
  ));
}
/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextCopyWith<$Res> get title {
  
  return $LegalTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextCopyWith<$Res> get intro {
  
  return $LegalTextCopyWith<$Res>(_self.intro, (value) {
    return _then(_self.copyWith(intro: value));
  });
}
}



/// @nodoc


class _LegalDocument implements LegalDocument {
  const _LegalDocument({required this.type, required this.title, required this.intro, required this.lastUpdated, required final  List<LegalSection> sections}): _sections = sections;
  

@override final  LegalDocumentType type;
@override final  LegalText title;
@override final  LegalText intro;
@override final  DateTime lastUpdated;
 final  List<LegalSection> _sections;
@override List<LegalSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}


/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LegalDocumentCopyWith<_LegalDocument> get copyWith => __$LegalDocumentCopyWithImpl<_LegalDocument>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LegalDocument&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.intro, intro) || other.intro == intro)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other._sections, _sections));
}


@override
int get hashCode => Object.hash(runtimeType,type,title,intro,lastUpdated,const DeepCollectionEquality().hash(_sections));

@override
String toString() {
  return 'LegalDocument(type: $type, title: $title, intro: $intro, lastUpdated: $lastUpdated, sections: $sections)';
}


}

/// @nodoc
abstract mixin class _$LegalDocumentCopyWith<$Res> implements $LegalDocumentCopyWith<$Res> {
  factory _$LegalDocumentCopyWith(_LegalDocument value, $Res Function(_LegalDocument) _then) = __$LegalDocumentCopyWithImpl;
@override @useResult
$Res call({
 LegalDocumentType type, LegalText title, LegalText intro, DateTime lastUpdated, List<LegalSection> sections
});


@override $LegalTextCopyWith<$Res> get title;@override $LegalTextCopyWith<$Res> get intro;

}
/// @nodoc
class __$LegalDocumentCopyWithImpl<$Res>
    implements _$LegalDocumentCopyWith<$Res> {
  __$LegalDocumentCopyWithImpl(this._self, this._then);

  final _LegalDocument _self;
  final $Res Function(_LegalDocument) _then;

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? intro = null,Object? lastUpdated = null,Object? sections = null,}) {
  return _then(_LegalDocument(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LegalDocumentType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LegalText,intro: null == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as LegalText,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<LegalSection>,
  ));
}

/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextCopyWith<$Res> get title {
  
  return $LegalTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of LegalDocument
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LegalTextCopyWith<$Res> get intro {
  
  return $LegalTextCopyWith<$Res>(_self.intro, (value) {
    return _then(_self.copyWith(intro: value));
  });
}
}

// dart format on
