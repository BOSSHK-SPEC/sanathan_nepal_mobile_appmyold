import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/product.dart';
import 'product_comment_model.dart';
import 'seller_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

/// Wire/persistence shape of [Product] (used for cart persistence and, later,
/// the remote API). Nested seller / comments are models too.
@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required String id,
    required String title,
    required String titleNe,
    required String description,
    required String descriptionNe,
    required double price,
    required String categoryId,
    required List<String> images,
    required SellerModel seller,
    required String location,
    required String locationNe,
    required DateTime postedAt,
    @Default('NPR') String currency,
    @JsonKey(unknownEnumValue: ProductCondition.used)
    @Default(ProductCondition.used)
    ProductCondition condition,
    @Default(0) int views,
    @Default(0) int likes,
    @Default(0) double rating,
    @Default(false) bool isBoosted,
    @Default(false) bool isFavourite,
    @Default(false) bool isMine,
    String? businessId,
    @Default(false) bool negotiable,
    @Default(false) bool isService,
    String? websiteLink,
    DateTime? expiresAt,
    @Default({}) Map<String, String> specs,
    @Default({}) Map<String, List<String>> options,
    @Default([]) List<ProductCommentModel> comments,
    @Default([]) List<String> videos,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  factory ProductModel.fromEntity(Product p) => ProductModel(
    id: p.id,
    title: p.title,
    titleNe: p.titleNe,
    description: p.description,
    descriptionNe: p.descriptionNe,
    price: p.price,
    currency: p.currency,
    condition: p.condition,
    categoryId: p.categoryId,
    images: p.images,
    seller: SellerModel.fromEntity(p.seller),
    location: p.location,
    locationNe: p.locationNe,
    postedAt: p.postedAt,
    views: p.views,
    likes: p.likes,
    rating: p.rating,
    isBoosted: p.isBoosted,
    isFavourite: p.isFavourite,
    isMine: p.isMine,
    businessId: p.businessId,
    negotiable: p.negotiable,
    isService: p.isService,
    websiteLink: p.websiteLink,
    expiresAt: p.expiresAt,
    specs: p.specs,
    options: p.options,
    comments: p.comments.map(ProductCommentModel.fromEntity).toList(),
    videos: p.videos,
  );

  Product toEntity() => Product(
    id: id,
    title: title,
    titleNe: titleNe,
    description: description,
    descriptionNe: descriptionNe,
    price: price,
    currency: currency,
    condition: condition,
    categoryId: categoryId,
    images: images,
    seller: seller.toEntity(),
    location: location,
    locationNe: locationNe,
    postedAt: postedAt,
    views: views,
    likes: likes,
    rating: rating,
    isBoosted: isBoosted,
    isFavourite: isFavourite,
    isMine: isMine,
    businessId: businessId,
    negotiable: negotiable,
    isService: isService,
    websiteLink: websiteLink,
    expiresAt: expiresAt,
    specs: specs,
    options: options,
    comments: comments.map((c) => c.toEntity()).toList(),
    videos: videos,
  );
}
