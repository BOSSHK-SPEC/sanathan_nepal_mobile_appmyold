// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kundli_chart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanetPosition {

 Graha get graha;/// Sidereal longitude, 0–360.
 double get longitude;/// House 1–12, counted from the ascendant.
 int get house; bool get retrograde;
/// Create a copy of PlanetPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanetPositionCopyWith<PlanetPosition> get copyWith => _$PlanetPositionCopyWithImpl<PlanetPosition>(this as PlanetPosition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanetPosition&&(identical(other.graha, graha) || other.graha == graha)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.house, house) || other.house == house)&&(identical(other.retrograde, retrograde) || other.retrograde == retrograde));
}


@override
int get hashCode => Object.hash(runtimeType,graha,longitude,house,retrograde);

@override
String toString() {
  return 'PlanetPosition(graha: $graha, longitude: $longitude, house: $house, retrograde: $retrograde)';
}


}

/// @nodoc
abstract mixin class $PlanetPositionCopyWith<$Res>  {
  factory $PlanetPositionCopyWith(PlanetPosition value, $Res Function(PlanetPosition) _then) = _$PlanetPositionCopyWithImpl;
@useResult
$Res call({
 Graha graha, double longitude, int house, bool retrograde
});




}
/// @nodoc
class _$PlanetPositionCopyWithImpl<$Res>
    implements $PlanetPositionCopyWith<$Res> {
  _$PlanetPositionCopyWithImpl(this._self, this._then);

  final PlanetPosition _self;
  final $Res Function(PlanetPosition) _then;

/// Create a copy of PlanetPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? graha = null,Object? longitude = null,Object? house = null,Object? retrograde = null,}) {
  return _then(_self.copyWith(
graha: null == graha ? _self.graha : graha // ignore: cast_nullable_to_non_nullable
as Graha,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,house: null == house ? _self.house : house // ignore: cast_nullable_to_non_nullable
as int,retrograde: null == retrograde ? _self.retrograde : retrograde // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _PlanetPosition extends PlanetPosition {
  const _PlanetPosition({required this.graha, required this.longitude, required this.house, this.retrograde = false}): super._();
  

@override final  Graha graha;
/// Sidereal longitude, 0–360.
@override final  double longitude;
/// House 1–12, counted from the ascendant.
@override final  int house;
@override@JsonKey() final  bool retrograde;

/// Create a copy of PlanetPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanetPositionCopyWith<_PlanetPosition> get copyWith => __$PlanetPositionCopyWithImpl<_PlanetPosition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanetPosition&&(identical(other.graha, graha) || other.graha == graha)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.house, house) || other.house == house)&&(identical(other.retrograde, retrograde) || other.retrograde == retrograde));
}


@override
int get hashCode => Object.hash(runtimeType,graha,longitude,house,retrograde);

@override
String toString() {
  return 'PlanetPosition(graha: $graha, longitude: $longitude, house: $house, retrograde: $retrograde)';
}


}

/// @nodoc
abstract mixin class _$PlanetPositionCopyWith<$Res> implements $PlanetPositionCopyWith<$Res> {
  factory _$PlanetPositionCopyWith(_PlanetPosition value, $Res Function(_PlanetPosition) _then) = __$PlanetPositionCopyWithImpl;
@override @useResult
$Res call({
 Graha graha, double longitude, int house, bool retrograde
});




}
/// @nodoc
class __$PlanetPositionCopyWithImpl<$Res>
    implements _$PlanetPositionCopyWith<$Res> {
  __$PlanetPositionCopyWithImpl(this._self, this._then);

  final _PlanetPosition _self;
  final $Res Function(_PlanetPosition) _then;

/// Create a copy of PlanetPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? graha = null,Object? longitude = null,Object? house = null,Object? retrograde = null,}) {
  return _then(_PlanetPosition(
graha: null == graha ? _self.graha : graha // ignore: cast_nullable_to_non_nullable
as Graha,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,house: null == house ? _self.house : house // ignore: cast_nullable_to_non_nullable
as int,retrograde: null == retrograde ? _self.retrograde : retrograde // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$KundliChart {

 BirthProfile get profile; double get ascendantLongitude; List<PlanetPosition> get positions;
/// Create a copy of KundliChart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KundliChartCopyWith<KundliChart> get copyWith => _$KundliChartCopyWithImpl<KundliChart>(this as KundliChart, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KundliChart&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.ascendantLongitude, ascendantLongitude) || other.ascendantLongitude == ascendantLongitude)&&const DeepCollectionEquality().equals(other.positions, positions));
}


@override
int get hashCode => Object.hash(runtimeType,profile,ascendantLongitude,const DeepCollectionEquality().hash(positions));

@override
String toString() {
  return 'KundliChart(profile: $profile, ascendantLongitude: $ascendantLongitude, positions: $positions)';
}


}

/// @nodoc
abstract mixin class $KundliChartCopyWith<$Res>  {
  factory $KundliChartCopyWith(KundliChart value, $Res Function(KundliChart) _then) = _$KundliChartCopyWithImpl;
@useResult
$Res call({
 BirthProfile profile, double ascendantLongitude, List<PlanetPosition> positions
});


$BirthProfileCopyWith<$Res> get profile;

}
/// @nodoc
class _$KundliChartCopyWithImpl<$Res>
    implements $KundliChartCopyWith<$Res> {
  _$KundliChartCopyWithImpl(this._self, this._then);

  final KundliChart _self;
  final $Res Function(KundliChart) _then;

/// Create a copy of KundliChart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? ascendantLongitude = null,Object? positions = null,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as BirthProfile,ascendantLongitude: null == ascendantLongitude ? _self.ascendantLongitude : ascendantLongitude // ignore: cast_nullable_to_non_nullable
as double,positions: null == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as List<PlanetPosition>,
  ));
}
/// Create a copy of KundliChart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BirthProfileCopyWith<$Res> get profile {
  
  return $BirthProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}



/// @nodoc


class _KundliChart extends KundliChart {
  const _KundliChart({required this.profile, required this.ascendantLongitude, required final  List<PlanetPosition> positions}): _positions = positions,super._();
  

@override final  BirthProfile profile;
@override final  double ascendantLongitude;
 final  List<PlanetPosition> _positions;
@override List<PlanetPosition> get positions {
  if (_positions is EqualUnmodifiableListView) return _positions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_positions);
}


/// Create a copy of KundliChart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KundliChartCopyWith<_KundliChart> get copyWith => __$KundliChartCopyWithImpl<_KundliChart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KundliChart&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.ascendantLongitude, ascendantLongitude) || other.ascendantLongitude == ascendantLongitude)&&const DeepCollectionEquality().equals(other._positions, _positions));
}


@override
int get hashCode => Object.hash(runtimeType,profile,ascendantLongitude,const DeepCollectionEquality().hash(_positions));

@override
String toString() {
  return 'KundliChart(profile: $profile, ascendantLongitude: $ascendantLongitude, positions: $positions)';
}


}

/// @nodoc
abstract mixin class _$KundliChartCopyWith<$Res> implements $KundliChartCopyWith<$Res> {
  factory _$KundliChartCopyWith(_KundliChart value, $Res Function(_KundliChart) _then) = __$KundliChartCopyWithImpl;
@override @useResult
$Res call({
 BirthProfile profile, double ascendantLongitude, List<PlanetPosition> positions
});


@override $BirthProfileCopyWith<$Res> get profile;

}
/// @nodoc
class __$KundliChartCopyWithImpl<$Res>
    implements _$KundliChartCopyWith<$Res> {
  __$KundliChartCopyWithImpl(this._self, this._then);

  final _KundliChart _self;
  final $Res Function(_KundliChart) _then;

/// Create a copy of KundliChart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? ascendantLongitude = null,Object? positions = null,}) {
  return _then(_KundliChart(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as BirthProfile,ascendantLongitude: null == ascendantLongitude ? _self.ascendantLongitude : ascendantLongitude // ignore: cast_nullable_to_non_nullable
as double,positions: null == positions ? _self._positions : positions // ignore: cast_nullable_to_non_nullable
as List<PlanetPosition>,
  ));
}

/// Create a copy of KundliChart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BirthProfileCopyWith<$Res> get profile {
  
  return $BirthProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
