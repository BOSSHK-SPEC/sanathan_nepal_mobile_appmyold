// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_flag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeatureFlag {

 String get key; String get description; bool get enabled;/// Null means the flag applies to every region.
 String? get region; int get rolloutPct;
/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeatureFlagCopyWith<FeatureFlag> get copyWith => _$FeatureFlagCopyWithImpl<FeatureFlag>(this as FeatureFlag, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeatureFlag&&(identical(other.key, key) || other.key == key)&&(identical(other.description, description) || other.description == description)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.region, region) || other.region == region)&&(identical(other.rolloutPct, rolloutPct) || other.rolloutPct == rolloutPct));
}


@override
int get hashCode => Object.hash(runtimeType,key,description,enabled,region,rolloutPct);

@override
String toString() {
  return 'FeatureFlag(key: $key, description: $description, enabled: $enabled, region: $region, rolloutPct: $rolloutPct)';
}


}

/// @nodoc
abstract mixin class $FeatureFlagCopyWith<$Res>  {
  factory $FeatureFlagCopyWith(FeatureFlag value, $Res Function(FeatureFlag) _then) = _$FeatureFlagCopyWithImpl;
@useResult
$Res call({
 String key, String description, bool enabled, String? region, int rolloutPct
});




}
/// @nodoc
class _$FeatureFlagCopyWithImpl<$Res>
    implements $FeatureFlagCopyWith<$Res> {
  _$FeatureFlagCopyWithImpl(this._self, this._then);

  final FeatureFlag _self;
  final $Res Function(FeatureFlag) _then;

/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? description = null,Object? enabled = null,Object? region = freezed,Object? rolloutPct = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,rolloutPct: null == rolloutPct ? _self.rolloutPct : rolloutPct // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _FeatureFlag implements FeatureFlag {
  const _FeatureFlag({required this.key, this.description = '', this.enabled = false, this.region, this.rolloutPct = 0});
  

@override final  String key;
@override@JsonKey() final  String description;
@override@JsonKey() final  bool enabled;
/// Null means the flag applies to every region.
@override final  String? region;
@override@JsonKey() final  int rolloutPct;

/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeatureFlagCopyWith<_FeatureFlag> get copyWith => __$FeatureFlagCopyWithImpl<_FeatureFlag>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeatureFlag&&(identical(other.key, key) || other.key == key)&&(identical(other.description, description) || other.description == description)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.region, region) || other.region == region)&&(identical(other.rolloutPct, rolloutPct) || other.rolloutPct == rolloutPct));
}


@override
int get hashCode => Object.hash(runtimeType,key,description,enabled,region,rolloutPct);

@override
String toString() {
  return 'FeatureFlag(key: $key, description: $description, enabled: $enabled, region: $region, rolloutPct: $rolloutPct)';
}


}

/// @nodoc
abstract mixin class _$FeatureFlagCopyWith<$Res> implements $FeatureFlagCopyWith<$Res> {
  factory _$FeatureFlagCopyWith(_FeatureFlag value, $Res Function(_FeatureFlag) _then) = __$FeatureFlagCopyWithImpl;
@override @useResult
$Res call({
 String key, String description, bool enabled, String? region, int rolloutPct
});




}
/// @nodoc
class __$FeatureFlagCopyWithImpl<$Res>
    implements _$FeatureFlagCopyWith<$Res> {
  __$FeatureFlagCopyWithImpl(this._self, this._then);

  final _FeatureFlag _self;
  final $Res Function(_FeatureFlag) _then;

/// Create a copy of FeatureFlag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? description = null,Object? enabled = null,Object? region = freezed,Object? rolloutPct = null,}) {
  return _then(_FeatureFlag(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,rolloutPct: null == rolloutPct ? _self.rolloutPct : rolloutPct // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
