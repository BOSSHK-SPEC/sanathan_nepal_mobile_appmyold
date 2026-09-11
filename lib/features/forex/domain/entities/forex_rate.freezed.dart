// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forex_rate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForexRate {

 Currency get currency; double get buy; double get sell; DateTime get date;
/// Create a copy of ForexRate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForexRateCopyWith<ForexRate> get copyWith => _$ForexRateCopyWithImpl<ForexRate>(this as ForexRate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForexRate&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.buy, buy) || other.buy == buy)&&(identical(other.sell, sell) || other.sell == sell)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,currency,buy,sell,date);

@override
String toString() {
  return 'ForexRate(currency: $currency, buy: $buy, sell: $sell, date: $date)';
}


}

/// @nodoc
abstract mixin class $ForexRateCopyWith<$Res>  {
  factory $ForexRateCopyWith(ForexRate value, $Res Function(ForexRate) _then) = _$ForexRateCopyWithImpl;
@useResult
$Res call({
 Currency currency, double buy, double sell, DateTime date
});


$CurrencyCopyWith<$Res> get currency;

}
/// @nodoc
class _$ForexRateCopyWithImpl<$Res>
    implements $ForexRateCopyWith<$Res> {
  _$ForexRateCopyWithImpl(this._self, this._then);

  final ForexRate _self;
  final $Res Function(ForexRate) _then;

/// Create a copy of ForexRate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currency = null,Object? buy = null,Object? sell = null,Object? date = null,}) {
  return _then(_self.copyWith(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,buy: null == buy ? _self.buy : buy // ignore: cast_nullable_to_non_nullable
as double,sell: null == sell ? _self.sell : sell // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ForexRate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res> get currency {
  
  return $CurrencyCopyWith<$Res>(_self.currency, (value) {
    return _then(_self.copyWith(currency: value));
  });
}
}



/// @nodoc


class _ForexRate extends ForexRate {
  const _ForexRate({required this.currency, required this.buy, required this.sell, required this.date}): super._();
  

@override final  Currency currency;
@override final  double buy;
@override final  double sell;
@override final  DateTime date;

/// Create a copy of ForexRate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForexRateCopyWith<_ForexRate> get copyWith => __$ForexRateCopyWithImpl<_ForexRate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForexRate&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.buy, buy) || other.buy == buy)&&(identical(other.sell, sell) || other.sell == sell)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,currency,buy,sell,date);

@override
String toString() {
  return 'ForexRate(currency: $currency, buy: $buy, sell: $sell, date: $date)';
}


}

/// @nodoc
abstract mixin class _$ForexRateCopyWith<$Res> implements $ForexRateCopyWith<$Res> {
  factory _$ForexRateCopyWith(_ForexRate value, $Res Function(_ForexRate) _then) = __$ForexRateCopyWithImpl;
@override @useResult
$Res call({
 Currency currency, double buy, double sell, DateTime date
});


@override $CurrencyCopyWith<$Res> get currency;

}
/// @nodoc
class __$ForexRateCopyWithImpl<$Res>
    implements _$ForexRateCopyWith<$Res> {
  __$ForexRateCopyWithImpl(this._self, this._then);

  final _ForexRate _self;
  final $Res Function(_ForexRate) _then;

/// Create a copy of ForexRate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currency = null,Object? buy = null,Object? sell = null,Object? date = null,}) {
  return _then(_ForexRate(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as Currency,buy: null == buy ? _self.buy : buy // ignore: cast_nullable_to_non_nullable
as double,sell: null == sell ? _self.sell : sell // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ForexRate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res> get currency {
  
  return $CurrencyCopyWith<$Res>(_self.currency, (value) {
    return _then(_self.copyWith(currency: value));
  });
}
}

// dart format on
