// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horoscope_prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HoroscopePredictionModel _$HoroscopePredictionModelFromJson(
  Map<String, dynamic> json,
) => _HoroscopePredictionModel(
  sign:
      $enumDecodeNullable(
        _$ZodiacSignEnumMap,
        json['sign'],
        unknownValue: ZodiacSign.aries,
      ) ??
      ZodiacSign.aries,
  period:
      $enumDecodeNullable(
        _$HoroscopePeriodEnumMap,
        json['period'],
        unknownValue: HoroscopePeriod.daily,
      ) ??
      HoroscopePeriod.daily,
  textNe: json['text_ne'] as String? ?? '',
  textEn: json['text_en'] as String? ?? '',
  textHi: json['text_hi'] as String? ?? '',
  lucky: json['lucky'] == null
      ? const LuckyDetailsModel()
      : LuckyDetailsModel.fromJson(json['lucky'] as Map<String, dynamic>),
  media: json['media'] == null
      ? const HoroscopeMediaModel()
      : HoroscopeMediaModel.fromJson(json['media'] as Map<String, dynamic>),
  profile: json['profile'] == null
      ? null
      : SignProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HoroscopePredictionModelToJson(
  _HoroscopePredictionModel instance,
) => <String, dynamic>{
  'sign': _$ZodiacSignEnumMap[instance.sign]!,
  'period': _$HoroscopePeriodEnumMap[instance.period]!,
  'text_ne': instance.textNe,
  'text_en': instance.textEn,
  'text_hi': instance.textHi,
  'lucky': instance.lucky.toJson(),
  'media': instance.media.toJson(),
  'profile': ?instance.profile?.toJson(),
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

const _$HoroscopePeriodEnumMap = {
  HoroscopePeriod.daily: 'daily',
  HoroscopePeriod.weekly: 'weekly',
  HoroscopePeriod.monthly: 'monthly',
  HoroscopePeriod.yearly: 'yearly',
};
