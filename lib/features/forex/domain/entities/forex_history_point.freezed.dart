// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forex_history_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForexHistoryPoint {

 DateTime get date; double get buy; double get sell;
/// Create a copy of ForexHistoryPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForexHistoryPointCopyWith<ForexHistoryPoint> get copyWith => _$ForexHistoryPointCopyWithImpl<ForexHistoryPoint>(this as ForexHistoryPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForexHistoryPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.buy, buy) || other.buy == buy)&&(identical(other.sell, sell) || other.sell == sell));
}


@override
int get hashCode => Object.hash(runtimeType,date,buy,sell);

@override
String toString() {
  return 'ForexHistoryPoint(date: $date, buy: $buy, sell: $sell)';
}


}

/// @nodoc
abstract mixin class $ForexHistoryPointCopyWith<$Res>  {
  factory $ForexHistoryPointCopyWith(ForexHistoryPoint value, $Res Function(ForexHistoryPoint) _then) = _$ForexHistoryPointCopyWithImpl;
@useResult
$Res call({
 DateTime date, double buy, double sell
});




}
/// @nodoc
class _$ForexHistoryPointCopyWithImpl<$Res>
    implements $ForexHistoryPointCopyWith<$Res> {
  _$ForexHistoryPointCopyWithImpl(this._self, this._then);

  final ForexHistoryPoint _self;
  final $Res Function(ForexHistoryPoint) _then;

/// Create a copy of ForexHistoryPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? buy = null,Object? sell = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,buy: null == buy ? _self.buy : buy // ignore: cast_nullable_to_non_nullable
as double,sell: null == sell ? _self.sell : sell // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}



/// @nodoc


class _ForexHistoryPoint implements ForexHistoryPoint {
  const _ForexHistoryPoint({required this.date, required this.buy, required this.sell});
  

@override final  DateTime date;
@override final  double buy;
@override final  double sell;

/// Create a copy of ForexHistoryPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForexHistoryPointCopyWith<_ForexHistoryPoint> get copyWith => __$ForexHistoryPointCopyWithImpl<_ForexHistoryPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForexHistoryPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.buy, buy) || other.buy == buy)&&(identical(other.sell, sell) || other.sell == sell));
}


@override
int get hashCode => Object.hash(runtimeType,date,buy,sell);

@override
String toString() {
  return 'ForexHistoryPoint(date: $date, buy: $buy, sell: $sell)';
}


}

/// @nodoc
abstract mixin class _$ForexHistoryPointCopyWith<$Res> implements $ForexHistoryPointCopyWith<$Res> {
  factory _$ForexHistoryPointCopyWith(_ForexHistoryPoint value, $Res Function(_ForexHistoryPoint) _then) = __$ForexHistoryPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double buy, double sell
});




}
/// @nodoc
class __$ForexHistoryPointCopyWithImpl<$Res>
    implements _$ForexHistoryPointCopyWith<$Res> {
  __$ForexHistoryPointCopyWithImpl(this._self, this._then);

  final _ForexHistoryPoint _self;
  final $Res Function(_ForexHistoryPoint) _then;

/// Create a copy of ForexHistoryPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? buy = null,Object? sell = null,}) {
  return _then(_ForexHistoryPoint(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,buy: null == buy ? _self.buy : buy // ignore: cast_nullable_to_non_nullable
as double,sell: null == sell ? _self.sell : sell // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
