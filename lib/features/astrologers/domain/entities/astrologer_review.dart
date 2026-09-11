import 'package:freezed_annotation/freezed_annotation.dart';

part 'astrologer_review.freezed.dart';

/// A review left by a seeker after a consultation.
@freezed
abstract class AstrologerReview with _$AstrologerReview {
  const AstrologerReview._();

  const factory AstrologerReview({
    required String id,
    required String astrologerId,
    required String authorName,
    required int rating,
    required String comment,
    required DateTime createdAt,
    String? authorAvatar,

    /// Short tags picked during review submission ("Accurate", "Patient").
    @Default([]) List<String> tags,

    /// The astrologer's public reply, when they have answered.
    String? reply,
    DateTime? repliedAt,

    /// Set when the review is attached to a completed consultation.
    String? consultationId,
  }) = _AstrologerReview;

  bool get hasReply => reply != null && reply!.isNotEmpty;
}

/// What the seeker submits from the review screen.
@freezed
abstract class ReviewDraft with _$ReviewDraft {
  const factory ReviewDraft({
    required String astrologerId,
    required int rating,
    @Default('') String comment,
    @Default([]) List<String> tags,
    String? consultationId,
  }) = _ReviewDraft;
}

/// Why a seeker is reporting an astrologer.
enum ReportReason {
  misleading,
  rude,
  spam,
  pricing,
  impersonation,
  other;

  static ReportReason fromName(String? name) => ReportReason.values.firstWhere(
    (r) => r.name == name,
    orElse: () => ReportReason.other,
  );
}

@freezed
abstract class ReportDraft with _$ReportDraft {
  const factory ReportDraft({
    required String astrologerId,
    required ReportReason reason,
    @Default('') String details,
    @Default(false) bool alsoBlock,
  }) = _ReportDraft;
}
