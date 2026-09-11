// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'horoscope_media_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HoroscopeMediaModel {

 String get titleNe; String get titleEn; String get titleHi;@JsonKey(name: 'duration') int get durationSeconds; String? get url;
/// Create a copy of HoroscopeMediaModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HoroscopeMediaModelCopyWith<HoroscopeMediaModel> get copyWith => _$HoroscopeMediaModelCopyWithImpl<HoroscopeMediaModel>(this as HoroscopeMediaModel, _$identity);

  /// Serializes this HoroscopeMediaModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HoroscopeMediaModel&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,titleNe,titleEn,titleHi,durationSeconds,url);

@override
String toString() {
  return 'HoroscopeMediaModel(titleNe: $titleNe, titleEn: $titleEn, titleHi: $titleHi, durationSeconds: $durationSeconds, url: $url)';
}


}

/// @nodoc
abstract mixin class $HoroscopeMediaModelCopyWith<$Res>  {
  factory $HoroscopeMediaModelCopyWith(HoroscopeMediaModel value, $Res Function(HoroscopeMediaModel) _then) = _$HoroscopeMediaModelCopyWithImpl;
@useResult
$Res call({
 String titleNe, String titleEn, String titleHi,@JsonKey(name: 'duration') int durationSeconds, String? url
});




}
/// @nodoc
class _$HoroscopeMediaModelCopyWithImpl<$Res>
    implements $HoroscopeMediaModelCopyWith<$Res> {
  _$HoroscopeMediaModelCopyWithImpl(this._self, this._then);

  final HoroscopeMediaModel _self;
  final $Res Function(HoroscopeMediaModel) _then;

/// Create a copy of HoroscopeMediaModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? titleNe = null,Object? titleEn = null,Object? titleHi = null,Object? durationSeconds = null,Object? url = freezed,}) {
  return _then(_self.copyWith(
titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _HoroscopeMediaModel extends HoroscopeMediaModel {
  const _HoroscopeMediaModel({this.titleNe = '', this.titleEn = '', this.titleHi = '', @JsonKey(name: 'duration') this.durationSeconds = 0, this.url}): super._();
  factory _HoroscopeMediaModel.fromJson(Map<String, dynamic> json) => _$HoroscopeMediaModelFromJson(json);

@override@JsonKey() final  String titleNe;
@override@JsonKey() final  String titleEn;
@override@JsonKey() final  String titleHi;
@override@JsonKey(name: 'duration') final  int durationSeconds;
@override final  String? url;

/// Create a copy of HoroscopeMediaModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HoroscopeMediaModelCopyWith<_HoroscopeMediaModel> get copyWith => __$HoroscopeMediaModelCopyWithImpl<_HoroscopeMediaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HoroscopeMediaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HoroscopeMediaModel&&(identical(other.titleNe, titleNe) || other.titleNe == titleNe)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleHi, titleHi) || other.titleHi == titleHi)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,titleNe,titleEn,titleHi,durationSeconds,url);

@override
String toString() {
  return 'HoroscopeMediaModel(titleNe: $titleNe, titleEn: $titleEn, titleHi: $titleHi, durationSeconds: $durationSeconds, url: $url)';
}


}

/// @nodoc
abstract mixin class _$HoroscopeMediaModelCopyWith<$Res> implements $HoroscopeMediaModelCopyWith<$Res> {
  factory _$HoroscopeMediaModelCopyWith(_HoroscopeMediaModel value, $Res Function(_HoroscopeMediaModel) _then) = __$HoroscopeMediaModelCopyWithImpl;
@override @useResult
$Res call({
 String titleNe, String titleEn, String titleHi,@JsonKey(name: 'duration') int durationSeconds, String? url
});




}
/// @nodoc
class __$HoroscopeMediaModelCopyWithImpl<$Res>
    implements _$HoroscopeMediaModelCopyWith<$Res> {
  __$HoroscopeMediaModelCopyWithImpl(this._self, this._then);

  final _HoroscopeMediaModel _self;
  final $Res Function(_HoroscopeMediaModel) _then;

/// Create a copy of HoroscopeMediaModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? titleNe = null,Object? titleEn = null,Object? titleHi = null,Object? durationSeconds = null,Object? url = freezed,}) {
  return _then(_HoroscopeMediaModel(
titleNe: null == titleNe ? _self.titleNe : titleNe // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleHi: null == titleHi ? _self.titleHi : titleHi // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
