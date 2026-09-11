import '../../../../core/billing/spending_account.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../datasources/wallet_data_source.dart';

/// Adapts the wallet to the core [SpendingAccount] contract so consultations,
/// reports and orders can charge without importing this feature.
class WalletSpendingAccount implements SpendingAccount {
  const WalletSpendingAccount(this._source);

  final WalletDataSource _source;

  @override
  Future<double> spendable() async => (await _source.getBalance()).spendable;

  @override
  Future<void> charge({
    required double amount,
    required SpendCategory category,
    required String description,
    String? referenceId,
  }) => _source.debit(
    amount: amount,
    category: switch (category) {
      SpendCategory.consultation => TransactionCategory.consultation,
      SpendCategory.report => TransactionCategory.report,
      SpendCategory.product => TransactionCategory.productPurchase,
    },
    description: description,
    referenceId: referenceId,
  );
}
