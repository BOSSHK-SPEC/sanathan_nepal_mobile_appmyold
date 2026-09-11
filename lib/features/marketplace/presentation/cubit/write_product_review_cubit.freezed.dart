// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'write_product_review_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WriteProductReviewState {

 ProductReviewDraft get draft; LoadState<ProductReview> get submission; String? get submitError;
/// Create a copy of WriteProductReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WriteProductReviewStateCopyWith<WriteProductReviewState> get copyWith => _$WriteProductReviewStateCopyWithImpl<WriteProductReviewState>(this as WriteProductReviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WriteProductReviewState&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.submission, submission) || other.submission == submission)&&(identical(other.submitError, submitError) || other.submitError == submitError));
}


@override
int get hashCode => Object.hash(runtimeType,draft,submission,submitError);

@override
String toString() {
  return 'WriteProductReviewState(draft: $draft, submission: $submission, submitError: $submitError)';
}


}

/// @nodoc
abstract mixin class $WriteProductReviewStateCopyWith<$Res>  {
  factory $WriteProductReviewStateCopyWith(WriteProductReviewState value, $Res Function(WriteProductReviewState) _then) = _$WriteProductReviewStateCopyWithImpl;
@useResult
$Res call({
 ProductReviewDraft draft, LoadState<ProductReview> submission, String? submitError
});


$ProductReviewDraftCopyWith<$Res> get draft;$LoadStateCopyWith<ProductReview, $Res> get submission;

}
/// @nodoc
class _$WriteProductReviewStateCopyWithImpl<$Res>
    implements $WriteProductReviewStateCopyWith<$Res> {
  _$WriteProductReviewStateCopyWithImpl(this._self, this._then);

  final WriteProductReviewState _self;
  final $Res Function(WriteProductReviewState) _then;

/// Create a copy of WriteProductReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? draft = null,Object? submission = null,Object? submitError = freezed,}) {
  return _then(_self.copyWith(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ProductReviewDraft,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<ProductReview>,submitError: freezed == submitError ? _self.submitError : submitError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of WriteProductReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductReviewDraftCopyWith<$Res> get draft {
  
  return $ProductReviewDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of WriteProductReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ProductReview, $Res> get submission {
  
  return $LoadStateCopyWith<ProductReview, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}



/// @nodoc


class _WriteProductReviewState extends WriteProductReviewState {
  const _WriteProductReviewState({required this.draft, this.submission = const LoadState.idle(), this.submitError}): super._();
  

@override final  ProductReviewDraft draft;
@override@JsonKey() final  LoadState<ProductReview> submission;
@override final  String? submitError;

/// Create a copy of WriteProductReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WriteProductReviewStateCopyWith<_WriteProductReviewState> get copyWith => __$WriteProductReviewStateCopyWithImpl<_WriteProductReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WriteProductReviewState&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.submission, submission) || other.submission == submission)&&(identical(other.submitError, submitError) || other.submitError == submitError));
}


@override
int get hashCode => Object.hash(runtimeType,draft,submission,submitError);

@override
String toString() {
  return 'WriteProductReviewState(draft: $draft, submission: $submission, submitError: $submitError)';
}


}

/// @nodoc
abstract mixin class _$WriteProductReviewStateCopyWith<$Res> implements $WriteProductReviewStateCopyWith<$Res> {
  factory _$WriteProductReviewStateCopyWith(_WriteProductReviewState value, $Res Function(_WriteProductReviewState) _then) = __$WriteProductReviewStateCopyWithImpl;
@override @useResult
$Res call({
 ProductReviewDraft draft, LoadState<ProductReview> submission, String? submitError
});


@override $ProductReviewDraftCopyWith<$Res> get draft;@override $LoadStateCopyWith<ProductReview, $Res> get submission;

}
/// @nodoc
class __$WriteProductReviewStateCopyWithImpl<$Res>
    implements _$WriteProductReviewStateCopyWith<$Res> {
  __$WriteProductReviewStateCopyWithImpl(this._self, this._then);

  final _WriteProductReviewState _self;
  final $Res Function(_WriteProductReviewState) _then;

/// Create a copy of WriteProductReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? submission = null,Object? submitError = freezed,}) {
  return _then(_WriteProductReviewState(
draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as ProductReviewDraft,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<ProductReview>,submitError: freezed == submitError ? _self.submitError : submitError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of WriteProductReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductReviewDraftCopyWith<$Res> get draft {
  
  return $ProductReviewDraftCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of WriteProductReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ProductReview, $Res> get submission {
  
  return $LoadStateCopyWith<ProductReview, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}

// dart format on
