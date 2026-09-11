// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OtpChallengeModel _$OtpChallengeModelFromJson(Map<String, dynamic> json) =>
    _OtpChallengeModel(
      phoneNumber: json['phone_number'] as String,
      isRegistered: json['is_registered'] as bool? ?? false,
      displayName: json['display_name'] as String?,
      codeLength: (json['code_length'] as num?)?.toInt() ?? 6,
    );

Map<String, dynamic> _$OtpChallengeModelToJson(_OtpChallengeModel instance) =>
    <String, dynamic>{
      'phone_number': instance.phoneNumber,
      'is_registered': instance.isRegistered,
      'display_name': ?instance.displayName,
      'code_length': instance.codeLength,
    };
