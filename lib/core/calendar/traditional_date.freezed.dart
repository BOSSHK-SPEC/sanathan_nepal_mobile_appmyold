// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'traditional_date.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TraditionalDate {

 int get year; int get month; int get day;
/// Create a copy of TraditionalDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TraditionalDateCopyWith<TraditionalDate> get copyWith => _$TraditionalDateCopyWithImpl<TraditionalDate>(this as TraditionalDate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TraditionalDate&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,day);

@override
String toString() {
  return 'TraditionalDate(year: $year, month: $month, day: $day)';
}


}

/// @nodoc
abstract mixin class $TraditionalDateCopyWith<$Res>  {
  factory $TraditionalDateCopyWith(TraditionalDate value, $Res Function(TraditionalDate) _then) = _$TraditionalDateCopyWithImpl;
@useResult
$Res call({
 int year, int month, int day
});




}
/// @nodoc
class _$TraditionalDateCopyWithImpl<$Res>
    implements $TraditionalDateCopyWith<$Res> {
  _$TraditionalDateCopyWithImpl(this._self, this._then);

  final TraditionalDate _self;
  final $Res Function(TraditionalDate) _then;

/// Create a copy of TraditionalDate
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


class _TraditionalDate extends TraditionalDate {
  const _TraditionalDate(this.year, this.month, this.day): super._();
  

@override final  int year;
@override final  int month;
@override final  int day;

/// Create a copy of TraditionalDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TraditionalDateCopyWith<_TraditionalDate> get copyWith => __$TraditionalDateCopyWithImpl<_TraditionalDate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TraditionalDate&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,year,month,day);

@override
String toString() {
  return 'TraditionalDate(year: $year, month: $month, day: $day)';
}


}

/// @nodoc
abstract mixin class _$TraditionalDateCopyWith<$Res> implements $TraditionalDateCopyWith<$Res> {
  factory _$TraditionalDateCopyWith(_TraditionalDate value, $Res Function(_TraditionalDate) _then) = __$TraditionalDateCopyWithImpl;
@override @useResult
$Res call({
 int year, int month, int day
});




}
/// @nodoc
class __$TraditionalDateCopyWithImpl<$Res>
    implements _$TraditionalDateCopyWith<$Res> {
  __$TraditionalDateCopyWithImpl(this._self, this._then);

  final _TraditionalDate _self;
  final $Res Function(_TraditionalDate) _then;

/// Create a copy of TraditionalDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? month = null,Object? day = null,}) {
  return _then(_TraditionalDate(
null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
