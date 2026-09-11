// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthSessionModel _$AuthSessionModelFromJson(Map<String, dynamic> json) =>
    _AuthSessionModel(
      userId: json['user_id'] as String,
      provider:
          $enumDecodeNullable(
            _$AuthProviderEnumMap,
            json['provider'],
            unknownValue: AuthProvider.phone,
          ) ??
          AuthProvider.phone,
      isNewUser: json['is_new_user'] as bool? ?? false,
      displayName: json['display_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$AuthSessionModelToJson(_AuthSessionModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'provider': _$AuthProviderEnumMap[instance.provider]!,
      'is_new_user': instance.isNewUser,
      'display_name': ?instance.displayName,
      'phone_number': ?instance.phoneNumber,
      'email': ?instance.email,
    };

const _$AuthProviderEnumMap = {
  AuthProvider.google: 'google',
  AuthProvider.apple: 'apple',
  AuthProvider.phone: 'phone',
};
