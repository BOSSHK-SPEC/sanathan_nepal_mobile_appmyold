// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_events_in_range.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DateRangeParams {

 DateTime get from; DateTime get to;
/// Create a copy of DateRangeParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateRangeParamsCopyWith<DateRangeParams> get copyWith => _$DateRangeParamsCopyWithImpl<DateRangeParams>(this as DateRangeParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateRangeParams&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'DateRangeParams(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class $DateRangeParamsCopyWith<$Res>  {
  factory $DateRangeParamsCopyWith(DateRangeParams value, $Res Function(DateRangeParams) _then) = _$DateRangeParamsCopyWithImpl;
@useResult
$Res call({
 DateTime from, DateTime to
});




}
/// @nodoc
class _$DateRangeParamsCopyWithImpl<$Res>
    implements $DateRangeParamsCopyWith<$Res> {
  _$DateRangeParamsCopyWithImpl(this._self, this._then);

  final DateRangeParams _self;
  final $Res Function(DateRangeParams) _then;

/// Create a copy of DateRangeParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}



/// @nodoc


class _DateRangeParams implements DateRangeParams {
  const _DateRangeParams({required this.from, required this.to});
  

@override final  DateTime from;
@override final  DateTime to;

/// Create a copy of DateRangeParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateRangeParamsCopyWith<_DateRangeParams> get copyWith => __$DateRangeParamsCopyWithImpl<_DateRangeParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateRangeParams&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode => Object.hash(runtimeType,from,to);

@override
String toString() {
  return 'DateRangeParams(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$DateRangeParamsCopyWith<$Res> implements $DateRangeParamsCopyWith<$Res> {
  factory _$DateRangeParamsCopyWith(_DateRangeParams value, $Res Function(_DateRangeParams) _then) = __$DateRangeParamsCopyWithImpl;
@override @useResult
$Res call({
 DateTime from, DateTime to
});




}
/// @nodoc
class __$DateRangeParamsCopyWithImpl<$Res>
    implements _$DateRangeParamsCopyWith<$Res> {
  __$DateRangeParamsCopyWithImpl(this._self, this._then);

  final _DateRangeParams _self;
  final $Res Function(_DateRangeParams) _then;

/// Create a copy of DateRangeParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,}) {
  return _then(_DateRangeParams(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
