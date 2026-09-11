// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherState {

 LoadState<WeatherBundle> get weather;/// Index into `bundle.upcomingHours()` of the highlighted hourly card.
 int get selectedHourIndex;/// Location chosen explicitly via `loadFor` (null = device / region
/// default location).
 GeoLocation? get explicitLocation;
/// Create a copy of WeatherState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherStateCopyWith<WeatherState> get copyWith => _$WeatherStateCopyWithImpl<WeatherState>(this as WeatherState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherState&&(identical(other.weather, weather) || other.weather == weather)&&(identical(other.selectedHourIndex, selectedHourIndex) || other.selectedHourIndex == selectedHourIndex)&&(identical(other.explicitLocation, explicitLocation) || other.explicitLocation == explicitLocation));
}


@override
int get hashCode => Object.hash(runtimeType,weather,selectedHourIndex,explicitLocation);

@override
String toString() {
  return 'WeatherState(weather: $weather, selectedHourIndex: $selectedHourIndex, explicitLocation: $explicitLocation)';
}


}

/// @nodoc
abstract mixin class $WeatherStateCopyWith<$Res>  {
  factory $WeatherStateCopyWith(WeatherState value, $Res Function(WeatherState) _then) = _$WeatherStateCopyWithImpl;
@useResult
$Res call({
 LoadState<WeatherBundle> weather, int selectedHourIndex, GeoLocation? explicitLocation
});


$LoadStateCopyWith<WeatherBundle, $Res> get weather;$GeoLocationCopyWith<$Res>? get explicitLocation;

}
/// @nodoc
class _$WeatherStateCopyWithImpl<$Res>
    implements $WeatherStateCopyWith<$Res> {
  _$WeatherStateCopyWithImpl(this._self, this._then);

  final WeatherState _self;
  final $Res Function(WeatherState) _then;

/// Create a copy of WeatherState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weather = null,Object? selectedHourIndex = null,Object? explicitLocation = freezed,}) {
  return _then(_self.copyWith(
weather: null == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as LoadState<WeatherBundle>,selectedHourIndex: null == selectedHourIndex ? _self.selectedHourIndex : selectedHourIndex // ignore: cast_nullable_to_non_nullable
as int,explicitLocation: freezed == explicitLocation ? _self.explicitLocation : explicitLocation // ignore: cast_nullable_to_non_nullable
as GeoLocation?,
  ));
}
/// Create a copy of WeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<WeatherBundle, $Res> get weather {
  
  return $LoadStateCopyWith<WeatherBundle, $Res>(_self.weather, (value) {
    return _then(_self.copyWith(weather: value));
  });
}/// Create a copy of WeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoLocationCopyWith<$Res>? get explicitLocation {
    if (_self.explicitLocation == null) {
    return null;
  }

  return $GeoLocationCopyWith<$Res>(_self.explicitLocation!, (value) {
    return _then(_self.copyWith(explicitLocation: value));
  });
}
}



/// @nodoc


class _WeatherState extends WeatherState {
  const _WeatherState({this.weather = const LoadState.idle(), this.selectedHourIndex = 0, this.explicitLocation}): super._();
  

@override@JsonKey() final  LoadState<WeatherBundle> weather;
/// Index into `bundle.upcomingHours()` of the highlighted hourly card.
@override@JsonKey() final  int selectedHourIndex;
/// Location chosen explicitly via `loadFor` (null = device / region
/// default location).
@override final  GeoLocation? explicitLocation;

/// Create a copy of WeatherState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherStateCopyWith<_WeatherState> get copyWith => __$WeatherStateCopyWithImpl<_WeatherState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherState&&(identical(other.weather, weather) || other.weather == weather)&&(identical(other.selectedHourIndex, selectedHourIndex) || other.selectedHourIndex == selectedHourIndex)&&(identical(other.explicitLocation, explicitLocation) || other.explicitLocation == explicitLocation));
}


@override
int get hashCode => Object.hash(runtimeType,weather,selectedHourIndex,explicitLocation);

@override
String toString() {
  return 'WeatherState(weather: $weather, selectedHourIndex: $selectedHourIndex, explicitLocation: $explicitLocation)';
}


}

/// @nodoc
abstract mixin class _$WeatherStateCopyWith<$Res> implements $WeatherStateCopyWith<$Res> {
  factory _$WeatherStateCopyWith(_WeatherState value, $Res Function(_WeatherState) _then) = __$WeatherStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<WeatherBundle> weather, int selectedHourIndex, GeoLocation? explicitLocation
});


@override $LoadStateCopyWith<WeatherBundle, $Res> get weather;@override $GeoLocationCopyWith<$Res>? get explicitLocation;

}
/// @nodoc
class __$WeatherStateCopyWithImpl<$Res>
    implements _$WeatherStateCopyWith<$Res> {
  __$WeatherStateCopyWithImpl(this._self, this._then);

  final _WeatherState _self;
  final $Res Function(_WeatherState) _then;

/// Create a copy of WeatherState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weather = null,Object? selectedHourIndex = null,Object? explicitLocation = freezed,}) {
  return _then(_WeatherState(
weather: null == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as LoadState<WeatherBundle>,selectedHourIndex: null == selectedHourIndex ? _self.selectedHourIndex : selectedHourIndex // ignore: cast_nullable_to_non_nullable
as int,explicitLocation: freezed == explicitLocation ? _self.explicitLocation : explicitLocation // ignore: cast_nullable_to_non_nullable
as GeoLocation?,
  ));
}

/// Create a copy of WeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<WeatherBundle, $Res> get weather {
  
  return $LoadStateCopyWith<WeatherBundle, $Res>(_self.weather, (value) {
    return _then(_self.copyWith(weather: value));
  });
}/// Create a copy of WeatherState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoLocationCopyWith<$Res>? get explicitLocation {
    if (_self.explicitLocation == null) {
    return null;
  }

  return $GeoLocationCopyWith<$Res>(_self.explicitLocation!, (value) {
    return _then(_self.copyWith(explicitLocation: value));
  });
}
}

// dart format on
