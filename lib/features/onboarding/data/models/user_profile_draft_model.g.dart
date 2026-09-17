// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_draft_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileDraftModel _$UserProfileDraftModelFromJson(
  Map<String, dynamic> json,
) => _UserProfileDraftModel(
  fullName: json['full_name'] as String? ?? '',
  email: json['email'] as String? ?? '',
  dateOfBirth: json['date_of_birth'] == null
      ? null
      : DateTime.parse(json['date_of_birth'] as String),
  dateSystem:
      $enumDecodeNullable(
        _$DateSystemEnumMap,
        json['date_system'],
        unknownValue: DateSystem.bs,
      ) ??
      DateSystem.bs,
  birthTimeMinutes: (json['birth_time_minutes'] as num?)?.toInt(),
  birthPlace: json['birth_place'] as String? ?? '',
  gender: $enumDecodeNullable(
    _$GenderEnumMap,
    json['gender'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  zodiacSign: $enumDecodeNullable(
    _$ZodiacSignEnumMap,
    json['zodiac_sign'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$UserProfileDraftModelToJson(
  _UserProfileDraftModel instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'email': instance.email,
  'date_of_birth': ?instance.dateOfBirth?.toIso8601String(),
  'date_system': _$DateSystemEnumMap[instance.dateSystem]!,
  'birth_time_minutes': ?instance.birthTimeMinutes,
  'birth_place': instance.birthPlace,
  'gender': ?_$GenderEnumMap[instance.gender],
  'zodiac_sign': ?_$ZodiacSignEnumMap[instance.zodiacSign],
  'avatar_url': ?instance.avatarUrl,
};

const _$DateSystemEnumMap = {DateSystem.bs: 'bs', DateSystem.ad: 'ad'};

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};

const _$ZodiacSignEnumMap = {
  ZodiacSign.aries: 'aries',
  ZodiacSign.taurus: 'taurus',
  ZodiacSign.gemini: 'gemini',
  ZodiacSign.cancer: 'cancer',
  ZodiacSign.leo: 'leo',
  ZodiacSign.virgo: 'virgo',
  ZodiacSign.libra: 'libra',
  ZodiacSign.scorpio: 'scorpio',
  ZodiacSign.sagittarius: 'sagittarius',
  ZodiacSign.capricorn: 'capricorn',
  ZodiacSign.aquarius: 'aquarius',
  ZodiacSign.pisces: 'pisces',
};
