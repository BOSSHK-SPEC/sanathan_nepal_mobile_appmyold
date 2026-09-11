// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppStatus {

 AppAvailability get availability;/// Current build, e.g. "1.4.2".
 String get currentVersion; String get latestVersion;/// Store URL for the upgrade action.
 String? get storeUrl;/// Shown during maintenance; the honest version of "try again later".
 String? get message; DateTime? get expectedBackAt;
/// Create a copy of AppStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStatusCopyWith<AppStatus> get copyWith => _$AppStatusCopyWithImpl<AppStatus>(this as AppStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStatus&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.currentVersion, currentVersion) || other.currentVersion == currentVersion)&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.storeUrl, storeUrl) || other.storeUrl == storeUrl)&&(identical(other.message, message) || other.message == message)&&(identical(other.expectedBackAt, expectedBackAt) || other.expectedBackAt == expectedBackAt));
}


@override
int get hashCode => Object.hash(runtimeType,availability,currentVersion,latestVersion,storeUrl,message,expectedBackAt);

@override
String toString() {
  return 'AppStatus(availability: $availability, currentVersion: $currentVersion, latestVersion: $latestVersion, storeUrl: $storeUrl, message: $message, expectedBackAt: $expectedBackAt)';
}


}

/// @nodoc
abstract mixin class $AppStatusCopyWith<$Res>  {
  factory $AppStatusCopyWith(AppStatus value, $Res Function(AppStatus) _then) = _$AppStatusCopyWithImpl;
@useResult
$Res call({
 AppAvailability availability, String currentVersion, String latestVersion, String? storeUrl, String? message, DateTime? expectedBackAt
});




}
/// @nodoc
class _$AppStatusCopyWithImpl<$Res>
    implements $AppStatusCopyWith<$Res> {
  _$AppStatusCopyWithImpl(this._self, this._then);

  final AppStatus _self;
  final $Res Function(AppStatus) _then;

/// Create a copy of AppStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availability = null,Object? currentVersion = null,Object? latestVersion = null,Object? storeUrl = freezed,Object? message = freezed,Object? expectedBackAt = freezed,}) {
  return _then(_self.copyWith(
availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as AppAvailability,currentVersion: null == currentVersion ? _self.currentVersion : currentVersion // ignore: cast_nullable_to_non_nullable
as String,latestVersion: null == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String,storeUrl: freezed == storeUrl ? _self.storeUrl : storeUrl // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,expectedBackAt: freezed == expectedBackAt ? _self.expectedBackAt : expectedBackAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}



/// @nodoc


class _AppStatus extends AppStatus {
  const _AppStatus({this.availability = AppAvailability.available, this.currentVersion = '', this.latestVersion = '', this.storeUrl, this.message, this.expectedBackAt}): super._();
  

@override@JsonKey() final  AppAvailability availability;
/// Current build, e.g. "1.4.2".
@override@JsonKey() final  String currentVersion;
@override@JsonKey() final  String latestVersion;
/// Store URL for the upgrade action.
@override final  String? storeUrl;
/// Shown during maintenance; the honest version of "try again later".
@override final  String? message;
@override final  DateTime? expectedBackAt;

/// Create a copy of AppStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStatusCopyWith<_AppStatus> get copyWith => __$AppStatusCopyWithImpl<_AppStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppStatus&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.currentVersion, currentVersion) || other.currentVersion == currentVersion)&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.storeUrl, storeUrl) || other.storeUrl == storeUrl)&&(identical(other.message, message) || other.message == message)&&(identical(other.expectedBackAt, expectedBackAt) || other.expectedBackAt == expectedBackAt));
}


@override
int get hashCode => Object.hash(runtimeType,availability,currentVersion,latestVersion,storeUrl,message,expectedBackAt);

@override
String toString() {
  return 'AppStatus(availability: $availability, currentVersion: $currentVersion, latestVersion: $latestVersion, storeUrl: $storeUrl, message: $message, expectedBackAt: $expectedBackAt)';
}


}

/// @nodoc
abstract mixin class _$AppStatusCopyWith<$Res> implements $AppStatusCopyWith<$Res> {
  factory _$AppStatusCopyWith(_AppStatus value, $Res Function(_AppStatus) _then) = __$AppStatusCopyWithImpl;
@override @useResult
$Res call({
 AppAvailability availability, String currentVersion, String latestVersion, String? storeUrl, String? message, DateTime? expectedBackAt
});




}
/// @nodoc
class __$AppStatusCopyWithImpl<$Res>
    implements _$AppStatusCopyWith<$Res> {
  __$AppStatusCopyWithImpl(this._self, this._then);

  final _AppStatus _self;
  final $Res Function(_AppStatus) _then;

/// Create a copy of AppStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availability = null,Object? currentVersion = null,Object? latestVersion = null,Object? storeUrl = freezed,Object? message = freezed,Object? expectedBackAt = freezed,}) {
  return _then(_AppStatus(
availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as AppAvailability,currentVersion: null == currentVersion ? _self.currentVersion : currentVersion // ignore: cast_nullable_to_non_nullable
as String,latestVersion: null == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String,storeUrl: freezed == storeUrl ? _self.storeUrl : storeUrl // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,expectedBackAt: freezed == expectedBackAt ? _self.expectedBackAt : expectedBackAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
