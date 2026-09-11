// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_rate_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetRateHistoryParams {

 String get iso3; ForexRange get range;
/// Create a copy of GetRateHistoryParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetRateHistoryParamsCopyWith<GetRateHistoryParams> get copyWith => _$GetRateHistoryParamsCopyWithImpl<GetRateHistoryParams>(this as GetRateHistoryParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetRateHistoryParams&&(identical(other.iso3, iso3) || other.iso3 == iso3)&&(identical(other.range, range) || other.range == range));
}


@override
int get hashCode => Object.hash(runtimeType,iso3,range);

@override
String toString() {
  return 'GetRateHistoryParams(iso3: $iso3, range: $range)';
}


}

/// @nodoc
abstract mixin class $GetRateHistoryParamsCopyWith<$Res>  {
  factory $GetRateHistoryParamsCopyWith(GetRateHistoryParams value, $Res Function(GetRateHistoryParams) _then) = _$GetRateHistoryParamsCopyWithImpl;
@useResult
$Res call({
 String iso3, ForexRange range
});




}
/// @nodoc
class _$GetRateHistoryParamsCopyWithImpl<$Res>
    implements $GetRateHistoryParamsCopyWith<$Res> {
  _$GetRateHistoryParamsCopyWithImpl(this._self, this._then);

  final GetRateHistoryParams _self;
  final $Res Function(GetRateHistoryParams) _then;

/// Create a copy of GetRateHistoryParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? iso3 = null,Object? range = null,}) {
  return _then(_self.copyWith(
iso3: null == iso3 ? _self.iso3 : iso3 // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as ForexRange,
  ));
}

}



/// @nodoc


class _GetRateHistoryParams implements GetRateHistoryParams {
  const _GetRateHistoryParams({required this.iso3, required this.range});
  

@override final  String iso3;
@override final  ForexRange range;

/// Create a copy of GetRateHistoryParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetRateHistoryParamsCopyWith<_GetRateHistoryParams> get copyWith => __$GetRateHistoryParamsCopyWithImpl<_GetRateHistoryParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetRateHistoryParams&&(identical(other.iso3, iso3) || other.iso3 == iso3)&&(identical(other.range, range) || other.range == range));
}


@override
int get hashCode => Object.hash(runtimeType,iso3,range);

@override
String toString() {
  return 'GetRateHistoryParams(iso3: $iso3, range: $range)';
}


}

/// @nodoc
abstract mixin class _$GetRateHistoryParamsCopyWith<$Res> implements $GetRateHistoryParamsCopyWith<$Res> {
  factory _$GetRateHistoryParamsCopyWith(_GetRateHistoryParams value, $Res Function(_GetRateHistoryParams) _then) = __$GetRateHistoryParamsCopyWithImpl;
@override @useResult
$Res call({
 String iso3, ForexRange range
});




}
/// @nodoc
class __$GetRateHistoryParamsCopyWithImpl<$Res>
    implements _$GetRateHistoryParamsCopyWith<$Res> {
  __$GetRateHistoryParamsCopyWithImpl(this._self, this._then);

  final _GetRateHistoryParams _self;
  final $Res Function(_GetRateHistoryParams) _then;

/// Create a copy of GetRateHistoryParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? iso3 = null,Object? range = null,}) {
  return _then(_GetRateHistoryParams(
iso3: null == iso3 ? _self.iso3 : iso3 // ignore: cast_nullable_to_non_nullable
as String,range: null == range ? _self.range : range // ignore: cast_nullable_to_non_nullable
as ForexRange,
  ));
}


}

// dart format on
