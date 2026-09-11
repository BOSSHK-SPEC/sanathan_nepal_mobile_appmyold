// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditProfileState {

/// Profile being edited (loaded from the repository, then the saved copy).
 LoadState<UserProfile> get profile;/// Save request; `loaded` carries the persisted profile.
 LoadState<UserProfile> get save;
/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileStateCopyWith<EditProfileState> get copyWith => _$EditProfileStateCopyWithImpl<EditProfileState>(this as EditProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.save, save) || other.save == save));
}


@override
int get hashCode => Object.hash(runtimeType,profile,save);

@override
String toString() {
  return 'EditProfileState(profile: $profile, save: $save)';
}


}

/// @nodoc
abstract mixin class $EditProfileStateCopyWith<$Res>  {
  factory $EditProfileStateCopyWith(EditProfileState value, $Res Function(EditProfileState) _then) = _$EditProfileStateCopyWithImpl;
@useResult
$Res call({
 LoadState<UserProfile> profile, LoadState<UserProfile> save
});


$LoadStateCopyWith<UserProfile, $Res> get profile;$LoadStateCopyWith<UserProfile, $Res> get save;

}
/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._self, this._then);

  final EditProfileState _self;
  final $Res Function(EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? save = null,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as LoadState<UserProfile>,save: null == save ? _self.save : save // ignore: cast_nullable_to_non_nullable
as LoadState<UserProfile>,
  ));
}
/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<UserProfile, $Res> get profile {
  
  return $LoadStateCopyWith<UserProfile, $Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<UserProfile, $Res> get save {
  
  return $LoadStateCopyWith<UserProfile, $Res>(_self.save, (value) {
    return _then(_self.copyWith(save: value));
  });
}
}



/// @nodoc


class _EditProfileState implements EditProfileState {
  const _EditProfileState({this.profile = const LoadState.idle(), this.save = const LoadState.idle()});
  

/// Profile being edited (loaded from the repository, then the saved copy).
@override@JsonKey() final  LoadState<UserProfile> profile;
/// Save request; `loaded` carries the persisted profile.
@override@JsonKey() final  LoadState<UserProfile> save;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditProfileStateCopyWith<_EditProfileState> get copyWith => __$EditProfileStateCopyWithImpl<_EditProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.save, save) || other.save == save));
}


@override
int get hashCode => Object.hash(runtimeType,profile,save);

@override
String toString() {
  return 'EditProfileState(profile: $profile, save: $save)';
}


}

/// @nodoc
abstract mixin class _$EditProfileStateCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$EditProfileStateCopyWith(_EditProfileState value, $Res Function(_EditProfileState) _then) = __$EditProfileStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<UserProfile> profile, LoadState<UserProfile> save
});


@override $LoadStateCopyWith<UserProfile, $Res> get profile;@override $LoadStateCopyWith<UserProfile, $Res> get save;

}
/// @nodoc
class __$EditProfileStateCopyWithImpl<$Res>
    implements _$EditProfileStateCopyWith<$Res> {
  __$EditProfileStateCopyWithImpl(this._self, this._then);

  final _EditProfileState _self;
  final $Res Function(_EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? save = null,}) {
  return _then(_EditProfileState(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as LoadState<UserProfile>,save: null == save ? _self.save : save // ignore: cast_nullable_to_non_nullable
as LoadState<UserProfile>,
  ));
}

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<UserProfile, $Res> get profile {
  
  return $LoadStateCopyWith<UserProfile, $Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<UserProfile, $Res> get save {
  
  return $LoadStateCopyWith<UserProfile, $Res>(_self.save, (value) {
    return _then(_self.copyWith(save: value));
  });
}
}

// dart format on
