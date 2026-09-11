// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtpChallengeModel {

 String get phoneNumber; bool get isRegistered; String? get displayName; int get codeLength;
/// Create a copy of OtpChallengeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpChallengeModelCopyWith<OtpChallengeModel> get copyWith => _$OtpChallengeModelCopyWithImpl<OtpChallengeModel>(this as OtpChallengeModel, _$identity);

  /// Serializes this OtpChallengeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpChallengeModel&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.isRegistered, isRegistered) || other.isRegistered == isRegistered)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.codeLength, codeLength) || other.codeLength == codeLength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,isRegistered,displayName,codeLength);

@override
String toString() {
  return 'OtpChallengeModel(phoneNumber: $phoneNumber, isRegistered: $isRegistered, displayName: $displayName, codeLength: $codeLength)';
}


}

/// @nodoc
abstract mixin class $OtpChallengeModelCopyWith<$Res>  {
  factory $OtpChallengeModelCopyWith(OtpChallengeModel value, $Res Function(OtpChallengeModel) _then) = _$OtpChallengeModelCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, bool isRegistered, String? displayName, int codeLength
});




}
/// @nodoc
class _$OtpChallengeModelCopyWithImpl<$Res>
    implements $OtpChallengeModelCopyWith<$Res> {
  _$OtpChallengeModelCopyWithImpl(this._self, this._then);

  final OtpChallengeModel _self;
  final $Res Function(OtpChallengeModel) _then;

/// Create a copy of OtpChallengeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? isRegistered = null,Object? displayName = freezed,Object? codeLength = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,isRegistered: null == isRegistered ? _self.isRegistered : isRegistered // ignore: cast_nullable_to_non_nullable
as bool,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,codeLength: null == codeLength ? _self.codeLength : codeLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _OtpChallengeModel extends OtpChallengeModel {
  const _OtpChallengeModel({required this.phoneNumber, this.isRegistered = false, this.displayName, this.codeLength = 6}): super._();
  factory _OtpChallengeModel.fromJson(Map<String, dynamic> json) => _$OtpChallengeModelFromJson(json);

@override final  String phoneNumber;
@override@JsonKey() final  bool isRegistered;
@override final  String? displayName;
@override@JsonKey() final  int codeLength;

/// Create a copy of OtpChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpChallengeModelCopyWith<_OtpChallengeModel> get copyWith => __$OtpChallengeModelCopyWithImpl<_OtpChallengeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtpChallengeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpChallengeModel&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.isRegistered, isRegistered) || other.isRegistered == isRegistered)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.codeLength, codeLength) || other.codeLength == codeLength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,isRegistered,displayName,codeLength);

@override
String toString() {
  return 'OtpChallengeModel(phoneNumber: $phoneNumber, isRegistered: $isRegistered, displayName: $displayName, codeLength: $codeLength)';
}


}

/// @nodoc
abstract mixin class _$OtpChallengeModelCopyWith<$Res> implements $OtpChallengeModelCopyWith<$Res> {
  factory _$OtpChallengeModelCopyWith(_OtpChallengeModel value, $Res Function(_OtpChallengeModel) _then) = __$OtpChallengeModelCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, bool isRegistered, String? displayName, int codeLength
});




}
/// @nodoc
class __$OtpChallengeModelCopyWithImpl<$Res>
    implements _$OtpChallengeModelCopyWith<$Res> {
  __$OtpChallengeModelCopyWithImpl(this._self, this._then);

  final _OtpChallengeModel _self;
  final $Res Function(_OtpChallengeModel) _then;

/// Create a copy of OtpChallengeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? isRegistered = null,Object? displayName = freezed,Object? codeLength = null,}) {
  return _then(_OtpChallengeModel(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,isRegistered: null == isRegistered ? _self.isRegistered : isRegistered // ignore: cast_nullable_to_non_nullable
as bool,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,codeLength: null == codeLength ? _self.codeLength : codeLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
