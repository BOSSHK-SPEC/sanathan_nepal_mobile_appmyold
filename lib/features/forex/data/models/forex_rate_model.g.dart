// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forex_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ForexCurrencyModel _$ForexCurrencyModelFromJson(Map<String, dynamic> json) =>
    _ForexCurrencyModel(
      iso3: json['iso3'] as String,
      name: json['name'] as String?,
      unit: json['unit'] == null ? 1 : _unitFromJson(json['unit']),
    );

Map<String, dynamic> _$ForexCurrencyModelToJson(_ForexCurrencyModel instance) =>
    <String, dynamic>{
      'iso3': instance.iso3,
      'name': ?instance.name,
      'unit': instance.unit,
    };

_ForexRateModel _$ForexRateModelFromJson(Map<String, dynamic> json) =>
    _ForexRateModel(
      currency: ForexCurrencyModel.fromJson(
        json['currency'] as Map<String, dynamic>,
      ),
      buy: _doubleFromJson(json['buy']),
      sell: _doubleFromJson(json['sell']),
    );

Map<String, dynamic> _$ForexRateModelToJson(_ForexRateModel instance) =>
    <String, dynamic>{
      'currency': instance.currency.toJson(),
      'buy': instance.buy,
      'sell': instance.sell,
    };
