// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planet_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanetPosition {

 String get nameNe; String get nameEn;/// `rashi:deg:min:sec` with ASCII digits.
 String get value;
/// Create a copy of PlanetPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanetPositionCopyWith<PlanetPosition> get copyWith => _$PlanetPositionCopyWithImpl<PlanetPosition>(this as PlanetPosition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanetPosition&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,nameNe,nameEn,value);

@override
String toString() {
  return 'PlanetPosition(nameNe: $nameNe, nameEn: $nameEn, value: $value)';
}


}

/// @nodoc
abstract mixin class $PlanetPositionCopyWith<$Res>  {
  factory $PlanetPositionCopyWith(PlanetPosition value, $Res Function(PlanetPosition) _then) = _$PlanetPositionCopyWithImpl;
@useResult
$Res call({
 String nameNe, String nameEn, String value
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
@pragma('vm:prefer-inline') @override $Res call({Object? nameNe = null,Object? nameEn = null,Object? value = null,}) {
  return _then(_self.copyWith(
nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _PlanetPosition extends PlanetPosition {
  const _PlanetPosition({required this.nameNe, required this.nameEn, required this.value}): super._();
  

@override final  String nameNe;
@override final  String nameEn;
/// `rashi:deg:min:sec` with ASCII digits.
@override final  String value;

/// Create a copy of PlanetPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanetPositionCopyWith<_PlanetPosition> get copyWith => __$PlanetPositionCopyWithImpl<_PlanetPosition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanetPosition&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,nameNe,nameEn,value);

@override
String toString() {
  return 'PlanetPosition(nameNe: $nameNe, nameEn: $nameEn, value: $value)';
}


}

/// @nodoc
abstract mixin class _$PlanetPositionCopyWith<$Res> implements $PlanetPositionCopyWith<$Res> {
  factory _$PlanetPositionCopyWith(_PlanetPosition value, $Res Function(_PlanetPosition) _then) = __$PlanetPositionCopyWithImpl;
@override @useResult
$Res call({
 String nameNe, String nameEn, String value
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
@override @pragma('vm:prefer-inline') $Res call({Object? nameNe = null,Object? nameEn = null,Object? value = null,}) {
  return _then(_PlanetPosition(
nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
