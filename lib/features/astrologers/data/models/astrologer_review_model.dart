import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/astrologer_review.dart';

part 'astrologer_review_model.freezed.dart';
part 'astrologer_review_model.g.dart';

@freezed
abstract class AstrologerReviewModel with _$AstrologerReviewModel {
  const AstrologerReviewModel._();

  const factory AstrologerReviewModel({
    required String id,
    required String astrologerId,
    required String authorName,
    required int rating,
    required String comment,
    required DateTime createdAt,
    String? authorAvatar,
    @Default([]) List<String> tags,
    String? reply,
    DateTime? repliedAt,
    String? consultationId,
  }) = _AstrologerReviewModel;

  factory AstrologerReviewModel.fromJson(Map<String, dynamic> json) =>
      _$AstrologerReviewModelFromJson(json);

  factory AstrologerReviewModel.fromEntity(AstrologerReview e) =>
      AstrologerReviewModel(
        id: e.id,
        astrologerId: e.astrologerId,
        authorName: e.authorName,
        rating: e.rating,
        comment: e.comment,
        createdAt: e.createdAt,
        authorAvatar: e.authorAvatar,
        tags: e.tags,
        reply: e.reply,
        repliedAt: e.repliedAt,
        consultationId: e.consultationId,
      );

  AstrologerReview toEntity() => AstrologerReview(
    id: id,
    astrologerId: astrologerId,
    authorName: authorName,
    rating: rating,
    comment: comment,
    createdAt: createdAt,
    authorAvatar: authorAvatar,
    tags: tags,
    reply: reply,
    repliedAt: repliedAt,
    consultationId: consultationId,
  );
}
