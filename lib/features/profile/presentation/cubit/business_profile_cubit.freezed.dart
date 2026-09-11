// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BusinessProfileState {

 LoadState<BusinessProfile> get business; bool get isFollowing;
/// Create a copy of BusinessProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessProfileStateCopyWith<BusinessProfileState> get copyWith => _$BusinessProfileStateCopyWithImpl<BusinessProfileState>(this as BusinessProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessProfileState&&(identical(other.business, business) || other.business == business)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}


@override
int get hashCode => Object.hash(runtimeType,business,isFollowing);

@override
String toString() {
  return 'BusinessProfileState(business: $business, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class $BusinessProfileStateCopyWith<$Res>  {
  factory $BusinessProfileStateCopyWith(BusinessProfileState value, $Res Function(BusinessProfileState) _then) = _$BusinessProfileStateCopyWithImpl;
@useResult
$Res call({
 LoadState<BusinessProfile> business, bool isFollowing
});


$LoadStateCopyWith<BusinessProfile, $Res> get business;

}
/// @nodoc
class _$BusinessProfileStateCopyWithImpl<$Res>
    implements $BusinessProfileStateCopyWith<$Res> {
  _$BusinessProfileStateCopyWithImpl(this._self, this._then);

  final BusinessProfileState _self;
  final $Res Function(BusinessProfileState) _then;

/// Create a copy of BusinessProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? business = null,Object? isFollowing = null,}) {
  return _then(_self.copyWith(
business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as LoadState<BusinessProfile>,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of BusinessProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BusinessProfile, $Res> get business {
  
  return $LoadStateCopyWith<BusinessProfile, $Res>(_self.business, (value) {
    return _then(_self.copyWith(business: value));
  });
}
}



/// @nodoc


class _BusinessProfileState implements BusinessProfileState {
  const _BusinessProfileState({this.business = const LoadState.idle(), this.isFollowing = false});
  

@override@JsonKey() final  LoadState<BusinessProfile> business;
@override@JsonKey() final  bool isFollowing;

/// Create a copy of BusinessProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessProfileStateCopyWith<_BusinessProfileState> get copyWith => __$BusinessProfileStateCopyWithImpl<_BusinessProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessProfileState&&(identical(other.business, business) || other.business == business)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing));
}


@override
int get hashCode => Object.hash(runtimeType,business,isFollowing);

@override
String toString() {
  return 'BusinessProfileState(business: $business, isFollowing: $isFollowing)';
}


}

/// @nodoc
abstract mixin class _$BusinessProfileStateCopyWith<$Res> implements $BusinessProfileStateCopyWith<$Res> {
  factory _$BusinessProfileStateCopyWith(_BusinessProfileState value, $Res Function(_BusinessProfileState) _then) = __$BusinessProfileStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<BusinessProfile> business, bool isFollowing
});


@override $LoadStateCopyWith<BusinessProfile, $Res> get business;

}
/// @nodoc
class __$BusinessProfileStateCopyWithImpl<$Res>
    implements _$BusinessProfileStateCopyWith<$Res> {
  __$BusinessProfileStateCopyWithImpl(this._self, this._then);

  final _BusinessProfileState _self;
  final $Res Function(_BusinessProfileState) _then;

/// Create a copy of BusinessProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? business = null,Object? isFollowing = null,}) {
  return _then(_BusinessProfileState(
business: null == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as LoadState<BusinessProfile>,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BusinessProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BusinessProfile, $Res> get business {
  
  return $LoadStateCopyWith<BusinessProfile, $Res>(_self.business, (value) {
    return _then(_self.copyWith(business: value));
  });
}
}

// dart format on
