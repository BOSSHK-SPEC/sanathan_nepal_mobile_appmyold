import '../../../../core/region/region.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/payment_intent.dart';
import '../entities/refund_request.dart';
import '../entities/topup_option.dart';
import '../entities/transaction_filter.dart';
import '../entities/wallet_balance.dart';
import '../entities/wallet_transaction.dart';
import '../repositories/wallet_repository.dart';

/// Spendable balance plus the recent entries shown on the wallet home.
class GetWalletBalance implements NoParamsUseCase<WalletBalance> {
  const GetWalletBalance(this._repo);
  final WalletRepository _repo;

  @override
  Future<Result<WalletBalance>> call() => _repo.getBalance();
}

class GetTransactions
    implements UseCase<List<WalletTransaction>, TransactionFilter> {
  const GetTransactions(this._repo);
  final WalletRepository _repo;

  @override
  Future<Result<List<WalletTransaction>>> call(TransactionFilter params) =>
      _repo.getTransactions(params);
}

class GetTopUpOptions implements NoParamsUseCase<List<TopUpOption>> {
  const GetTopUpOptions(this._repo);
  final WalletRepository _repo;

  @override
  Future<Result<List<TopUpOption>>> call() => _repo.getTopUpOptions();
}

/// Arguments for [CreateTopUp].
class TopUpParams {
  const TopUpParams({required this.amount, required this.rail});
  final double amount;
  final PaymentRail rail;
}

class CreateTopUp implements UseCase<PaymentIntent, TopUpParams> {
  const CreateTopUp(this._repo);
  final WalletRepository _repo;

  @override
  Future<Result<PaymentIntent>> call(TopUpParams params) =>
      _repo.createTopUp(amount: params.amount, rail: params.rail);
}

/// Polled until the intent settles — gateways confirm asynchronously.
class GetPaymentIntent implements UseCase<PaymentIntent, String> {
  const GetPaymentIntent(this._repo);
  final WalletRepository _repo;

  @override
  Future<Result<PaymentIntent>> call(String params) =>
      _repo.getPaymentIntent(params);
}

/// Arguments for [DebitWallet].
class DebitParams {
  const DebitParams({
    required this.amount,
    required this.category,
    required this.description,
    this.referenceId,
  });

  final double amount;
  final TransactionCategory category;
  final String description;
  final String? referenceId;
}

/// Charges the wallet. Consultations, paid reports and orders all go
/// through this so there is one place that can reject an overspend.
class DebitWallet implements UseCase<WalletTransaction, DebitParams> {
  const DebitWallet(this._repo);
  final WalletRepository _repo;

  @override
  Future<Result<WalletTransaction>> call(DebitParams params) => _repo.debit(
    amount: params.amount,
    category: params.category,
    description: params.description,
    referenceId: params.referenceId,
  );
}

class RequestRefund implements UseCase<RefundRequest, RefundDraft> {
  const RequestRefund(this._repo);
  final WalletRepository _repo;

  @override
  Future<Result<RefundRequest>> call(RefundDraft params) =>
      _repo.requestRefund(params);
}

class GetRefunds implements NoParamsUseCase<List<RefundRequest>> {
  const GetRefunds(this._repo);
  final WalletRepository _repo;

  @override
  Future<Result<List<RefundRequest>>> call() => _repo.getRefunds();
}
