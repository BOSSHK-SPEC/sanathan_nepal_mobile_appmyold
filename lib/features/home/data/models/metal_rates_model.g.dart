// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metal_rates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MetalRatesModel _$MetalRatesModelFromJson(Map<String, dynamic> json) =>
    _MetalRatesModel(
      gold: (json['gold'] as num).toDouble(),
      silver: (json['silver'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'NPR',
      unit: json['unit'] as String? ?? 'tola',
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$MetalRatesModelToJson(_MetalRatesModel instance) =>
    <String, dynamic>{
      'gold': instance.gold,
      'silver': instance.silver,
      'currency': instance.currency,
      'unit': instance.unit,
      'date': instance.date.toIso8601String(),
    };
