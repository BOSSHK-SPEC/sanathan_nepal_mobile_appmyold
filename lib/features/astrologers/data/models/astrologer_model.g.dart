// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astrologer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AstrologerModel _$AstrologerModelFromJson(Map<String, dynamic> json) =>
    _AstrologerModel(
      id: json['id'] as String,
      name: LocalizedTextModel.fromJson(json['name'] as Map<String, dynamic>),
      headline: LocalizedTextModel.fromJson(
        json['headline'] as Map<String, dynamic>,
      ),
      about: LocalizedTextModel.fromJson(json['about'] as Map<String, dynamic>),
      specialties:
          (json['specialties'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      languageCodes:
          (json['language_codes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      experienceYears: (json['experience_years'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      ratePerMinute:
          (json['rate_per_minute'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      consultationCount: (json['consultation_count'] as num?)?.toInt() ?? 0,
      followers: (json['followers'] as num?)?.toInt() ?? 0,
      recommendedPercent: (json['recommended_percent'] as num?)?.toInt() ?? 0,
      isOnline: json['is_online'] as bool? ?? false,
      isVerified: json['is_verified'] as bool? ?? false,
      queueLength: (json['queue_length'] as num?)?.toInt() ?? 0,
      isFollowing: json['is_following'] as bool? ?? false,
      avatarAsset: json['avatar_asset'] as String?,
      location: json['location'] == null
          ? null
          : LocalizedTextModel.fromJson(
              json['location'] as Map<String, dynamic>,
            ),
      ratingBreakdown:
          (json['rating_breakdown'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$AstrologerModelToJson(_AstrologerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name.toJson(),
      'headline': instance.headline.toJson(),
      'about': instance.about.toJson(),
      'specialties': instance.specialties,
      'language_codes': instance.languageCodes,
      'experience_years': instance.experienceYears,
      'rating': instance.rating,
      'review_count': instance.reviewCount,
      'rate_per_minute': instance.ratePerMinute,
      'consultation_count': instance.consultationCount,
      'followers': instance.followers,
      'recommended_percent': instance.recommendedPercent,
      'is_online': instance.isOnline,
      'is_verified': instance.isVerified,
      'queue_length': instance.queueLength,
      'is_following': instance.isFollowing,
      'avatar_asset': ?instance.avatarAsset,
      'location': ?instance.location?.toJson(),
      'rating_breakdown': instance.ratingBreakdown,
    };
