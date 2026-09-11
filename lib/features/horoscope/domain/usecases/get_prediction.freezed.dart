// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_prediction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetPredictionParams {

 ZodiacSign get sign; HoroscopePeriod get period;
/// Create a copy of GetPredictionParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetPredictionParamsCopyWith<GetPredictionParams> get copyWith => _$GetPredictionParamsCopyWithImpl<GetPredictionParams>(this as GetPredictionParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetPredictionParams&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode => Object.hash(runtimeType,sign,period);

@override
String toString() {
  return 'GetPredictionParams(sign: $sign, period: $period)';
}


}

/// @nodoc
abstract mixin class $GetPredictionParamsCopyWith<$Res>  {
  factory $GetPredictionParamsCopyWith(GetPredictionParams value, $Res Function(GetPredictionParams) _then) = _$GetPredictionParamsCopyWithImpl;
@useResult
$Res call({
 ZodiacSign sign, HoroscopePeriod period
});




}
/// @nodoc
class _$GetPredictionParamsCopyWithImpl<$Res>
    implements $GetPredictionParamsCopyWith<$Res> {
  _$GetPredictionParamsCopyWithImpl(this._self, this._then);

  final GetPredictionParams _self;
  final $Res Function(GetPredictionParams) _then;

/// Create a copy of GetPredictionParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sign = null,Object? period = null,}) {
  return _then(_self.copyWith(
sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as ZodiacSign,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as HoroscopePeriod,
  ));
}

}



/// @nodoc


class _GetPredictionParams implements GetPredictionParams {
  const _GetPredictionParams({required this.sign, required this.period});
  

@override final  ZodiacSign sign;
@override final  HoroscopePeriod period;

/// Create a copy of GetPredictionParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetPredictionParamsCopyWith<_GetPredictionParams> get copyWith => __$GetPredictionParamsCopyWithImpl<_GetPredictionParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetPredictionParams&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode => Object.hash(runtimeType,sign,period);

@override
String toString() {
  return 'GetPredictionParams(sign: $sign, period: $period)';
}


}

/// @nodoc
abstract mixin class _$GetPredictionParamsCopyWith<$Res> implements $GetPredictionParamsCopyWith<$Res> {
  factory _$GetPredictionParamsCopyWith(_GetPredictionParams value, $Res Function(_GetPredictionParams) _then) = __$GetPredictionParamsCopyWithImpl;
@override @useResult
$Res call({
 ZodiacSign sign, HoroscopePeriod period
});




}
/// @nodoc
class __$GetPredictionParamsCopyWithImpl<$Res>
    implements _$GetPredictionParamsCopyWith<$Res> {
  __$GetPredictionParamsCopyWithImpl(this._self, this._then);

  final _GetPredictionParams _self;
  final $Res Function(_GetPredictionParams) _then;

/// Create a copy of GetPredictionParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sign = null,Object? period = null,}) {
  return _then(_GetPredictionParams(
sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as ZodiacSign,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as HoroscopePeriod,
  ));
}


}

// dart format on
