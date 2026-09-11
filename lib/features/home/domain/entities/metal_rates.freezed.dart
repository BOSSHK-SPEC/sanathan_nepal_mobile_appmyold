// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metal_rates.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MetalRates {

 double get goldPerUnit; double get silverPerUnit;/// ISO 4217 code (NPR / INR).
 String get currencyCode;/// Bullion unit the prices refer to ("tola" / "10 g").
 String get unit; DateTime get date;
/// Create a copy of MetalRates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MetalRatesCopyWith<MetalRates> get copyWith => _$MetalRatesCopyWithImpl<MetalRates>(this as MetalRates, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MetalRates&&(identical(other.goldPerUnit, goldPerUnit) || other.goldPerUnit == goldPerUnit)&&(identical(other.silverPerUnit, silverPerUnit) || other.silverPerUnit == silverPerUnit)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,goldPerUnit,silverPerUnit,currencyCode,unit,date);

@override
String toString() {
  return 'MetalRates(goldPerUnit: $goldPerUnit, silverPerUnit: $silverPerUnit, currencyCode: $currencyCode, unit: $unit, date: $date)';
}


}

/// @nodoc
abstract mixin class $MetalRatesCopyWith<$Res>  {
  factory $MetalRatesCopyWith(MetalRates value, $Res Function(MetalRates) _then) = _$MetalRatesCopyWithImpl;
@useResult
$Res call({
 double goldPerUnit, double silverPerUnit, String currencyCode, String unit, DateTime date
});




}
/// @nodoc
class _$MetalRatesCopyWithImpl<$Res>
    implements $MetalRatesCopyWith<$Res> {
  _$MetalRatesCopyWithImpl(this._self, this._then);

  final MetalRates _self;
  final $Res Function(MetalRates) _then;

/// Create a copy of MetalRates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? goldPerUnit = null,Object? silverPerUnit = null,Object? currencyCode = null,Object? unit = null,Object? date = null,}) {
  return _then(_self.copyWith(
goldPerUnit: null == goldPerUnit ? _self.goldPerUnit : goldPerUnit // ignore: cast_nullable_to_non_nullable
as double,silverPerUnit: null == silverPerUnit ? _self.silverPerUnit : silverPerUnit // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}



/// @nodoc


class _MetalRates implements MetalRates {
  const _MetalRates({required this.goldPerUnit, required this.silverPerUnit, required this.currencyCode, required this.unit, required this.date});
  

@override final  double goldPerUnit;
@override final  double silverPerUnit;
/// ISO 4217 code (NPR / INR).
@override final  String currencyCode;
/// Bullion unit the prices refer to ("tola" / "10 g").
@override final  String unit;
@override final  DateTime date;

/// Create a copy of MetalRates
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetalRatesCopyWith<_MetalRates> get copyWith => __$MetalRatesCopyWithImpl<_MetalRates>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MetalRates&&(identical(other.goldPerUnit, goldPerUnit) || other.goldPerUnit == goldPerUnit)&&(identical(other.silverPerUnit, silverPerUnit) || other.silverPerUnit == silverPerUnit)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,goldPerUnit,silverPerUnit,currencyCode,unit,date);

@override
String toString() {
  return 'MetalRates(goldPerUnit: $goldPerUnit, silverPerUnit: $silverPerUnit, currencyCode: $currencyCode, unit: $unit, date: $date)';
}


}

/// @nodoc
abstract mixin class _$MetalRatesCopyWith<$Res> implements $MetalRatesCopyWith<$Res> {
  factory _$MetalRatesCopyWith(_MetalRates value, $Res Function(_MetalRates) _then) = __$MetalRatesCopyWithImpl;
@override @useResult
$Res call({
 double goldPerUnit, double silverPerUnit, String currencyCode, String unit, DateTime date
});




}
/// @nodoc
class __$MetalRatesCopyWithImpl<$Res>
    implements _$MetalRatesCopyWith<$Res> {
  __$MetalRatesCopyWithImpl(this._self, this._then);

  final _MetalRates _self;
  final $Res Function(_MetalRates) _then;

/// Create a copy of MetalRates
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? goldPerUnit = null,Object? silverPerUnit = null,Object? currencyCode = null,Object? unit = null,Object? date = null,}) {
  return _then(_MetalRates(
goldPerUnit: null == goldPerUnit ? _self.goldPerUnit : goldPerUnit // ignore: cast_nullable_to_non_nullable
as double,silverPerUnit: null == silverPerUnit ? _self.silverPerUnit : silverPerUnit // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
