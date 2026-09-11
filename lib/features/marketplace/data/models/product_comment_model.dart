import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product_comment.dart';

part 'product_comment_model.freezed.dart';
part 'product_comment_model.g.dart';

/// Wire/persistence shape of [ProductComment].
@freezed
abstract class ProductCommentModel with _$ProductCommentModel {
  const ProductCommentModel._();

  const factory ProductCommentModel({
    required String id,
    required String author,
    required String message,
    required DateTime postedAt,
    String? avatar,
  }) = _ProductCommentModel;

  factory ProductCommentModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCommentModelFromJson(json);

  factory ProductCommentModel.fromEntity(ProductComment c) =>
      ProductCommentModel(
        id: c.id,
        author: c.author,
        message: c.message,
        postedAt: c.postedAt,
        avatar: c.avatar,
      );

  ProductComment toEntity() => ProductComment(
    id: id,
    author: author,
    message: message,
    postedAt: postedAt,
    avatar: avatar,
  );
}
