// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lunar_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LunarDay {

/// 1..15 within the [paksha] (15 = पूर्णिमा for shukla, औंसी for krishna).
 int get tithiIndex; Paksha get paksha;
/// Create a copy of LunarDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LunarDayCopyWith<LunarDay> get copyWith => _$LunarDayCopyWithImpl<LunarDay>(this as LunarDay, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LunarDay&&(identical(other.tithiIndex, tithiIndex) || other.tithiIndex == tithiIndex)&&(identical(other.paksha, paksha) || other.paksha == paksha));
}


@override
int get hashCode => Object.hash(runtimeType,tithiIndex,paksha);

@override
String toString() {
  return 'LunarDay(tithiIndex: $tithiIndex, paksha: $paksha)';
}


}

/// @nodoc
abstract mixin class $LunarDayCopyWith<$Res>  {
  factory $LunarDayCopyWith(LunarDay value, $Res Function(LunarDay) _then) = _$LunarDayCopyWithImpl;
@useResult
$Res call({
 int tithiIndex, Paksha paksha
});




}
/// @nodoc
class _$LunarDayCopyWithImpl<$Res>
    implements $LunarDayCopyWith<$Res> {
  _$LunarDayCopyWithImpl(this._self, this._then);

  final LunarDay _self;
  final $Res Function(LunarDay) _then;

/// Create a copy of LunarDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tithiIndex = null,Object? paksha = null,}) {
  return _then(_self.copyWith(
tithiIndex: null == tithiIndex ? _self.tithiIndex : tithiIndex // ignore: cast_nullable_to_non_nullable
as int,paksha: null == paksha ? _self.paksha : paksha // ignore: cast_nullable_to_non_nullable
as Paksha,
  ));
}

}



/// @nodoc


class _LunarDay extends LunarDay {
  const _LunarDay({required this.tithiIndex, required this.paksha}): super._();
  

/// 1..15 within the [paksha] (15 = पूर्णिमा for shukla, औंसी for krishna).
@override final  int tithiIndex;
@override final  Paksha paksha;

/// Create a copy of LunarDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LunarDayCopyWith<_LunarDay> get copyWith => __$LunarDayCopyWithImpl<_LunarDay>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LunarDay&&(identical(other.tithiIndex, tithiIndex) || other.tithiIndex == tithiIndex)&&(identical(other.paksha, paksha) || other.paksha == paksha));
}


@override
int get hashCode => Object.hash(runtimeType,tithiIndex,paksha);

@override
String toString() {
  return 'LunarDay(tithiIndex: $tithiIndex, paksha: $paksha)';
}


}

/// @nodoc
abstract mixin class _$LunarDayCopyWith<$Res> implements $LunarDayCopyWith<$Res> {
  factory _$LunarDayCopyWith(_LunarDay value, $Res Function(_LunarDay) _then) = __$LunarDayCopyWithImpl;
@override @useResult
$Res call({
 int tithiIndex, Paksha paksha
});




}
/// @nodoc
class __$LunarDayCopyWithImpl<$Res>
    implements _$LunarDayCopyWith<$Res> {
  __$LunarDayCopyWithImpl(this._self, this._then);

  final _LunarDay _self;
  final $Res Function(_LunarDay) _then;

/// Create a copy of LunarDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tithiIndex = null,Object? paksha = null,}) {
  return _then(_LunarDay(
tithiIndex: null == tithiIndex ? _self.tithiIndex : tithiIndex // ignore: cast_nullable_to_non_nullable
as int,paksha: null == paksha ? _self.paksha : paksha // ignore: cast_nullable_to_non_nullable
as Paksha,
  ));
}


}

// dart format on
