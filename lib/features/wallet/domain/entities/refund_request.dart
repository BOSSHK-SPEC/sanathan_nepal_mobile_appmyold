import 'package:freezed_annotation/freezed_annotation.dart';

part 'refund_request.freezed.dart';

/// Why the user is asking for money back.
enum RefundReason {
  sessionNotDelivered,
  poorConnection,
  chargedTwice,
  wrongAmount,
  notAsDescribed,
  other;

  static RefundReason fromName(String? name) => RefundReason.values.firstWhere(
    (r) => r.name == name,
    orElse: () => RefundReason.other,
  );
}

enum RefundStatus { submitted, underReview, approved, rejected, credited }

/// What the user submits.
@freezed
abstract class RefundDraft with _$RefundDraft {
  const factory RefundDraft({
    /// Transaction being disputed.
    required String transactionId,
    required RefundReason reason,
    @Default('') String details,
  }) = _RefundDraft;
}

/// A submitted request, with its progress.
@freezed
abstract class RefundRequest with _$RefundRequest {
  const RefundRequest._();

  const factory RefundRequest({
    required String id,
    required String transactionId,
    required RefundReason reason,
    required RefundStatus status,
    required double amount,
    required DateTime createdAt,
    @Default('') String details,
    DateTime? resolvedAt,
    String? resolutionNote,
  }) = _RefundRequest;

  bool get isOpen =>
      status == RefundStatus.submitted || status == RefundStatus.underReview;
}
