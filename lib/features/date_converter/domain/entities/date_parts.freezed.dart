// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_parts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DateParts {

 int get year; int get month; int get day;
/// Create a copy of DateParts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatePartsCopyWith<DateParts> get copyWith => _$DatePartsCopyWithImpl<DateParts>(this as DateParts, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateParts&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,day);

@override
String toString() {
  return 'DateParts(year: $year, month: $month, day: $day)';
}


}

/// @nodoc
abstract mixin class $DatePartsCopyWith<$Res>  {
  factory $DatePartsCopyWith(DateParts value, $Res Function(DateParts) _then) = _$DatePartsCopyWithImpl;
@useResult
$Res call({
 int year, int month, int day
});




}
/// @nodoc
class _$DatePartsCopyWithImpl<$Res>
    implements $DatePartsCopyWith<$Res> {
  _$DatePartsCopyWithImpl(this._self, this._then);

  final DateParts _self;
  final $Res Function(DateParts) _then;

/// Create a copy of DateParts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_self.copyWith(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _DateParts implements DateParts {
  const _DateParts({required this.year, required this.month, required this.day});
  

@override final  int year;
@override final  int month;
@override final  int day;

/// Create a copy of DateParts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DatePartsCopyWith<_DateParts> get copyWith => __$DatePartsCopyWithImpl<_DateParts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateParts&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,day);

@override
String toString() {
  return 'DateParts(year: $year, month: $month, day: $day)';
}


}

/// @nodoc
abstract mixin class _$DatePartsCopyWith<$Res> implements $DatePartsCopyWith<$Res> {
  factory _$DatePartsCopyWith(_DateParts value, $Res Function(_DateParts) _then) = __$DatePartsCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, int day
});




}
/// @nodoc
class __$DatePartsCopyWithImpl<$Res>
    implements _$DatePartsCopyWith<$Res> {
  __$DatePartsCopyWithImpl(this._self, this._then);

  final _DateParts _self;
  final $Res Function(_DateParts) _then;

/// Create a copy of DateParts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_DateParts(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
