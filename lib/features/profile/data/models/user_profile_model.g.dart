// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    _UserProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      gender: $enumDecodeNullable(
        _$GenderEnumMap,
        json['gender'],
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
      dobBs: json['dob_bs'] as String?,
      dobAd: json['dob_ad'] as String?,
      birthTime: json['birth_time'] as String?,
      birthPlace: json['birth_place'] as String?,
      address: json['address'] as String?,
      zodiacSign: $enumDecodeNullable(
        _$ProfileZodiacEnumMap,
        json['zodiac_sign'],
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
      religion: json['religion'] as String?,
      bio: json['bio'] as String?,
      verified: json['verified'] as bool? ?? false,
      roles:
          (json['roles'] as List<dynamic>?)
              ?.map(
                (e) => $enumDecode(
                  _$UserRoleEnumMap,
                  e,
                  unknownValue: UserRole.user,
                ),
              )
              .toSet() ??
          const {UserRole.user},
    );

Map<String, dynamic> _$UserProfileModelToJson(_UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'avatar_url': ?instance.avatarUrl,
      'gender': ?_$GenderEnumMap[instance.gender],
      'dob_bs': ?instance.dobBs,
      'dob_ad': ?instance.dobAd,
      'birth_time': ?instance.birthTime,
      'birth_place': ?instance.birthPlace,
      'address': ?instance.address,
      'zodiac_sign': ?_$ProfileZodiacEnumMap[instance.zodiacSign],
      'religion': ?instance.religion,
      'bio': ?instance.bio,
      'verified': instance.verified,
      'roles': instance.roles.map((e) => _$UserRoleEnumMap[e]!).toList(),
    };

const _$GenderEnumMap = {
  Gender.female: 'female',
  Gender.male: 'male',
  Gender.other: 'other',
};

const _$ProfileZodiacEnumMap = {
  ProfileZodiac.aries: 'aries',
  ProfileZodiac.taurus: 'taurus',
  ProfileZodiac.gemini: 'gemini',
  ProfileZodiac.cancer: 'cancer',
  ProfileZodiac.leo: 'leo',
  ProfileZodiac.virgo: 'virgo',
  ProfileZodiac.libra: 'libra',
  ProfileZodiac.scorpio: 'scorpio',
  ProfileZodiac.sagittarius: 'sagittarius',
  ProfileZodiac.capricorn: 'capricorn',
  ProfileZodiac.aquarius: 'aquarius',
  ProfileZodiac.pisces: 'pisces',
};

const _$UserRoleEnumMap = {
  UserRole.user: 'user',
  UserRole.astrologer: 'astrologer',
  UserRole.seller: 'seller',
  UserRole.admin: 'admin',
};
