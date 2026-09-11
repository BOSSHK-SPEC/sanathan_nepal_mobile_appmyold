part of 'refund_cubit.dart';

@freezed
abstract class RefundState with _$RefundState {
  const RefundState._();

  const factory RefundState({
    required String transactionId,
    RefundReason? reason,
    @Default('') String details,
    @Default(LoadState.idle()) LoadState<RefundRequest> submission,
  }) = _RefundState;

  /// "Other" needs an explanation; a specific reason speaks for itself.
  bool get canSubmit =>
      reason != null &&
      !submission.isLoading &&
      (reason != RefundReason.other || details.trim().isNotEmpty);

  bool get isSubmitted => submission.isLoaded;
}
