// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfileDraft {

 String get fullName; String get email;/// Stored as Gregorian; presentation converts to BS when needed.
 DateTime? get dateOfBirth; DateSystem get dateSystem;/// Minutes since midnight (0–1439) or `null` if unknown.
 int? get birthTimeMinutes; String get birthPlace; Gender? get gender; ZodiacSign? get zodiacSign;/// Public URL of an uploaded profile photo. Optional — nobody should be
/// stopped at the door of the app for not having a photo to hand.
 String? get avatarUrl;
/// Create a copy of UserProfileDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileDraftCopyWith<UserProfileDraft> get copyWith => _$UserProfileDraftCopyWithImpl<UserProfileDraft>(this as UserProfileDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileDraft&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.dateSystem, dateSystem) || other.dateSystem == dateSystem)&&(identical(other.birthTimeMinutes, birthTimeMinutes) || other.birthTimeMinutes == birthTimeMinutes)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.zodiacSign, zodiacSign) || other.zodiacSign == zodiacSign)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,dateOfBirth,dateSystem,birthTimeMinutes,birthPlace,gender,zodiacSign,avatarUrl);

@override
String toString() {
  return 'UserProfileDraft(fullName: $fullName, email: $email, dateOfBirth: $dateOfBirth, dateSystem: $dateSystem, birthTimeMinutes: $birthTimeMinutes, birthPlace: $birthPlace, gender: $gender, zodiacSign: $zodiacSign, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $UserProfileDraftCopyWith<$Res>  {
  factory $UserProfileDraftCopyWith(UserProfileDraft value, $Res Function(UserProfileDraft) _then) = _$UserProfileDraftCopyWithImpl;
@useResult
$Res call({
 String fullName, String email, DateTime? dateOfBirth, DateSystem dateSystem, int? birthTimeMinutes, String birthPlace, Gender? gender, ZodiacSign? zodiacSign, String? avatarUrl
});




}
/// @nodoc
class _$UserProfileDraftCopyWithImpl<$Res>
    implements $UserProfileDraftCopyWith<$Res> {
  _$UserProfileDraftCopyWithImpl(this._self, this._then);

  final UserProfileDraft _self;
  final $Res Function(UserProfileDraft) _then;

/// Create a copy of UserProfileDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? email = null,Object? dateOfBirth = freezed,Object? dateSystem = null,Object? birthTimeMinutes = freezed,Object? birthPlace = null,Object? gender = freezed,Object? zodiacSign = freezed,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,dateSystem: null == dateSystem ? _self.dateSystem : dateSystem // ignore: cast_nullable_to_non_nullable
as DateSystem,birthTimeMinutes: freezed == birthTimeMinutes ? _self.birthTimeMinutes : birthTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,zodiacSign: freezed == zodiacSign ? _self.zodiacSign : zodiacSign // ignore: cast_nullable_to_non_nullable
as ZodiacSign?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _UserProfileDraft extends UserProfileDraft {
  const _UserProfileDraft({this.fullName = '', this.email = '', this.dateOfBirth, this.dateSystem = DateSystem.bs, this.birthTimeMinutes, this.birthPlace = '', this.gender, this.zodiacSign, this.avatarUrl}): super._();
  

@override@JsonKey() final  String fullName;
@override@JsonKey() final  String email;
/// Stored as Gregorian; presentation converts to BS when needed.
@override final  DateTime? dateOfBirth;
@override@JsonKey() final  DateSystem dateSystem;
/// Minutes since midnight (0–1439) or `null` if unknown.
@override final  int? birthTimeMinutes;
@override@JsonKey() final  String birthPlace;
@override final  Gender? gender;
@override final  ZodiacSign? zodiacSign;
/// Public URL of an uploaded profile photo. Optional — nobody should be
/// stopped at the door of the app for not having a photo to hand.
@override final  String? avatarUrl;

/// Create a copy of UserProfileDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileDraftCopyWith<_UserProfileDraft> get copyWith => __$UserProfileDraftCopyWithImpl<_UserProfileDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileDraft&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.dateSystem, dateSystem) || other.dateSystem == dateSystem)&&(identical(other.birthTimeMinutes, birthTimeMinutes) || other.birthTimeMinutes == birthTimeMinutes)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.zodiacSign, zodiacSign) || other.zodiacSign == zodiacSign)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,dateOfBirth,dateSystem,birthTimeMinutes,birthPlace,gender,zodiacSign,avatarUrl);

@override
String toString() {
  return 'UserProfileDraft(fullName: $fullName, email: $email, dateOfBirth: $dateOfBirth, dateSystem: $dateSystem, birthTimeMinutes: $birthTimeMinutes, birthPlace: $birthPlace, gender: $gender, zodiacSign: $zodiacSign, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$UserProfileDraftCopyWith<$Res> implements $UserProfileDraftCopyWith<$Res> {
  factory _$UserProfileDraftCopyWith(_UserProfileDraft value, $Res Function(_UserProfileDraft) _then) = __$UserProfileDraftCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String email, DateTime? dateOfBirth, DateSystem dateSystem, int? birthTimeMinutes, String birthPlace, Gender? gender, ZodiacSign? zodiacSign, String? avatarUrl
});




}
/// @nodoc
class __$UserProfileDraftCopyWithImpl<$Res>
    implements _$UserProfileDraftCopyWith<$Res> {
  __$UserProfileDraftCopyWithImpl(this._self, this._then);

  final _UserProfileDraft _self;
  final $Res Function(_UserProfileDraft) _then;

/// Create a copy of UserProfileDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? email = null,Object? dateOfBirth = freezed,Object? dateSystem = null,Object? birthTimeMinutes = freezed,Object? birthPlace = null,Object? gender = freezed,Object? zodiacSign = freezed,Object? avatarUrl = freezed,}) {
  return _then(_UserProfileDraft(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,dateSystem: null == dateSystem ? _self.dateSystem : dateSystem // ignore: cast_nullable_to_non_nullable
as DateSystem,birthTimeMinutes: freezed == birthTimeMinutes ? _self.birthTimeMinutes : birthTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,birthPlace: null == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,zodiacSign: freezed == zodiacSign ? _self.zodiacSign : zodiacSign // ignore: cast_nullable_to_non_nullable
as ZodiacSign?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
