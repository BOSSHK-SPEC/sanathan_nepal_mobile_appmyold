// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lucky_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LuckyDetailsModel _$LuckyDetailsModelFromJson(
  Map<String, dynamic> json,
) => _LuckyDetailsModel(
  numbers:
      (json['numbers'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  colorNe: json['color_ne'] as String? ?? '',
  colorEn: json['color_en'] as String? ?? '',
  colorHi: json['color_hi'] as String? ?? '',
  colorValue: (json['color_value'] as num?)?.toInt() ?? 0,
  daysNe:
      (json['days_ne'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  daysEn:
      (json['days_en'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  daysHi:
      (json['days_hi'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  rulingPlanetNe: json['ruling_planet_ne'] as String? ?? '',
  rulingPlanetEn: json['ruling_planet_en'] as String? ?? '',
  rulingPlanetHi: json['ruling_planet_hi'] as String? ?? '',
  symbolNe: json['symbol_ne'] as String? ?? '',
  symbolEn: json['symbol_en'] as String? ?? '',
  symbolHi: json['symbol_hi'] as String? ?? '',
  elementNe: json['element_ne'] as String? ?? '',
  elementEn: json['element_en'] as String? ?? '',
  elementHi: json['element_hi'] as String? ?? '',
  luckyStoneNe: json['lucky_stone_ne'] as String? ?? '',
  luckyStoneEn: json['lucky_stone_en'] as String? ?? '',
  luckyStoneHi: json['lucky_stone_hi'] as String? ?? '',
  unluckyStoneNe: json['unlucky_stone_ne'] as String? ?? '',
  unluckyStoneEn: json['unlucky_stone_en'] as String? ?? '',
  unluckyStoneHi: json['unlucky_stone_hi'] as String? ?? '',
  luckyAlphabet: json['lucky_alphabet'] as String? ?? '',
  eventfulYears:
      (json['eventful_years'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$LuckyDetailsModelToJson(_LuckyDetailsModel instance) =>
    <String, dynamic>{
      'numbers': instance.numbers,
      'color_ne': instance.colorNe,
      'color_en': instance.colorEn,
      'color_hi': instance.colorHi,
      'color_value': instance.colorValue,
      'days_ne': instance.daysNe,
      'days_en': instance.daysEn,
      'days_hi': instance.daysHi,
      'ruling_planet_ne': instance.rulingPlanetNe,
      'ruling_planet_en': instance.rulingPlanetEn,
      'ruling_planet_hi': instance.rulingPlanetHi,
      'symbol_ne': instance.symbolNe,
      'symbol_en': instance.symbolEn,
      'symbol_hi': instance.symbolHi,
      'element_ne': instance.elementNe,
      'element_en': instance.elementEn,
      'element_hi': instance.elementHi,
      'lucky_stone_ne': instance.luckyStoneNe,
      'lucky_stone_en': instance.luckyStoneEn,
      'lucky_stone_hi': instance.luckyStoneHi,
      'unlucky_stone_ne': instance.unluckyStoneNe,
      'unlucky_stone_en': instance.unluckyStoneEn,
      'unlucky_stone_hi': instance.unluckyStoneHi,
      'lucky_alphabet': instance.luckyAlphabet,
      'eventful_years': instance.eventfulYears,
    };
