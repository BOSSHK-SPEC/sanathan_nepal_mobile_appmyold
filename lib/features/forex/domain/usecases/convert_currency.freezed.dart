// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'convert_currency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConvertCurrencyParams {

 double get amount; Currency get from; Currency get to;/// Latest rates quoted in the local currency (which itself needs no entry).
 List<ForexRate> get rates;/// ISO code of the quote (local) currency – `NPR` for Nepal, `INR` for
/// India. Comes from `RegionConfig.currencyCode`.
 String get localIso3;
/// Create a copy of ConvertCurrencyParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConvertCurrencyParamsCopyWith<ConvertCurrencyParams> get copyWith => _$ConvertCurrencyParamsCopyWithImpl<ConvertCurrencyParams>(this as ConvertCurrencyParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConvertCurrencyParams&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other.rates, rates)&&(identical(other.localIso3, localIso3) || other.localIso3 == localIso3));
}


@override
int get hashCode => Object.hash(runtimeType,amount,from,to,const DeepCollectionEquality().hash(rates),localIso3);

@override
String toString() {
  return 'ConvertCurrencyParams(amount: $amount, from: $from, to: $to, rates: $rates, localIso3: $localIso3)';
}


}

/// @nodoc
abstract mixin class $ConvertCurrencyParamsCopyWith<$Res>  {
  factory $ConvertCurrencyParamsCopyWith(ConvertCurrencyParams value, $Res Function(ConvertCurrencyParams) _then) = _$ConvertCurrencyParamsCopyWithImpl;
@useResult
$Res call({
 double amount, Currency from, Currency to, List<ForexRate> rates, String localIso3
});


$CurrencyCopyWith<$Res> get from;$CurrencyCopyWith<$Res> get to;

}
/// @nodoc
class _$ConvertCurrencyParamsCopyWithImpl<$Res>
    implements $ConvertCurrencyParamsCopyWith<$Res> {
  _$ConvertCurrencyParamsCopyWithImpl(this._self, this._then);

  final ConvertCurrencyParams _self;
  final $Res Function(ConvertCurrencyParams) _then;

/// Create a copy of ConvertCurrencyParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? from = null,Object? to = null,Object? rates = null,Object? localIso3 = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Currency,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Currency,rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as List<ForexRate>,localIso3: null == localIso3 ? _self.localIso3 : localIso3 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ConvertCurrencyParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res> get from {
  
  return $CurrencyCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of ConvertCurrencyParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res> get to {
  
  return $CurrencyCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}



/// @nodoc


class _ConvertCurrencyParams implements ConvertCurrencyParams {
  const _ConvertCurrencyParams({required this.amount, required this.from, required this.to, required final  List<ForexRate> rates, this.localIso3 = 'NPR'}): _rates = rates;
  

@override final  double amount;
@override final  Currency from;
@override final  Currency to;
/// Latest rates quoted in the local currency (which itself needs no entry).
 final  List<ForexRate> _rates;
/// Latest rates quoted in the local currency (which itself needs no entry).
@override List<ForexRate> get rates {
  if (_rates is EqualUnmodifiableListView) return _rates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rates);
}

/// ISO code of the quote (local) currency – `NPR` for Nepal, `INR` for
/// India. Comes from `RegionConfig.currencyCode`.
@override@JsonKey() final  String localIso3;

/// Create a copy of ConvertCurrencyParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConvertCurrencyParamsCopyWith<_ConvertCurrencyParams> get copyWith => __$ConvertCurrencyParamsCopyWithImpl<_ConvertCurrencyParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConvertCurrencyParams&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other._rates, _rates)&&(identical(other.localIso3, localIso3) || other.localIso3 == localIso3));
}


@override
int get hashCode => Object.hash(runtimeType,amount,from,to,const DeepCollectionEquality().hash(_rates),localIso3);

@override
String toString() {
  return 'ConvertCurrencyParams(amount: $amount, from: $from, to: $to, rates: $rates, localIso3: $localIso3)';
}


}

/// @nodoc
abstract mixin class _$ConvertCurrencyParamsCopyWith<$Res> implements $ConvertCurrencyParamsCopyWith<$Res> {
  factory _$ConvertCurrencyParamsCopyWith(_ConvertCurrencyParams value, $Res Function(_ConvertCurrencyParams) _then) = __$ConvertCurrencyParamsCopyWithImpl;
@override @useResult
$Res call({
 double amount, Currency from, Currency to, List<ForexRate> rates, String localIso3
});


@override $CurrencyCopyWith<$Res> get from;@override $CurrencyCopyWith<$Res> get to;

}
/// @nodoc
class __$ConvertCurrencyParamsCopyWithImpl<$Res>
    implements _$ConvertCurrencyParamsCopyWith<$Res> {
  __$ConvertCurrencyParamsCopyWithImpl(this._self, this._then);

  final _ConvertCurrencyParams _self;
  final $Res Function(_ConvertCurrencyParams) _then;

/// Create a copy of ConvertCurrencyParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? from = null,Object? to = null,Object? rates = null,Object? localIso3 = null,}) {
  return _then(_ConvertCurrencyParams(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Currency,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Currency,rates: null == rates ? _self._rates : rates // ignore: cast_nullable_to_non_nullable
as List<ForexRate>,localIso3: null == localIso3 ? _self.localIso3 : localIso3 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ConvertCurrencyParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res> get from {
  
  return $CurrencyCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of ConvertCurrencyParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res> get to {
  
  return $CurrencyCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}

// dart format on
