// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessItemModel _$BusinessItemModelFromJson(Map<String, dynamic> json) =>
    _BusinessItemModel(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      priceLabel: json['price_label'] as String? ?? '',
      category: json['category'] as String? ?? '',
      isService: json['is_service'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
      purchaseLink: json['purchase_link'] as String? ?? '',
      tiktokLink: json['tiktok_link'] as String? ?? '',
      youtubeLink: json['youtube_link'] as String? ?? '',
      negotiable: json['negotiable'] as bool? ?? false,
    );

Map<String, dynamic> _$BusinessItemModelToJson(_BusinessItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price_label': instance.priceLabel,
      'category': instance.category,
      'is_service': instance.isService,
      'image_url': ?instance.imageUrl,
      'purchase_link': instance.purchaseLink,
      'tiktok_link': instance.tiktokLink,
      'youtube_link': instance.youtubeLink,
      'negotiable': instance.negotiable,
    };

_BusinessReviewModel _$BusinessReviewModelFromJson(Map<String, dynamic> json) =>
    _BusinessReviewModel(
      id: json['id'] as String,
      author: json['author'] as String? ?? '',
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      date: DateTime.parse(json['date'] as String),
      text: json['text'] as String? ?? '',
      helpfulCount: (json['helpful_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BusinessReviewModelToJson(
  _BusinessReviewModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'author': instance.author,
  'rating': instance.rating,
  'date': instance.date.toIso8601String(),
  'text': instance.text,
  'helpful_count': instance.helpfulCount,
};

_BusinessProfileModel _$BusinessProfileModelFromJson(
  Map<String, dynamic> json,
) => _BusinessProfileModel(
  id: json['id'] as String,
  name: json['name'] as String? ?? '',
  category: json['category'] as String? ?? '',
  tagline: json['tagline'] as String? ?? '',
  description: json['description'] as String? ?? '',
  email: json['email'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  whatsapp: json['whatsapp'] as String? ?? '',
  website: json['website'] as String? ?? '',
  address: json['address'] as String? ?? '',
  mapLink: json['map_link'] as String? ?? '',
  workingHours: json['working_hours'] as String? ?? '',
  taxId: json['tax_id'] as String? ?? '',
  logoUrl: json['logo_url'] as String?,
  coverUrl: json['cover_url'] as String?,
  verified: json['verified'] as bool? ?? false,
  rating: (json['rating'] as num?)?.toDouble() ?? 0,
  reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
  recommendedPercent: (json['recommended_percent'] as num?)?.toInt() ?? 0,
  followers: (json['followers'] as num?)?.toInt() ?? 0,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => BusinessItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  reviews:
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => BusinessReviewModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  documents:
      (json['documents'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  status:
      $enumDecodeNullable(
        _$BusinessStatusEnumMap,
        json['status'],
        unknownValue: BusinessStatus.pending,
      ) ??
      BusinessStatus.pending,
  moderationNote: json['moderation_note'] as String? ?? '',
);

Map<String, dynamic> _$BusinessProfileModelToJson(
  _BusinessProfileModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'tagline': instance.tagline,
  'description': instance.description,
  'email': instance.email,
  'phone': instance.phone,
  'whatsapp': instance.whatsapp,
  'website': instance.website,
  'address': instance.address,
  'map_link': instance.mapLink,
  'working_hours': instance.workingHours,
  'tax_id': instance.taxId,
  'logo_url': ?instance.logoUrl,
  'cover_url': ?instance.coverUrl,
  'verified': instance.verified,
  'rating': instance.rating,
  'review_count': instance.reviewCount,
  'recommended_percent': instance.recommendedPercent,
  'followers': instance.followers,
  'items': instance.items.map((e) => e.toJson()).toList(),
  'reviews': instance.reviews.map((e) => e.toJson()).toList(),
  'documents': instance.documents,
  'status': _$BusinessStatusEnumMap[instance.status]!,
  'moderation_note': instance.moderationNote,
};

const _$BusinessStatusEnumMap = {
  BusinessStatus.pending: 'pending',
  BusinessStatus.approved: 'approved',
  BusinessStatus.rejected: 'rejected',
};
