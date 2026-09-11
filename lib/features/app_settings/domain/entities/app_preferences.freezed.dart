// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppPreferences {

 Region get region; AppLanguage get language; ThemeMode get themeMode; bool get silentMode; bool get onboardingCompleted;
/// Create a copy of AppPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppPreferencesCopyWith<AppPreferences> get copyWith => _$AppPreferencesCopyWithImpl<AppPreferences>(this as AppPreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppPreferences&&(identical(other.region, region) || other.region == region)&&(identical(other.language, language) || other.language == language)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.silentMode, silentMode) || other.silentMode == silentMode)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,region,language,themeMode,silentMode,onboardingCompleted);

@override
String toString() {
  return 'AppPreferences(region: $region, language: $language, themeMode: $themeMode, silentMode: $silentMode, onboardingCompleted: $onboardingCompleted)';
}


}

/// @nodoc
abstract mixin class $AppPreferencesCopyWith<$Res>  {
  factory $AppPreferencesCopyWith(AppPreferences value, $Res Function(AppPreferences) _then) = _$AppPreferencesCopyWithImpl;
@useResult
$Res call({
 Region region, AppLanguage language, ThemeMode themeMode, bool silentMode, bool onboardingCompleted
});




}
/// @nodoc
class _$AppPreferencesCopyWithImpl<$Res>
    implements $AppPreferencesCopyWith<$Res> {
  _$AppPreferencesCopyWithImpl(this._self, this._then);

  final AppPreferences _self;
  final $Res Function(AppPreferences) _then;

/// Create a copy of AppPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? region = null,Object? language = null,Object? themeMode = null,Object? silentMode = null,Object? onboardingCompleted = null,}) {
  return _then(_self.copyWith(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,silentMode: null == silentMode ? _self.silentMode : silentMode // ignore: cast_nullable_to_non_nullable
as bool,onboardingCompleted: null == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _AppPreferences implements AppPreferences {
  const _AppPreferences({this.region = Region.nepal, this.language = AppLanguage.nepali, this.themeMode = ThemeMode.light, this.silentMode = false, this.onboardingCompleted = false});
  

@override@JsonKey() final  Region region;
@override@JsonKey() final  AppLanguage language;
@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  bool silentMode;
@override@JsonKey() final  bool onboardingCompleted;

/// Create a copy of AppPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppPreferencesCopyWith<_AppPreferences> get copyWith => __$AppPreferencesCopyWithImpl<_AppPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppPreferences&&(identical(other.region, region) || other.region == region)&&(identical(other.language, language) || other.language == language)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.silentMode, silentMode) || other.silentMode == silentMode)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,region,language,themeMode,silentMode,onboardingCompleted);

@override
String toString() {
  return 'AppPreferences(region: $region, language: $language, themeMode: $themeMode, silentMode: $silentMode, onboardingCompleted: $onboardingCompleted)';
}


}

/// @nodoc
abstract mixin class _$AppPreferencesCopyWith<$Res> implements $AppPreferencesCopyWith<$Res> {
  factory _$AppPreferencesCopyWith(_AppPreferences value, $Res Function(_AppPreferences) _then) = __$AppPreferencesCopyWithImpl;
@override @useResult
$Res call({
 Region region, AppLanguage language, ThemeMode themeMode, bool silentMode, bool onboardingCompleted
});




}
/// @nodoc
class __$AppPreferencesCopyWithImpl<$Res>
    implements _$AppPreferencesCopyWith<$Res> {
  __$AppPreferencesCopyWithImpl(this._self, this._then);

  final _AppPreferences _self;
  final $Res Function(_AppPreferences) _then;

/// Create a copy of AppPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? region = null,Object? language = null,Object? themeMode = null,Object? silentMode = null,Object? onboardingCompleted = null,}) {
  return _then(_AppPreferences(
region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as Region,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,silentMode: null == silentMode ? _self.silentMode : silentMode // ignore: cast_nullable_to_non_nullable
as bool,onboardingCompleted: null == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
