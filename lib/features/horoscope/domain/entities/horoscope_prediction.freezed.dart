// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'horoscope_prediction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HoroscopePrediction {

 ZodiacSign get sign; HoroscopePeriod get period; String get textNe; String get textEn; LuckyDetails get lucky; HoroscopeMedia get media;/// Hindi text – empty when not provided (falls back to [textEn]).
 String get textHi;/// About-the-sign content of the expanded "More Details" area (null when
/// the backend does not provide it – the UI then hides that block).
 SignProfile? get profile;
/// Create a copy of HoroscopePrediction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HoroscopePredictionCopyWith<HoroscopePrediction> get copyWith => _$HoroscopePredictionCopyWithImpl<HoroscopePrediction>(this as HoroscopePrediction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HoroscopePrediction&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.period, period) || other.period == period)&&(identical(other.textNe, textNe) || other.textNe == textNe)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.lucky, lucky) || other.lucky == lucky)&&(identical(other.media, media) || other.media == media)&&(identical(other.textHi, textHi) || other.textHi == textHi)&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,sign,period,textNe,textEn,lucky,media,textHi,profile);

@override
String toString() {
  return 'HoroscopePrediction(sign: $sign, period: $period, textNe: $textNe, textEn: $textEn, lucky: $lucky, media: $media, textHi: $textHi, profile: $profile)';
}


}

/// @nodoc
abstract mixin class $HoroscopePredictionCopyWith<$Res>  {
  factory $HoroscopePredictionCopyWith(HoroscopePrediction value, $Res Function(HoroscopePrediction) _then) = _$HoroscopePredictionCopyWithImpl;
@useResult
$Res call({
 ZodiacSign sign, HoroscopePeriod period, String textNe, String textEn, LuckyDetails lucky, HoroscopeMedia media, String textHi, SignProfile? profile
});


$LuckyDetailsCopyWith<$Res> get lucky;$HoroscopeMediaCopyWith<$Res> get media;$SignProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class _$HoroscopePredictionCopyWithImpl<$Res>
    implements $HoroscopePredictionCopyWith<$Res> {
  _$HoroscopePredictionCopyWithImpl(this._self, this._then);

  final HoroscopePrediction _self;
  final $Res Function(HoroscopePrediction) _then;

/// Create a copy of HoroscopePrediction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sign = null,Object? period = null,Object? textNe = null,Object? textEn = null,Object? lucky = null,Object? media = null,Object? textHi = null,Object? profile = freezed,}) {
  return _then(_self.copyWith(
sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as ZodiacSign,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as HoroscopePeriod,textNe: null == textNe ? _self.textNe : textNe // ignore: cast_nullable_to_non_nullable
as String,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,lucky: null == lucky ? _self.lucky : lucky // ignore: cast_nullable_to_non_nullable
as LuckyDetails,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as HoroscopeMedia,textHi: null == textHi ? _self.textHi : textHi // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as SignProfile?,
  ));
}
/// Create a copy of HoroscopePrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LuckyDetailsCopyWith<$Res> get lucky {
  
  return $LuckyDetailsCopyWith<$Res>(_self.lucky, (value) {
    return _then(_self.copyWith(lucky: value));
  });
}/// Create a copy of HoroscopePrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HoroscopeMediaCopyWith<$Res> get media {
  
  return $HoroscopeMediaCopyWith<$Res>(_self.media, (value) {
    return _then(_self.copyWith(media: value));
  });
}/// Create a copy of HoroscopePrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $SignProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}



/// @nodoc


class _HoroscopePrediction extends HoroscopePrediction {
  const _HoroscopePrediction({required this.sign, required this.period, required this.textNe, required this.textEn, required this.lucky, required this.media, this.textHi = '', this.profile}): super._();
  

@override final  ZodiacSign sign;
@override final  HoroscopePeriod period;
@override final  String textNe;
@override final  String textEn;
@override final  LuckyDetails lucky;
@override final  HoroscopeMedia media;
/// Hindi text – empty when not provided (falls back to [textEn]).
@override@JsonKey() final  String textHi;
/// About-the-sign content of the expanded "More Details" area (null when
/// the backend does not provide it – the UI then hides that block).
@override final  SignProfile? profile;

/// Create a copy of HoroscopePrediction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HoroscopePredictionCopyWith<_HoroscopePrediction> get copyWith => __$HoroscopePredictionCopyWithImpl<_HoroscopePrediction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HoroscopePrediction&&(identical(other.sign, sign) || other.sign == sign)&&(identical(other.period, period) || other.period == period)&&(identical(other.textNe, textNe) || other.textNe == textNe)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.lucky, lucky) || other.lucky == lucky)&&(identical(other.media, media) || other.media == media)&&(identical(other.textHi, textHi) || other.textHi == textHi)&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,sign,period,textNe,textEn,lucky,media,textHi,profile);

@override
String toString() {
  return 'HoroscopePrediction(sign: $sign, period: $period, textNe: $textNe, textEn: $textEn, lucky: $lucky, media: $media, textHi: $textHi, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$HoroscopePredictionCopyWith<$Res> implements $HoroscopePredictionCopyWith<$Res> {
  factory _$HoroscopePredictionCopyWith(_HoroscopePrediction value, $Res Function(_HoroscopePrediction) _then) = __$HoroscopePredictionCopyWithImpl;
@override @useResult
$Res call({
 ZodiacSign sign, HoroscopePeriod period, String textNe, String textEn, LuckyDetails lucky, HoroscopeMedia media, String textHi, SignProfile? profile
});


@override $LuckyDetailsCopyWith<$Res> get lucky;@override $HoroscopeMediaCopyWith<$Res> get media;@override $SignProfileCopyWith<$Res>? get profile;

}
/// @nodoc
class __$HoroscopePredictionCopyWithImpl<$Res>
    implements _$HoroscopePredictionCopyWith<$Res> {
  __$HoroscopePredictionCopyWithImpl(this._self, this._then);

  final _HoroscopePrediction _self;
  final $Res Function(_HoroscopePrediction) _then;

/// Create a copy of HoroscopePrediction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sign = null,Object? period = null,Object? textNe = null,Object? textEn = null,Object? lucky = null,Object? media = null,Object? textHi = null,Object? profile = freezed,}) {
  return _then(_HoroscopePrediction(
sign: null == sign ? _self.sign : sign // ignore: cast_nullable_to_non_nullable
as ZodiacSign,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as HoroscopePeriod,textNe: null == textNe ? _self.textNe : textNe // ignore: cast_nullable_to_non_nullable
as String,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,lucky: null == lucky ? _self.lucky : lucky // ignore: cast_nullable_to_non_nullable
as LuckyDetails,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as HoroscopeMedia,textHi: null == textHi ? _self.textHi : textHi // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as SignProfile?,
  ));
}

/// Create a copy of HoroscopePrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LuckyDetailsCopyWith<$Res> get lucky {
  
  return $LuckyDetailsCopyWith<$Res>(_self.lucky, (value) {
    return _then(_self.copyWith(lucky: value));
  });
}/// Create a copy of HoroscopePrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HoroscopeMediaCopyWith<$Res> get media {
  
  return $HoroscopeMediaCopyWith<$Res>(_self.media, (value) {
    return _then(_self.copyWith(media: value));
  });
}/// Create a copy of HoroscopePrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $SignProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
