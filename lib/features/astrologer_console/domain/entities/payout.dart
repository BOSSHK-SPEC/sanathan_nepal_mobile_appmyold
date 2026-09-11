import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';

part 'payout.freezed.dart';

/// Where money is sent. The available destinations follow the region's
/// payment rails, so Nepal offers eSewa/Khalti/bank and India UPI/bank.
enum PayoutDestination { bankAccount, esewa, khalti, upi }

/// Whether the destination has been proved to belong to the astrologer.
enum VerificationState { unverified, pending, verified, failed }

@freezed
abstract class PayoutAccount with _$PayoutAccount {
  const PayoutAccount._();

  const factory PayoutAccount({
    required PayoutDestination destination,

    /// Account number, wallet id or UPI handle depending on [destination].
    @Default('') String identifier,
    @Default('') String holderName,

    /// Bank name / branch, only for [PayoutDestination.bankAccount].
    @Default('') String bankName,
    @Default(VerificationState.unverified) VerificationState verification,
    String? failureReason,
  }) = _PayoutAccount;

  bool get isUsable => verification == VerificationState.verified;

  /// Masked for display — a full account number on screen is a liability.
  String get maskedIdentifier {
    if (identifier.length <= 4) return identifier;
    return '••••${identifier.substring(identifier.length - 4)}';
  }

  static List<PayoutDestination> forRegion(Region region) => switch (region) {
    Region.nepal => const [
      PayoutDestination.bankAccount,
      PayoutDestination.esewa,
      PayoutDestination.khalti,
    ],
    Region.india => const [
      PayoutDestination.bankAccount,
      PayoutDestination.upi,
    ],
  };
}

enum PayoutStatus { requested, processing, paid, failed }

@freezed
abstract class PayoutRequest with _$PayoutRequest {
  const PayoutRequest._();

  const factory PayoutRequest({
    required String id,
    required double amount,
    required PayoutStatus status,
    required DateTime requestedAt,

    /// Deducted from [amount]; shown before the request is confirmed.
    @Default(0) double fee,
    DateTime? settledAt,
    String? reference,
    String? failureReason,
  }) = _PayoutRequest;

  double get netAmount => amount - fee;

  bool get isOpen =>
      status == PayoutStatus.requested || status == PayoutStatus.processing;
}

/// A tax certificate or invoice the astrologer can download.
@freezed
abstract class TaxDocument with _$TaxDocument {
  const factory TaxDocument({
    required String id,
    required String title,
    required String financialYear,
    required double amount,
    required DateTime issuedAt,
  }) = _TaxDocument;
}
