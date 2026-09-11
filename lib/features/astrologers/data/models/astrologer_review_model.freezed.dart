// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'astrologer_review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AstrologerReviewModel {

 String get id; String get astrologerId; String get authorName; int get rating; String get comment; DateTime get createdAt; String? get authorAvatar; List<String> get tags; String? get reply; DateTime? get repliedAt; String? get consultationId;
/// Create a copy of AstrologerReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AstrologerReviewModelCopyWith<AstrologerReviewModel> get copyWith => _$AstrologerReviewModelCopyWithImpl<AstrologerReviewModel>(this as AstrologerReviewModel, _$identity);

  /// Serializes this AstrologerReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AstrologerReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.repliedAt, repliedAt) || other.repliedAt == repliedAt)&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,astrologerId,authorName,rating,comment,createdAt,authorAvatar,const DeepCollectionEquality().hash(tags),reply,repliedAt,consultationId);

@override
String toString() {
  return 'AstrologerReviewModel(id: $id, astrologerId: $astrologerId, authorName: $authorName, rating: $rating, comment: $comment, createdAt: $createdAt, authorAvatar: $authorAvatar, tags: $tags, reply: $reply, repliedAt: $repliedAt, consultationId: $consultationId)';
}


}

/// @nodoc
abstract mixin class $AstrologerReviewModelCopyWith<$Res>  {
  factory $AstrologerReviewModelCopyWith(AstrologerReviewModel value, $Res Function(AstrologerReviewModel) _then) = _$AstrologerReviewModelCopyWithImpl;
@useResult
$Res call({
 String id, String astrologerId, String authorName, int rating, String comment, DateTime createdAt, String? authorAvatar, List<String> tags, String? reply, DateTime? repliedAt, String? consultationId
});




}
/// @nodoc
class _$AstrologerReviewModelCopyWithImpl<$Res>
    implements $AstrologerReviewModelCopyWith<$Res> {
  _$AstrologerReviewModelCopyWithImpl(this._self, this._then);

  final AstrologerReviewModel _self;
  final $Res Function(AstrologerReviewModel) _then;

/// Create a copy of AstrologerReviewModel
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
@JsonSerializable()

class _AstrologerReviewModel extends AstrologerReviewModel {
  const _AstrologerReviewModel({required this.id, required this.astrologerId, required this.authorName, required this.rating, required this.comment, required this.createdAt, this.authorAvatar, final  List<String> tags = const [], this.reply, this.repliedAt, this.consultationId}): _tags = tags,super._();
  factory _AstrologerReviewModel.fromJson(Map<String, dynamic> json) => _$AstrologerReviewModelFromJson(json);

@override final  String id;
@override final  String astrologerId;
@override final  String authorName;
@override final  int rating;
@override final  String comment;
@override final  DateTime createdAt;
@override final  String? authorAvatar;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? reply;
@override final  DateTime? repliedAt;
@override final  String? consultationId;

/// Create a copy of AstrologerReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AstrologerReviewModelCopyWith<_AstrologerReviewModel> get copyWith => __$AstrologerReviewModelCopyWithImpl<_AstrologerReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AstrologerReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AstrologerReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.astrologerId, astrologerId) || other.astrologerId == astrologerId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.authorAvatar, authorAvatar) || other.authorAvatar == authorAvatar)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.reply, reply) || other.reply == reply)&&(identical(other.repliedAt, repliedAt) || other.repliedAt == repliedAt)&&(identical(other.consultationId, consultationId) || other.consultationId == consultationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,astrologerId,authorName,rating,comment,createdAt,authorAvatar,const DeepCollectionEquality().hash(_tags),reply,repliedAt,consultationId);

@override
String toString() {
  return 'AstrologerReviewModel(id: $id, astrologerId: $astrologerId, authorName: $authorName, rating: $rating, comment: $comment, createdAt: $createdAt, authorAvatar: $authorAvatar, tags: $tags, reply: $reply, repliedAt: $repliedAt, consultationId: $consultationId)';
}


}

/// @nodoc
abstract mixin class _$AstrologerReviewModelCopyWith<$Res> implements $AstrologerReviewModelCopyWith<$Res> {
  factory _$AstrologerReviewModelCopyWith(_AstrologerReviewModel value, $Res Function(_AstrologerReviewModel) _then) = __$AstrologerReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String astrologerId, String authorName, int rating, String comment, DateTime createdAt, String? authorAvatar, List<String> tags, String? reply, DateTime? repliedAt, String? consultationId
});




}
/// @nodoc
class __$AstrologerReviewModelCopyWithImpl<$Res>
    implements _$AstrologerReviewModelCopyWith<$Res> {
  __$AstrologerReviewModelCopyWithImpl(this._self, this._then);

  final _AstrologerReviewModel _self;
  final $Res Function(_AstrologerReviewModel) _then;

/// Create a copy of AstrologerReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? astrologerId = null,Object? authorName = null,Object? rating = null,Object? comment = null,Object? createdAt = null,Object? authorAvatar = freezed,Object? tags = null,Object? reply = freezed,Object? repliedAt = freezed,Object? consultationId = freezed,}) {
  return _then(_AstrologerReviewModel(
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

// dart format on
