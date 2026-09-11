import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';

part 'payment_intent.freezed.dart';

/// Lifecycle of a payment attempt.
///
/// [pending] is a real, common state — UPI and wallet redirects settle
/// asynchronously — so the UI polls it rather than treating "not success"
/// as failure.
enum PaymentStatus { created, pending, succeeded, failed, cancelled }

/// One attempt to move money into the wallet.
///
/// Mirrors what a real gateway returns, so swapping the mock for eSewa /
/// Khalti / Razorpay is a data-source change: the client never computes the
/// outcome, it reports what the server says.
@freezed
abstract class PaymentIntent with _$PaymentIntent {
  const PaymentIntent._();

  const factory PaymentIntent({
    required String id,
    required double amount,
    required PaymentRail rail,
    required PaymentStatus status,
    required DateTime createdAt,

    /// Promotional credit that lands alongside [amount] on success.
    @Default(0) double bonus,

    /// Gateway's own reference, shown on the receipt for support queries.
    String? gatewayReference,

    /// Where the payer completes the payment.
    ///
    /// Its own field rather than being folded into [gatewayReference], which
    /// is what used to happen: the URL was mapped onto the reference and only
    /// ever printed as a row of text, so nobody was ever sent anywhere to pay.
    /// The intent then sat unsettled until the poller gave up and said it was
    /// "taking longer than usual".
    String? checkoutUrl,

    /// Human-readable reason when [status] is failed.
    String? failureReason,

    /// Guards against a double-charge if the request is retried.
    String? idempotencyKey,
  }) = _PaymentIntent;

  bool get isSettled =>
      status == PaymentStatus.succeeded ||
      status == PaymentStatus.failed ||
      status == PaymentStatus.cancelled;

  bool get isPending =>
      status == PaymentStatus.created || status == PaymentStatus.pending;

  double get credited => amount + bonus;
}
