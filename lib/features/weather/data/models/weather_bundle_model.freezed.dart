// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_bundle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherBundleModel {

 GeoLocationModel get location; CurrentWeatherModel get current; List<HourlyForecastModel> get hourly; List<DailyForecastModel> get daily; bool get isFallback;
/// Create a copy of WeatherBundleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherBundleModelCopyWith<WeatherBundleModel> get copyWith => _$WeatherBundleModelCopyWithImpl<WeatherBundleModel>(this as WeatherBundleModel, _$identity);

  /// Serializes this WeatherBundleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherBundleModel&&(identical(other.location, location) || other.location == location)&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other.hourly, hourly)&&const DeepCollectionEquality().equals(other.daily, daily)&&(identical(other.isFallback, isFallback) || other.isFallback == isFallback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,current,const DeepCollectionEquality().hash(hourly),const DeepCollectionEquality().hash(daily),isFallback);

@override
String toString() {
  return 'WeatherBundleModel(location: $location, current: $current, hourly: $hourly, daily: $daily, isFallback: $isFallback)';
}


}

/// @nodoc
abstract mixin class $WeatherBundleModelCopyWith<$Res>  {
  factory $WeatherBundleModelCopyWith(WeatherBundleModel value, $Res Function(WeatherBundleModel) _then) = _$WeatherBundleModelCopyWithImpl;
@useResult
$Res call({
 GeoLocationModel location, CurrentWeatherModel current, List<HourlyForecastModel> hourly, List<DailyForecastModel> daily, bool isFallback
});


$GeoLocationModelCopyWith<$Res> get location;$CurrentWeatherModelCopyWith<$Res> get current;

}
/// @nodoc
class _$WeatherBundleModelCopyWithImpl<$Res>
    implements $WeatherBundleModelCopyWith<$Res> {
  _$WeatherBundleModelCopyWithImpl(this._self, this._then);

  final WeatherBundleModel _self;
  final $Res Function(WeatherBundleModel) _then;

/// Create a copy of WeatherBundleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? current = null,Object? hourly = null,Object? daily = null,Object? isFallback = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoLocationModel,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CurrentWeatherModel,hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as List<HourlyForecastModel>,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as List<DailyForecastModel>,isFallback: null == isFallback ? _self.isFallback : isFallback // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of WeatherBundleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoLocationModelCopyWith<$Res> get location {
  
  return $GeoLocationModelCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of WeatherBundleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentWeatherModelCopyWith<$Res> get current {
  
  return $CurrentWeatherModelCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _WeatherBundleModel extends WeatherBundleModel {
  const _WeatherBundleModel({required this.location, required this.current, final  List<HourlyForecastModel> hourly = const [], final  List<DailyForecastModel> daily = const [], this.isFallback = false}): _hourly = hourly,_daily = daily,super._();
  factory _WeatherBundleModel.fromJson(Map<String, dynamic> json) => _$WeatherBundleModelFromJson(json);

@override final  GeoLocationModel location;
@override final  CurrentWeatherModel current;
 final  List<HourlyForecastModel> _hourly;
@override@JsonKey() List<HourlyForecastModel> get hourly {
  if (_hourly is EqualUnmodifiableListView) return _hourly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hourly);
}

 final  List<DailyForecastModel> _daily;
@override@JsonKey() List<DailyForecastModel> get daily {
  if (_daily is EqualUnmodifiableListView) return _daily;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daily);
}

@override@JsonKey() final  bool isFallback;

/// Create a copy of WeatherBundleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherBundleModelCopyWith<_WeatherBundleModel> get copyWith => __$WeatherBundleModelCopyWithImpl<_WeatherBundleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherBundleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherBundleModel&&(identical(other.location, location) || other.location == location)&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other._hourly, _hourly)&&const DeepCollectionEquality().equals(other._daily, _daily)&&(identical(other.isFallback, isFallback) || other.isFallback == isFallback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location,current,const DeepCollectionEquality().hash(_hourly),const DeepCollectionEquality().hash(_daily),isFallback);

@override
String toString() {
  return 'WeatherBundleModel(location: $location, current: $current, hourly: $hourly, daily: $daily, isFallback: $isFallback)';
}


}

/// @nodoc
abstract mixin class _$WeatherBundleModelCopyWith<$Res> implements $WeatherBundleModelCopyWith<$Res> {
  factory _$WeatherBundleModelCopyWith(_WeatherBundleModel value, $Res Function(_WeatherBundleModel) _then) = __$WeatherBundleModelCopyWithImpl;
@override @useResult
$Res call({
 GeoLocationModel location, CurrentWeatherModel current, List<HourlyForecastModel> hourly, List<DailyForecastModel> daily, bool isFallback
});


@override $GeoLocationModelCopyWith<$Res> get location;@override $CurrentWeatherModelCopyWith<$Res> get current;

}
/// @nodoc
class __$WeatherBundleModelCopyWithImpl<$Res>
    implements _$WeatherBundleModelCopyWith<$Res> {
  __$WeatherBundleModelCopyWithImpl(this._self, this._then);

  final _WeatherBundleModel _self;
  final $Res Function(_WeatherBundleModel) _then;

/// Create a copy of WeatherBundleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? current = null,Object? hourly = null,Object? daily = null,Object? isFallback = null,}) {
  return _then(_WeatherBundleModel(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoLocationModel,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CurrentWeatherModel,hourly: null == hourly ? _self._hourly : hourly // ignore: cast_nullable_to_non_nullable
as List<HourlyForecastModel>,daily: null == daily ? _self._daily : daily // ignore: cast_nullable_to_non_nullable
as List<DailyForecastModel>,isFallback: null == isFallback ? _self.isFallback : isFallback // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of WeatherBundleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoLocationModelCopyWith<$Res> get location {
  
  return $GeoLocationModelCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of WeatherBundleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentWeatherModelCopyWith<$Res> get current {
  
  return $CurrentWeatherModelCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}

// dart format on
