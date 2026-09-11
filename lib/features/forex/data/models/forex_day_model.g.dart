// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forex_day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ForexDayModel _$ForexDayModelFromJson(Map<String, dynamic> json) =>
    _ForexDayModel(
      date: _dateFromJson(json['date']),
      publishedOn: _nullableDateFromJson(json['published_on']),
      rates:
          (json['rates'] as List<dynamic>?)
              ?.map((e) => ForexRateModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ForexDayModelToJson(_ForexDayModel instance) =>
    <String, dynamic>{
      'date': _dateToJson(instance.date),
      'published_on': ?_nullableDateToJson(instance.publishedOn),
      'rates': instance.rates.map((e) => e.toJson()).toList(),
    };
