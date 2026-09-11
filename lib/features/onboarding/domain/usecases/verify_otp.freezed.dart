// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifyOtpParams {

 String get phoneNumber; String get code;
/// Create a copy of VerifyOtpParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpParamsCopyWith<VerifyOtpParams> get copyWith => _$VerifyOtpParamsCopyWithImpl<VerifyOtpParams>(this as VerifyOtpParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpParams&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,code);

@override
String toString() {
  return 'VerifyOtpParams(phoneNumber: $phoneNumber, code: $code)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpParamsCopyWith<$Res>  {
  factory $VerifyOtpParamsCopyWith(VerifyOtpParams value, $Res Function(VerifyOtpParams) _then) = _$VerifyOtpParamsCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String code
});




}
/// @nodoc
class _$VerifyOtpParamsCopyWithImpl<$Res>
    implements $VerifyOtpParamsCopyWith<$Res> {
  _$VerifyOtpParamsCopyWithImpl(this._self, this._then);

  final VerifyOtpParams _self;
  final $Res Function(VerifyOtpParams) _then;

/// Create a copy of VerifyOtpParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? code = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc


class _VerifyOtpParams implements VerifyOtpParams {
  const _VerifyOtpParams({required this.phoneNumber, required this.code});
  

@override final  String phoneNumber;
@override final  String code;

/// Create a copy of VerifyOtpParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpParamsCopyWith<_VerifyOtpParams> get copyWith => __$VerifyOtpParamsCopyWithImpl<_VerifyOtpParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpParams&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,code);

@override
String toString() {
  return 'VerifyOtpParams(phoneNumber: $phoneNumber, code: $code)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpParamsCopyWith<$Res> implements $VerifyOtpParamsCopyWith<$Res> {
  factory _$VerifyOtpParamsCopyWith(_VerifyOtpParams value, $Res Function(_VerifyOtpParams) _then) = __$VerifyOtpParamsCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String code
});




}
/// @nodoc
class __$VerifyOtpParamsCopyWithImpl<$Res>
    implements _$VerifyOtpParamsCopyWith<$Res> {
  __$VerifyOtpParamsCopyWithImpl(this._self, this._then);

  final _VerifyOtpParams _self;
  final $Res Function(_VerifyOtpParams) _then;

/// Create a copy of VerifyOtpParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? code = null,}) {
  return _then(_VerifyOtpParams(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
