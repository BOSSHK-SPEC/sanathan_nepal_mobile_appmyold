// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_bundle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherBundle {

 GeoLocation get location; CurrentWeather get current;/// Hourly forecast starting from the current hour (typically 24+ entries).
 List<HourlyForecast> get hourly;/// Daily forecast starting today (typically 7 entries).
 List<DailyForecast> get daily;/// True when the data came from the offline mock (network unavailable).
 bool get isFallback;
/// Create a copy of WeatherBundle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherBundleCopyWith<WeatherBundle> get copyWith => _$WeatherBundleCopyWithImpl<WeatherBundle>(this as WeatherBundle, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherBundle&&(identical(other.location, location) || other.location == location)&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other.hourly, hourly)&&const DeepCollectionEquality().equals(other.daily, daily)&&(identical(other.isFallback, isFallback) || other.isFallback == isFallback));
}


@override
int get hashCode => Object.hash(runtimeType,location,current,const DeepCollectionEquality().hash(hourly),const DeepCollectionEquality().hash(daily),isFallback);

@override
String toString() {
  return 'WeatherBundle(location: $location, current: $current, hourly: $hourly, daily: $daily, isFallback: $isFallback)';
}


}

/// @nodoc
abstract mixin class $WeatherBundleCopyWith<$Res>  {
  factory $WeatherBundleCopyWith(WeatherBundle value, $Res Function(WeatherBundle) _then) = _$WeatherBundleCopyWithImpl;
@useResult
$Res call({
 GeoLocation location, CurrentWeather current, List<HourlyForecast> hourly, List<DailyForecast> daily, bool isFallback
});


$GeoLocationCopyWith<$Res> get location;$CurrentWeatherCopyWith<$Res> get current;

}
/// @nodoc
class _$WeatherBundleCopyWithImpl<$Res>
    implements $WeatherBundleCopyWith<$Res> {
  _$WeatherBundleCopyWithImpl(this._self, this._then);

  final WeatherBundle _self;
  final $Res Function(WeatherBundle) _then;

/// Create a copy of WeatherBundle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = null,Object? current = null,Object? hourly = null,Object? daily = null,Object? isFallback = null,}) {
  return _then(_self.copyWith(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoLocation,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CurrentWeather,hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as List<HourlyForecast>,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as List<DailyForecast>,isFallback: null == isFallback ? _self.isFallback : isFallback // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of WeatherBundle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoLocationCopyWith<$Res> get location {
  
  return $GeoLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of WeatherBundle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentWeatherCopyWith<$Res> get current {
  
  return $CurrentWeatherCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}



/// @nodoc


class _WeatherBundle extends WeatherBundle {
  const _WeatherBundle({required this.location, required this.current, required final  List<HourlyForecast> hourly, required final  List<DailyForecast> daily, this.isFallback = false}): _hourly = hourly,_daily = daily,super._();
  

@override final  GeoLocation location;
@override final  CurrentWeather current;
/// Hourly forecast starting from the current hour (typically 24+ entries).
 final  List<HourlyForecast> _hourly;
/// Hourly forecast starting from the current hour (typically 24+ entries).
@override List<HourlyForecast> get hourly {
  if (_hourly is EqualUnmodifiableListView) return _hourly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hourly);
}

/// Daily forecast starting today (typically 7 entries).
 final  List<DailyForecast> _daily;
/// Daily forecast starting today (typically 7 entries).
@override List<DailyForecast> get daily {
  if (_daily is EqualUnmodifiableListView) return _daily;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daily);
}

/// True when the data came from the offline mock (network unavailable).
@override@JsonKey() final  bool isFallback;

/// Create a copy of WeatherBundle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherBundleCopyWith<_WeatherBundle> get copyWith => __$WeatherBundleCopyWithImpl<_WeatherBundle>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherBundle&&(identical(other.location, location) || other.location == location)&&(identical(other.current, current) || other.current == current)&&const DeepCollectionEquality().equals(other._hourly, _hourly)&&const DeepCollectionEquality().equals(other._daily, _daily)&&(identical(other.isFallback, isFallback) || other.isFallback == isFallback));
}


@override
int get hashCode => Object.hash(runtimeType,location,current,const DeepCollectionEquality().hash(_hourly),const DeepCollectionEquality().hash(_daily),isFallback);

@override
String toString() {
  return 'WeatherBundle(location: $location, current: $current, hourly: $hourly, daily: $daily, isFallback: $isFallback)';
}


}

/// @nodoc
abstract mixin class _$WeatherBundleCopyWith<$Res> implements $WeatherBundleCopyWith<$Res> {
  factory _$WeatherBundleCopyWith(_WeatherBundle value, $Res Function(_WeatherBundle) _then) = __$WeatherBundleCopyWithImpl;
@override @useResult
$Res call({
 GeoLocation location, CurrentWeather current, List<HourlyForecast> hourly, List<DailyForecast> daily, bool isFallback
});


@override $GeoLocationCopyWith<$Res> get location;@override $CurrentWeatherCopyWith<$Res> get current;

}
/// @nodoc
class __$WeatherBundleCopyWithImpl<$Res>
    implements _$WeatherBundleCopyWith<$Res> {
  __$WeatherBundleCopyWithImpl(this._self, this._then);

  final _WeatherBundle _self;
  final $Res Function(_WeatherBundle) _then;

/// Create a copy of WeatherBundle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = null,Object? current = null,Object? hourly = null,Object? daily = null,Object? isFallback = null,}) {
  return _then(_WeatherBundle(
location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoLocation,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as CurrentWeather,hourly: null == hourly ? _self._hourly : hourly // ignore: cast_nullable_to_non_nullable
as List<HourlyForecast>,daily: null == daily ? _self._daily : daily // ignore: cast_nullable_to_non_nullable
as List<DailyForecast>,isFallback: null == isFallback ? _self.isFallback : isFallback // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of WeatherBundle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoLocationCopyWith<$Res> get location {
  
  return $GeoLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of WeatherBundle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentWeatherCopyWith<$Res> get current {
  
  return $CurrentWeatherCopyWith<$Res>(_self.current, (value) {
    return _then(_self.copyWith(current: value));
  });
}
}

// dart format on
