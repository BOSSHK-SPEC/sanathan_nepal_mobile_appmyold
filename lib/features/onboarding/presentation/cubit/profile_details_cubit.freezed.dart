// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileDetailsState {

 UserProfileDraft get draft; LoadState<void> get submission;
/// Create a copy of ProfileDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileDetailsStateCopyWith<ProfileDetailsState> get copyWith => _$ProfileDetailsStateCopyWithImpl<ProfileDetailsState>(this as ProfileDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileDetailsState&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hash(runtimeType,draft,submission);

@override
String toString() {
  return 'ProfileDetailsState(draft: $draft, submission: $submission)';
}


}

/// @nodoc
abstract mixin class $ProfileDetailsStateCopyWith<$Res>  {
  factory $ProfileDetailsStateCopyWith(ProfileDetailsState value, $Res Function(ProfileDetailsState) _then) = _$ProfileDetailsStateCopyWithImpl;
@useResult
$Res call({
 UserProfileDraft draft, LoadState<void> submission
});


$UserProfileDraftCopyWith<$Res> get draft;$LoadStateCopyWith<void, $Res> get submission;

}
/// @nodoc
class _$ProfileDetailsStateCopyWithImpl<$Res>
    implements $ProfileDetailsStateCopyWith<$Res> {
  _$ProfileDetailsStateCopyWithImpl(this._self, this._then);

  final ProfileDetailsState _self;
  final $Res Function(ProfileDetailsState) _then;

/// Create a copy of ProfileDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draft = null,Object? submission = null,}) {
  return _then(_self.copyWith(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as UserProfileDraft,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<void>,
  ));
}
/// Create a copy of ProfileDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileDraftCopyWith<$Res> get draft {
  
  return $UserProfileDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of ProfileDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<void, $Res> get submission {
  
  return $LoadStateCopyWith<void, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}



/// @nodoc


class _ProfileDetailsState extends ProfileDetailsState {
  const _ProfileDetailsState({this.draft = const UserProfileDraft(), this.submission = const LoadState.idle()}): super._();
  

@override@JsonKey() final  UserProfileDraft draft;
@override@JsonKey() final  LoadState<void> submission;

/// Create a copy of ProfileDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileDetailsStateCopyWith<_ProfileDetailsState> get copyWith => __$ProfileDetailsStateCopyWithImpl<_ProfileDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileDetailsState&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hash(runtimeType,draft,submission);

@override
String toString() {
  return 'ProfileDetailsState(draft: $draft, submission: $submission)';
}


}

/// @nodoc
abstract mixin class _$ProfileDetailsStateCopyWith<$Res> implements $ProfileDetailsStateCopyWith<$Res> {
  factory _$ProfileDetailsStateCopyWith(_ProfileDetailsState value, $Res Function(_ProfileDetailsState) _then) = __$ProfileDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 UserProfileDraft draft, LoadState<void> submission
});


@override $UserProfileDraftCopyWith<$Res> get draft;@override $LoadStateCopyWith<void, $Res> get submission;

}
/// @nodoc
class __$ProfileDetailsStateCopyWithImpl<$Res>
    implements _$ProfileDetailsStateCopyWith<$Res> {
  __$ProfileDetailsStateCopyWithImpl(this._self, this._then);

  final _ProfileDetailsState _self;
  final $Res Function(_ProfileDetailsState) _then;

/// Create a copy of ProfileDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? submission = null,}) {
  return _then(_ProfileDetailsState(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as UserProfileDraft,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<void>,
  ));
}

/// Create a copy of ProfileDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileDraftCopyWith<$Res> get draft {
  
  return $UserProfileDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of ProfileDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<void, $Res> get submission {
  
  return $LoadStateCopyWith<void, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}

// dart format on
