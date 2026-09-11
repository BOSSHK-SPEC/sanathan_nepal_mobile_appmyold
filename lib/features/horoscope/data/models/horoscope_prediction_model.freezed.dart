// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'horoscope_prediction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HoroscopePredictionModel {

@JsonKey(unknownEnumValue: ZodiacSign.aries) ZodiacSign get sign;@JsonKey(unknownEnumValue: HoroscopePeriod.daily) HoroscopePeriod get period; String get textNe; String get textEn; String get textHi; LuckyDetailsModel get lucky; HoroscopeMediaModel get media; SignProfileModel? get profile;
/// Create a copy of HoroscopePredictionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HoroscopePredictionModelCopyWith<HoroscopePredictionModel> get copyWith => _$HoroscopePredictionModelCopyWithImpl<HoroscopePredictionModel>(this as HoroscopePredictionModel, _$identity);

  /// Serializes this HoroscopePredictionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HoroscopePredictionModel&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.period, period) || other.period == period)&&(identical(other.textNe, textNe) || other.textNe == textNe)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.textHi, textHi) || other.textHi == textHi)&&(identical(other.lucky, lucky) || other.lucky == lucky)&&(identical(other.media, media) || other.media == media)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sign,period,textNe,textEn,textHi,lucky,media,profile);

@override
String toString() {
  return 'HoroscopePredictionModel(sign: $sign, period: $period, textNe: $textNe, textEn: $textEn, textHi: $textHi, lucky: $lucky, media: $media, profile: $profile)';
}


}

/// @nodoc
abstract mixin class $HoroscopePredictionModelCopyWith<$Res>  {
  factory $HoroscopePredictionModelCopyWith(HoroscopePredictionModel value, $Res Function(HoroscopePredictionModel) _then) = _$HoroscopePredictionModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: ZodiacSign.aries) ZodiacSign sign,@JsonKey(unknownEnumValue: HoroscopePeriod.daily) HoroscopePeriod period, String textNe, String textEn, String textHi, LuckyDetailsModel lucky, HoroscopeMediaModel media, SignProfileModel? profile
});


$LuckyDetailsModelCopyWith<$Res> get lucky;$HoroscopeMediaModelCopyWith<$Res> get media;$SignProfileModelCopyWith<$Res>? get profile;

}
/// @nodoc
class _$HoroscopePredictionModelCopyWithImpl<$Res>
    implements $HoroscopePredictionModelCopyWith<$Res> {
  _$HoroscopePredictionModelCopyWithImpl(this._self, this._then);

  final HoroscopePredictionModel _self;
  final $Res Function(HoroscopePredictionModel) _then;

/// Create a copy of HoroscopePredictionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sign = null,Object? period = null,Object? textNe = null,Object? textEn = null,Object? textHi = null,Object? lucky = null,Object? media = null,Object? profile = freezed,}) {
  return _then(_self.copyWith(
sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as ZodiacSign,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as HoroscopePeriod,textNe: null == textNe ? _self.textNe : textNe // ignore: cast_nullable_to_non_nullable
as String,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,textHi: null == textHi ? _self.textHi : textHi // ignore: cast_nullable_to_non_nullable
as String,lucky: null == lucky ? _self.lucky : lucky // ignore: cast_nullable_to_non_nullable
as LuckyDetailsModel,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as HoroscopeMediaModel,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as SignProfileModel?,
  ));
}
/// Create a copy of HoroscopePredictionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LuckyDetailsModelCopyWith<$Res> get lucky {
  
  return $LuckyDetailsModelCopyWith<$Res>(_self.lucky, (value) {
    return _then(_self.copyWith(lucky: value));
  });
}/// Create a copy of HoroscopePredictionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HoroscopeMediaModelCopyWith<$Res> get media {
  
  return $HoroscopeMediaModelCopyWith<$Res>(_self.media, (value) {
    return _then(_self.copyWith(media: value));
  });
}/// Create a copy of HoroscopePredictionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignProfileModelCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $SignProfileModelCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _HoroscopePredictionModel extends HoroscopePredictionModel {
  const _HoroscopePredictionModel({@JsonKey(unknownEnumValue: ZodiacSign.aries) this.sign = ZodiacSign.aries, @JsonKey(unknownEnumValue: HoroscopePeriod.daily) this.period = HoroscopePeriod.daily, this.textNe = '', this.textEn = '', this.textHi = '', this.lucky = const LuckyDetailsModel(), this.media = const HoroscopeMediaModel(), this.profile}): super._();
  factory _HoroscopePredictionModel.fromJson(Map<String, dynamic> json) => _$HoroscopePredictionModelFromJson(json);

@override@JsonKey(unknownEnumValue: ZodiacSign.aries) final  ZodiacSign sign;
@override@JsonKey(unknownEnumValue: HoroscopePeriod.daily) final  HoroscopePeriod period;
@override@JsonKey() final  String textNe;
@override@JsonKey() final  String textEn;
@override@JsonKey() final  String textHi;
@override@JsonKey() final  LuckyDetailsModel lucky;
@override@JsonKey() final  HoroscopeMediaModel media;
@override final  SignProfileModel? profile;

/// Create a copy of HoroscopePredictionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HoroscopePredictionModelCopyWith<_HoroscopePredictionModel> get copyWith => __$HoroscopePredictionModelCopyWithImpl<_HoroscopePredictionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HoroscopePredictionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HoroscopePredictionModel&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.period, period) || other.period == period)&&(identical(other.textNe, textNe) || other.textNe == textNe)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.textHi, textHi) || other.textHi == textHi)&&(identical(other.lucky, lucky) || other.lucky == lucky)&&(identical(other.media, media) || other.media == media)&&(identical(other.profile, profile) || other.profile == profile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sign,period,textNe,textEn,textHi,lucky,media,profile);

@override
String toString() {
  return 'HoroscopePredictionModel(sign: $sign, period: $period, textNe: $textNe, textEn: $textEn, textHi: $textHi, lucky: $lucky, media: $media, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$HoroscopePredictionModelCopyWith<$Res> implements $HoroscopePredictionModelCopyWith<$Res> {
  factory _$HoroscopePredictionModelCopyWith(_HoroscopePredictionModel value, $Res Function(_HoroscopePredictionModel) _then) = __$HoroscopePredictionModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: ZodiacSign.aries) ZodiacSign sign,@JsonKey(unknownEnumValue: HoroscopePeriod.daily) HoroscopePeriod period, String textNe, String textEn, String textHi, LuckyDetailsModel lucky, HoroscopeMediaModel media, SignProfileModel? profile
});


@override $LuckyDetailsModelCopyWith<$Res> get lucky;@override $HoroscopeMediaModelCopyWith<$Res> get media;@override $SignProfileModelCopyWith<$Res>? get profile;

}
/// @nodoc
class __$HoroscopePredictionModelCopyWithImpl<$Res>
    implements _$HoroscopePredictionModelCopyWith<$Res> {
  __$HoroscopePredictionModelCopyWithImpl(this._self, this._then);

  final _HoroscopePredictionModel _self;
  final $Res Function(_HoroscopePredictionModel) _then;

/// Create a copy of HoroscopePredictionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sign = null,Object? period = null,Object? textNe = null,Object? textEn = null,Object? textHi = null,Object? lucky = null,Object? media = null,Object? profile = freezed,}) {
  return _then(_HoroscopePredictionModel(
sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as ZodiacSign,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as HoroscopePeriod,textNe: null == textNe ? _self.textNe : textNe // ignore: cast_nullable_to_non_nullable
as String,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,textHi: null == textHi ? _self.textHi : textHi // ignore: cast_nullable_to_non_nullable
as String,lucky: null == lucky ? _self.lucky : lucky // ignore: cast_nullable_to_non_nullable
as LuckyDetailsModel,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as HoroscopeMediaModel,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as SignProfileModel?,
  ));
}

/// Create a copy of HoroscopePredictionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LuckyDetailsModelCopyWith<$Res> get lucky {
  
  return $LuckyDetailsModelCopyWith<$Res>(_self.lucky, (value) {
    return _then(_self.copyWith(lucky: value));
  });
}/// Create a copy of HoroscopePredictionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HoroscopeMediaModelCopyWith<$Res> get media {
  
  return $HoroscopeMediaModelCopyWith<$Res>(_self.media, (value) {
    return _then(_self.copyWith(media: value));
  });
}/// Create a copy of HoroscopePredictionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignProfileModelCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $SignProfileModelCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
