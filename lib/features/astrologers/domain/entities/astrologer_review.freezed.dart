// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AstrologerReview {

 String get id; String get astrologerId; String get authorName; int get rating; String get comment; DateTime get createdAt; String? get authorAvatar;/// Short tags picked during review submission ("Accurate", "Patient").
 List<String> get tags;/// The astrologer's public reply, when they have answered.
 String? get reply; DateTime? get repliedAt;/// Set when the review is attached to a completed consultation.
 String? get consultationId;
/// Create a copy of AstrologerReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerReviewCopyWith<AstrologerReview> get copyWith => _$AstrologerReviewCopyWithImpl<AstrologerReview>(this as AstrologerReview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerReview&&(identical(other.id, id) || other.id == id)&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.repliedAt, repliedAt) || other.repliedAt == repliedAt)&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId));
}


@override
int get hashCode => Object.hash(runtimeType,id,astrologerId,authorName,rating,comment,createdAt,authorAvatar,const DeepCollectionEquality().hash(tags),reply,repliedAt,consultationId);

@override
String toString() {
  return 'AstrologerReview(id: $id, astrologerId: $astrologerId, authorName: $authorName, rating: $rating, comment: $comment, createdAt: $createdAt, authorAvatar: $authorAvatar, tags: $tags, reply: $reply, repliedAt: $repliedAt, consultationId: $consultationId)';
}


}

/// @nodoc
abstract mixin class $AstrologerReviewCopyWith<$Res>  {
  factory $AstrologerReviewCopyWith(AstrologerReview value, $Res Function(AstrologerReview) _then) = _$AstrologerReviewCopyWithImpl;
@useResult
$Res call({
 String id, String astrologerId, String authorName, int rating, String comment, DateTime createdAt, String? authorAvatar, List<String> tags, String? reply, DateTime? repliedAt, String? consultationId
});




}
/// @nodoc
class _$AstrologerReviewCopyWithImpl<$Res>
    implements $AstrologerReviewCopyWith<$Res> {
  _$AstrologerReviewCopyWithImpl(this._self, this._then);

  final AstrologerReview _self;
  final $Res Function(AstrologerReview) _then;

/// Create a copy of AstrologerReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? astrologerId = null,Object? authorName = null,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? authorAvatar = freezed,Object? tags = null,Object? reply = freezed,Object? repliedAt = freezed,Object? consultationId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,authorAvatar: freezed == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String?,repliedAt: freezed == repliedAt ? _self.repliedAt : repliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,consultationId: freezed == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _AstrologerReview extends AstrologerReview {
  const _AstrologerReview({required this.id, required this.astrologerId, required this.authorName, required this.rating, required this.comment, required this.createdAt, this.authorAvatar, final  List<String> tags = const [], this.reply, this.repliedAt, this.consultationId}): _tags = tags,super._();
  

@override final  String id;
@override final  String astrologerId;
@override final  String authorName;
@override final  int rating;
@override final  String comment;
@override final  DateTime createdAt;
@override final  String? authorAvatar;
/// Short tags picked during review submission ("Accurate", "Patient").
 final  List<String> _tags;
/// Short tags picked during review submission ("Accurate", "Patient").
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// The astrologer's public reply, when they have answered.
@override final  String? reply;
@override final  DateTime? repliedAt;
/// Set when the review is attached to a completed consultation.
@override final  String? consultationId;

/// Create a copy of AstrologerReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerReviewCopyWith<_AstrologerReview> get copyWith => __$AstrologerReviewCopyWithImpl<_AstrologerReview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerReview&&(identical(other.id, id) || other.id == id)&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.repliedAt, repliedAt) || other.repliedAt == repliedAt)&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId));
}


@override
int get hashCode => Object.hash(runtimeType,id,astrologerId,authorName,rating,comment,createdAt,authorAvatar,const DeepCollectionEquality().hash(_tags),reply,repliedAt,consultationId);

@override
String toString() {
  return 'AstrologerReview(id: $id, astrologerId: $astrologerId, authorName: $authorName, rating: $rating, comment: $comment, createdAt: $createdAt, authorAvatar: $authorAvatar, tags: $tags, reply: $reply, repliedAt: $repliedAt, consultationId: $consultationId)';
}


}

/// @nodoc
abstract mixin class _$AstrologerReviewCopyWith<$Res> implements $AstrologerReviewCopyWith<$Res> {
  factory _$AstrologerReviewCopyWith(_AstrologerReview value, $Res Function(_AstrologerReview) _then) = __$AstrologerReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String astrologerId, String authorName, int rating, String comment, DateTime createdAt, String? authorAvatar, List<String> tags, String? reply, DateTime? repliedAt, String? consultationId
});




}
/// @nodoc
class __$AstrologerReviewCopyWithImpl<$Res>
    implements _$AstrologerReviewCopyWith<$Res> {
  __$AstrologerReviewCopyWithImpl(this._self, this._then);

  final _AstrologerReview _self;
  final $Res Function(_AstrologerReview) _then;

/// Create a copy of AstrologerReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? astrologerId = null,Object? authorName = null,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? authorAvatar = freezed,Object? tags = null,Object? reply = freezed,Object? repliedAt = freezed,Object? consultationId = freezed,}) {
  return _then(_AstrologerReview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,authorAvatar: freezed == authorAvatar ? _self.authorAvatar : authorAvatar // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String?,repliedAt: freezed == repliedAt ? _self.repliedAt : repliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,consultationId: freezed == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ReviewDraft {

 String get astrologerId; int get rating; String get comment; List<String> get tags; String? get consultationId;
/// Create a copy of ReviewDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewDraftCopyWith<ReviewDraft> get copyWith => _$ReviewDraftCopyWithImpl<ReviewDraft>(this as ReviewDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewDraft&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,rating,comment,const DeepCollectionEquality().hash(tags),consultationId);

@override
String toString() {
  return 'ReviewDraft(astrologerId: $astrologerId, rating: $rating, comment: $comment, tags: $tags, consultationId: $consultationId)';
}


}

/// @nodoc
abstract mixin class $ReviewDraftCopyWith<$Res>  {
  factory $ReviewDraftCopyWith(ReviewDraft value, $Res Function(ReviewDraft) _then) = _$ReviewDraftCopyWithImpl;
@useResult
$Res call({
 String astrologerId, int rating, String comment, List<String> tags, String? consultationId
});




}
/// @nodoc
class _$ReviewDraftCopyWithImpl<$Res>
    implements $ReviewDraftCopyWith<$Res> {
  _$ReviewDraftCopyWithImpl(this._self, this._then);

  final ReviewDraft _self;
  final $Res Function(ReviewDraft) _then;

/// Create a copy of ReviewDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? astrologerId = null,Object? rating = null,Object? comment = null,Object? tags = null,Object? consultationId = freezed,}) {
  return _then(_self.copyWith(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,consultationId: freezed == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _ReviewDraft implements ReviewDraft {
  const _ReviewDraft({required this.astrologerId, required this.rating, this.comment = '', final  List<String> tags = const [], this.consultationId}): _tags = tags;
  

@override final  String astrologerId;
@override final  int rating;
@override@JsonKey() final  String comment;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? consultationId;

/// Create a copy of ReviewDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewDraftCopyWith<_ReviewDraft> get copyWith => __$ReviewDraftCopyWithImpl<_ReviewDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewDraft&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,rating,comment,const DeepCollectionEquality().hash(_tags),consultationId);

@override
String toString() {
  return 'ReviewDraft(astrologerId: $astrologerId, rating: $rating, comment: $comment, tags: $tags, consultationId: $consultationId)';
}


}

/// @nodoc
abstract mixin class _$ReviewDraftCopyWith<$Res> implements $ReviewDraftCopyWith<$Res> {
  factory _$ReviewDraftCopyWith(_ReviewDraft value, $Res Function(_ReviewDraft) _then) = __$ReviewDraftCopyWithImpl;
@override @useResult
$Res call({
 String astrologerId, int rating, String comment, List<String> tags, String? consultationId
});




}
/// @nodoc
class __$ReviewDraftCopyWithImpl<$Res>
    implements _$ReviewDraftCopyWith<$Res> {
  __$ReviewDraftCopyWithImpl(this._self, this._then);

  final _ReviewDraft _self;
  final $Res Function(_ReviewDraft) _then;

/// Create a copy of ReviewDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? astrologerId = null,Object? rating = null,Object? comment = null,Object? tags = null,Object? consultationId = freezed,}) {
  return _then(_ReviewDraft(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,consultationId: freezed == consultationId ? _self.consultationId : consultationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ReportDraft {

 String get astrologerId; ReportReason get reason; String get details; bool get alsoBlock;
/// Create a copy of ReportDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportDraftCopyWith<ReportDraft> get copyWith => _$ReportDraftCopyWithImpl<ReportDraft>(this as ReportDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportDraft&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details)&&(identical(other.alsoBlock, alsoBlock) || other.alsoBlock == alsoBlock));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,reason,details,alsoBlock);

@override
String toString() {
  return 'ReportDraft(astrologerId: $astrologerId, reason: $reason, details: $details, alsoBlock: $alsoBlock)';
}


}

/// @nodoc
abstract mixin class $ReportDraftCopyWith<$Res>  {
  factory $ReportDraftCopyWith(ReportDraft value, $Res Function(ReportDraft) _then) = _$ReportDraftCopyWithImpl;
@useResult
$Res call({
 String astrologerId, ReportReason reason, String details, bool alsoBlock
});




}
/// @nodoc
class _$ReportDraftCopyWithImpl<$Res>
    implements $ReportDraftCopyWith<$Res> {
  _$ReportDraftCopyWithImpl(this._self, this._then);

  final ReportDraft _self;
  final $Res Function(ReportDraft) _then;

/// Create a copy of ReportDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? astrologerId = null,Object? reason = null,Object? details = null,Object? alsoBlock = null,}) {
  return _then(_self.copyWith(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReportReason,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,alsoBlock: null == alsoBlock ? _self.alsoBlock : alsoBlock // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _ReportDraft implements ReportDraft {
  const _ReportDraft({required this.astrologerId, required this.reason, this.details = '', this.alsoBlock = false});
  

@override final  String astrologerId;
@override final  ReportReason reason;
@override@JsonKey() final  String details;
@override@JsonKey() final  bool alsoBlock;

/// Create a copy of ReportDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportDraftCopyWith<_ReportDraft> get copyWith => __$ReportDraftCopyWithImpl<_ReportDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportDraft&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.details, details) || other.details == details)&&(identical(other.alsoBlock, alsoBlock) || other.alsoBlock == alsoBlock));
}


@override
int get hashCode => Object.hash(runtimeType,astrologerId,reason,details,alsoBlock);

@override
String toString() {
  return 'ReportDraft(astrologerId: $astrologerId, reason: $reason, details: $details, alsoBlock: $alsoBlock)';
}


}

/// @nodoc
abstract mixin class _$ReportDraftCopyWith<$Res> implements $ReportDraftCopyWith<$Res> {
  factory _$ReportDraftCopyWith(_ReportDraft value, $Res Function(_ReportDraft) _then) = __$ReportDraftCopyWithImpl;
@override @useResult
$Res call({
 String astrologerId, ReportReason reason, String details, bool alsoBlock
});




}
/// @nodoc
class __$ReportDraftCopyWithImpl<$Res>
    implements _$ReportDraftCopyWith<$Res> {
  __$ReportDraftCopyWithImpl(this._self, this._then);

  final _ReportDraft _self;
  final $Res Function(_ReportDraft) _then;

/// Create a copy of ReportDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? astrologerId = null,Object? reason = null,Object? details = null,Object? alsoBlock = null,}) {
  return _then(_ReportDraft(
astrologerId: null == astrologerId ? _self.astrologerId : astrologerId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ReportReason,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,alsoBlock: null == alsoBlock ? _self.alsoBlock : alsoBlock // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
