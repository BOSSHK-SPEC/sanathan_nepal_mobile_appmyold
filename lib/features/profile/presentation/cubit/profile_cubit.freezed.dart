// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {

 LoadState<UserProfile> get profile; LoadState<List<FavouriteProduct>> get favourites;/// Logout / delete-account request; `loaded` means the session ended.
 LoadState<void> get signOut;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.favourites, favourites) || other.favourites == favourites)&&(identical(other.signOut, signOut) || other.signOut == signOut));
}


@override
int get hashCode => Object.hash(runtimeType,profile,favourites,signOut);

@override
String toString() {
  return 'ProfileState(profile: $profile, favourites: $favourites, signOut: $signOut)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 LoadState<UserProfile> profile, LoadState<List<FavouriteProduct>> favourites, LoadState<void> signOut
});


$LoadStateCopyWith<UserProfile, $Res> get profile;$LoadStateCopyWith<List<FavouriteProduct>, $Res> get favourites;$LoadStateCopyWith<void, $Res> get signOut;

}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? favourites = null,Object? signOut = null,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as LoadState<UserProfile>,favourites: null == favourites ? _self.favourites : favourites // ignore: cast_nullable_to_non_nullable
as LoadState<List<FavouriteProduct>>,signOut: null == signOut ? _self.signOut : signOut // ignore: cast_nullable_to_non_nullable
as LoadState<void>,
  ));
}
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<UserProfile, $Res> get profile {
  
  return $LoadStateCopyWith<UserProfile, $Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<FavouriteProduct>, $Res> get favourites {
  
  return $LoadStateCopyWith<List<FavouriteProduct>, $Res>(_self.favourites, (value) {
    return _then(_self.copyWith(favourites: value));
  });
}/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<void, $Res> get signOut {
  
  return $LoadStateCopyWith<void, $Res>(_self.signOut, (value) {
    return _then(_self.copyWith(signOut: value));
  });
}
}



/// @nodoc


class _ProfileState implements ProfileState {
  const _ProfileState({this.profile = const LoadState.idle(), this.favourites = const LoadState.idle(), this.signOut = const LoadState.idle()});
  

@override@JsonKey() final  LoadState<UserProfile> profile;
@override@JsonKey() final  LoadState<List<FavouriteProduct>> favourites;
/// Logout / delete-account request; `loaded` means the session ended.
@override@JsonKey() final  LoadState<void> signOut;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.favourites, favourites) || other.favourites == favourites)&&(identical(other.signOut, signOut) || other.signOut == signOut));
}


@override
int get hashCode => Object.hash(runtimeType,profile,favourites,signOut);

@override
String toString() {
  return 'ProfileState(profile: $profile, favourites: $favourites, signOut: $signOut)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<UserProfile> profile, LoadState<List<FavouriteProduct>> favourites, LoadState<void> signOut
});


@override $LoadStateCopyWith<UserProfile, $Res> get profile;@override $LoadStateCopyWith<List<FavouriteProduct>, $Res> get favourites;@override $LoadStateCopyWith<void, $Res> get signOut;

}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? favourites = null,Object? signOut = null,}) {
  return _then(_ProfileState(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as LoadState<UserProfile>,favourites: null == favourites ? _self.favourites : favourites // ignore: cast_nullable_to_non_nullable
as LoadState<List<FavouriteProduct>>,signOut: null == signOut ? _self.signOut : signOut // ignore: cast_nullable_to_non_nullable
as LoadState<void>,
  ));
}

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<UserProfile, $Res> get profile {
  
  return $LoadStateCopyWith<UserProfile, $Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<FavouriteProduct>, $Res> get favourites {
  
  return $LoadStateCopyWith<List<FavouriteProduct>, $Res>(_self.favourites, (value) {
    return _then(_self.copyWith(favourites: value));
  });
}/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<void, $Res> get signOut {
  
  return $LoadStateCopyWith<void, $Res>(_self.signOut, (value) {
    return _then(_self.copyWith(signOut: value));
  });
}
}

// dart format on
