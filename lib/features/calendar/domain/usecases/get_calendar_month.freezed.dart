// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_calendar_month.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarMonthParams {

 int get year; int get month; CalendarViewMode get mode;
/// Create a copy of CalendarMonthParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarMonthParamsCopyWith<CalendarMonthParams> get copyWith => _$CalendarMonthParamsCopyWithImpl<CalendarMonthParams>(this as CalendarMonthParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarMonthParams&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,mode);

@override
String toString() {
  return 'CalendarMonthParams(year: $year, month: $month, mode: $mode)';
}


}

/// @nodoc
abstract mixin class $CalendarMonthParamsCopyWith<$Res>  {
  factory $CalendarMonthParamsCopyWith(CalendarMonthParams value, $Res Function(CalendarMonthParams) _then) = _$CalendarMonthParamsCopyWithImpl;
@useResult
$Res call({
 int year, int month, CalendarViewMode mode
});




}
/// @nodoc
class _$CalendarMonthParamsCopyWithImpl<$Res>
    implements $CalendarMonthParamsCopyWith<$Res> {
  _$CalendarMonthParamsCopyWithImpl(this._self, this._then);

  final CalendarMonthParams _self;
  final $Res Function(CalendarMonthParams) _then;

/// Create a copy of CalendarMonthParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? mode = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as CalendarViewMode,
  ));
}

}



/// @nodoc


class _CalendarMonthParams implements CalendarMonthParams {
  const _CalendarMonthParams({required this.year, required this.month, this.mode = CalendarViewMode.traditional});
  

@override final  int year;
@override final  int month;
@override@JsonKey() final  CalendarViewMode mode;

/// Create a copy of CalendarMonthParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarMonthParamsCopyWith<_CalendarMonthParams> get copyWith => __$CalendarMonthParamsCopyWithImpl<_CalendarMonthParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarMonthParams&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,mode);

@override
String toString() {
  return 'CalendarMonthParams(year: $year, month: $month, mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$CalendarMonthParamsCopyWith<$Res> implements $CalendarMonthParamsCopyWith<$Res> {
  factory _$CalendarMonthParamsCopyWith(_CalendarMonthParams value, $Res Function(_CalendarMonthParams) _then) = __$CalendarMonthParamsCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, CalendarViewMode mode
});




}
/// @nodoc
class __$CalendarMonthParamsCopyWithImpl<$Res>
    implements _$CalendarMonthParamsCopyWith<$Res> {
  __$CalendarMonthParamsCopyWithImpl(this._self, this._then);

  final _CalendarMonthParams _self;
  final $Res Function(_CalendarMonthParams) _then;

/// Create a copy of CalendarMonthParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? mode = null,}) {
  return _then(_CalendarMonthParams(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as CalendarViewMode,
  ));
}


}

// dart format on
