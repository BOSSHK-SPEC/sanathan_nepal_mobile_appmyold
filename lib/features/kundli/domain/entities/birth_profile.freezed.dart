// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'birth_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BirthProfile {

 String get id; String get name;/// Local date and time of birth. When [timeUnknown] the time component
/// is a placeholder and must not be used for house calculations.
 DateTime get birthDateTime; String get birthPlace; ChartRelation get relation;/// Needed for Gun Milan, which is asymmetric between bride and groom.
 bool get isFemale;/// Without a birth time the ascendant and houses cannot be computed, so
/// the chart falls back to a Moon-based reading.
 bool get timeUnknown; DateTime? get createdAt;
/// Create a copy of BirthProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BirthProfileCopyWith<BirthProfile> get copyWith => _$BirthProfileCopyWithImpl<BirthProfile>(this as BirthProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BirthProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.birthDateTime, birthDateTime) || other.birthDateTime == birthDateTime)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.relation, relation) || other.relation == relation)&&(identical(other.isFemale, isFemale) || other.isFemale == isFemale)&&(identical(other.timeUnknown, timeUnknown) || other.timeUnknown == timeUnknown)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,birthDateTime,birthPlace,relation,isFemale,timeUnknown,createdAt);

@override
String toString() {
  return 'BirthProfile(id: $id, name: $name, birthDateTime: $birthDateTime, birthPlace: $birthPlace, relation: $relation, isFemale: $isFemale, timeUnknown: $timeUnknown, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $BirthProfileCopyWith<$Res>  {
  factory $BirthProfileCopyWith(BirthProfile value, $Res Function(BirthProfile) _then) = _$BirthProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, DateTime birthDateTime, String birthPlace, ChartRelation relation, bool isFemale, bool timeUnknown, DateTime? createdAt
});




}
/// @nodoc
class _$BirthProfileCopyWithImpl<$Res>
    implements $BirthProfileCopyWith<$Res> {
  _$BirthProfileCopyWithImpl(this._self, this._then);

  final BirthProfile _self;
  final $Res Function(BirthProfile) _then;

/// Create a copy of BirthProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? birthDateTime = null,Object? birthPlace = null,Object? relation = null,Object? isFemale = null,Object? timeUnknown = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,birthDateTime: null == birthDateTime ? _self.birthDateTime : birthDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,relation: null == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as ChartRelation,isFemale: null == isFemale ? _self.isFemale : isFemale // ignore: cast_nullable_to_non_nullable
as bool,timeUnknown: null == timeUnknown ? _self.timeUnknown : timeUnknown // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}



/// @nodoc


class _BirthProfile extends BirthProfile {
  const _BirthProfile({required this.id, required this.name, required this.birthDateTime, required this.birthPlace, this.relation = ChartRelation.self, this.isFemale = false, this.timeUnknown = false, this.createdAt}): super._();
  

@override final  String id;
@override final  String name;
/// Local date and time of birth. When [timeUnknown] the time component
/// is a placeholder and must not be used for house calculations.
@override final  DateTime birthDateTime;
@override final  String birthPlace;
@override@JsonKey() final  ChartRelation relation;
/// Needed for Gun Milan, which is asymmetric between bride and groom.
@override@JsonKey() final  bool isFemale;
/// Without a birth time the ascendant and houses cannot be computed, so
/// the chart falls back to a Moon-based reading.
@override@JsonKey() final  bool timeUnknown;
@override final  DateTime? createdAt;

/// Create a copy of BirthProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BirthProfileCopyWith<_BirthProfile> get copyWith => __$BirthProfileCopyWithImpl<_BirthProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BirthProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.birthDateTime, birthDateTime) || other.birthDateTime == birthDateTime)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.relation, relation) || other.relation == relation)&&(identical(other.isFemale, isFemale) || other.isFemale == isFemale)&&(identical(other.timeUnknown, timeUnknown) || other.timeUnknown == timeUnknown)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,birthDateTime,birthPlace,relation,isFemale,timeUnknown,createdAt);

@override
String toString() {
  return 'BirthProfile(id: $id, name: $name, birthDateTime: $birthDateTime, birthPlace: $birthPlace, relation: $relation, isFemale: $isFemale, timeUnknown: $timeUnknown, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$BirthProfileCopyWith<$Res> implements $BirthProfileCopyWith<$Res> {
  factory _$BirthProfileCopyWith(_BirthProfile value, $Res Function(_BirthProfile) _then) = __$BirthProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, DateTime birthDateTime, String birthPlace, ChartRelation relation, bool isFemale, bool timeUnknown, DateTime? createdAt
});




}
/// @nodoc
class __$BirthProfileCopyWithImpl<$Res>
    implements _$BirthProfileCopyWith<$Res> {
  __$BirthProfileCopyWithImpl(this._self, this._then);

  final _BirthProfile _self;
  final $Res Function(_BirthProfile) _then;

/// Create a copy of BirthProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? birthDateTime = null,Object? birthPlace = null,Object? relation = null,Object? isFemale = null,Object? timeUnknown = null,Object? createdAt = freezed,}) {
  return _then(_BirthProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,birthDateTime: null == birthDateTime ? _self.birthDateTime : birthDateTime // ignore: cast_nullable_to_non_nullable
as DateTime,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,relation: null == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as ChartRelation,isFemale: null == isFemale ? _self.isFemale : isFemale // ignore: cast_nullable_to_non_nullable
as bool,timeUnknown: null == timeUnknown ? _self.timeUnknown : timeUnknown // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
