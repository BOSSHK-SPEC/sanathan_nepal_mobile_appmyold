// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hourly_forecast_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HourlyForecastModel {

 DateTime get time; double get temperature;@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) WeatherCondition get condition; int get precipitationProbability; bool get isDay;
/// Create a copy of HourlyForecastModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourlyForecastModelCopyWith<HourlyForecastModel> get copyWith => _$HourlyForecastModelCopyWithImpl<HourlyForecastModel>(this as HourlyForecastModel, _$identity);

  /// Serializes this HourlyForecastModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HourlyForecastModel&&(identical(other.time, time) || other.time == time)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.isDay, isDay) || other.isDay == isDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,temperature,condition,precipitationProbability,isDay);

@override
String toString() {
  return 'HourlyForecastModel(time: $time, temperature: $temperature, condition: $condition, precipitationProbability: $precipitationProbability, isDay: $isDay)';
}


}

/// @nodoc
abstract mixin class $HourlyForecastModelCopyWith<$Res>  {
  factory $HourlyForecastModelCopyWith(HourlyForecastModel value, $Res Function(HourlyForecastModel) _then) = _$HourlyForecastModelCopyWithImpl;
@useResult
$Res call({
 DateTime time, double temperature,@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) WeatherCondition condition, int precipitationProbability, bool isDay
});




}
/// @nodoc
class _$HourlyForecastModelCopyWithImpl<$Res>
    implements $HourlyForecastModelCopyWith<$Res> {
  _$HourlyForecastModelCopyWithImpl(this._self, this._then);

  final HourlyForecastModel _self;
  final $Res Function(HourlyForecastModel) _then;

/// Create a copy of HourlyForecastModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? temperature = null,Object? condition = null,Object? precipitationProbability = null,Object? isDay = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherCondition,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as int,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _HourlyForecastModel extends HourlyForecastModel {
  const _HourlyForecastModel({required this.time, this.temperature = 0, @JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) this.condition = WeatherCondition.partlyCloudy, this.precipitationProbability = 0, this.isDay = true}): super._();
  factory _HourlyForecastModel.fromJson(Map<String, dynamic> json) => _$HourlyForecastModelFromJson(json);

@override final  DateTime time;
@override@JsonKey() final  double temperature;
@override@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) final  WeatherCondition condition;
@override@JsonKey() final  int precipitationProbability;
@override@JsonKey() final  bool isDay;

/// Create a copy of HourlyForecastModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourlyForecastModelCopyWith<_HourlyForecastModel> get copyWith => __$HourlyForecastModelCopyWithImpl<_HourlyForecastModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HourlyForecastModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HourlyForecastModel&&(identical(other.time, time) || other.time == time)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.isDay, isDay) || other.isDay == isDay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,temperature,condition,precipitationProbability,isDay);

@override
String toString() {
  return 'HourlyForecastModel(time: $time, temperature: $temperature, condition: $condition, precipitationProbability: $precipitationProbability, isDay: $isDay)';
}


}

/// @nodoc
abstract mixin class _$HourlyForecastModelCopyWith<$Res> implements $HourlyForecastModelCopyWith<$Res> {
  factory _$HourlyForecastModelCopyWith(_HourlyForecastModel value, $Res Function(_HourlyForecastModel) _then) = __$HourlyForecastModelCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, double temperature,@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) WeatherCondition condition, int precipitationProbability, bool isDay
});




}
/// @nodoc
class __$HourlyForecastModelCopyWithImpl<$Res>
    implements _$HourlyForecastModelCopyWith<$Res> {
  __$HourlyForecastModelCopyWithImpl(this._self, this._then);

  final _HourlyForecastModel _self;
  final $Res Function(_HourlyForecastModel) _then;

/// Create a copy of HourlyForecastModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? temperature = null,Object? condition = null,Object? precipitationProbability = null,Object? isDay = null,}) {
  return _then(_HourlyForecastModel(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherCondition,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as int,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
