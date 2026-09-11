// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignProfileModel _$SignProfileModelFromJson(Map<String, dynamic> json) =>
    _SignProfileModel(
      aboutNe: json['about_ne'] as String? ?? '',
      aboutEn: json['about_en'] as String? ?? '',
      aboutHi: json['about_hi'] as String? ?? '',
      tabs:
          (json['tabs'] as List<dynamic>?)
              ?.map(
                (e) => SignProfileTabModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      luckyMedia: json['lucky_media'] == null
          ? const HoroscopeMediaModel()
          : HoroscopeMediaModel.fromJson(
              json['lucky_media'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SignProfileModelToJson(_SignProfileModel instance) =>
    <String, dynamic>{
      'about_ne': instance.aboutNe,
      'about_en': instance.aboutEn,
      'about_hi': instance.aboutHi,
      'tabs': instance.tabs.map((e) => e.toJson()).toList(),
      'lucky_media': instance.luckyMedia.toJson(),
    };

_SignProfileTabModel _$SignProfileTabModelFromJson(Map<String, dynamic> json) =>
    _SignProfileTabModel(
      titleNe: json['title_ne'] as String? ?? '',
      titleEn: json['title_en'] as String? ?? '',
      titleHi: json['title_hi'] as String? ?? '',
      introNe: json['intro_ne'] as String? ?? '',
      introEn: json['intro_en'] as String? ?? '',
      introHi: json['intro_hi'] as String? ?? '',
      points:
          (json['points'] as List<dynamic>?)
              ?.map(
                (e) =>
                    SignProfilePointModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SignProfileTabModelToJson(
  _SignProfileTabModel instance,
) => <String, dynamic>{
  'title_ne': instance.titleNe,
  'title_en': instance.titleEn,
  'title_hi': instance.titleHi,
  'intro_ne': instance.introNe,
  'intro_en': instance.introEn,
  'intro_hi': instance.introHi,
  'points': instance.points.map((e) => e.toJson()).toList(),
};

_SignProfilePointModel _$SignProfilePointModelFromJson(
  Map<String, dynamic> json,
) => _SignProfilePointModel(
  labelNe: json['label_ne'] as String? ?? '',
  labelEn: json['label_en'] as String? ?? '',
  labelHi: json['label_hi'] as String? ?? '',
  textNe: json['text_ne'] as String? ?? '',
  textEn: json['text_en'] as String? ?? '',
  textHi: json['text_hi'] as String? ?? '',
);

Map<String, dynamic> _$SignProfilePointModelToJson(
  _SignProfilePointModel instance,
) => <String, dynamic>{
  'label_ne': instance.labelNe,
  'label_en': instance.labelEn,
  'label_hi': instance.labelHi,
  'text_ne': instance.textNe,
  'text_en': instance.textEn,
  'text_hi': instance.textHi,
};
