import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/business_profile.dart';

part 'business_profile_model.freezed.dart';
part 'business_profile_model.g.dart';

/// Persistence shape of [BusinessItem].
@freezed
abstract class BusinessItemModel with _$BusinessItemModel {
  const BusinessItemModel._();

  const factory BusinessItemModel({
    required String id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String priceLabel,
    @Default('') String category,
    @Default(false) bool isService,
    String? imageUrl,
    @Default('') String purchaseLink,
    @Default('') String tiktokLink,
    @Default('') String youtubeLink,
    @Default(false) bool negotiable,
  }) = _BusinessItemModel;

  factory BusinessItemModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessItemModelFromJson(json);

  factory BusinessItemModel.fromEntity(BusinessItem e) => BusinessItemModel(
    id: e.id,
    title: e.title,
    description: e.description,
    priceLabel: e.priceLabel,
    category: e.category,
    isService: e.isService,
    imageUrl: e.imageUrl,
    purchaseLink: e.purchaseLink,
    tiktokLink: e.tiktokLink,
    youtubeLink: e.youtubeLink,
    negotiable: e.negotiable,
  );

  BusinessItem toEntity() => BusinessItem(
    id: id,
    title: title,
    description: description,
    priceLabel: priceLabel,
    category: category,
    isService: isService,
    imageUrl: imageUrl,
    purchaseLink: purchaseLink,
    tiktokLink: tiktokLink,
    youtubeLink: youtubeLink,
    negotiable: negotiable,
  );
}

/// Persistence shape of [BusinessReview].
@freezed
abstract class BusinessReviewModel with _$BusinessReviewModel {
  const BusinessReviewModel._();

  const factory BusinessReviewModel({
    required String id,
    @Default('') String author,
    @Default(0) int rating,
    required DateTime date,
    @Default('') String text,
    @Default(0) int helpfulCount,
  }) = _BusinessReviewModel;

  factory BusinessReviewModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessReviewModelFromJson(json);

  factory BusinessReviewModel.fromEntity(BusinessReview e) =>
      BusinessReviewModel(
        id: e.id,
        author: e.author,
        rating: e.rating,
        date: e.date,
        text: e.text,
        helpfulCount: e.helpfulCount,
      );

  BusinessReview toEntity() => BusinessReview(
    id: id,
    author: author,
    rating: rating,
    date: date,
    text: text,
    helpfulCount: helpfulCount,
  );
}

/// Persistence shape of [BusinessProfile] (JSON in the local key-value store).
@freezed
abstract class BusinessProfileModel with _$BusinessProfileModel {
  const BusinessProfileModel._();

  const factory BusinessProfileModel({
    required String id,
    @Default('') String name,
    @Default('') String category,
    @Default('') String tagline,
    @Default('') String description,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String whatsapp,
    @Default('') String website,
    @Default('') String address,
    @Default('') String mapLink,
    @Default('') String workingHours,
    @Default('') String taxId,
    String? logoUrl,
    String? coverUrl,
    @Default(false) bool verified,
    @Default(0) double rating,
    @Default(0) int reviewCount,
    @Default(0) int recommendedPercent,
    @Default(0) int followers,
    @Default([]) List<BusinessItemModel> items,
    @Default([]) List<BusinessReviewModel> reviews,
    @Default([]) List<String> documents,
    @JsonKey(unknownEnumValue: BusinessStatus.pending)
    @Default(BusinessStatus.pending)
    BusinessStatus status,
    @Default('') String moderationNote,
  }) = _BusinessProfileModel;

  factory BusinessProfileModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessProfileModelFromJson(json);

  factory BusinessProfileModel.fromEntity(BusinessProfile e) =>
      BusinessProfileModel(
        id: e.id,
        name: e.name,
        category: e.category,
        tagline: e.tagline,
        description: e.description,
        email: e.email,
        phone: e.phone,
        whatsapp: e.whatsapp,
        website: e.website,
        address: e.address,
        mapLink: e.mapLink,
        workingHours: e.workingHours,
        taxId: e.taxId,
        logoUrl: e.logoUrl,
        coverUrl: e.coverUrl,
        verified: e.verified,
        rating: e.rating,
        reviewCount: e.reviewCount,
        recommendedPercent: e.recommendedPercent,
        followers: e.followers,
        items: e.items.map(BusinessItemModel.fromEntity).toList(),
        reviews: e.reviews.map(BusinessReviewModel.fromEntity).toList(),
        documents: e.documents,
        status: e.status,
        moderationNote: e.moderationNote,
      );

  BusinessProfile toEntity() => BusinessProfile(
    id: id,
    name: name,
    category: category,
    tagline: tagline,
    description: description,
    email: email,
    phone: phone,
    whatsapp: whatsapp,
    website: website,
    address: address,
    mapLink: mapLink,
    workingHours: workingHours,
    taxId: taxId,
    logoUrl: logoUrl,
    coverUrl: coverUrl,
    verified: verified,
    rating: rating,
    reviewCount: reviewCount,
    recommendedPercent: recommendedPercent,
    followers: followers,
    items: items.map((i) => i.toEntity()).toList(),
    reviews: reviews.map((r) => r.toEntity()).toList(),
    documents: documents,
    status: status,
    moderationNote: moderationNote,
  );
}
