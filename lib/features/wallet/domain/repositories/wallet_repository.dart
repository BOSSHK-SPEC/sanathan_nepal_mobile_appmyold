import '../../../../core/region/region.dart';
import '../../../../core/utils/result.dart';
import '../entities/payment_intent.dart';
import '../entities/refund_request.dart';
import '../entities/topup_option.dart';
import '../entities/transaction_filter.dart';
import '../entities/wallet_balance.dart';
import '../entities/wallet_transaction.dart';

/// Wallet balance, ledger, top-ups and refunds.
abstract interface class WalletRepository {
  Future<Result<WalletBalance>> getBalance();

  Future<Result<List<WalletTransaction>>> getTransactions(
    TransactionFilter filter,
  );

  Future<Result<List<TopUpOption>>> getTopUpOptions();

  /// Creates a payment attempt. The returned intent starts unsettled — the
  /// caller polls [getPaymentIntent] until [PaymentIntent.isSettled].
  Future<Result<PaymentIntent>> createTopUp({
    required double amount,
    required PaymentRail rail,
  });

  Future<Result<PaymentIntent>> getPaymentIntent(String intentId);

  /// Charges the wallet — used by consultations, reports and orders.
  ///
  /// Fails with a validation error when the balance is insufficient, so the
  /// caller never has to pre-check and race.
  Future<Result<WalletTransaction>> debit({
    required double amount,
    required TransactionCategory category,
    required String description,
    String? referenceId,
  });

  Future<Result<RefundRequest>> requestRefund(RefundDraft draft);

  Future<Result<List<RefundRequest>>> getRefunds();
}
