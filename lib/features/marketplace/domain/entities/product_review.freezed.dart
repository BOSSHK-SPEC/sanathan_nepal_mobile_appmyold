// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductReview {

 String get id; String get productId; String get authorName;/// 1–5.
 int get rating; String get comment; DateTime get createdAt; String? get authorAvatar;/// The order this review came from. Its presence is what makes the
/// review "verified" — never a flag someone can set independently.
 String? get orderId;/// Photos the buyer attached.
 List<String> get photos;/// The seller's public reply, when they have answered.
 String? get sellerReply; DateTime? get repliedAt;/// Buyers marking the review useful. Drives the "most helpful" ordering.
 int get helpfulCount; bool get markedHelpful;
/// Create a copy of ProductReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductReviewCopyWith<ProductReview> get copyWith => _$ProductReviewCopyWithImpl<ProductReview>(this as ProductReview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductReview&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.sellerReply, sellerReply) || other.sellerReply == sellerReply)&&(identical(other.repliedAt, repliedAt) || other.repliedAt == repliedAt)&&(identical(other.helpfulCount, helpfulCount) || other.helpfulCount == helpfulCount)&&(identical(other.markedHelpful, markedHelpful) || other.markedHelpful == markedHelpful));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,authorName,rating,comment,createdAt,authorAvatar,orderId,const DeepCollectionEquality().hash(photos),sellerReply,repliedAt,helpfulCount,markedHelpful);

@override
String toString() {
  return 'ProductReview(id: $id, productId: $productId, authorName: $authorName, rating: $rating, comment: $comment, createdAt: $createdAt, authorAvatar: $authorAvatar, orderId: $orderId, photos: $photos, sellerReply: $sellerReply, repliedAt: $repliedAt, helpfulCount: $helpfulCount, markedHelpful: $markedHelpful)';
}


}

/// @nodoc
abstract mixin class $ProductReviewCopyWith<$Res>  {
  factory $ProductReviewCopyWith(ProductReview value, $Res Function(ProductReview) _then) = _$ProductReviewCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String authorName, int rating, String comment, DateTime createdAt, String? authorAvatar, String? orderId, List<String> photos, String? sellerReply, DateTime? repliedAt, int helpfulCount, bool markedHelpful
});




}
/// @nodoc
class _$ProductReviewCopyWithImpl<$Res>
    implements $ProductReviewCopyWith<$Res> {
  _$ProductReviewCopyWithImpl(this._self, this._then);

  final ProductReview _self;
  final $Res Function(ProductReview) _then;

/// Create a copy of ProductReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? authorName = null,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? authorAvatar = freezed,Object? orderId = freezed,Object? photos = null,Object? sellerReply = freezed,Object? repliedAt = freezed,Object? helpfulCount = null,Object? markedHelpful = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,authorAvatar: freezed == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String?,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,sellerReply: freezed == sellerReply ? _self.sellerReply : sellerReply // ignore: cast_nullable_to_non_nullable
as String?,repliedAt: freezed == repliedAt ? _self.repliedAt : repliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,helpfulCount: null == helpfulCount ? _self.helpfulCount : helpfulCount // ignore: cast_nullable_to_non_nullable
as int,markedHelpful: null == markedHelpful ? _self.markedHelpful : markedHelpful // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _ProductReview extends ProductReview {
  const _ProductReview({required this.id, required this.productId, required this.authorName, required this.rating, required this.comment, required this.createdAt, this.authorAvatar, this.orderId, final  List<String> photos = const <String>[], this.sellerReply, this.repliedAt, this.helpfulCount = 0, this.markedHelpful = false}): _photos = photos,super._();
  

@override final  String id;
@override final  String productId;
@override final  String authorName;
/// 1–5.
@override final  int rating;
@override final  String comment;
@override final  DateTime createdAt;
@override final  String? authorAvatar;
/// The order this review came from. Its presence is what makes the
/// review "verified" — never a flag someone can set independently.
@override final  String? orderId;
/// Photos the buyer attached.
 final  List<String> _photos;
/// Photos the buyer attached.
@override@JsonKey() List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

/// The seller's public reply, when they have answered.
@override final  String? sellerReply;
@override final  DateTime? repliedAt;
/// Buyers marking the review useful. Drives the "most helpful" ordering.
@override@JsonKey() final  int helpfulCount;
@override@JsonKey() final  bool markedHelpful;

/// Create a copy of ProductReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductReviewCopyWith<_ProductReview> get copyWith => __$ProductReviewCopyWithImpl<_ProductReview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductReview&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.sellerReply, sellerReply) || other.sellerReply == sellerReply)&&(identical(other.repliedAt, repliedAt) || other.repliedAt == repliedAt)&&(identical(other.helpfulCount, helpfulCount) || other.helpfulCount == helpfulCount)&&(identical(other.markedHelpful, markedHelpful) || other.markedHelpful == markedHelpful));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,authorName,rating,comment,createdAt,authorAvatar,orderId,const DeepCollectionEquality().hash(_photos),sellerReply,repliedAt,helpfulCount,markedHelpful);

@override
String toString() {
  return 'ProductReview(id: $id, productId: $productId, authorName: $authorName, rating: $rating, comment: $comment, createdAt: $createdAt, authorAvatar: $authorAvatar, orderId: $orderId, photos: $photos, sellerReply: $sellerReply, repliedAt: $repliedAt, helpfulCount: $helpfulCount, markedHelpful: $markedHelpful)';
}


}

/// @nodoc
abstract mixin class _$ProductReviewCopyWith<$Res> implements $ProductReviewCopyWith<$Res> {
  factory _$ProductReviewCopyWith(_ProductReview value, $Res Function(_ProductReview) _then) = __$ProductReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String authorName, int rating, String comment, DateTime createdAt, String? authorAvatar, String? orderId, List<String> photos, String? sellerReply, DateTime? repliedAt, int helpfulCount, bool markedHelpful
});




}
/// @nodoc
class __$ProductReviewCopyWithImpl<$Res>
    implements _$ProductReviewCopyWith<$Res> {
  __$ProductReviewCopyWithImpl(this._self, this._then);

  final _ProductReview _self;
  final $Res Function(_ProductReview) _then;

/// Create a copy of ProductReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? authorName = null,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? authorAvatar = freezed,Object? orderId = freezed,Object? photos = null,Object? sellerReply = freezed,Object? repliedAt = freezed,Object? helpfulCount = null,Object? markedHelpful = null,}) {
  return _then(_ProductReview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,authorAvatar: freezed == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String?,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,sellerReply: freezed == sellerReply ? _self.sellerReply : sellerReply // ignore: cast_nullable_to_non_nullable
as String?,repliedAt: freezed == repliedAt ? _self.repliedAt : repliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,helpfulCount: null == helpfulCount ? _self.helpfulCount : helpfulCount // ignore: cast_nullable_to_non_nullable
as int,markedHelpful: null == markedHelpful ? _self.markedHelpful : markedHelpful // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ProductReviewDraft {

 String get productId; int get rating; String get comment; List<String> get photos;/// Set when the review is written from a delivered order.
 String? get orderId;
/// Create a copy of ProductReviewDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductReviewDraftCopyWith<ProductReviewDraft> get copyWith => _$ProductReviewDraftCopyWithImpl<ProductReviewDraft>(this as ProductReviewDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductReviewDraft&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,productId,rating,comment,const DeepCollectionEquality().hash(photos),orderId);

@override
String toString() {
  return 'ProductReviewDraft(productId: $productId, rating: $rating, comment: $comment, photos: $photos, orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $ProductReviewDraftCopyWith<$Res>  {
  factory $ProductReviewDraftCopyWith(ProductReviewDraft value, $Res Function(ProductReviewDraft) _then) = _$ProductReviewDraftCopyWithImpl;
@useResult
$Res call({
 String productId, int rating, String comment, List<String> photos, String? orderId
});




}
/// @nodoc
class _$ProductReviewDraftCopyWithImpl<$Res>
    implements $ProductReviewDraftCopyWith<$Res> {
  _$ProductReviewDraftCopyWithImpl(this._self, this._then);

  final ProductReviewDraft _self;
  final $Res Function(ProductReviewDraft) _then;

/// Create a copy of ProductReviewDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? rating = null,Object? comment = null,Object? photos = null,Object? orderId = freezed,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _ProductReviewDraft extends ProductReviewDraft {
  const _ProductReviewDraft({required this.productId, this.rating = 0, this.comment = '', final  List<String> photos = const <String>[], this.orderId}): _photos = photos,super._();
  

@override final  String productId;
@override@JsonKey() final  int rating;
@override@JsonKey() final  String comment;
 final  List<String> _photos;
@override@JsonKey() List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

/// Set when the review is written from a delivered order.
@override final  String? orderId;

/// Create a copy of ProductReviewDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductReviewDraftCopyWith<_ProductReviewDraft> get copyWith => __$ProductReviewDraftCopyWithImpl<_ProductReviewDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductReviewDraft&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,productId,rating,comment,const DeepCollectionEquality().hash(_photos),orderId);

@override
String toString() {
  return 'ProductReviewDraft(productId: $productId, rating: $rating, comment: $comment, photos: $photos, orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class _$ProductReviewDraftCopyWith<$Res> implements $ProductReviewDraftCopyWith<$Res> {
  factory _$ProductReviewDraftCopyWith(_ProductReviewDraft value, $Res Function(_ProductReviewDraft) _then) = __$ProductReviewDraftCopyWithImpl;
@override @useResult
$Res call({
 String productId, int rating, String comment, List<String> photos, String? orderId
});




}
/// @nodoc
class __$ProductReviewDraftCopyWithImpl<$Res>
    implements _$ProductReviewDraftCopyWith<$Res> {
  __$ProductReviewDraftCopyWithImpl(this._self, this._then);

  final _ProductReviewDraft _self;
  final $Res Function(_ProductReviewDraft) _then;

/// Create a copy of ProductReviewDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? rating = null,Object? comment = null,Object? photos = null,Object? orderId = freezed,}) {
  return _then(_ProductReviewDraft(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ProductRatingSummary {

 double get average; int get total;/// Count per star, keyed 1–5.
 Map<int, int> get distribution; int get verifiedCount; int get withPhotos;
/// Create a copy of ProductRatingSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductRatingSummaryCopyWith<ProductRatingSummary> get copyWith => _$ProductRatingSummaryCopyWithImpl<ProductRatingSummary>(this as ProductRatingSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductRatingSummary&&(identical(other.average, average) || other.average == average)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.distribution, distribution)&&(identical(other.verifiedCount, verifiedCount) || other.verifiedCount == verifiedCount)&&(identical(other.withPhotos, withPhotos) || other.withPhotos == withPhotos));
}


@override
int get hashCode => Object.hash(runtimeType,average,total,const DeepCollectionEquality().hash(distribution),verifiedCount,withPhotos);

@override
String toString() {
  return 'ProductRatingSummary(average: $average, total: $total, distribution: $distribution, verifiedCount: $verifiedCount, withPhotos: $withPhotos)';
}


}

/// @nodoc
abstract mixin class $ProductRatingSummaryCopyWith<$Res>  {
  factory $ProductRatingSummaryCopyWith(ProductRatingSummary value, $Res Function(ProductRatingSummary) _then) = _$ProductRatingSummaryCopyWithImpl;
@useResult
$Res call({
 double average, int total, Map<int, int> distribution, int verifiedCount, int withPhotos
});




}
/// @nodoc
class _$ProductRatingSummaryCopyWithImpl<$Res>
    implements $ProductRatingSummaryCopyWith<$Res> {
  _$ProductRatingSummaryCopyWithImpl(this._self, this._then);

  final ProductRatingSummary _self;
  final $Res Function(ProductRatingSummary) _then;

/// Create a copy of ProductRatingSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? average = null,Object? total = null,Object? distribution = null,Object? verifiedCount = null,Object? withPhotos = null,}) {
  return _then(_self.copyWith(
average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,distribution: null == distribution ? _self.distribution : distribution // ignore: cast_nullable_to_non_nullable
as Map<int, int>,verifiedCount: null == verifiedCount ? _self.verifiedCount : verifiedCount // ignore: cast_nullable_to_non_nullable
as int,withPhotos: null == withPhotos ? _self.withPhotos : withPhotos // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class _ProductRatingSummary extends ProductRatingSummary {
  const _ProductRatingSummary({this.average = 0, this.total = 0, final  Map<int, int> distribution = const <int, int>{}, this.verifiedCount = 0, this.withPhotos = 0}): _distribution = distribution,super._();
  

@override@JsonKey() final  double average;
@override@JsonKey() final  int total;
/// Count per star, keyed 1–5.
 final  Map<int, int> _distribution;
/// Count per star, keyed 1–5.
@override@JsonKey() Map<int, int> get distribution {
  if (_distribution is EqualUnmodifiableMapView) return _distribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_distribution);
}

@override@JsonKey() final  int verifiedCount;
@override@JsonKey() final  int withPhotos;

/// Create a copy of ProductRatingSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductRatingSummaryCopyWith<_ProductRatingSummary> get copyWith => __$ProductRatingSummaryCopyWithImpl<_ProductRatingSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductRatingSummary&&(identical(other.average, average) || other.average == average)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._distribution, _distribution)&&(identical(other.verifiedCount, verifiedCount) || other.verifiedCount == verifiedCount)&&(identical(other.withPhotos, withPhotos) || other.withPhotos == withPhotos));
}


@override
int get hashCode => Object.hash(runtimeType,average,total,const DeepCollectionEquality().hash(_distribution),verifiedCount,withPhotos);

@override
String toString() {
  return 'ProductRatingSummary(average: $average, total: $total, distribution: $distribution, verifiedCount: $verifiedCount, withPhotos: $withPhotos)';
}


}

/// @nodoc
abstract mixin class _$ProductRatingSummaryCopyWith<$Res> implements $ProductRatingSummaryCopyWith<$Res> {
  factory _$ProductRatingSummaryCopyWith(_ProductRatingSummary value, $Res Function(_ProductRatingSummary) _then) = __$ProductRatingSummaryCopyWithImpl;
@override @useResult
$Res call({
 double average, int total, Map<int, int> distribution, int verifiedCount, int withPhotos
});




}
/// @nodoc
class __$ProductRatingSummaryCopyWithImpl<$Res>
    implements _$ProductRatingSummaryCopyWith<$Res> {
  __$ProductRatingSummaryCopyWithImpl(this._self, this._then);

  final _ProductRatingSummary _self;
  final $Res Function(_ProductRatingSummary) _then;

/// Create a copy of ProductRatingSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? average = null,Object? total = null,Object? distribution = null,Object? verifiedCount = null,Object? withPhotos = null,}) {
  return _then(_ProductRatingSummary(
average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,distribution: null == distribution ? _self._distribution : distribution // ignore: cast_nullable_to_non_nullable
as Map<int, int>,verifiedCount: null == verifiedCount ? _self.verifiedCount : verifiedCount // ignore: cast_nullable_to_non_nullable
as int,withPhotos: null == withPhotos ? _self.withPhotos : withPhotos // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
