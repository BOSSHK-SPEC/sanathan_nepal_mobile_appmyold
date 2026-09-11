// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'write_review_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WriteReviewState {

 String get astrologerId; String? get consultationId; int get rating; String get comment; Set<String> get tags; LoadState<AstrologerReview> get submission;
/// Create a copy of WriteReviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WriteReviewStateCopyWith<WriteReviewState> get copyWith => _$WriteReviewStateCopyWithImpl<WriteReviewState>(this as WriteReviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WriteReviewState&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,consultationId,rating,comment,const DeepCollectionEquality().hash(tags),submission);

@override
String toString() {
  return 'WriteReviewState(astrologerId: $astrologerId, consultationId: $consultationId, rating: $rating, comment: $comment, tags: $tags, submission: $submission)';
}


}

/// @nodoc
abstract mixin class $WriteReviewStateCopyWith<$Res>  {
  factory $WriteReviewStateCopyWith(WriteReviewState value, $Res Function(WriteReviewState) _then) = _$WriteReviewStateCopyWithImpl;
@useResult
$Res call({
 String astrologerId, String? consultationId, int rating, String comment, Set<String> tags, LoadState<AstrologerReview> submission
});


$LoadStateCopyWith<AstrologerReview, $Res> get submission;

}
/// @nodoc
class _$WriteReviewStateCopyWithImpl<$Res>
    implements $WriteReviewStateCopyWith<$Res> {
  _$WriteReviewStateCopyWithImpl(this._self, this._then);

  final WriteReviewState _self;
  final $Res Function(WriteReviewState) _then;

/// Create a copy of WriteReviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? astrologerId = null,Object? consultationId = freezed,Object? rating = null,Object? comment = null,Object? tags = null,Object? submission = null,}) {
  return _then(_self.copyWith(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,consultationId: freezed == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as Set<String>,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerReview>,
  ));
}
/// Create a copy of WriteReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerReview, $Res> get submission {
  
  return $LoadStateCopyWith<AstrologerReview, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}



/// @nodoc


class _WriteReviewState extends WriteReviewState {
  const _WriteReviewState({required this.astrologerId, this.consultationId, this.rating = 0, this.comment = '', final  Set<String> tags = const <String>{}, this.submission = const LoadState.idle()}): _tags = tags,super._();
  

@override final  String astrologerId;
@override final  String? consultationId;
@override@JsonKey() final  int rating;
@override@JsonKey() final  String comment;
 final  Set<String> _tags;
@override@JsonKey() Set<String> get tags {
  if (_tags is EqualUnmodifiableSetView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_tags);
}

@override@JsonKey() final  LoadState<AstrologerReview> submission;

/// Create a copy of WriteReviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WriteReviewStateCopyWith<_WriteReviewState> get copyWith => __$WriteReviewStateCopyWithImpl<_WriteReviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WriteReviewState&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.submission, submission) || other.submission == submission));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,consultationId,rating,comment,const DeepCollectionEquality().hash(_tags),submission);

@override
String toString() {
  return 'WriteReviewState(astrologerId: $astrologerId, consultationId: $consultationId, rating: $rating, comment: $comment, tags: $tags, submission: $submission)';
}


}

/// @nodoc
abstract mixin class _$WriteReviewStateCopyWith<$Res> implements $WriteReviewStateCopyWith<$Res> {
  factory _$WriteReviewStateCopyWith(_WriteReviewState value, $Res Function(_WriteReviewState) _then) = __$WriteReviewStateCopyWithImpl;
@override @useResult
$Res call({
 String astrologerId, String? consultationId, int rating, String comment, Set<String> tags, LoadState<AstrologerReview> submission
});


@override $LoadStateCopyWith<AstrologerReview, $Res> get submission;

}
/// @nodoc
class __$WriteReviewStateCopyWithImpl<$Res>
    implements _$WriteReviewStateCopyWith<$Res> {
  __$WriteReviewStateCopyWithImpl(this._self, this._then);

  final _WriteReviewState _self;
  final $Res Function(_WriteReviewState) _then;

/// Create a copy of WriteReviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? astrologerId = null,Object? consultationId = freezed,Object? rating = null,Object? comment = null,Object? tags = null,Object? submission = null,}) {
  return _then(_WriteReviewState(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,consultationId: freezed == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as Set<String>,submission: null == submission ? _self.submission : submission // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerReview>,
  ));
}

/// Create a copy of WriteReviewState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerReview, $Res> get submission {
  
  return $LoadStateCopyWith<AstrologerReview, $Res>(_self.submission, (value) {
    return _then(_self.copyWith(submission: value));
  });
}
}

// dart format on
