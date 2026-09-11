// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LegalTextModel _$LegalTextModelFromJson(Map<String, dynamic> json) =>
    _LegalTextModel(
      ne: json['ne'] as String? ?? '',
      en: json['en'] as String? ?? '',
      hi: json['hi'] as String?,
    );

Map<String, dynamic> _$LegalTextModelToJson(_LegalTextModel instance) =>
    <String, dynamic>{'ne': instance.ne, 'en': instance.en, 'hi': ?instance.hi};

_LegalSectionModel _$LegalSectionModelFromJson(Map<String, dynamic> json) =>
    _LegalSectionModel(
      heading: LegalTextModel.fromJson(json['heading'] as Map<String, dynamic>),
      body: LegalTextModel.fromJson(json['body'] as Map<String, dynamic>),
      level: (json['level'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$LegalSectionModelToJson(_LegalSectionModel instance) =>
    <String, dynamic>{
      'heading': instance.heading.toJson(),
      'body': instance.body.toJson(),
      'level': instance.level,
    };

_LegalDocumentModel _$LegalDocumentModelFromJson(Map<String, dynamic> json) =>
    _LegalDocumentModel(
      type:
          $enumDecodeNullable(_$LegalDocumentTypeEnumMap, json['type']) ??
          LegalDocumentType.privacyPolicy,
      title: LegalTextModel.fromJson(json['title'] as Map<String, dynamic>),
      intro: LegalTextModel.fromJson(json['intro'] as Map<String, dynamic>),
      lastUpdated: DateTime.parse(json['last_updated'] as String),
      sections:
          (json['sections'] as List<dynamic>?)
              ?.map(
                (e) => LegalSectionModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <LegalSectionModel>[],
    );

Map<String, dynamic> _$LegalDocumentModelToJson(_LegalDocumentModel instance) =>
    <String, dynamic>{
      'type': _$LegalDocumentTypeEnumMap[instance.type]!,
      'title': instance.title.toJson(),
      'intro': instance.intro.toJson(),
      'last_updated': instance.lastUpdated.toIso8601String(),
      'sections': instance.sections.map((e) => e.toJson()).toList(),
    };

const _$LegalDocumentTypeEnumMap = {
  LegalDocumentType.privacyPolicy: 'privacyPolicy',
  LegalDocumentType.termsConditions: 'termsConditions',
};
