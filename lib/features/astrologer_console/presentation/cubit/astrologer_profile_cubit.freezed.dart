// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AstrologerProfileState {

 LoadState<AstrologerProfileDraft> get profile; LoadState<AstrologerProfileDraft> get saving; AstrologerProfileDraft? get draft; String? get saveError;
/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerProfileStateCopyWith<AstrologerProfileState> get copyWith => _$AstrologerProfileStateCopyWithImpl<AstrologerProfileState>(this as AstrologerProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,profile,saving,draft,saveError);

@override
String toString() {
  return 'AstrologerProfileState(profile: $profile, saving: $saving, draft: $draft, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class $AstrologerProfileStateCopyWith<$Res>  {
  factory $AstrologerProfileStateCopyWith(AstrologerProfileState value, $Res Function(AstrologerProfileState) _then) = _$AstrologerProfileStateCopyWithImpl;
@useResult
$Res call({
 LoadState<AstrologerProfileDraft> profile, LoadState<AstrologerProfileDraft> saving, AstrologerProfileDraft? draft, String? saveError
});


$LoadStateCopyWith<AstrologerProfileDraft, $Res> get profile;$LoadStateCopyWith<AstrologerProfileDraft, $Res> get saving;$AstrologerProfileDraftCopyWith<$Res>? get draft;

}
/// @nodoc
class _$AstrologerProfileStateCopyWithImpl<$Res>
    implements $AstrologerProfileStateCopyWith<$Res> {
  _$AstrologerProfileStateCopyWithImpl(this._self, this._then);

  final AstrologerProfileState _self;
  final $Res Function(AstrologerProfileState) _then;

/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? saving = null,Object? draft = freezed,Object? saveError = freezed,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerProfileDraft>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerProfileDraft>,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as AstrologerProfileDraft?,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerProfileDraft, $Res> get profile {
  
  return $LoadStateCopyWith<AstrologerProfileDraft, $Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerProfileDraft, $Res> get saving {
  
  return $LoadStateCopyWith<AstrologerProfileDraft, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AstrologerProfileDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $AstrologerProfileDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}



/// @nodoc


class _AstrologerProfileState extends AstrologerProfileState {
  const _AstrologerProfileState({this.profile = const LoadState.idle(), this.saving = const LoadState.idle(), this.draft, this.saveError}): super._();
  

@override@JsonKey() final  LoadState<AstrologerProfileDraft> profile;
@override@JsonKey() final  LoadState<AstrologerProfileDraft> saving;
@override final  AstrologerProfileDraft? draft;
@override final  String? saveError;

/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerProfileStateCopyWith<_AstrologerProfileState> get copyWith => __$AstrologerProfileStateCopyWithImpl<_AstrologerProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerProfileState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.saveError, saveError) || other.saveError == saveError));
}


@override
int get hashCode => Object.hash(runtimeType,profile,saving,draft,saveError);

@override
String toString() {
  return 'AstrologerProfileState(profile: $profile, saving: $saving, draft: $draft, saveError: $saveError)';
}


}

/// @nodoc
abstract mixin class _$AstrologerProfileStateCopyWith<$Res> implements $AstrologerProfileStateCopyWith<$Res> {
  factory _$AstrologerProfileStateCopyWith(_AstrologerProfileState value, $Res Function(_AstrologerProfileState) _then) = __$AstrologerProfileStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<AstrologerProfileDraft> profile, LoadState<AstrologerProfileDraft> saving, AstrologerProfileDraft? draft, String? saveError
});


@override $LoadStateCopyWith<AstrologerProfileDraft, $Res> get profile;@override $LoadStateCopyWith<AstrologerProfileDraft, $Res> get saving;@override $AstrologerProfileDraftCopyWith<$Res>? get draft;

}
/// @nodoc
class __$AstrologerProfileStateCopyWithImpl<$Res>
    implements _$AstrologerProfileStateCopyWith<$Res> {
  __$AstrologerProfileStateCopyWithImpl(this._self, this._then);

  final _AstrologerProfileState _self;
  final $Res Function(_AstrologerProfileState) _then;

/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? saving = null,Object? draft = freezed,Object? saveError = freezed,}) {
  return _then(_AstrologerProfileState(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerProfileDraft>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerProfileDraft>,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as AstrologerProfileDraft?,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerProfileDraft, $Res> get profile {
  
  return $LoadStateCopyWith<AstrologerProfileDraft, $Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerProfileDraft, $Res> get saving {
  
  return $LoadStateCopyWith<AstrologerProfileDraft, $Res>(_self.saving, (value) {
    return _then(_self.copyWith(saving: value));
  });
}/// Create a copy of AstrologerProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AstrologerProfileDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $AstrologerProfileDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
