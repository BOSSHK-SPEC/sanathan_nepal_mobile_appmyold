// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panchanga_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PanchangaModel _$PanchangaModelFromJson(
  Map<String, dynamic> json,
) => _PanchangaModel(
  date: DateTime.parse(json['date'] as String),
  shakaSamvat: (json['shaka_samvat'] as num).toInt(),
  nepalSamvat: (json['nepal_samvat'] as num).toInt(),
  nepalSamvatMonthNe: json['nepal_samvat_month_ne'] as String? ?? '',
  nepalSamvatMonthEn: json['nepal_samvat_month_en'] as String? ?? '',
  tithiTitleNe: json['tithi_title_ne'] as String? ?? '',
  tithiTitleEn: json['tithi_title_en'] as String? ?? '',
  tithi: PanchangaElementModel.fromJson(json['tithi'] as Map<String, dynamic>),
  nakshatra: PanchangaElementModel.fromJson(
    json['nakshatra'] as Map<String, dynamic>,
  ),
  karana: PanchangaElementModel.fromJson(
    json['karana'] as Map<String, dynamic>,
  ),
  yoga: PanchangaElementModel.fromJson(json['yoga'] as Map<String, dynamic>),
  sunrise: DateTime.parse(json['sunrise'] as String),
  sunset: DateTime.parse(json['sunset'] as String),
  moonrise: DateTime.parse(json['moonrise'] as String),
  moonset: DateTime.parse(json['moonset'] as String),
  dayDetails:
      (json['day_details'] as List<dynamic>?)
          ?.map((e) => PanchangaDetailModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  chandraRashiNe: json['chandra_rashi_ne'] as String? ?? '',
  chandraRashiEn: json['chandra_rashi_en'] as String? ?? '',
  anandadiYogaNe: json['anandadi_yoga_ne'] as String? ?? '',
  anandadiYogaEn: json['anandadi_yoga_en'] as String? ?? '',
  planets:
      (json['planets'] as List<dynamic>?)
          ?.map((e) => PlanetPositionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  rahuKaal: json['rahu_kaal'] == null
      ? null
      : TimeWindowModel.fromJson(json['rahu_kaal'] as Map<String, dynamic>),
  yamaganda: json['yamaganda'] == null
      ? null
      : TimeWindowModel.fromJson(json['yamaganda'] as Map<String, dynamic>),
  gulikaKaal: json['gulika_kaal'] == null
      ? null
      : TimeWindowModel.fromJson(json['gulika_kaal'] as Map<String, dynamic>),
  abhijitMuhurat: json['abhijit_muhurat'] == null
      ? null
      : TimeWindowModel.fromJson(
          json['abhijit_muhurat'] as Map<String, dynamic>,
        ),
  choghadiya:
      (json['choghadiya'] as List<dynamic>?)
          ?.map((e) => TimeWindowModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  source:
      $enumDecodeNullable(
        _$PanchangaSourceEnumMap,
        json['source'],
        unknownValue: PanchangaSource.approximate,
      ) ??
      PanchangaSource.approximate,
);

Map<String, dynamic> _$PanchangaModelToJson(_PanchangaModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'shaka_samvat': instance.shakaSamvat,
      'nepal_samvat': instance.nepalSamvat,
      'nepal_samvat_month_ne': instance.nepalSamvatMonthNe,
      'nepal_samvat_month_en': instance.nepalSamvatMonthEn,
      'tithi_title_ne': instance.tithiTitleNe,
      'tithi_title_en': instance.tithiTitleEn,
      'tithi': instance.tithi.toJson(),
      'nakshatra': instance.nakshatra.toJson(),
      'karana': instance.karana.toJson(),
      'yoga': instance.yoga.toJson(),
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
      'moonrise': instance.moonrise.toIso8601String(),
      'moonset': instance.moonset.toIso8601String(),
      'day_details': instance.dayDetails.map((e) => e.toJson()).toList(),
      'chandra_rashi_ne': instance.chandraRashiNe,
      'chandra_rashi_en': instance.chandraRashiEn,
      'anandadi_yoga_ne': instance.anandadiYogaNe,
      'anandadi_yoga_en': instance.anandadiYogaEn,
      'planets': instance.planets.map((e) => e.toJson()).toList(),
      'rahu_kaal': ?instance.rahuKaal?.toJson(),
      'yamaganda': ?instance.yamaganda?.toJson(),
      'gulika_kaal': ?instance.gulikaKaal?.toJson(),
      'abhijit_muhurat': ?instance.abhijitMuhurat?.toJson(),
      'choghadiya': instance.choghadiya.map((e) => e.toJson()).toList(),
      'source': _$PanchangaSourceEnumMap[instance.source]!,
    };

const _$PanchangaSourceEnumMap = {
  PanchangaSource.computed: 'computed',
  PanchangaSource.approximate: 'approximate',
};
