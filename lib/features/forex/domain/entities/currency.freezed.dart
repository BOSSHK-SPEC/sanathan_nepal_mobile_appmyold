// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Currency {

/// ISO 4217 code, e.g. `USD`.
 String get iso3; String get nameEn; String get nameNe;/// ISO 3166-1 alpha-2 country code (or `EU`) for the flag.
 String get countryCode;/// Hindi name; falls back to [nameNe] (both Devanagari) when null.
 String? get nameHi;/// Some sources quote a currency per 10 / 100 units.
 int get unit;
/// Create a copy of Currency
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyCopyWith<Currency> get copyWith => _$CurrencyCopyWithImpl<Currency>(this as Currency, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Currency&&(identical(other.iso3, iso3) || other.iso3 == iso3)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.nameHi, nameHi) || other.nameHi == nameHi)&&(identical(other.unit, unit) || other.unit == unit));
}


@override
int get hashCode => Object.hash(runtimeType,iso3,nameEn,nameNe,countryCode,nameHi,unit);

@override
String toString() {
  return 'Currency(iso3: $iso3, nameEn: $nameEn, nameNe: $nameNe, countryCode: $countryCode, nameHi: $nameHi, unit: $unit)';
}


}

/// @nodoc
abstract mixin class $CurrencyCopyWith<$Res>  {
  factory $CurrencyCopyWith(Currency value, $Res Function(Currency) _then) = _$CurrencyCopyWithImpl;
@useResult
$Res call({
 String iso3, String nameEn, String nameNe, String countryCode, String? nameHi, int unit
});




}
/// @nodoc
class _$CurrencyCopyWithImpl<$Res>
    implements $CurrencyCopyWith<$Res> {
  _$CurrencyCopyWithImpl(this._self, this._then);

  final Currency _self;
  final $Res Function(Currency) _then;

/// Create a copy of Currency
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? iso3 = null,Object? nameEn = null,Object? nameNe = null,Object? countryCode = null,Object? nameHi = freezed,Object? unit = null,}) {
  return _then(_self.copyWith(
iso3: null == iso3 ? _self.iso3 : iso3 // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,nameHi: freezed == nameHi ? _self.nameHi : nameHi // ignore: cast_nullable_to_non_nullable
as String?,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _Currency extends Currency {
  const _Currency({required this.iso3, required this.nameEn, required this.nameNe, required this.countryCode, this.nameHi, this.unit = 1}): super._();
  

/// ISO 4217 code, e.g. `USD`.
@override final  String iso3;
@override final  String nameEn;
@override final  String nameNe;
/// ISO 3166-1 alpha-2 country code (or `EU`) for the flag.
@override final  String countryCode;
/// Hindi name; falls back to [nameNe] (both Devanagari) when null.
@override final  String? nameHi;
/// Some sources quote a currency per 10 / 100 units.
@override@JsonKey() final  int unit;

/// Create a copy of Currency
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrencyCopyWith<_Currency> get copyWith => __$CurrencyCopyWithImpl<_Currency>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Currency&&(identical(other.iso3, iso3) || other.iso3 == iso3)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameNe, nameNe) || other.nameNe == nameNe)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.nameHi, nameHi) || other.nameHi == nameHi)&&(identical(other.unit, unit) || other.unit == unit));
}


@override
int get hashCode => Object.hash(runtimeType,iso3,nameEn,nameNe,countryCode,nameHi,unit);

@override
String toString() {
  return 'Currency(iso3: $iso3, nameEn: $nameEn, nameNe: $nameNe, countryCode: $countryCode, nameHi: $nameHi, unit: $unit)';
}


}

/// @nodoc
abstract mixin class _$CurrencyCopyWith<$Res> implements $CurrencyCopyWith<$Res> {
  factory _$CurrencyCopyWith(_Currency value, $Res Function(_Currency) _then) = __$CurrencyCopyWithImpl;
@override @useResult
$Res call({
 String iso3, String nameEn, String nameNe, String countryCode, String? nameHi, int unit
});




}
/// @nodoc
class __$CurrencyCopyWithImpl<$Res>
    implements _$CurrencyCopyWith<$Res> {
  __$CurrencyCopyWithImpl(this._self, this._then);

  final _Currency _self;
  final $Res Function(_Currency) _then;

/// Create a copy of Currency
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? iso3 = null,Object? nameEn = null,Object? nameNe = null,Object? countryCode = null,Object? nameHi = freezed,Object? unit = null,}) {
  return _then(_Currency(
iso3: null == iso3 ? _self.iso3 : iso3 // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameNe: null == nameNe ? _self.nameNe : nameNe // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,nameHi: freezed == nameHi ? _self.nameHi : nameHi // ignore: cast_nullable_to_non_nullable
as String?,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
