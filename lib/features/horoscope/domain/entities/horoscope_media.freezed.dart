// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'horoscope_media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HoroscopeMedia {

 String get titleNe; String get titleEn; Duration get duration;/// Hindi title – empty when not provided (falls back to [titleEn]).
 String get titleHi;/// Remote media URL – null while the backend is mocked.
 String? get url;
/// Create a copy of HoroscopeMedia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HoroscopeMediaCopyWith<HoroscopeMedia> get copyWith => _$HoroscopeMediaCopyWithImpl<HoroscopeMedia>(this as HoroscopeMedia, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HoroscopeMedia&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,titleNe,titleEn,duration,titleHi,url);

@override
String toString() {
  return 'HoroscopeMedia(titleNe: $titleNe, titleEn: $titleEn, duration: $duration, titleHi: $titleHi, url: $url)';
}


}

/// @nodoc
abstract mixin class $HoroscopeMediaCopyWith<$Res>  {
  factory $HoroscopeMediaCopyWith(HoroscopeMedia value, $Res Function(HoroscopeMedia) _then) = _$HoroscopeMediaCopyWithImpl;
@useResult
$Res call({
 String titleNe, String titleEn, Duration duration, String titleHi, String? url
});




}
/// @nodoc
class _$HoroscopeMediaCopyWithImpl<$Res>
    implements $HoroscopeMediaCopyWith<$Res> {
  _$HoroscopeMediaCopyWithImpl(this._self, this._then);

  final HoroscopeMedia _self;
  final $Res Function(HoroscopeMedia) _then;

/// Create a copy of HoroscopeMedia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? titleNe = null,Object? titleEn = null,Object? duration = null,Object? titleHi = null,Object? url = freezed,}) {
  return _then(_self.copyWith(
titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _HoroscopeMedia extends HoroscopeMedia {
  const _HoroscopeMedia({required this.titleNe, required this.titleEn, required this.duration, this.titleHi = '', this.url}): super._();
  

@override final  String titleNe;
@override final  String titleEn;
@override final  Duration duration;
/// Hindi title – empty when not provided (falls back to [titleEn]).
@override@JsonKey() final  String titleHi;
/// Remote media URL – null while the backend is mocked.
@override final  String? url;

/// Create a copy of HoroscopeMedia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HoroscopeMediaCopyWith<_HoroscopeMedia> get copyWith => __$HoroscopeMediaCopyWithImpl<_HoroscopeMedia>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HoroscopeMedia&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,titleNe,titleEn,duration,titleHi,url);

@override
String toString() {
  return 'HoroscopeMedia(titleNe: $titleNe, titleEn: $titleEn, duration: $duration, titleHi: $titleHi, url: $url)';
}


}

/// @nodoc
abstract mixin class _$HoroscopeMediaCopyWith<$Res> implements $HoroscopeMediaCopyWith<$Res> {
  factory _$HoroscopeMediaCopyWith(_HoroscopeMedia value, $Res Function(_HoroscopeMedia) _then) = __$HoroscopeMediaCopyWithImpl;
@override @useResult
$Res call({
 String titleNe, String titleEn, Duration duration, String titleHi, String? url
});




}
/// @nodoc
class __$HoroscopeMediaCopyWithImpl<$Res>
    implements _$HoroscopeMediaCopyWith<$Res> {
  __$HoroscopeMediaCopyWithImpl(this._self, this._then);

  final _HoroscopeMedia _self;
  final $Res Function(_HoroscopeMedia) _then;

/// Create a copy of HoroscopeMedia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? titleNe = null,Object? titleEn = null,Object? duration = null,Object? titleHi = null,Object? url = freezed,}) {
  return _then(_HoroscopeMedia(
titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
