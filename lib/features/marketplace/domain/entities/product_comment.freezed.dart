// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductComment {

 String get id; String get author; String get message; DateTime get postedAt; String? get avatar;
/// Create a copy of ProductComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCommentCopyWith<ProductComment> get copyWith => _$ProductCommentCopyWithImpl<ProductComment>(this as ProductComment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductComment&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.message, message) || other.message == message)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}


@override
int get hashCode => Object.hash(runtimeType,id,author,message,postedAt,avatar);

@override
String toString() {
  return 'ProductComment(id: $id, author: $author, message: $message, postedAt: $postedAt, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $ProductCommentCopyWith<$Res>  {
  factory $ProductCommentCopyWith(ProductComment value, $Res Function(ProductComment) _then) = _$ProductCommentCopyWithImpl;
@useResult
$Res call({
 String id, String author, String message, DateTime postedAt, String? avatar
});




}
/// @nodoc
class _$ProductCommentCopyWithImpl<$Res>
    implements $ProductCommentCopyWith<$Res> {
  _$ProductCommentCopyWithImpl(this._self, this._then);

  final ProductComment _self;
  final $Res Function(ProductComment) _then;

/// Create a copy of ProductComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? message = null,Object? postedAt = null,Object? avatar = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}



/// @nodoc


class _ProductComment implements ProductComment {
  const _ProductComment({required this.id, required this.author, required this.message, required this.postedAt, this.avatar});
  

@override final  String id;
@override final  String author;
@override final  String message;
@override final  DateTime postedAt;
@override final  String? avatar;

/// Create a copy of ProductComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCommentCopyWith<_ProductComment> get copyWith => __$ProductCommentCopyWithImpl<_ProductComment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductComment&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.message, message) || other.message == message)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}


@override
int get hashCode => Object.hash(runtimeType,id,author,message,postedAt,avatar);

@override
String toString() {
  return 'ProductComment(id: $id, author: $author, message: $message, postedAt: $postedAt, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class _$ProductCommentCopyWith<$Res> implements $ProductCommentCopyWith<$Res> {
  factory _$ProductCommentCopyWith(_ProductComment value, $Res Function(_ProductComment) _then) = __$ProductCommentCopyWithImpl;
@override @useResult
$Res call({
 String id, String author, String message, DateTime postedAt, String? avatar
});




}
/// @nodoc
class __$ProductCommentCopyWithImpl<$Res>
    implements _$ProductCommentCopyWith<$Res> {
  __$ProductCommentCopyWithImpl(this._self, this._then);

  final _ProductComment _self;
  final $Res Function(_ProductComment) _then;

/// Create a copy of ProductComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? message = null,Object? postedAt = null,Object? avatar = freezed,}) {
  return _then(_ProductComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,postedAt: null == postedAt ? _self.postedAt : postedAt // ignore: cast_nullable_to_non_nullable
as DateTime,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
