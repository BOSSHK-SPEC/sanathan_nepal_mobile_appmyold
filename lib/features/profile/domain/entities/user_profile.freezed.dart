// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserProfile {

 String get id; String get name; String get email; String get phone; String? get avatarUrl; Gender? get gender;/// Date of birth in the region's traditional calendar (Bikram Sambat for
/// Nepal, Saka for India), `YYYY/MM/DD`. The field keeps its historical
/// `dobBs` name.
 String? get dobBs;/// Date of birth in Gregorian calendar, `YYYY/MM/DD`.
 String? get dobAd;/// Birth time, e.g. `4:12:20 PM`.
 String? get birthTime; String? get birthPlace; String? get address; ProfileZodiac? get zodiacSign; String? get religion; String? get bio; bool get verified;/// Roles this account holds.
///
/// A set, not a field: someone can be an astrologer *and* run a shop,
/// and gaining one role must never silently strip another.
 Set<UserRole> get roles;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dobBs, dobBs) || other.dobBs == dobBs)&&(identical(other.dobAd, dobAd) || other.dobAd == dobAd)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.address, address) || other.address == address)&&(identical(other.zodiacSign, zodiacSign) || other.zodiacSign == zodiacSign)&&(identical(other.religion, religion) || other.religion == religion)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.verified, verified) || other.verified == verified)&&const DeepCollectionEquality().equals(other.roles, roles));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,email,phone,avatarUrl,gender,dobBs,dobAd,birthTime,birthPlace,address,zodiacSign,religion,bio,verified,const DeepCollectionEquality().hash(roles));

@override
String toString() {
  return 'UserProfile(id: $id, name: $name, email: $email, phone: $phone, avatarUrl: $avatarUrl, gender: $gender, dobBs: $dobBs, dobAd: $dobAd, birthTime: $birthTime, birthPlace: $birthPlace, address: $address, zodiacSign: $zodiacSign, religion: $religion, bio: $bio, verified: $verified, roles: $roles)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String phone, String? avatarUrl, Gender? gender, String? dobBs, String? dobAd, String? birthTime, String? birthPlace, String? address, ProfileZodiac? zodiacSign, String? religion, String? bio, bool verified, Set<UserRole> roles
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = null,Object? avatarUrl = freezed,Object? gender = freezed,Object? dobBs = freezed,Object? dobAd = freezed,Object? birthTime = freezed,Object? birthPlace = freezed,Object? address = freezed,Object? zodiacSign = freezed,Object? religion = freezed,Object? bio = freezed,Object? verified = null,Object? roles = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,dobBs: freezed == dobBs ? _self.dobBs : dobBs // ignore: cast_nullable_to_non_nullable
as String?,dobAd: freezed == dobAd ? _self.dobAd : dobAd // ignore: cast_nullable_to_non_nullable
as String?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,birthPlace: freezed == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,zodiacSign: freezed == zodiacSign ? _self.zodiacSign : zodiacSign // ignore: cast_nullable_to_non_nullable
as ProfileZodiac?,religion: freezed == religion ? _self.religion : religion // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as Set<UserRole>,
  ));
}

}



/// @nodoc


class _UserProfile extends UserProfile {
  const _UserProfile({required this.id, required this.name, required this.email, this.phone = '', this.avatarUrl, this.gender, this.dobBs, this.dobAd, this.birthTime, this.birthPlace, this.address, this.zodiacSign, this.religion, this.bio, this.verified = false, final  Set<UserRole> roles = const {UserRole.user}}): _roles = roles,super._();
  

@override final  String id;
@override final  String name;
@override final  String email;
@override@JsonKey() final  String phone;
@override final  String? avatarUrl;
@override final  Gender? gender;
/// Date of birth in the region's traditional calendar (Bikram Sambat for
/// Nepal, Saka for India), `YYYY/MM/DD`. The field keeps its historical
/// `dobBs` name.
@override final  String? dobBs;
/// Date of birth in Gregorian calendar, `YYYY/MM/DD`.
@override final  String? dobAd;
/// Birth time, e.g. `4:12:20 PM`.
@override final  String? birthTime;
@override final  String? birthPlace;
@override final  String? address;
@override final  ProfileZodiac? zodiacSign;
@override final  String? religion;
@override final  String? bio;
@override@JsonKey() final  bool verified;
/// Roles this account holds.
///
/// A set, not a field: someone can be an astrologer *and* run a shop,
/// and gaining one role must never silently strip another.
 final  Set<UserRole> _roles;
/// Roles this account holds.
///
/// A set, not a field: someone can be an astrologer *and* run a shop,
/// and gaining one role must never silently strip another.
@override@JsonKey() Set<UserRole> get roles {
  if (_roles is EqualUnmodifiableSetView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_roles);
}


/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dobBs, dobBs) || other.dobBs == dobBs)&&(identical(other.dobAd, dobAd) || other.dobAd == dobAd)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.address, address) || other.address == address)&&(identical(other.zodiacSign, zodiacSign) || other.zodiacSign == zodiacSign)&&(identical(other.religion, religion) || other.religion == religion)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.verified, verified) || other.verified == verified)&&const DeepCollectionEquality().equals(other._roles, _roles));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,email,phone,avatarUrl,gender,dobBs,dobAd,birthTime,birthPlace,address,zodiacSign,religion,bio,verified,const DeepCollectionEquality().hash(_roles));

@override
String toString() {
  return 'UserProfile(id: $id, name: $name, email: $email, phone: $phone, avatarUrl: $avatarUrl, gender: $gender, dobBs: $dobBs, dobAd: $dobAd, birthTime: $birthTime, birthPlace: $birthPlace, address: $address, zodiacSign: $zodiacSign, religion: $religion, bio: $bio, verified: $verified, roles: $roles)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String phone, String? avatarUrl, Gender? gender, String? dobBs, String? dobAd, String? birthTime, String? birthPlace, String? address, ProfileZodiac? zodiacSign, String? religion, String? bio, bool verified, Set<UserRole> roles
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = null,Object? avatarUrl = freezed,Object? gender = freezed,Object? dobBs = freezed,Object? dobAd = freezed,Object? birthTime = freezed,Object? birthPlace = freezed,Object? address = freezed,Object? zodiacSign = freezed,Object? religion = freezed,Object? bio = freezed,Object? verified = null,Object? roles = null,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,dobBs: freezed == dobBs ? _self.dobBs : dobBs // ignore: cast_nullable_to_non_nullable
as String?,dobAd: freezed == dobAd ? _self.dobAd : dobAd // ignore: cast_nullable_to_non_nullable
as String?,birthTime: freezed == birthTime ? _self.birthTime : birthTime // ignore: cast_nullable_to_non_nullable
as String?,birthPlace: freezed == birthPlace ? _self.birthPlace : birthPlace // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,zodiacSign: freezed == zodiacSign ? _self.zodiacSign : zodiacSign // ignore: cast_nullable_to_non_nullable
as ProfileZodiac?,religion: freezed == religion ? _self.religion : religion // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as Set<UserRole>,
  ));
}


}

// dart format on
