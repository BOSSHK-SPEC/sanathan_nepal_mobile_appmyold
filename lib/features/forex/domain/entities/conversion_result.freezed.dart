// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversion_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConversionResult {

 double get amount; Currency get from; Currency get to;/// Amount of [to] using buying rates.
 double get buyResult;/// Amount of [to] using selling rates.
 double get sellResult;
/// Create a copy of ConversionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversionResultCopyWith<ConversionResult> get copyWith => _$ConversionResultCopyWithImpl<ConversionResult>(this as ConversionResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversionResult&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.buyResult, buyResult) || other.buyResult == buyResult)&&(identical(other.sellResult, sellResult) || other.sellResult == sellResult));
}


@override
int get hashCode => Object.hash(runtimeType,amount,from,to,buyResult,sellResult);

@override
String toString() {
  return 'ConversionResult(amount: $amount, from: $from, to: $to, buyResult: $buyResult, sellResult: $sellResult)';
}


}

/// @nodoc
abstract mixin class $ConversionResultCopyWith<$Res>  {
  factory $ConversionResultCopyWith(ConversionResult value, $Res Function(ConversionResult) _then) = _$ConversionResultCopyWithImpl;
@useResult
$Res call({
 double amount, Currency from, Currency to, double buyResult, double sellResult
});


$CurrencyCopyWith<$Res> get from;$CurrencyCopyWith<$Res> get to;

}
/// @nodoc
class _$ConversionResultCopyWithImpl<$Res>
    implements $ConversionResultCopyWith<$Res> {
  _$ConversionResultCopyWithImpl(this._self, this._then);

  final ConversionResult _self;
  final $Res Function(ConversionResult) _then;

/// Create a copy of ConversionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? from = null,Object? to = null,Object? buyResult = null,Object? sellResult = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Currency,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Currency,buyResult: null == buyResult ? _self.buyResult : buyResult // ignore: cast_nullable_to_non_nullable
as double,sellResult: null == sellResult ? _self.sellResult : sellResult // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of ConversionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res> get from {
  
  return $CurrencyCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of ConversionResult
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


class _ConversionResult implements ConversionResult {
  const _ConversionResult({required this.amount, required this.from, required this.to, required this.buyResult, required this.sellResult});
  

@override final  double amount;
@override final  Currency from;
@override final  Currency to;
/// Amount of [to] using buying rates.
@override final  double buyResult;
/// Amount of [to] using selling rates.
@override final  double sellResult;

/// Create a copy of ConversionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversionResultCopyWith<_ConversionResult> get copyWith => __$ConversionResultCopyWithImpl<_ConversionResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversionResult&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.buyResult, buyResult) || other.buyResult == buyResult)&&(identical(other.sellResult, sellResult) || other.sellResult == sellResult));
}


@override
int get hashCode => Object.hash(runtimeType,amount,from,to,buyResult,sellResult);

@override
String toString() {
  return 'ConversionResult(amount: $amount, from: $from, to: $to, buyResult: $buyResult, sellResult: $sellResult)';
}


}

/// @nodoc
abstract mixin class _$ConversionResultCopyWith<$Res> implements $ConversionResultCopyWith<$Res> {
  factory _$ConversionResultCopyWith(_ConversionResult value, $Res Function(_ConversionResult) _then) = __$ConversionResultCopyWithImpl;
@override @useResult
$Res call({
 double amount, Currency from, Currency to, double buyResult, double sellResult
});


@override $CurrencyCopyWith<$Res> get from;@override $CurrencyCopyWith<$Res> get to;

}
/// @nodoc
class __$ConversionResultCopyWithImpl<$Res>
    implements _$ConversionResultCopyWith<$Res> {
  __$ConversionResultCopyWithImpl(this._self, this._then);

  final _ConversionResult _self;
  final $Res Function(_ConversionResult) _then;

/// Create a copy of ConversionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? from = null,Object? to = null,Object? buyResult = null,Object? sellResult = null,}) {
  return _then(_ConversionResult(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as Currency,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as Currency,buyResult: null == buyResult ? _self.buyResult : buyResult // ignore: cast_nullable_to_non_nullable
as double,sellResult: null == sellResult ? _self.sellResult : sellResult // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of ConversionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrencyCopyWith<$Res> get from {
  
  return $CurrencyCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of ConversionResult
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
