// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppPreferencesModel _$AppPreferencesModelFromJson(Map<String, dynamic> json) =>
    _AppPreferencesModel(
      region: json['region'] as String?,
      language: json['language'] as String?,
      theme: json['theme'] as String?,
      silent: json['silent'] as bool?,
      onboarded: json['onboarded'] as bool?,
    );

Map<String, dynamic> _$AppPreferencesModelToJson(
  _AppPreferencesModel instance,
) => <String, dynamic>{
  'region': ?instance.region,
  'language': ?instance.language,
  'theme': ?instance.theme,
  'silent': ?instance.silent,
  'onboarded': ?instance.onboarded,
};
