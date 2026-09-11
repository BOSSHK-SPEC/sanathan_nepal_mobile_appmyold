part of 'payment_status_cubit.dart';

@freezed
abstract class PaymentStatusState with _$PaymentStatusState {
  const PaymentStatusState._();

  const factory PaymentStatusState({
    @Default(LoadState.idle()) LoadState<PaymentIntent> intent,
    @Default(0) int attempts,
  }) = _PaymentStatusState;

  PaymentIntent? get payment => intent.dataOrNull;

  bool get isSettled => payment?.isSettled ?? false;

  bool get isSucceeded => payment?.status == PaymentStatus.succeeded;

  bool get isFailed =>
      payment?.status == PaymentStatus.failed ||
      payment?.status == PaymentStatus.cancelled;

  /// Still unsettled after the polling budget — surfaced as "taking longer
  /// than usual" with a manual check, never as a failure.
  bool get isSlow =>
      !isSettled &&
      attempts >= PaymentStatusCubit.maxAttempts &&
      payment != null;

  bool get isWaiting => !isSettled && !isSlow;
}
