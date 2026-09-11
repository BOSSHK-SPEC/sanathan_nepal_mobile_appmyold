// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SellerModel _$SellerModelFromJson(Map<String, dynamic> json) => _SellerModel(
  id: json['id'] as String,
  name: json['name'] as String,
  avatar: json['avatar'] as String?,
  verified: json['verified'] as bool? ?? false,
  phone: json['phone'] as String?,
  handle: json['handle'] as String?,
);

Map<String, dynamic> _$SellerModelToJson(_SellerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': ?instance.avatar,
      'verified': instance.verified,
      'phone': ?instance.phone,
      'handle': ?instance.handle,
    };
