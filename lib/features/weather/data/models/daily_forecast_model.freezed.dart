// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_forecast_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyForecastModel {

 DateTime get date; double get maxTemperature; double get minTemperature;@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) WeatherCondition get condition; DateTime get sunrise; DateTime get sunset;
/// Create a copy of DailyForecastModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyForecastModelCopyWith<DailyForecastModel> get copyWith => _$DailyForecastModelCopyWithImpl<DailyForecastModel>(this as DailyForecastModel, _$identity);

  /// Serializes this DailyForecastModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyForecastModel&&(identical(other.date, date) || other.date == date)&&(identical(other.maxTemperature, maxTemperature) || other.maxTemperature == maxTemperature)&&(identical(other.minTemperature, minTemperature) || other.minTemperature == minTemperature)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,maxTemperature,minTemperature,condition,sunrise,sunset);

@override
String toString() {
  return 'DailyForecastModel(date: $date, maxTemperature: $maxTemperature, minTemperature: $minTemperature, condition: $condition, sunrise: $sunrise, sunset: $sunset)';
}


}

/// @nodoc
abstract mixin class $DailyForecastModelCopyWith<$Res>  {
  factory $DailyForecastModelCopyWith(DailyForecastModel value, $Res Function(DailyForecastModel) _then) = _$DailyForecastModelCopyWithImpl;
@useResult
$Res call({
 DateTime date, double maxTemperature, double minTemperature,@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) WeatherCondition condition, DateTime sunrise, DateTime sunset
});




}
/// @nodoc
class _$DailyForecastModelCopyWithImpl<$Res>
    implements $DailyForecastModelCopyWith<$Res> {
  _$DailyForecastModelCopyWithImpl(this._self, this._then);

  final DailyForecastModel _self;
  final $Res Function(DailyForecastModel) _then;

/// Create a copy of DailyForecastModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? maxTemperature = null,Object? minTemperature = null,Object? condition = null,Object? sunrise = null,Object? sunset = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,maxTemperature: null == maxTemperature ? _self.maxTemperature : maxTemperature // ignore: cast_nullable_to_non_nullable
as double,minTemperature: null == minTemperature ? _self.minTemperature : minTemperature // ignore: cast_nullable_to_non_nullable
as double,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherCondition,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _DailyForecastModel extends DailyForecastModel {
  const _DailyForecastModel({required this.date, this.maxTemperature = 0, this.minTemperature = 0, @JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) this.condition = WeatherCondition.partlyCloudy, required this.sunrise, required this.sunset}): super._();
  factory _DailyForecastModel.fromJson(Map<String, dynamic> json) => _$DailyForecastModelFromJson(json);

@override final  DateTime date;
@override@JsonKey() final  double maxTemperature;
@override@JsonKey() final  double minTemperature;
@override@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) final  WeatherCondition condition;
@override final  DateTime sunrise;
@override final  DateTime sunset;

/// Create a copy of DailyForecastModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyForecastModelCopyWith<_DailyForecastModel> get copyWith => __$DailyForecastModelCopyWithImpl<_DailyForecastModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyForecastModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyForecastModel&&(identical(other.date, date) || other.date == date)&&(identical(other.maxTemperature, maxTemperature) || other.maxTemperature == maxTemperature)&&(identical(other.minTemperature, minTemperature) || other.minTemperature == minTemperature)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.sunset, sunset) || other.sunset == sunset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,maxTemperature,minTemperature,condition,sunrise,sunset);

@override
String toString() {
  return 'DailyForecastModel(date: $date, maxTemperature: $maxTemperature, minTemperature: $minTemperature, condition: $condition, sunrise: $sunrise, sunset: $sunset)';
}


}

/// @nodoc
abstract mixin class _$DailyForecastModelCopyWith<$Res> implements $DailyForecastModelCopyWith<$Res> {
  factory _$DailyForecastModelCopyWith(_DailyForecastModel value, $Res Function(_DailyForecastModel) _then) = __$DailyForecastModelCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double maxTemperature, double minTemperature,@JsonKey(unknownEnumValue: WeatherCondition.partlyCloudy) WeatherCondition condition, DateTime sunrise, DateTime sunset
});




}
/// @nodoc
class __$DailyForecastModelCopyWithImpl<$Res>
    implements _$DailyForecastModelCopyWith<$Res> {
  __$DailyForecastModelCopyWithImpl(this._self, this._then);

  final _DailyForecastModel _self;
  final $Res Function(_DailyForecastModel) _then;

/// Create a copy of DailyForecastModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? maxTemperature = null,Object? minTemperature = null,Object? condition = null,Object? sunrise = null,Object? sunset = null,}) {
  return _then(_DailyForecastModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,maxTemperature: null == maxTemperature ? _self.maxTemperature : maxTemperature // ignore: cast_nullable_to_non_nullable
as double,minTemperature: null == minTemperature ? _self.minTemperature : minTemperature // ignore: cast_nullable_to_non_nullable
as double,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as WeatherCondition,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as DateTime,sunset: null == sunset ? _self.sunset : sunset // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
