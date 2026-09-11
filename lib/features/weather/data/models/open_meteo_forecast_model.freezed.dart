// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_meteo_forecast_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OpenMeteoForecastModel {

 double? get latitude; double? get longitude; String? get timezone; OpenMeteoCurrentModel get current; OpenMeteoHourlyModel get hourly; OpenMeteoDailyModel get daily;
/// Create a copy of OpenMeteoForecastModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenMeteoForecastModelCopyWith<OpenMeteoForecastModel> get copyWith => _$OpenMeteoForecastModelCopyWithImpl<OpenMeteoForecastModel>(this as OpenMeteoForecastModel, _$identity);

  /// Serializes this OpenMeteoForecastModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenMeteoForecastModel&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.current, current) || other.current == current)&&(identical(other.hourly, hourly) || other.hourly == hourly)&&(identical(other.daily, daily) || other.daily == daily));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,timezone,current,hourly,daily);

@override
String toString() {
  return 'OpenMeteoForecastModel(latitude: $latitude, longitude: $longitude, timezone: $timezone, current: $current, hourly: $hourly, daily: $daily)';
}


}

/// @nodoc
abstract mixin class $OpenMeteoForecastModelCopyWith<$Res>  {
  factory $OpenMeteoForecastModelCopyWith(OpenMeteoForecastModel value, $Res Function(OpenMeteoForecastModel) _then) = _$OpenMeteoForecastModelCopyWithImpl;
@useResult
$Res call({
 double? latitude, double? longitude, String? timezone, OpenMeteoCurrentModel current, OpenMeteoHourlyModel hourly, OpenMeteoDailyModel daily
});


$OpenMeteoCurrentModelCopyWith<$Res> get current;$OpenMeteoHourlyModelCopyWith<$Res> get hourly;$OpenMeteoDailyModelCopyWith<$Res> get daily;

}
/// @nodoc
class _$OpenMeteoForecastModelCopyWithImpl<$Res>
    implements $OpenMeteoForecastModelCopyWith<$Res> {
  _$OpenMeteoForecastModelCopyWithImpl(this._self, this._then);

  final OpenMeteoForecastModel _self;
  final $Res Function(OpenMeteoForecastModel) _then;

/// Create a copy of OpenMeteoForecastModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = freezed,Object? longitude = freezed,Object? timezone = freezed,Object? current = null,Object? hourly = null,Object? daily = null,}) {
  return _then(_self.copyWith(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as OpenMeteoCurrentModel,hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as OpenMeteoHourlyModel,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as OpenMeteoDailyModel,
  ));
}
/// Create a copy of OpenMeteoForecastModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenMeteoCurrentModelCopyWith<$Res> get current {
  
  return $OpenMeteoCurrentModelCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of OpenMeteoForecastModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenMeteoHourlyModelCopyWith<$Res> get hourly {
  
  return $OpenMeteoHourlyModelCopyWith<$Res>(_self.hourly, (value) {
    return _then(_self.copyWith(hourly: value));
  });
}/// Create a copy of OpenMeteoForecastModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenMeteoDailyModelCopyWith<$Res> get daily {
  
  return $OpenMeteoDailyModelCopyWith<$Res>(_self.daily, (value) {
    return _then(_self.copyWith(daily: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _OpenMeteoForecastModel implements OpenMeteoForecastModel {
  const _OpenMeteoForecastModel({this.latitude, this.longitude, this.timezone, this.current = const OpenMeteoCurrentModel(), this.hourly = const OpenMeteoHourlyModel(), this.daily = const OpenMeteoDailyModel()});
  factory _OpenMeteoForecastModel.fromJson(Map<String, dynamic> json) => _$OpenMeteoForecastModelFromJson(json);

@override final  double? latitude;
@override final  double? longitude;
@override final  String? timezone;
@override@JsonKey() final  OpenMeteoCurrentModel current;
@override@JsonKey() final  OpenMeteoHourlyModel hourly;
@override@JsonKey() final  OpenMeteoDailyModel daily;

/// Create a copy of OpenMeteoForecastModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenMeteoForecastModelCopyWith<_OpenMeteoForecastModel> get copyWith => __$OpenMeteoForecastModelCopyWithImpl<_OpenMeteoForecastModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenMeteoForecastModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenMeteoForecastModel&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.current, current) || other.current == current)&&(identical(other.hourly, hourly) || other.hourly == hourly)&&(identical(other.daily, daily) || other.daily == daily));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,timezone,current,hourly,daily);

@override
String toString() {
  return 'OpenMeteoForecastModel(latitude: $latitude, longitude: $longitude, timezone: $timezone, current: $current, hourly: $hourly, daily: $daily)';
}


}

/// @nodoc
abstract mixin class _$OpenMeteoForecastModelCopyWith<$Res> implements $OpenMeteoForecastModelCopyWith<$Res> {
  factory _$OpenMeteoForecastModelCopyWith(_OpenMeteoForecastModel value, $Res Function(_OpenMeteoForecastModel) _then) = __$OpenMeteoForecastModelCopyWithImpl;
@override @useResult
$Res call({
 double? latitude, double? longitude, String? timezone, OpenMeteoCurrentModel current, OpenMeteoHourlyModel hourly, OpenMeteoDailyModel daily
});


@override $OpenMeteoCurrentModelCopyWith<$Res> get current;@override $OpenMeteoHourlyModelCopyWith<$Res> get hourly;@override $OpenMeteoDailyModelCopyWith<$Res> get daily;

}
/// @nodoc
class __$OpenMeteoForecastModelCopyWithImpl<$Res>
    implements _$OpenMeteoForecastModelCopyWith<$Res> {
  __$OpenMeteoForecastModelCopyWithImpl(this._self, this._then);

  final _OpenMeteoForecastModel _self;
  final $Res Function(_OpenMeteoForecastModel) _then;

/// Create a copy of OpenMeteoForecastModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = freezed,Object? longitude = freezed,Object? timezone = freezed,Object? current = null,Object? hourly = null,Object? daily = null,}) {
  return _then(_OpenMeteoForecastModel(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,timezone: freezed == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String?,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as OpenMeteoCurrentModel,hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as OpenMeteoHourlyModel,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as OpenMeteoDailyModel,
  ));
}

/// Create a copy of OpenMeteoForecastModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenMeteoCurrentModelCopyWith<$Res> get current {
  
  return $OpenMeteoCurrentModelCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}/// Create a copy of OpenMeteoForecastModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenMeteoHourlyModelCopyWith<$Res> get hourly {
  
  return $OpenMeteoHourlyModelCopyWith<$Res>(_self.hourly, (value) {
    return _then(_self.copyWith(hourly: value));
  });
}/// Create a copy of OpenMeteoForecastModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenMeteoDailyModelCopyWith<$Res> get daily {
  
  return $OpenMeteoDailyModelCopyWith<$Res>(_self.daily, (value) {
    return _then(_self.copyWith(daily: value));
  });
}
}


/// @nodoc
mixin _$OpenMeteoCurrentModel {

/// ISO-8601 local time without offset, e.g. `2024-03-01T10:00`.
 String? get time;@JsonKey(name: 'temperature_2m') double? get temperature2m;@JsonKey(name: 'weather_code') int? get weatherCode;@JsonKey(name: 'relative_humidity_2m') int? get relativeHumidity2m;@JsonKey(name: 'wind_speed_10m') double? get windSpeed10m;
/// Create a copy of OpenMeteoCurrentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenMeteoCurrentModelCopyWith<OpenMeteoCurrentModel> get copyWith => _$OpenMeteoCurrentModelCopyWithImpl<OpenMeteoCurrentModel>(this as OpenMeteoCurrentModel, _$identity);

  /// Serializes this OpenMeteoCurrentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenMeteoCurrentModel&&(identical(other.time, time) || other.time == time)&&(identical(other.temperature2m, temperature2m) || other.temperature2m == temperature2m)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.relativeHumidity2m, relativeHumidity2m) || other.relativeHumidity2m == relativeHumidity2m)&&(identical(other.windSpeed10m, windSpeed10m) || other.windSpeed10m == windSpeed10m));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,temperature2m,weatherCode,relativeHumidity2m,windSpeed10m);

@override
String toString() {
  return 'OpenMeteoCurrentModel(time: $time, temperature2m: $temperature2m, weatherCode: $weatherCode, relativeHumidity2m: $relativeHumidity2m, windSpeed10m: $windSpeed10m)';
}


}

/// @nodoc
abstract mixin class $OpenMeteoCurrentModelCopyWith<$Res>  {
  factory $OpenMeteoCurrentModelCopyWith(OpenMeteoCurrentModel value, $Res Function(OpenMeteoCurrentModel) _then) = _$OpenMeteoCurrentModelCopyWithImpl;
@useResult
$Res call({
 String? time,@JsonKey(name: 'temperature_2m') double? temperature2m,@JsonKey(name: 'weather_code') int? weatherCode,@JsonKey(name: 'relative_humidity_2m') int? relativeHumidity2m,@JsonKey(name: 'wind_speed_10m') double? windSpeed10m
});




}
/// @nodoc
class _$OpenMeteoCurrentModelCopyWithImpl<$Res>
    implements $OpenMeteoCurrentModelCopyWith<$Res> {
  _$OpenMeteoCurrentModelCopyWithImpl(this._self, this._then);

  final OpenMeteoCurrentModel _self;
  final $Res Function(OpenMeteoCurrentModel) _then;

/// Create a copy of OpenMeteoCurrentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = freezed,Object? temperature2m = freezed,Object? weatherCode = freezed,Object? relativeHumidity2m = freezed,Object? windSpeed10m = freezed,}) {
  return _then(_self.copyWith(
time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,temperature2m: freezed == temperature2m ? _self.temperature2m : temperature2m // ignore: cast_nullable_to_non_nullable
as double?,weatherCode: freezed == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int?,relativeHumidity2m: freezed == relativeHumidity2m ? _self.relativeHumidity2m : relativeHumidity2m // ignore: cast_nullable_to_non_nullable
as int?,windSpeed10m: freezed == windSpeed10m ? _self.windSpeed10m : windSpeed10m // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _OpenMeteoCurrentModel implements OpenMeteoCurrentModel {
  const _OpenMeteoCurrentModel({this.time, @JsonKey(name: 'temperature_2m') this.temperature2m, @JsonKey(name: 'weather_code') this.weatherCode, @JsonKey(name: 'relative_humidity_2m') this.relativeHumidity2m, @JsonKey(name: 'wind_speed_10m') this.windSpeed10m});
  factory _OpenMeteoCurrentModel.fromJson(Map<String, dynamic> json) => _$OpenMeteoCurrentModelFromJson(json);

/// ISO-8601 local time without offset, e.g. `2024-03-01T10:00`.
@override final  String? time;
@override@JsonKey(name: 'temperature_2m') final  double? temperature2m;
@override@JsonKey(name: 'weather_code') final  int? weatherCode;
@override@JsonKey(name: 'relative_humidity_2m') final  int? relativeHumidity2m;
@override@JsonKey(name: 'wind_speed_10m') final  double? windSpeed10m;

/// Create a copy of OpenMeteoCurrentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenMeteoCurrentModelCopyWith<_OpenMeteoCurrentModel> get copyWith => __$OpenMeteoCurrentModelCopyWithImpl<_OpenMeteoCurrentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenMeteoCurrentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenMeteoCurrentModel&&(identical(other.time, time) || other.time == time)&&(identical(other.temperature2m, temperature2m) || other.temperature2m == temperature2m)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.relativeHumidity2m, relativeHumidity2m) || other.relativeHumidity2m == relativeHumidity2m)&&(identical(other.windSpeed10m, windSpeed10m) || other.windSpeed10m == windSpeed10m));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,temperature2m,weatherCode,relativeHumidity2m,windSpeed10m);

@override
String toString() {
  return 'OpenMeteoCurrentModel(time: $time, temperature2m: $temperature2m, weatherCode: $weatherCode, relativeHumidity2m: $relativeHumidity2m, windSpeed10m: $windSpeed10m)';
}


}

/// @nodoc
abstract mixin class _$OpenMeteoCurrentModelCopyWith<$Res> implements $OpenMeteoCurrentModelCopyWith<$Res> {
  factory _$OpenMeteoCurrentModelCopyWith(_OpenMeteoCurrentModel value, $Res Function(_OpenMeteoCurrentModel) _then) = __$OpenMeteoCurrentModelCopyWithImpl;
@override @useResult
$Res call({
 String? time,@JsonKey(name: 'temperature_2m') double? temperature2m,@JsonKey(name: 'weather_code') int? weatherCode,@JsonKey(name: 'relative_humidity_2m') int? relativeHumidity2m,@JsonKey(name: 'wind_speed_10m') double? windSpeed10m
});




}
/// @nodoc
class __$OpenMeteoCurrentModelCopyWithImpl<$Res>
    implements _$OpenMeteoCurrentModelCopyWith<$Res> {
  __$OpenMeteoCurrentModelCopyWithImpl(this._self, this._then);

  final _OpenMeteoCurrentModel _self;
  final $Res Function(_OpenMeteoCurrentModel) _then;

/// Create a copy of OpenMeteoCurrentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = freezed,Object? temperature2m = freezed,Object? weatherCode = freezed,Object? relativeHumidity2m = freezed,Object? windSpeed10m = freezed,}) {
  return _then(_OpenMeteoCurrentModel(
time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,temperature2m: freezed == temperature2m ? _self.temperature2m : temperature2m // ignore: cast_nullable_to_non_nullable
as double?,weatherCode: freezed == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int?,relativeHumidity2m: freezed == relativeHumidity2m ? _self.relativeHumidity2m : relativeHumidity2m // ignore: cast_nullable_to_non_nullable
as int?,windSpeed10m: freezed == windSpeed10m ? _self.windSpeed10m : windSpeed10m // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$OpenMeteoHourlyModel {

 List<String> get time;@JsonKey(name: 'temperature_2m') List<double?> get temperature2m;@JsonKey(name: 'precipitation_probability') List<int?> get precipitationProbability;@JsonKey(name: 'weather_code') List<int?> get weatherCode;
/// Create a copy of OpenMeteoHourlyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenMeteoHourlyModelCopyWith<OpenMeteoHourlyModel> get copyWith => _$OpenMeteoHourlyModelCopyWithImpl<OpenMeteoHourlyModel>(this as OpenMeteoHourlyModel, _$identity);

  /// Serializes this OpenMeteoHourlyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenMeteoHourlyModel&&const DeepCollectionEquality().equals(other.time, time)&&const DeepCollectionEquality().equals(other.temperature2m, temperature2m)&&const DeepCollectionEquality().equals(other.precipitationProbability, precipitationProbability)&&const DeepCollectionEquality().equals(other.weatherCode, weatherCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(time),const DeepCollectionEquality().hash(temperature2m),const DeepCollectionEquality().hash(precipitationProbability),const DeepCollectionEquality().hash(weatherCode));

@override
String toString() {
  return 'OpenMeteoHourlyModel(time: $time, temperature2m: $temperature2m, precipitationProbability: $precipitationProbability, weatherCode: $weatherCode)';
}


}

/// @nodoc
abstract mixin class $OpenMeteoHourlyModelCopyWith<$Res>  {
  factory $OpenMeteoHourlyModelCopyWith(OpenMeteoHourlyModel value, $Res Function(OpenMeteoHourlyModel) _then) = _$OpenMeteoHourlyModelCopyWithImpl;
@useResult
$Res call({
 List<String> time,@JsonKey(name: 'temperature_2m') List<double?> temperature2m,@JsonKey(name: 'precipitation_probability') List<int?> precipitationProbability,@JsonKey(name: 'weather_code') List<int?> weatherCode
});




}
/// @nodoc
class _$OpenMeteoHourlyModelCopyWithImpl<$Res>
    implements $OpenMeteoHourlyModelCopyWith<$Res> {
  _$OpenMeteoHourlyModelCopyWithImpl(this._self, this._then);

  final OpenMeteoHourlyModel _self;
  final $Res Function(OpenMeteoHourlyModel) _then;

/// Create a copy of OpenMeteoHourlyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? temperature2m = null,Object? precipitationProbability = null,Object? weatherCode = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as List<String>,temperature2m: null == temperature2m ? _self.temperature2m : temperature2m // ignore: cast_nullable_to_non_nullable
as List<double?>,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as List<int?>,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as List<int?>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _OpenMeteoHourlyModel implements OpenMeteoHourlyModel {
  const _OpenMeteoHourlyModel({final  List<String> time = const [], @JsonKey(name: 'temperature_2m') final  List<double?> temperature2m = const [], @JsonKey(name: 'precipitation_probability') final  List<int?> precipitationProbability = const [], @JsonKey(name: 'weather_code') final  List<int?> weatherCode = const []}): _time = time,_temperature2m = temperature2m,_precipitationProbability = precipitationProbability,_weatherCode = weatherCode;
  factory _OpenMeteoHourlyModel.fromJson(Map<String, dynamic> json) => _$OpenMeteoHourlyModelFromJson(json);

 final  List<String> _time;
@override@JsonKey() List<String> get time {
  if (_time is EqualUnmodifiableListView) return _time;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_time);
}

 final  List<double?> _temperature2m;
@override@JsonKey(name: 'temperature_2m') List<double?> get temperature2m {
  if (_temperature2m is EqualUnmodifiableListView) return _temperature2m;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_temperature2m);
}

 final  List<int?> _precipitationProbability;
@override@JsonKey(name: 'precipitation_probability') List<int?> get precipitationProbability {
  if (_precipitationProbability is EqualUnmodifiableListView) return _precipitationProbability;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_precipitationProbability);
}

 final  List<int?> _weatherCode;
@override@JsonKey(name: 'weather_code') List<int?> get weatherCode {
  if (_weatherCode is EqualUnmodifiableListView) return _weatherCode;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weatherCode);
}


/// Create a copy of OpenMeteoHourlyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenMeteoHourlyModelCopyWith<_OpenMeteoHourlyModel> get copyWith => __$OpenMeteoHourlyModelCopyWithImpl<_OpenMeteoHourlyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenMeteoHourlyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenMeteoHourlyModel&&const DeepCollectionEquality().equals(other._time, _time)&&const DeepCollectionEquality().equals(other._temperature2m, _temperature2m)&&const DeepCollectionEquality().equals(other._precipitationProbability, _precipitationProbability)&&const DeepCollectionEquality().equals(other._weatherCode, _weatherCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_time),const DeepCollectionEquality().hash(_temperature2m),const DeepCollectionEquality().hash(_precipitationProbability),const DeepCollectionEquality().hash(_weatherCode));

@override
String toString() {
  return 'OpenMeteoHourlyModel(time: $time, temperature2m: $temperature2m, precipitationProbability: $precipitationProbability, weatherCode: $weatherCode)';
}


}

/// @nodoc
abstract mixin class _$OpenMeteoHourlyModelCopyWith<$Res> implements $OpenMeteoHourlyModelCopyWith<$Res> {
  factory _$OpenMeteoHourlyModelCopyWith(_OpenMeteoHourlyModel value, $Res Function(_OpenMeteoHourlyModel) _then) = __$OpenMeteoHourlyModelCopyWithImpl;
@override @useResult
$Res call({
 List<String> time,@JsonKey(name: 'temperature_2m') List<double?> temperature2m,@JsonKey(name: 'precipitation_probability') List<int?> precipitationProbability,@JsonKey(name: 'weather_code') List<int?> weatherCode
});




}
/// @nodoc
class __$OpenMeteoHourlyModelCopyWithImpl<$Res>
    implements _$OpenMeteoHourlyModelCopyWith<$Res> {
  __$OpenMeteoHourlyModelCopyWithImpl(this._self, this._then);

  final _OpenMeteoHourlyModel _self;
  final $Res Function(_OpenMeteoHourlyModel) _then;

/// Create a copy of OpenMeteoHourlyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? temperature2m = null,Object? precipitationProbability = null,Object? weatherCode = null,}) {
  return _then(_OpenMeteoHourlyModel(
time: null == time ? _self._time : time // ignore: cast_nullable_to_non_nullable
as List<String>,temperature2m: null == temperature2m ? _self._temperature2m : temperature2m // ignore: cast_nullable_to_non_nullable
as List<double?>,precipitationProbability: null == precipitationProbability ? _self._precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as List<int?>,weatherCode: null == weatherCode ? _self._weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as List<int?>,
  ));
}


}


/// @nodoc
mixin _$OpenMeteoDailyModel {

 List<String> get time;@JsonKey(name: 'temperature_2m_max') List<double?> get temperature2mMax;@JsonKey(name: 'temperature_2m_min') List<double?> get temperature2mMin;@JsonKey(name: 'weather_code') List<int?> get weatherCode; List<String?> get sunrise; List<String?> get sunset;
/// Create a copy of OpenMeteoDailyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenMeteoDailyModelCopyWith<OpenMeteoDailyModel> get copyWith => _$OpenMeteoDailyModelCopyWithImpl<OpenMeteoDailyModel>(this as OpenMeteoDailyModel, _$identity);

  /// Serializes this OpenMeteoDailyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenMeteoDailyModel&&const DeepCollectionEquality().equals(other.time, time)&&const DeepCollectionEquality().equals(other.temperature2mMax, temperature2mMax)&&const DeepCollectionEquality().equals(other.temperature2mMin, temperature2mMin)&&const DeepCollectionEquality().equals(other.weatherCode, weatherCode)&&const DeepCollectionEquality().equals(other.sunrise, sunrise)&&const DeepCollectionEquality().equals(other.sunset, sunset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(time),const DeepCollectionEquality().hash(temperature2mMax),const DeepCollectionEquality().hash(temperature2mMin),const DeepCollectionEquality().hash(weatherCode),const DeepCollectionEquality().hash(sunrise),const DeepCollectionEquality().hash(sunset));

@override
String toString() {
  return 'OpenMeteoDailyModel(time: $time, temperature2mMax: $temperature2mMax, temperature2mMin: $temperature2mMin, weatherCode: $weatherCode, sunrise: $sunrise, sunset: $sunset)';
}


}

/// @nodoc
abstract mixin class $OpenMeteoDailyModelCopyWith<$Res>  {
  factory $OpenMeteoDailyModelCopyWith(OpenMeteoDailyModel value, $Res Function(OpenMeteoDailyModel) _then) = _$OpenMeteoDailyModelCopyWithImpl;
@useResult
$Res call({
 List<String> time,@JsonKey(name: 'temperature_2m_max') List<double?> temperature2mMax,@JsonKey(name: 'temperature_2m_min') List<double?> temperature2mMin,@JsonKey(name: 'weather_code') List<int?> weatherCode, List<String?> sunrise, List<String?> sunset
});




}
/// @nodoc
class _$OpenMeteoDailyModelCopyWithImpl<$Res>
    implements $OpenMeteoDailyModelCopyWith<$Res> {
  _$OpenMeteoDailyModelCopyWithImpl(this._self, this._then);

  final OpenMeteoDailyModel _self;
  final $Res Function(OpenMeteoDailyModel) _then;

/// Create a copy of OpenMeteoDailyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? temperature2mMax = null,Object? temperature2mMin = null,Object? weatherCode = null,Object? sunrise = null,Object? sunset = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as List<String>,temperature2mMax: null == temperature2mMax ? _self.temperature2mMax : temperature2mMax // ignore: cast_nullable_to_non_nullable
as List<double?>,temperature2mMin: null == temperature2mMin ? _self.temperature2mMin : temperature2mMin // ignore: cast_nullable_to_non_nullable
as List<double?>,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as List<int?>,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as List<String?>,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as List<String?>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _OpenMeteoDailyModel implements OpenMeteoDailyModel {
  const _OpenMeteoDailyModel({final  List<String> time = const [], @JsonKey(name: 'temperature_2m_max') final  List<double?> temperature2mMax = const [], @JsonKey(name: 'temperature_2m_min') final  List<double?> temperature2mMin = const [], @JsonKey(name: 'weather_code') final  List<int?> weatherCode = const [], final  List<String?> sunrise = const [], final  List<String?> sunset = const []}): _time = time,_temperature2mMax = temperature2mMax,_temperature2mMin = temperature2mMin,_weatherCode = weatherCode,_sunrise = sunrise,_sunset = sunset;
  factory _OpenMeteoDailyModel.fromJson(Map<String, dynamic> json) => _$OpenMeteoDailyModelFromJson(json);

 final  List<String> _time;
@override@JsonKey() List<String> get time {
  if (_time is EqualUnmodifiableListView) return _time;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_time);
}

 final  List<double?> _temperature2mMax;
@override@JsonKey(name: 'temperature_2m_max') List<double?> get temperature2mMax {
  if (_temperature2mMax is EqualUnmodifiableListView) return _temperature2mMax;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_temperature2mMax);
}

 final  List<double?> _temperature2mMin;
@override@JsonKey(name: 'temperature_2m_min') List<double?> get temperature2mMin {
  if (_temperature2mMin is EqualUnmodifiableListView) return _temperature2mMin;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_temperature2mMin);
}

 final  List<int?> _weatherCode;
@override@JsonKey(name: 'weather_code') List<int?> get weatherCode {
  if (_weatherCode is EqualUnmodifiableListView) return _weatherCode;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weatherCode);
}

 final  List<String?> _sunrise;
@override@JsonKey() List<String?> get sunrise {
  if (_sunrise is EqualUnmodifiableListView) return _sunrise;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sunrise);
}

 final  List<String?> _sunset;
@override@JsonKey() List<String?> get sunset {
  if (_sunset is EqualUnmodifiableListView) return _sunset;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sunset);
}


/// Create a copy of OpenMeteoDailyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenMeteoDailyModelCopyWith<_OpenMeteoDailyModel> get copyWith => __$OpenMeteoDailyModelCopyWithImpl<_OpenMeteoDailyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenMeteoDailyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenMeteoDailyModel&&const DeepCollectionEquality().equals(other._time, _time)&&const DeepCollectionEquality().equals(other._temperature2mMax, _temperature2mMax)&&const DeepCollectionEquality().equals(other._temperature2mMin, _temperature2mMin)&&const DeepCollectionEquality().equals(other._weatherCode, _weatherCode)&&const DeepCollectionEquality().equals(other._sunrise, _sunrise)&&const DeepCollectionEquality().equals(other._sunset, _sunset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_time),const DeepCollectionEquality().hash(_temperature2mMax),const DeepCollectionEquality().hash(_temperature2mMin),const DeepCollectionEquality().hash(_weatherCode),const DeepCollectionEquality().hash(_sunrise),const DeepCollectionEquality().hash(_sunset));

@override
String toString() {
  return 'OpenMeteoDailyModel(time: $time, temperature2mMax: $temperature2mMax, temperature2mMin: $temperature2mMin, weatherCode: $weatherCode, sunrise: $sunrise, sunset: $sunset)';
}


}

/// @nodoc
abstract mixin class _$OpenMeteoDailyModelCopyWith<$Res> implements $OpenMeteoDailyModelCopyWith<$Res> {
  factory _$OpenMeteoDailyModelCopyWith(_OpenMeteoDailyModel value, $Res Function(_OpenMeteoDailyModel) _then) = __$OpenMeteoDailyModelCopyWithImpl;
@override @useResult
$Res call({
 List<String> time,@JsonKey(name: 'temperature_2m_max') List<double?> temperature2mMax,@JsonKey(name: 'temperature_2m_min') List<double?> temperature2mMin,@JsonKey(name: 'weather_code') List<int?> weatherCode, List<String?> sunrise, List<String?> sunset
});




}
/// @nodoc
class __$OpenMeteoDailyModelCopyWithImpl<$Res>
    implements _$OpenMeteoDailyModelCopyWith<$Res> {
  __$OpenMeteoDailyModelCopyWithImpl(this._self, this._then);

  final _OpenMeteoDailyModel _self;
  final $Res Function(_OpenMeteoDailyModel) _then;

/// Create a copy of OpenMeteoDailyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? temperature2mMax = null,Object? temperature2mMin = null,Object? weatherCode = null,Object? sunrise = null,Object? sunset = null,}) {
  return _then(_OpenMeteoDailyModel(
time: null == time ? _self._time : time // ignore: cast_nullable_to_non_nullable
as List<String>,temperature2mMax: null == temperature2mMax ? _self._temperature2mMax : temperature2mMax // ignore: cast_nullable_to_non_nullable
as List<double?>,temperature2mMin: null == temperature2mMin ? _self._temperature2mMin : temperature2mMin // ignore: cast_nullable_to_non_nullable
as List<double?>,weatherCode: null == weatherCode ? _self._weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as List<int?>,sunrise: null == sunrise ? _self._sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as List<String?>,sunset: null == sunset ? _self._sunset : sunset // ignore: cast_nullable_to_non_nullable
as List<String?>,
  ));
}


}

// dart format on
