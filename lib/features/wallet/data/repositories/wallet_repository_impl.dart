import '../../../../core/region/region.dart';
import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/payment_intent.dart';
import '../../domain/entities/refund_request.dart';
import '../../domain/entities/topup_option.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/entities/wallet_balance.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_data_source.dart';

class WalletRepositoryImpl implements WalletRepository {
  const WalletRepositoryImpl(this._source);

  final WalletDataSource _source;

  @override
  Future<Result<WalletBalance>> getBalance() => guard(_source.getBalance);

  @override
  Future<Result<List<WalletTransaction>>> getTransactions(
    TransactionFilter filter,
  ) => guard(() => _source.getTransactions(filter));

  @override
  Future<Result<List<TopUpOption>>> getTopUpOptions() =>
      guard(_source.getTopUpOptions);

  @override
  Future<Result<PaymentIntent>> createTopUp({
    required double amount,
    required PaymentRail rail,
  }) => guard(() => _source.createTopUp(amount: amount, rail: rail));

  @override
  Future<Result<PaymentIntent>> getPaymentIntent(String intentId) =>
      guard(() => _source.getPaymentIntent(intentId));

  @override
  Future<Result<WalletTransaction>> debit({
    required double amount,
    required TransactionCategory category,
    required String description,
    String? referenceId,
  }) => guard(
    () => _source.debit(
      amount: amount,
      category: category,
      description: description,
      referenceId: referenceId,
    ),
  );

  @override
  Future<Result<RefundRequest>> requestRefund(RefundDraft draft) =>
      guard(() => _source.requestRefund(draft));

  @override
  Future<Result<List<RefundRequest>>> getRefunds() => guard(_source.getRefunds);
}
