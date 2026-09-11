// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_form_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BusinessFormState {

/// Stored business the draft was seeded from (`failed` when the user has
/// no business yet – the draft then starts blank).
 LoadState<BusinessProfile> get existing;/// Editable form value.
 BusinessProfile get draft;/// 0 = Business Details, 1 = Products / Services Details.
 int get step;/// Submit request; `loaded` carries the persisted business.
 LoadState<BusinessProfile> get submission;
/// Create a copy of BusinessFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessFormStateCopyWith<BusinessFormState> get copyWith => _$BusinessFormStateCopyWithImpl<BusinessFormState>(this as BusinessFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessFormState&&(identical(other.existing, existing) || other.existing == existing)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.step, step) || other.step == step)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hash(runtimeType,existing,draft,step,submission);

@override
String toString() {
  return 'BusinessFormState(existing: $existing, draft: $draft, step: $step, submission: $submission)';
}


}

/// @nodoc
abstract mixin class $BusinessFormStateCopyWith<$Res>  {
  factory $BusinessFormStateCopyWith(BusinessFormState value, $Res Function(BusinessFormState) _then) = _$BusinessFormStateCopyWithImpl;
@useResult
$Res call({
 LoadState<BusinessProfile> existing, BusinessProfile draft, int step, LoadState<BusinessProfile> submission
});


$LoadStateCopyWith<BusinessProfile, $Res> get existing;$BusinessProfileCopyWith<$Res> get draft;$LoadStateCopyWith<BusinessProfile, $Res> get submission;

}
/// @nodoc
class _$BusinessFormStateCopyWithImpl<$Res>
    implements $BusinessFormStateCopyWith<$Res> {
  _$BusinessFormStateCopyWithImpl(this._self, this._then);

  final BusinessFormState _self;
  final $Res Function(BusinessFormState) _then;

/// Create a copy of BusinessFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? existing = null,Object? draft = null,Object? step = null,Object? submission = null,}) {
  return _then(_self.copyWith(
existing: null == existing ? _self.existing : existing // ignore: cast_nullable_to_non_nullable
as LoadState<BusinessProfile>,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as BusinessProfile,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<BusinessProfile>,
  ));
}
/// Create a copy of BusinessFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BusinessProfile, $Res> get existing {
  
  return $LoadStateCopyWith<BusinessProfile, $Res>(_self.existing, (value) {
    return _then(_self.copyWith(existing: value));
  });
}/// Create a copy of BusinessFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessProfileCopyWith<$Res> get draft {
  
  return $BusinessProfileCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of BusinessFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BusinessProfile, $Res> get submission {
  
  return $LoadStateCopyWith<BusinessProfile, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}



/// @nodoc


class _BusinessFormState extends BusinessFormState {
  const _BusinessFormState({this.existing = const LoadState.idle(), this.draft = const BusinessProfile(id: '', name: '', category: ''), this.step = 0, this.submission = const LoadState.idle()}): super._();
  

/// Stored business the draft was seeded from (`failed` when the user has
/// no business yet – the draft then starts blank).
@override@JsonKey() final  LoadState<BusinessProfile> existing;
/// Editable form value.
@override@JsonKey() final  BusinessProfile draft;
/// 0 = Business Details, 1 = Products / Services Details.
@override@JsonKey() final  int step;
/// Submit request; `loaded` carries the persisted business.
@override@JsonKey() final  LoadState<BusinessProfile> submission;

/// Create a copy of BusinessFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessFormStateCopyWith<_BusinessFormState> get copyWith => __$BusinessFormStateCopyWithImpl<_BusinessFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessFormState&&(identical(other.existing, existing) || other.existing == existing)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.step, step) || other.step == step)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hash(runtimeType,existing,draft,step,submission);

@override
String toString() {
  return 'BusinessFormState(existing: $existing, draft: $draft, step: $step, submission: $submission)';
}


}

/// @nodoc
abstract mixin class _$BusinessFormStateCopyWith<$Res> implements $BusinessFormStateCopyWith<$Res> {
  factory _$BusinessFormStateCopyWith(_BusinessFormState value, $Res Function(_BusinessFormState) _then) = __$BusinessFormStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<BusinessProfile> existing, BusinessProfile draft, int step, LoadState<BusinessProfile> submission
});


@override $LoadStateCopyWith<BusinessProfile, $Res> get existing;@override $BusinessProfileCopyWith<$Res> get draft;@override $LoadStateCopyWith<BusinessProfile, $Res> get submission;

}
/// @nodoc
class __$BusinessFormStateCopyWithImpl<$Res>
    implements _$BusinessFormStateCopyWith<$Res> {
  __$BusinessFormStateCopyWithImpl(this._self, this._then);

  final _BusinessFormState _self;
  final $Res Function(_BusinessFormState) _then;

/// Create a copy of BusinessFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? existing = null,Object? draft = null,Object? step = null,Object? submission = null,}) {
  return _then(_BusinessFormState(
existing: null == existing ? _self.existing : existing // ignore: cast_nullable_to_non_nullable
as LoadState<BusinessProfile>,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as BusinessProfile,step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<BusinessProfile>,
  ));
}

/// Create a copy of BusinessFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BusinessProfile, $Res> get existing {
  
  return $LoadStateCopyWith<BusinessProfile, $Res>(_self.existing, (value) {
    return _then(_self.copyWith(existing: value));
  });
}/// Create a copy of BusinessFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessProfileCopyWith<$Res> get draft {
  
  return $BusinessProfileCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of BusinessFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<BusinessProfile, $Res> get submission {
  
  return $LoadStateCopyWith<BusinessProfile, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}

// dart format on
