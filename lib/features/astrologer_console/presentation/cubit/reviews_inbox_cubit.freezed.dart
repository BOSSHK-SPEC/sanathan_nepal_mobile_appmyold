// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reviews_inbox_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReviewsInboxState {

 LoadState<List<AstrologerReview>> get reviews; LoadState<AstrologerReview> get replying; ReviewFilter get filter;
/// Create a copy of ReviewsInboxState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewsInboxStateCopyWith<ReviewsInboxState> get copyWith => _$ReviewsInboxStateCopyWithImpl<ReviewsInboxState>(this as ReviewsInboxState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewsInboxState&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.replying, replying) || other.replying == replying)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,reviews,replying,filter);

@override
String toString() {
  return 'ReviewsInboxState(reviews: $reviews, replying: $replying, filter: $filter)';
}


}

/// @nodoc
abstract mixin class $ReviewsInboxStateCopyWith<$Res>  {
  factory $ReviewsInboxStateCopyWith(ReviewsInboxState value, $Res Function(ReviewsInboxState) _then) = _$ReviewsInboxStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<AstrologerReview>> reviews, LoadState<AstrologerReview> replying, ReviewFilter filter
});


$LoadStateCopyWith<List<AstrologerReview>, $Res> get reviews;$LoadStateCopyWith<AstrologerReview, $Res> get replying;

}
/// @nodoc
class _$ReviewsInboxStateCopyWithImpl<$Res>
    implements $ReviewsInboxStateCopyWith<$Res> {
  _$ReviewsInboxStateCopyWithImpl(this._self, this._then);

  final ReviewsInboxState _self;
  final $Res Function(ReviewsInboxState) _then;

/// Create a copy of ReviewsInboxState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reviews = null,Object? replying = null,Object? filter = null,}) {
  return _then(_self.copyWith(
reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as LoadState<List<AstrologerReview>>,replying: null == replying ? _self.replying : replying // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerReview>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ReviewFilter,
  ));
}
/// Create a copy of ReviewsInboxState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AstrologerReview>, $Res> get reviews {
  
  return $LoadStateCopyWith<List<AstrologerReview>, $Res>(_self.reviews, (value) {
    return _then(_self.copyWith(reviews: value));
  });
}/// Create a copy of ReviewsInboxState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerReview, $Res> get replying {
  
  return $LoadStateCopyWith<AstrologerReview, $Res>(_self.replying, (value) {
    return _then(_self.copyWith(replying: value));
  });
}
}



/// @nodoc


class _ReviewsInboxState extends ReviewsInboxState {
  const _ReviewsInboxState({this.reviews = const LoadState.idle(), this.replying = const LoadState.idle(), this.filter = ReviewFilter.needsReply}): super._();
  

@override@JsonKey() final  LoadState<List<AstrologerReview>> reviews;
@override@JsonKey() final  LoadState<AstrologerReview> replying;
@override@JsonKey() final  ReviewFilter filter;

/// Create a copy of ReviewsInboxState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewsInboxStateCopyWith<_ReviewsInboxState> get copyWith => __$ReviewsInboxStateCopyWithImpl<_ReviewsInboxState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewsInboxState&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.replying, replying) || other.replying == replying)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,reviews,replying,filter);

@override
String toString() {
  return 'ReviewsInboxState(reviews: $reviews, replying: $replying, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$ReviewsInboxStateCopyWith<$Res> implements $ReviewsInboxStateCopyWith<$Res> {
  factory _$ReviewsInboxStateCopyWith(_ReviewsInboxState value, $Res Function(_ReviewsInboxState) _then) = __$ReviewsInboxStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<AstrologerReview>> reviews, LoadState<AstrologerReview> replying, ReviewFilter filter
});


@override $LoadStateCopyWith<List<AstrologerReview>, $Res> get reviews;@override $LoadStateCopyWith<AstrologerReview, $Res> get replying;

}
/// @nodoc
class __$ReviewsInboxStateCopyWithImpl<$Res>
    implements _$ReviewsInboxStateCopyWith<$Res> {
  __$ReviewsInboxStateCopyWithImpl(this._self, this._then);

  final _ReviewsInboxState _self;
  final $Res Function(_ReviewsInboxState) _then;

/// Create a copy of ReviewsInboxState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reviews = null,Object? replying = null,Object? filter = null,}) {
  return _then(_ReviewsInboxState(
reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as LoadState<List<AstrologerReview>>,replying: null == replying ? _self.replying : replying // ignore: cast_nullable_to_non_nullable
as LoadState<AstrologerReview>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ReviewFilter,
  ));
}

/// Create a copy of ReviewsInboxState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<AstrologerReview>, $Res> get reviews {
  
  return $LoadStateCopyWith<List<AstrologerReview>, $Res>(_self.reviews, (value) {
    return _then(_self.copyWith(reviews: value));
  });
}/// Create a copy of ReviewsInboxState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<AstrologerReview, $Res> get replying {
  
  return $LoadStateCopyWith<AstrologerReview, $Res>(_self.replying, (value) {
    return _then(_self.copyWith(replying: value));
  });
}
}

// dart format on
