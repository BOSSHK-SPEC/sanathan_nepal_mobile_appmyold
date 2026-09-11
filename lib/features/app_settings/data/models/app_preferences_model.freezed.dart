// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_preferences_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppPreferencesModel {

 String? get region; String? get language; String? get theme; bool? get silent; bool? get onboarded;
/// Create a copy of AppPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppPreferencesModelCopyWith<AppPreferencesModel> get copyWith => _$AppPreferencesModelCopyWithImpl<AppPreferencesModel>(this as AppPreferencesModel, _$identity);

  /// Serializes this AppPreferencesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppPreferencesModel&&(identical(other.region, region) || other.region == region)&&(identical(other.language, language) || other.language == language)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.silent, silent) || other.silent == silent)&&(identical(other.onboarded, onboarded) || other.onboarded == onboarded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,language,theme,silent,onboarded);

@override
String toString() {
  return 'AppPreferencesModel(region: $region, language: $language, theme: $theme, silent: $silent, onboarded: $onboarded)';
}


}

/// @nodoc
abstract mixin class $AppPreferencesModelCopyWith<$Res>  {
  factory $AppPreferencesModelCopyWith(AppPreferencesModel value, $Res Function(AppPreferencesModel) _then) = _$AppPreferencesModelCopyWithImpl;
@useResult
$Res call({
 String? region, String? language, String? theme, bool? silent, bool? onboarded
});




}
/// @nodoc
class _$AppPreferencesModelCopyWithImpl<$Res>
    implements $AppPreferencesModelCopyWith<$Res> {
  _$AppPreferencesModelCopyWithImpl(this._self, this._then);

  final AppPreferencesModel _self;
  final $Res Function(AppPreferencesModel) _then;

/// Create a copy of AppPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? region = freezed,Object? language = freezed,Object? theme = freezed,Object? silent = freezed,Object? onboarded = freezed,}) {
  return _then(_self.copyWith(
region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String?,silent: freezed == silent ? _self.silent : silent // ignore: cast_nullable_to_non_nullable
as bool?,onboarded: freezed == onboarded ? _self.onboarded : onboarded // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _AppPreferencesModel extends AppPreferencesModel {
  const _AppPreferencesModel({this.region, this.language, this.theme, this.silent, this.onboarded}): super._();
  factory _AppPreferencesModel.fromJson(Map<String, dynamic> json) => _$AppPreferencesModelFromJson(json);

@override final  String? region;
@override final  String? language;
@override final  String? theme;
@override final  bool? silent;
@override final  bool? onboarded;

/// Create a copy of AppPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppPreferencesModelCopyWith<_AppPreferencesModel> get copyWith => __$AppPreferencesModelCopyWithImpl<_AppPreferencesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppPreferencesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppPreferencesModel&&(identical(other.region, region) || other.region == region)&&(identical(other.language, language) || other.language == language)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.silent, silent) || other.silent == silent)&&(identical(other.onboarded, onboarded) || other.onboarded == onboarded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,region,language,theme,silent,onboarded);

@override
String toString() {
  return 'AppPreferencesModel(region: $region, language: $language, theme: $theme, silent: $silent, onboarded: $onboarded)';
}


}

/// @nodoc
abstract mixin class _$AppPreferencesModelCopyWith<$Res> implements $AppPreferencesModelCopyWith<$Res> {
  factory _$AppPreferencesModelCopyWith(_AppPreferencesModel value, $Res Function(_AppPreferencesModel) _then) = __$AppPreferencesModelCopyWithImpl;
@override @useResult
$Res call({
 String? region, String? language, String? theme, bool? silent, bool? onboarded
});




}
/// @nodoc
class __$AppPreferencesModelCopyWithImpl<$Res>
    implements _$AppPreferencesModelCopyWith<$Res> {
  __$AppPreferencesModelCopyWithImpl(this._self, this._then);

  final _AppPreferencesModel _self;
  final $Res Function(_AppPreferencesModel) _then;

/// Create a copy of AppPreferencesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? region = freezed,Object? language = freezed,Object? theme = freezed,Object? silent = freezed,Object? onboarded = freezed,}) {
  return _then(_AppPreferencesModel(
region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String?,silent: freezed == silent ? _self.silent : silent // ignore: cast_nullable_to_non_nullable
as bool?,onboarded: freezed == onboarded ? _self.onboarded : onboarded // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
