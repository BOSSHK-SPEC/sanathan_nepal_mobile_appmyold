import '../../../../core/region/region.dart';
import '../../domain/entities/payment_intent.dart';
import '../../domain/entities/refund_request.dart';
import '../../domain/entities/topup_option.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/entities/wallet_balance.dart';
import '../../domain/entities/wallet_transaction.dart';

abstract interface class WalletDataSource {
  Future<WalletBalance> getBalance();
  Future<List<WalletTransaction>> getTransactions(TransactionFilter filter);
  Future<List<TopUpOption>> getTopUpOptions();
  Future<PaymentIntent> createTopUp({
    required double amount,
    required PaymentRail rail,
  });
  Future<PaymentIntent> getPaymentIntent(String intentId);
  Future<WalletTransaction> debit({
    required double amount,
    required TransactionCategory category,
    required String description,
    String? referenceId,
  });
  Future<RefundRequest> requestRefund(RefundDraft draft);
  Future<List<RefundRequest>> getRefunds();
}
