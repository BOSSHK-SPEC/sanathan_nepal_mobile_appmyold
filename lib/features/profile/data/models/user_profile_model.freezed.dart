// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileModel {

 String get id; String get name; String get email; String get phone; String? get avatarUrl;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) Gender? get gender; String? get dobBs; String? get dobAd; String? get birthTime; String? get birthPlace; String? get address;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) ProfileZodiac? get zodiacSign; String? get religion; String? get bio; bool get verified;@JsonKey(unknownEnumValue: UserRole.user) Set<UserRole> get roles;
/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileModelCopyWith<UserProfileModel> get copyWith => _$UserProfileModelCopyWithImpl<UserProfileModel>(this as UserProfileModel, _$identity);

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dobBs, dobBs) || other.dobBs == dobBs)&&(identical(other.dobAd, dobAd) || other.dobAd == dobAd)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.address, address) || other.address == address)&&(identical(other.zodiacSign, zodiacSign) || other.zodiacSign == zodiacSign)&&(identical(other.religion, religion) || other.religion == religion)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.verified, verified) || other.verified == verified)&&const DeepCollectionEquality().equals(other.roles, roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,phone,avatarUrl,gender,dobBs,dobAd,birthTime,birthPlace,address,zodiacSign,religion,bio,verified,const DeepCollectionEquality().hash(roles));

@override
String toString() {
  return 'UserProfileModel(id: $id, name: $name, email: $email, phone: $phone, avatarUrl: $avatarUrl, gender: $gender, dobBs: $dobBs, dobAd: $dobAd, birthTime: $birthTime, birthPlace: $birthPlace, address: $address, zodiacSign: $zodiacSign, religion: $religion, bio: $bio, verified: $verified, roles: $roles)';
}


}

/// @nodoc
abstract mixin class $UserProfileModelCopyWith<$Res>  {
  factory $UserProfileModelCopyWith(UserProfileModel value, $Res Function(UserProfileModel) _then) = _$UserProfileModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String phone, String? avatarUrl,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) Gender? gender, String? dobBs, String? dobAd, String? birthTime, String? birthPlace, String? address,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) ProfileZodiac? zodiacSign, String? religion, String? bio, bool verified,@JsonKey(unknownEnumValue: UserRole.user) Set<UserRole> roles
});




}
/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._self, this._then);

  final UserProfileModel _self;
  final $Res Function(UserProfileModel) _then;

/// Create a copy of UserProfileModel
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
@JsonSerializable()

class _UserProfileModel extends UserProfileModel {
  const _UserProfileModel({required this.id, required this.name, required this.email, this.phone = '', this.avatarUrl, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.gender, this.dobBs, this.dobAd, this.birthTime, this.birthPlace, this.address, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.zodiacSign, this.religion, this.bio, this.verified = false, @JsonKey(unknownEnumValue: UserRole.user) final  Set<UserRole> roles = const {UserRole.user}}): _roles = roles,super._();
  factory _UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String email;
@override@JsonKey() final  String phone;
@override final  String? avatarUrl;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  Gender? gender;
@override final  String? dobBs;
@override final  String? dobAd;
@override final  String? birthTime;
@override final  String? birthPlace;
@override final  String? address;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  ProfileZodiac? zodiacSign;
@override final  String? religion;
@override final  String? bio;
@override@JsonKey() final  bool verified;
 final  Set<UserRole> _roles;
@override@JsonKey(unknownEnumValue: UserRole.user) Set<UserRole> get roles {
  if (_roles is EqualUnmodifiableSetView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_roles);
}


/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileModelCopyWith<_UserProfileModel> get copyWith => __$UserProfileModelCopyWithImpl<_UserProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dobBs, dobBs) || other.dobBs == dobBs)&&(identical(other.dobAd, dobAd) || other.dobAd == dobAd)&&(identical(other.birthTime, birthTime) || other.birthTime == birthTime)&&(identical(other.birthPlace, birthPlace) || other.birthPlace == birthPlace)&&(identical(other.address, address) || other.address == address)&&(identical(other.zodiacSign, zodiacSign) || other.zodiacSign == zodiacSign)&&(identical(other.religion, religion) || other.religion == religion)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.verified, verified) || other.verified == verified)&&const DeepCollectionEquality().equals(other._roles, _roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,phone,avatarUrl,gender,dobBs,dobAd,birthTime,birthPlace,address,zodiacSign,religion,bio,verified,const DeepCollectionEquality().hash(_roles));

@override
String toString() {
  return 'UserProfileModel(id: $id, name: $name, email: $email, phone: $phone, avatarUrl: $avatarUrl, gender: $gender, dobBs: $dobBs, dobAd: $dobAd, birthTime: $birthTime, birthPlace: $birthPlace, address: $address, zodiacSign: $zodiacSign, religion: $religion, bio: $bio, verified: $verified, roles: $roles)';
}


}

/// @nodoc
abstract mixin class _$UserProfileModelCopyWith<$Res> implements $UserProfileModelCopyWith<$Res> {
  factory _$UserProfileModelCopyWith(_UserProfileModel value, $Res Function(_UserProfileModel) _then) = __$UserProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String phone, String? avatarUrl,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) Gender? gender, String? dobBs, String? dobAd, String? birthTime, String? birthPlace, String? address,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) ProfileZodiac? zodiacSign, String? religion, String? bio, bool verified,@JsonKey(unknownEnumValue: UserRole.user) Set<UserRole> roles
});




}
/// @nodoc
class __$UserProfileModelCopyWithImpl<$Res>
    implements _$UserProfileModelCopyWith<$Res> {
  __$UserProfileModelCopyWithImpl(this._self, this._then);

  final _UserProfileModel _self;
  final $Res Function(_UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = null,Object? avatarUrl = freezed,Object? gender = freezed,Object? dobBs = freezed,Object? dobAd = freezed,Object? birthTime = freezed,Object? birthPlace = freezed,Object? address = freezed,Object? zodiacSign = freezed,Object? religion = freezed,Object? bio = freezed,Object? verified = null,Object? roles = null,}) {
  return _then(_UserProfileModel(
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
