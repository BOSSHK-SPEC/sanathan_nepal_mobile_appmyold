// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(
  Map<String, dynamic> json,
) => _ProductModel(
  id: json['id'] as String,
  title: json['title'] as String,
  titleNe: json['title_ne'] as String,
  description: json['description'] as String,
  descriptionNe: json['description_ne'] as String,
  price: (json['price'] as num).toDouble(),
  categoryId: json['category_id'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  seller: SellerModel.fromJson(json['seller'] as Map<String, dynamic>),
  location: json['location'] as String,
  locationNe: json['location_ne'] as String,
  postedAt: DateTime.parse(json['posted_at'] as String),
  currency: json['currency'] as String? ?? 'NPR',
  condition:
      $enumDecodeNullable(
        _$ProductConditionEnumMap,
        json['condition'],
        unknownValue: ProductCondition.used,
      ) ??
      ProductCondition.used,
  views: (json['views'] as num?)?.toInt() ?? 0,
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  rating: (json['rating'] as num?)?.toDouble() ?? 0,
  isBoosted: json['is_boosted'] as bool? ?? false,
  isFavourite: json['is_favourite'] as bool? ?? false,
  isMine: json['is_mine'] as bool? ?? false,
  businessId: json['business_id'] as String?,
  negotiable: json['negotiable'] as bool? ?? false,
  isService: json['is_service'] as bool? ?? false,
  websiteLink: json['website_link'] as String?,
  expiresAt: json['expires_at'] == null
      ? null
      : DateTime.parse(json['expires_at'] as String),
  specs:
      (json['specs'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  options:
      (json['options'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ) ??
      const {},
  comments:
      (json['comments'] as List<dynamic>?)
          ?.map((e) => ProductCommentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  videos:
      (json['videos'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'title_ne': instance.titleNe,
      'description': instance.description,
      'description_ne': instance.descriptionNe,
      'price': instance.price,
      'category_id': instance.categoryId,
      'images': instance.images,
      'seller': instance.seller.toJson(),
      'location': instance.location,
      'location_ne': instance.locationNe,
      'posted_at': instance.postedAt.toIso8601String(),
      'currency': instance.currency,
      'condition': _$ProductConditionEnumMap[instance.condition]!,
      'views': instance.views,
      'likes': instance.likes,
      'rating': instance.rating,
      'is_boosted': instance.isBoosted,
      'is_favourite': instance.isFavourite,
      'is_mine': instance.isMine,
      'business_id': ?instance.businessId,
      'negotiable': instance.negotiable,
      'is_service': instance.isService,
      'website_link': ?instance.websiteLink,
      'expires_at': ?instance.expiresAt?.toIso8601String(),
      'specs': instance.specs,
      'options': instance.options,
      'comments': instance.comments.map((e) => e.toJson()).toList(),
      'videos': instance.videos,
    };

const _$ProductConditionEnumMap = {
  ProductCondition.brandNew: 'brandNew',
  ProductCondition.used: 'used',
};
