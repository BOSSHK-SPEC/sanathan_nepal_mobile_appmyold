// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AstrologerClient {

 String get id; String get name; int get sessionCount; double get lifetimeValue; DateTime get lastSessionAt; String? get avatar;/// Birth details the seeker supplied, so a returning client does not
/// have to repeat them.
 String? get birthDetails;/// The astrologer's own running notes about this client.
 String get notes; double? get averageRating;
/// Create a copy of AstrologerClient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerClientCopyWith<AstrologerClient> get copyWith => _$AstrologerClientCopyWithImpl<AstrologerClient>(this as AstrologerClient, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerClient&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount)&&(identical(other.lifetimeValue, lifetimeValue) || other.lifetimeValue == lifetimeValue)&&(identical(other.lastSessionAt, lastSessionAt) || other.lastSessionAt == lastSessionAt)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.birthDetails, birthDetails) || other.birthDetails == birthDetails)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,sessionCount,lifetimeValue,lastSessionAt,avatar,birthDetails,notes,averageRating);

@override
String toString() {
  return 'AstrologerClient(id: $id, name: $name, sessionCount: $sessionCount, lifetimeValue: $lifetimeValue, lastSessionAt: $lastSessionAt, avatar: $avatar, birthDetails: $birthDetails, notes: $notes, averageRating: $averageRating)';
}


}

/// @nodoc
abstract mixin class $AstrologerClientCopyWith<$Res>  {
  factory $AstrologerClientCopyWith(AstrologerClient value, $Res Function(AstrologerClient) _then) = _$AstrologerClientCopyWithImpl;
@useResult
$Res call({
 String id, String name, int sessionCount, double lifetimeValue, DateTime lastSessionAt, String? avatar, String? birthDetails, String notes, double? averageRating
});




}
/// @nodoc
class _$AstrologerClientCopyWithImpl<$Res>
    implements $AstrologerClientCopyWith<$Res> {
  _$AstrologerClientCopyWithImpl(this._self, this._then);

  final AstrologerClient _self;
  final $Res Function(AstrologerClient) _then;

/// Create a copy of AstrologerClient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? sessionCount = null,Object? lifetimeValue = null,Object? lastSessionAt = null,Object? avatar = freezed,Object? birthDetails = freezed,Object? notes = null,Object? averageRating = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,lifetimeValue: null == lifetimeValue ? _self.lifetimeValue : lifetimeValue // ignore: cast_nullable_to_non_nullable
as double,lastSessionAt: null == lastSessionAt ? _self.lastSessionAt : lastSessionAt // ignore: cast_nullable_to_non_nullable
as DateTime,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,birthDetails: freezed == birthDetails ? _self.birthDetails : birthDetails // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}



/// @nodoc


class _AstrologerClient extends AstrologerClient {
  const _AstrologerClient({required this.id, required this.name, required this.sessionCount, required this.lifetimeValue, required this.lastSessionAt, this.avatar, this.birthDetails, this.notes = '', this.averageRating}): super._();
  

@override final  String id;
@override final  String name;
@override final  int sessionCount;
@override final  double lifetimeValue;
@override final  DateTime lastSessionAt;
@override final  String? avatar;
/// Birth details the seeker supplied, so a returning client does not
/// have to repeat them.
@override final  String? birthDetails;
/// The astrologer's own running notes about this client.
@override@JsonKey() final  String notes;
@override final  double? averageRating;

/// Create a copy of AstrologerClient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerClientCopyWith<_AstrologerClient> get copyWith => __$AstrologerClientCopyWithImpl<_AstrologerClient>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerClient&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount)&&(identical(other.lifetimeValue, lifetimeValue) || other.lifetimeValue == lifetimeValue)&&(identical(other.lastSessionAt, lastSessionAt) || other.lastSessionAt == lastSessionAt)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.birthDetails, birthDetails) || other.birthDetails == birthDetails)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,sessionCount,lifetimeValue,lastSessionAt,avatar,birthDetails,notes,averageRating);

@override
String toString() {
  return 'AstrologerClient(id: $id, name: $name, sessionCount: $sessionCount, lifetimeValue: $lifetimeValue, lastSessionAt: $lastSessionAt, avatar: $avatar, birthDetails: $birthDetails, notes: $notes, averageRating: $averageRating)';
}


}

/// @nodoc
abstract mixin class _$AstrologerClientCopyWith<$Res> implements $AstrologerClientCopyWith<$Res> {
  factory _$AstrologerClientCopyWith(_AstrologerClient value, $Res Function(_AstrologerClient) _then) = __$AstrologerClientCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int sessionCount, double lifetimeValue, DateTime lastSessionAt, String? avatar, String? birthDetails, String notes, double? averageRating
});




}
/// @nodoc
class __$AstrologerClientCopyWithImpl<$Res>
    implements _$AstrologerClientCopyWith<$Res> {
  __$AstrologerClientCopyWithImpl(this._self, this._then);

  final _AstrologerClient _self;
  final $Res Function(_AstrologerClient) _then;

/// Create a copy of AstrologerClient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? sessionCount = null,Object? lifetimeValue = null,Object? lastSessionAt = null,Object? avatar = freezed,Object? birthDetails = freezed,Object? notes = null,Object? averageRating = freezed,}) {
  return _then(_AstrologerClient(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,lifetimeValue: null == lifetimeValue ? _self.lifetimeValue : lifetimeValue // ignore: cast_nullable_to_non_nullable
as double,lastSessionAt: null == lastSessionAt ? _self.lastSessionAt : lastSessionAt // ignore: cast_nullable_to_non_nullable
as DateTime,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,birthDetails: freezed == birthDetails ? _self.birthDetails : birthDetails // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,averageRating: freezed == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
