// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_weather_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrentWeatherModel {

 DateTime get time; double get temperature;@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) WeatherCondition get condition; int get humidity; double get windSpeed; bool get isDay; int get precipitationProbability;
/// Create a copy of CurrentWeatherModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentWeatherModelCopyWith<CurrentWeatherModel> get copyWith => _$CurrentWeatherModelCopyWithImpl<CurrentWeatherModel>(this as CurrentWeatherModel, _$identity);

  /// Serializes this CurrentWeatherModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentWeatherModel&&(identical(other.time, time) || other.time == time)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.isDay, isDay) || other.isDay == isDay)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,temperature,condition,humidity,windSpeed,isDay,precipitationProbability);

@override
String toString() {
  return 'CurrentWeatherModel(time: $time, temperature: $temperature, condition: $condition, humidity: $humidity, windSpeed: $windSpeed, isDay: $isDay, precipitationProbability: $precipitationProbability)';
}


}

/// @nodoc
abstract mixin class $CurrentWeatherModelCopyWith<$Res>  {
  factory $CurrentWeatherModelCopyWith(CurrentWeatherModel value, $Res Function(CurrentWeatherModel) _then) = _$CurrentWeatherModelCopyWithImpl;
@useResult
$Res call({
 DateTime time, double temperature,@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) WeatherCondition condition, int humidity, double windSpeed, bool isDay, int precipitationProbability
});




}
/// @nodoc
class _$CurrentWeatherModelCopyWithImpl<$Res>
    implements $CurrentWeatherModelCopyWith<$Res> {
  _$CurrentWeatherModelCopyWithImpl(this._self, this._then);

  final CurrentWeatherModel _self;
  final $Res Function(CurrentWeatherModel) _then;

/// Create a copy of CurrentWeatherModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? temperature = null,Object? condition = null,Object? humidity = null,Object? windSpeed = null,Object? isDay = null,Object? precipitationProbability = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherCondition,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as bool,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _CurrentWeatherModel extends CurrentWeatherModel {
  const _CurrentWeatherModel({required this.time, this.temperature = 0, @JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) this.condition = WeatherCondition.partlyCloudy, this.humidity = 0, this.windSpeed = 0, this.isDay = true, this.precipitationProbability = 0}): super._();
  factory _CurrentWeatherModel.fromJson(Map<String, dynamic> json) => _$CurrentWeatherModelFromJson(json);

@override final  DateTime time;
@override@JsonKey() final  double temperature;
@override@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) final  WeatherCondition condition;
@override@JsonKey() final  int humidity;
@override@JsonKey() final  double windSpeed;
@override@JsonKey() final  bool isDay;
@override@JsonKey() final  int precipitationProbability;

/// Create a copy of CurrentWeatherModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentWeatherModelCopyWith<_CurrentWeatherModel> get copyWith => __$CurrentWeatherModelCopyWithImpl<_CurrentWeatherModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentWeatherModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentWeatherModel&&(identical(other.time, time) || other.time == time)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.isDay, isDay) || other.isDay == isDay)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,temperature,condition,humidity,windSpeed,isDay,precipitationProbability);

@override
String toString() {
  return 'CurrentWeatherModel(time: $time, temperature: $temperature, condition: $condition, humidity: $humidity, windSpeed: $windSpeed, isDay: $isDay, precipitationProbability: $precipitationProbability)';
}


}

/// @nodoc
abstract mixin class _$CurrentWeatherModelCopyWith<$Res> implements $CurrentWeatherModelCopyWith<$Res> {
  factory _$CurrentWeatherModelCopyWith(_CurrentWeatherModel value, $Res Function(_CurrentWeatherModel) _then) = __$CurrentWeatherModelCopyWithImpl;
@override @useResult
$Res call({
 DateTime time, double temperature,@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) WeatherCondition condition, int humidity, double windSpeed, bool isDay, int precipitationProbability
});




}
/// @nodoc
class __$CurrentWeatherModelCopyWithImpl<$Res>
    implements _$CurrentWeatherModelCopyWith<$Res> {
  __$CurrentWeatherModelCopyWithImpl(this._self, this._then);

  final _CurrentWeatherModel _self;
  final $Res Function(_CurrentWeatherModel) _then;

/// Create a copy of CurrentWeatherModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? temperature = null,Object? condition = null,Object? humidity = null,Object? windSpeed = null,Object? isDay = null,Object? precipitationProbability = null,}) {
  return _then(_CurrentWeatherModel(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherCondition,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,isDay: null == isDay ? _self.isDay : isDay // ignore: cast_nullable_to_non_nullable
as bool,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
