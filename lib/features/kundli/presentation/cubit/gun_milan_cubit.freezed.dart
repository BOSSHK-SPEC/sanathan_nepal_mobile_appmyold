// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gun_milan_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GunMilanState {

 LoadState<List<BirthProfile>> get profiles; LoadState<GunMilanResult> get result; String? get brideId; String? get groomId;
/// Create a copy of GunMilanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GunMilanStateCopyWith<GunMilanState> get copyWith => _$GunMilanStateCopyWithImpl<GunMilanState>(this as GunMilanState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GunMilanState&&(identical(other.profiles, profiles) || other.profiles == profiles)&&(identical(other.result, result) || other.result == result)&&(identical(other.brideId, brideId) || other.brideId == brideId)&&(identical(other.groomId, groomId) || other.groomId == groomId));
}


@override
int get hashCode => Object.hash(runtimeType,profiles,result,brideId,groomId);

@override
String toString() {
  return 'GunMilanState(profiles: $profiles, result: $result, brideId: $brideId, groomId: $groomId)';
}


}

/// @nodoc
abstract mixin class $GunMilanStateCopyWith<$Res>  {
  factory $GunMilanStateCopyWith(GunMilanState value, $Res Function(GunMilanState) _then) = _$GunMilanStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<BirthProfile>> profiles, LoadState<GunMilanResult> result, String? brideId, String? groomId
});


$LoadStateCopyWith<List<BirthProfile>, $Res> get profiles;$LoadStateCopyWith<GunMilanResult, $Res> get result;

}
/// @nodoc
class _$GunMilanStateCopyWithImpl<$Res>
    implements $GunMilanStateCopyWith<$Res> {
  _$GunMilanStateCopyWithImpl(this._self, this._then);

  final GunMilanState _self;
  final $Res Function(GunMilanState) _then;

/// Create a copy of GunMilanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profiles = null,Object? result = null,Object? brideId = freezed,Object? groomId = freezed,}) {
  return _then(_self.copyWith(
profiles: null == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as LoadState<List<BirthProfile>>,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as LoadState<GunMilanResult>,brideId: freezed == brideId ? _self.brideId : brideId // ignore: cast_nullable_to_non_nullable
as String?,groomId: freezed == groomId ? _self.groomId : groomId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GunMilanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BirthProfile>, $Res> get profiles {
  
  return $LoadStateCopyWith<List<BirthProfile>, $Res>(_self.profiles, (value) {
    return _then(_self.copyWith(profiles: value));
  });
}/// Create a copy of GunMilanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<GunMilanResult, $Res> get result {
  
  return $LoadStateCopyWith<GunMilanResult, $Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}



/// @nodoc


class _GunMilanState extends GunMilanState {
  const _GunMilanState({this.profiles = const LoadState.idle(), this.result = const LoadState.idle(), this.brideId, this.groomId}): super._();
  

@override@JsonKey() final  LoadState<List<BirthProfile>> profiles;
@override@JsonKey() final  LoadState<GunMilanResult> result;
@override final  String? brideId;
@override final  String? groomId;

/// Create a copy of GunMilanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GunMilanStateCopyWith<_GunMilanState> get copyWith => __$GunMilanStateCopyWithImpl<_GunMilanState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GunMilanState&&(identical(other.profiles, profiles) || other.profiles == profiles)&&(identical(other.result, result) || other.result == result)&&(identical(other.brideId, brideId) || other.brideId == brideId)&&(identical(other.groomId, groomId) || other.groomId == groomId));
}


@override
int get hashCode => Object.hash(runtimeType,profiles,result,brideId,groomId);

@override
String toString() {
  return 'GunMilanState(profiles: $profiles, result: $result, brideId: $brideId, groomId: $groomId)';
}


}

/// @nodoc
abstract mixin class _$GunMilanStateCopyWith<$Res> implements $GunMilanStateCopyWith<$Res> {
  factory _$GunMilanStateCopyWith(_GunMilanState value, $Res Function(_GunMilanState) _then) = __$GunMilanStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<BirthProfile>> profiles, LoadState<GunMilanResult> result, String? brideId, String? groomId
});


@override $LoadStateCopyWith<List<BirthProfile>, $Res> get profiles;@override $LoadStateCopyWith<GunMilanResult, $Res> get result;

}
/// @nodoc
class __$GunMilanStateCopyWithImpl<$Res>
    implements _$GunMilanStateCopyWith<$Res> {
  __$GunMilanStateCopyWithImpl(this._self, this._then);

  final _GunMilanState _self;
  final $Res Function(_GunMilanState) _then;

/// Create a copy of GunMilanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profiles = null,Object? result = null,Object? brideId = freezed,Object? groomId = freezed,}) {
  return _then(_GunMilanState(
profiles: null == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as LoadState<List<BirthProfile>>,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as LoadState<GunMilanResult>,brideId: freezed == brideId ? _self.brideId : brideId // ignore: cast_nullable_to_non_nullable
as String?,groomId: freezed == groomId ? _self.groomId : groomId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GunMilanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<BirthProfile>, $Res> get profiles {
  
  return $LoadStateCopyWith<List<BirthProfile>, $Res>(_self.profiles, (value) {
    return _then(_self.copyWith(profiles: value));
  });
}/// Create a copy of GunMilanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<GunMilanResult, $Res> get result {
  
  return $LoadStateCopyWith<GunMilanResult, $Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
