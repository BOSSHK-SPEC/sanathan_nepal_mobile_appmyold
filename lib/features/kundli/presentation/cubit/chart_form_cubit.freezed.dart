// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChartFormState {

 BirthProfile get profile; LoadState<BirthProfile> get saving;
/// Create a copy of ChartFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartFormStateCopyWith<ChartFormState> get copyWith => _$ChartFormStateCopyWithImpl<ChartFormState>(this as ChartFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartFormState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.saving, saving) || other.saving == saving));
}


@override
int get hashCode => Object.hash(runtimeType,profile,saving);

@override
String toString() {
  return 'ChartFormState(profile: $profile, saving: $saving)';
}


}

/// @nodoc
abstract mixin class $ChartFormStateCopyWith<$Res>  {
  factory $ChartFormStateCopyWith(ChartFormState value, $Res Function(ChartFormState) _then) = _$ChartFormStateCopyWithImpl;
@useResult
$Res call({
 BirthProfile profile, LoadState<BirthProfile> saving
});


$BirthProfileCopyWith<$Res> get profile;$LoadStateCopyWith<BirthProfile, $Res> get saving;

}
/// @nodoc
class _$ChartFormStateCopyWithImpl<$Res>
    implements $ChartFormStateCopyWith<$Res> {
  _$ChartFormStateCopyWithImpl(this._self, this._then);

  final ChartFormState _self;
  final $Res Function(ChartFormState) _then;

/// Create a copy of ChartFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? saving = null,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as BirthProfile,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<BirthProfile>,
  ));
}
/// Create a copy of ChartFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BirthProfileCopyWith<$Res> get profile {
  
  return $BirthProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of ChartFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BirthProfile, $Res> get saving {
  
  return $LoadStateCopyWith<BirthProfile, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}
}



/// @nodoc


class _ChartFormState extends ChartFormState {
  const _ChartFormState({required this.profile, this.saving = const LoadState.idle()}): super._();
  

@override final  BirthProfile profile;
@override@JsonKey() final  LoadState<BirthProfile> saving;

/// Create a copy of ChartFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChartFormStateCopyWith<_ChartFormState> get copyWith => __$ChartFormStateCopyWithImpl<_ChartFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChartFormState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.saving, saving) || other.saving == saving));
}


@override
int get hashCode => Object.hash(runtimeType,profile,saving);

@override
String toString() {
  return 'ChartFormState(profile: $profile, saving: $saving)';
}


}

/// @nodoc
abstract mixin class _$ChartFormStateCopyWith<$Res> implements $ChartFormStateCopyWith<$Res> {
  factory _$ChartFormStateCopyWith(_ChartFormState value, $Res Function(_ChartFormState) _then) = __$ChartFormStateCopyWithImpl;
@override @useResult
$Res call({
 BirthProfile profile, LoadState<BirthProfile> saving
});


@override $BirthProfileCopyWith<$Res> get profile;@override $LoadStateCopyWith<BirthProfile, $Res> get saving;

}
/// @nodoc
class __$ChartFormStateCopyWithImpl<$Res>
    implements _$ChartFormStateCopyWith<$Res> {
  __$ChartFormStateCopyWithImpl(this._self, this._then);

  final _ChartFormState _self;
  final $Res Function(_ChartFormState) _then;

/// Create a copy of ChartFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? saving = null,}) {
  return _then(_ChartFormState(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as BirthProfile,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<BirthProfile>,
  ));
}

/// Create a copy of ChartFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BirthProfileCopyWith<$Res> get profile {
  
  return $BirthProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of ChartFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BirthProfile, $Res> get saving {
  
  return $LoadStateCopyWith<BirthProfile, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}
}

// dart format on
