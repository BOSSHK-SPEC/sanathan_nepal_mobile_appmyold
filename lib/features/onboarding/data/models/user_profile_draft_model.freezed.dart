// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_draft_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileDraftModel {

 String get fullName; String get email; DateTime? get dateOfBirth;@JsonKey(unknownEnumValue: DateSystem.bs) DateSystem get dateSystem; int? get birthTimeMinutes; String get birthPlace;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) Gender? get gender;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) ZodiacSign? get zodiacSign;
/// Create a copy of UserProfileDraftModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileDraftModelCopyWith<UserProfileDraftModel> get copyWith => _$UserProfileDraftModelCopyWithImpl<UserProfileDraftModel>(this as UserProfileDraftModel, _$identity);

  /// Serializes this UserProfileDraftModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileDraftModel&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.dateSystem, dateSystem) || other.dateSystem == dateSystem)&&(identical(other.birthTimeMinutes, birthTimeMinutes) || other.birthTimeMinutes == birthTimeMinutes)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.zodiacSign, zodiacSign) || other.zodiacSign == zodiacSign));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,dateOfBirth,dateSystem,birthTimeMinutes,birthPlace,gender,zodiacSign);

@override
String toString() {
  return 'UserProfileDraftModel(fullName: $fullName, email: $email, dateOfBirth: $dateOfBirth, dateSystem: $dateSystem, birthTimeMinutes: $birthTimeMinutes, birthPlace: $birthPlace, gender: $gender, zodiacSign: $zodiacSign)';
}


}

/// @nodoc
abstract mixin class $UserProfileDraftModelCopyWith<$Res>  {
  factory $UserProfileDraftModelCopyWith(UserProfileDraftModel value, $Res Function(UserProfileDraftModel) _then) = _$UserProfileDraftModelCopyWithImpl;
@useResult
$Res call({
 String fullName, String email, DateTime? dateOfBirth,@JsonKey(unknownEnumValue: DateSystem.bs) DateSystem dateSystem, int? birthTimeMinutes, String birthPlace,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) Gender? gender,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) ZodiacSign? zodiacSign
});




}
/// @nodoc
class _$UserProfileDraftModelCopyWithImpl<$Res>
    implements $UserProfileDraftModelCopyWith<$Res> {
  _$UserProfileDraftModelCopyWithImpl(this._self, this._then);

  final UserProfileDraftModel _self;
  final $Res Function(UserProfileDraftModel) _then;

/// Create a copy of UserProfileDraftModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? email = null,Object? dateOfBirth = freezed,Object? dateSystem = null,Object? birthTimeMinutes = freezed,Object? birthPlace = null,Object? gender = freezed,Object? zodiacSign = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,dateSystem: null == dateSystem ? _self.dateSystem : dateSystem // ignore: cast_nullable_to_non_nullable
as DateSystem,birthTimeMinutes: freezed == birthTimeMinutes ? _self.birthTimeMinutes : birthTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,zodiacSign: freezed == zodiacSign ? _self.zodiacSign : zodiacSign // ignore: cast_nullable_to_non_nullable
as ZodiacSign?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _UserProfileDraftModel extends UserProfileDraftModel {
  const _UserProfileDraftModel({this.fullName = '', this.email = '', this.dateOfBirth, @JsonKey(unknownEnumValue: DateSystem.bs) this.dateSystem = DateSystem.bs, this.birthTimeMinutes, this.birthPlace = '', @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.gender, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.zodiacSign}): super._();
  factory _UserProfileDraftModel.fromJson(Map<String, dynamic> json) => _$UserProfileDraftModelFromJson(json);

@override@JsonKey() final  String fullName;
@override@JsonKey() final  String email;
@override final  DateTime? dateOfBirth;
@override@JsonKey(unknownEnumValue: DateSystem.bs) final  DateSystem dateSystem;
@override final  int? birthTimeMinutes;
@override@JsonKey() final  String birthPlace;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  Gender? gender;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  ZodiacSign? zodiacSign;

/// Create a copy of UserProfileDraftModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileDraftModelCopyWith<_UserProfileDraftModel> get copyWith => __$UserProfileDraftModelCopyWithImpl<_UserProfileDraftModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileDraftModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileDraftModel&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.dateSystem, dateSystem) || other.dateSystem == dateSystem)&&(identical(other.birthTimeMinutes, birthTimeMinutes) || other.birthTimeMinutes == birthTimeMinutes)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.zodiacSign, zodiacSign) || other.zodiacSign == zodiacSign));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,dateOfBirth,dateSystem,birthTimeMinutes,birthPlace,gender,zodiacSign);

@override
String toString() {
  return 'UserProfileDraftModel(fullName: $fullName, email: $email, dateOfBirth: $dateOfBirth, dateSystem: $dateSystem, birthTimeMinutes: $birthTimeMinutes, birthPlace: $birthPlace, gender: $gender, zodiacSign: $zodiacSign)';
}


}

/// @nodoc
abstract mixin class _$UserProfileDraftModelCopyWith<$Res> implements $UserProfileDraftModelCopyWith<$Res> {
  factory _$UserProfileDraftModelCopyWith(_UserProfileDraftModel value, $Res Function(_UserProfileDraftModel) _then) = __$UserProfileDraftModelCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String email, DateTime? dateOfBirth,@JsonKey(unknownEnumValue: DateSystem.bs) DateSystem dateSystem, int? birthTimeMinutes, String birthPlace,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) Gender? gender,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) ZodiacSign? zodiacSign
});




}
/// @nodoc
class __$UserProfileDraftModelCopyWithImpl<$Res>
    implements _$UserProfileDraftModelCopyWith<$Res> {
  __$UserProfileDraftModelCopyWithImpl(this._self, this._then);

  final _UserProfileDraftModel _self;
  final $Res Function(_UserProfileDraftModel) _then;

/// Create a copy of UserProfileDraftModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? email = null,Object? dateOfBirth = freezed,Object? dateSystem = null,Object? birthTimeMinutes = freezed,Object? birthPlace = null,Object? gender = freezed,Object? zodiacSign = freezed,}) {
  return _then(_UserProfileDraftModel(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,dateSystem: null == dateSystem ? _self.dateSystem : dateSystem // ignore: cast_nullable_to_non_nullable
as DateSystem,birthTimeMinutes: freezed == birthTimeMinutes ? _self.birthTimeMinutes : birthTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,zodiacSign: freezed == zodiacSign ? _self.zodiacSign : zodiacSign // ignore: cast_nullable_to_non_nullable
as ZodiacSign?,
  ));
}


}

// dart format on
