// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductCommentModel {

 String get id; String get author; String get message; DateTime get postedAt; String? get avatar;
/// Create a copy of ProductCommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCommentModelCopyWith<ProductCommentModel> get copyWith => _$ProductCommentModelCopyWithImpl<ProductCommentModel>(this as ProductCommentModel, _$identity);

  /// Serializes this ProductCommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.message, message) || other.message == message)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,message,postedAt,avatar);

@override
String toString() {
  return 'ProductCommentModel(id: $id, author: $author, message: $message, postedAt: $postedAt, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $ProductCommentModelCopyWith<$Res>  {
  factory $ProductCommentModelCopyWith(ProductCommentModel value, $Res Function(ProductCommentModel) _then) = _$ProductCommentModelCopyWithImpl;
@useResult
$Res call({
 String id, String author, String message, DateTime postedAt, String? avatar
});




}
/// @nodoc
class _$ProductCommentModelCopyWithImpl<$Res>
    implements $ProductCommentModelCopyWith<$Res> {
  _$ProductCommentModelCopyWithImpl(this._self, this._then);

  final ProductCommentModel _self;
  final $Res Function(ProductCommentModel) _then;

/// Create a copy of ProductCommentModel
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
@JsonSerializable()

class _ProductCommentModel extends ProductCommentModel {
  const _ProductCommentModel({required this.id, required this.author, required this.message, required this.postedAt, this.avatar}): super._();
  factory _ProductCommentModel.fromJson(Map<String, dynamic> json) => _$ProductCommentModelFromJson(json);

@override final  String id;
@override final  String author;
@override final  String message;
@override final  DateTime postedAt;
@override final  String? avatar;

/// Create a copy of ProductCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCommentModelCopyWith<_ProductCommentModel> get copyWith => __$ProductCommentModelCopyWithImpl<_ProductCommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductCommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.message, message) || other.message == message)&&(identical(other.postedAt, postedAt) || other.postedAt == postedAt)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,message,postedAt,avatar);

@override
String toString() {
  return 'ProductCommentModel(id: $id, author: $author, message: $message, postedAt: $postedAt, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class _$ProductCommentModelCopyWith<$Res> implements $ProductCommentModelCopyWith<$Res> {
  factory _$ProductCommentModelCopyWith(_ProductCommentModel value, $Res Function(_ProductCommentModel) _then) = __$ProductCommentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String author, String message, DateTime postedAt, String? avatar
});




}
/// @nodoc
class __$ProductCommentModelCopyWithImpl<$Res>
    implements _$ProductCommentModelCopyWith<$Res> {
  __$ProductCommentModelCopyWithImpl(this._self, this._then);

  final _ProductCommentModel _self;
  final $Res Function(_ProductCommentModel) _then;

/// Create a copy of ProductCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? message = null,Object? postedAt = null,Object? avatar = freezed,}) {
  return _then(_ProductCommentModel(
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
