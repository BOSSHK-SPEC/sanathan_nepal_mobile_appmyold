import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_profile.freezed.dart';

/// Admin moderation state of a business listing.
enum BusinessStatus { pending, approved, rejected }

/// A product or service offered by a business.
@freezed
abstract class BusinessItem with _$BusinessItem {
  const factory BusinessItem({
    required String id,
    required String title,
    required String description,
    required String priceLabel,
    required String category,
    @Default(false) bool isService,
    String? imageUrl,

    /// External purchase / website link for the item (optional).
    @Default('') String purchaseLink,

    /// TikTok / YouTube video links (product related, optional).
    @Default('') String tiktokLink,
    @Default('') String youtubeLink,
    @Default(false) bool negotiable,
  }) = _BusinessItem;
}

/// A customer review of a business.
@freezed
abstract class BusinessReview with _$BusinessReview {
  const factory BusinessReview({
    required String id,
    required String author,
    required int rating,
    required DateTime date,
    required String text,
    @Default(0) int helpfulCount,
  }) = _BusinessReview;
}

/// Seller / business profile (Figma "ADMIN VIEW – Business Profile Details").
@freezed
abstract class BusinessProfile with _$BusinessProfile {
  const BusinessProfile._();

  const factory BusinessProfile({
    required String id,
    required String name,
    required String category,
    @Default('') String tagline,
    @Default('') String description,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String whatsapp,
    @Default('') String website,
    @Default('') String address,
    @Default('') String mapLink,
    @Default('') String workingHours,

    /// Tax registration number – PAN/VAT for Nepal, GSTIN for India (optional).
    @Default('') String taxId,
    String? logoUrl,
    String? coverUrl,
    @Default(false) bool verified,
    @Default(0) double rating,
    @Default(0) int reviewCount,
    @Default(0) int recommendedPercent,
    @Default(0) int followers,
    @Default([]) List<BusinessItem> items,
    @Default([]) List<BusinessReview> reviews,

    /// Names of uploaded verification documents.
    @Default([]) List<String> documents,
    @Default(BusinessStatus.pending) BusinessStatus status,

    /// Reason entered by the admin when rejecting (shown to the owner).
    @Default('') String moderationNote,
  }) = _BusinessProfile;

  List<BusinessItem> get products => items.where((i) => !i.isService).toList();
  List<BusinessItem> get services => items.where((i) => i.isService).toList();
}

/// The two pictures a business shows: the square logo and the wide banner.
enum BusinessImageSlot { logo, cover }
