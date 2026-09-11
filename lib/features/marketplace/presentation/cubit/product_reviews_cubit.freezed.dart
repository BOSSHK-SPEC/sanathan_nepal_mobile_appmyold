// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_reviews_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductReviewsState {

 LoadState<List<ProductReview>> get reviews; LoadState<ProductRatingSummary> get summary; ReviewSort get sort; bool get withPhotosOnly; int? get minRating; String? get busyReviewId; String? get actionError;
/// Create a copy of ProductReviewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductReviewsStateCopyWith<ProductReviewsState> get copyWith => _$ProductReviewsStateCopyWithImpl<ProductReviewsState>(this as ProductReviewsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductReviewsState&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.withPhotosOnly, withPhotosOnly) || other.withPhotosOnly == withPhotosOnly)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.busyReviewId, busyReviewId) || other.busyReviewId == busyReviewId)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,reviews,summary,sort,withPhotosOnly,minRating,busyReviewId,actionError);

@override
String toString() {
  return 'ProductReviewsState(reviews: $reviews, summary: $summary, sort: $sort, withPhotosOnly: $withPhotosOnly, minRating: $minRating, busyReviewId: $busyReviewId, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $ProductReviewsStateCopyWith<$Res>  {
  factory $ProductReviewsStateCopyWith(ProductReviewsState value, $Res Function(ProductReviewsState) _then) = _$ProductReviewsStateCopyWithImpl;
@useResult
$Res call({
 LoadState<List<ProductReview>> reviews, LoadState<ProductRatingSummary> summary, ReviewSort sort, bool withPhotosOnly, int? minRating, String? busyReviewId, String? actionError
});


$LoadStateCopyWith<List<ProductReview>, $Res> get reviews;$LoadStateCopyWith<ProductRatingSummary, $Res> get summary;

}
/// @nodoc
class _$ProductReviewsStateCopyWithImpl<$Res>
    implements $ProductReviewsStateCopyWith<$Res> {
  _$ProductReviewsStateCopyWithImpl(this._self, this._then);

  final ProductReviewsState _self;
  final $Res Function(ProductReviewsState) _then;

/// Create a copy of ProductReviewsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reviews = null,Object? summary = null,Object? sort = null,Object? withPhotosOnly = null,Object? minRating = freezed,Object? busyReviewId = freezed,Object? actionError = freezed,}) {
  return _then(_self.copyWith(
reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as LoadState<List<ProductReview>>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LoadState<ProductRatingSummary>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ReviewSort,withPhotosOnly: null == withPhotosOnly ? _self.withPhotosOnly : withPhotosOnly // ignore: cast_nullable_to_non_nullable
as bool,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as int?,busyReviewId: freezed == busyReviewId ? _self.busyReviewId : busyReviewId // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProductReviewsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ProductReview>, $Res> get reviews {
  
  return $LoadStateCopyWith<List<ProductReview>, $Res>(_self.reviews, (value) {
    return _then(_self.copyWith(reviews: value));
  });
}/// Create a copy of ProductReviewsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ProductRatingSummary, $Res> get summary {
  
  return $LoadStateCopyWith<ProductRatingSummary, $Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}



/// @nodoc


class _ProductReviewsState extends ProductReviewsState {
  const _ProductReviewsState({this.reviews = const LoadState.idle(), this.summary = const LoadState.idle(), this.sort = ReviewSort.recent, this.withPhotosOnly = false, this.minRating, this.busyReviewId, this.actionError}): super._();
  

@override@JsonKey() final  LoadState<List<ProductReview>> reviews;
@override@JsonKey() final  LoadState<ProductRatingSummary> summary;
@override@JsonKey() final  ReviewSort sort;
@override@JsonKey() final  bool withPhotosOnly;
@override final  int? minRating;
@override final  String? busyReviewId;
@override final  String? actionError;

/// Create a copy of ProductReviewsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductReviewsStateCopyWith<_ProductReviewsState> get copyWith => __$ProductReviewsStateCopyWithImpl<_ProductReviewsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductReviewsState&&(identical(other.reviews, reviews) || other.reviews == reviews)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.withPhotosOnly, withPhotosOnly) || other.withPhotosOnly == withPhotosOnly)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.busyReviewId, busyReviewId) || other.busyReviewId == busyReviewId)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,reviews,summary,sort,withPhotosOnly,minRating,busyReviewId,actionError);

@override
String toString() {
  return 'ProductReviewsState(reviews: $reviews, summary: $summary, sort: $sort, withPhotosOnly: $withPhotosOnly, minRating: $minRating, busyReviewId: $busyReviewId, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class _$ProductReviewsStateCopyWith<$Res> implements $ProductReviewsStateCopyWith<$Res> {
  factory _$ProductReviewsStateCopyWith(_ProductReviewsState value, $Res Function(_ProductReviewsState) _then) = __$ProductReviewsStateCopyWithImpl;
@override @useResult
$Res call({
 LoadState<List<ProductReview>> reviews, LoadState<ProductRatingSummary> summary, ReviewSort sort, bool withPhotosOnly, int? minRating, String? busyReviewId, String? actionError
});


@override $LoadStateCopyWith<List<ProductReview>, $Res> get reviews;@override $LoadStateCopyWith<ProductRatingSummary, $Res> get summary;

}
/// @nodoc
class __$ProductReviewsStateCopyWithImpl<$Res>
    implements _$ProductReviewsStateCopyWith<$Res> {
  __$ProductReviewsStateCopyWithImpl(this._self, this._then);

  final _ProductReviewsState _self;
  final $Res Function(_ProductReviewsState) _then;

/// Create a copy of ProductReviewsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reviews = null,Object? summary = null,Object? sort = null,Object? withPhotosOnly = null,Object? minRating = freezed,Object? busyReviewId = freezed,Object? actionError = freezed,}) {
  return _then(_ProductReviewsState(
reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as LoadState<List<ProductReview>>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LoadState<ProductRatingSummary>,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ReviewSort,withPhotosOnly: null == withPhotosOnly ? _self.withPhotosOnly : withPhotosOnly // ignore: cast_nullable_to_non_nullable
as bool,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as int?,busyReviewId: freezed == busyReviewId ? _self.busyReviewId : busyReviewId // ignore: cast_nullable_to_non_nullable
as String?,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProductReviewsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<List<ProductReview>, $Res> get reviews {
  
  return $LoadStateCopyWith<List<ProductReview>, $Res>(_self.reviews, (value) {
    return _then(_self.copyWith(reviews: value));
  });
}/// Create a copy of ProductReviewsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadStateCopyWith<ProductRatingSummary, $Res> get summary {
  
  return $LoadStateCopyWith<ProductRatingSummary, $Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
