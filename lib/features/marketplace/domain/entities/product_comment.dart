import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_comment.freezed.dart';

/// A public comment / question left on a product listing.
@freezed
abstract class ProductComment with _$ProductComment {
  const factory ProductComment({
    required String id,
    required String author,
    required String message,
    required DateTime postedAt,
    String? avatar,
  }) = _ProductComment;
}
