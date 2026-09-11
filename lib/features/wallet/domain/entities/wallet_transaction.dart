import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_transaction.freezed.dart';

/// Direction of money movement.
enum TransactionDirection { credit, debit }

/// What the movement was for. Drives the icon, the wording and the ledger
/// filter — the amount alone never explains an entry.
enum TransactionCategory {
  topUp,
  bonus,
  consultation,
  report,
  productPurchase,
  refund,
  cashback,
  adjustment;

  /// Credits and debits are a property of the category, not of the sign, so
  /// a refund is always a credit even when it reverses a debit.
  TransactionDirection get direction => switch (this) {
    TransactionCategory.topUp ||
    TransactionCategory.bonus ||
    TransactionCategory.refund ||
    TransactionCategory.cashback => TransactionDirection.credit,
    TransactionCategory.consultation ||
    TransactionCategory.report ||
    TransactionCategory.productPurchase => TransactionDirection.debit,
    // Manual corrections can go either way; the sign of `amount` decides.
    TransactionCategory.adjustment => TransactionDirection.credit,
  };

  static TransactionCategory fromName(String? name) =>
      TransactionCategory.values.firstWhere(
        (c) => c.name == name,
        orElse: () => TransactionCategory.adjustment,
      );
}

/// One line in the wallet ledger.
@freezed
abstract class WalletTransaction with _$WalletTransaction {
  const WalletTransaction._();

  const factory WalletTransaction({
    required String id,
    required TransactionCategory category,

    /// Always positive; [isCredit] carries the direction.
    required double amount,
    required DateTime createdAt,

    /// Wallet balance immediately after this entry — lets the ledger be
    /// audited without re-summing every prior row.
    required double balanceAfter,

    /// Free-text detail, e.g. the astrologer's name or the product title.
    @Default('') String description,

    /// Links back to the consultation / order / payment that caused it.
    String? referenceId,

    /// Only set for adjustments that reduce the balance.
    @Default(false) bool forceDebit,
  }) = _WalletTransaction;

  bool get isCredit =>
      !forceDebit && category.direction == TransactionDirection.credit;

  /// Signed amount for display and for re-deriving a balance.
  double get signedAmount => isCredit ? amount : -amount;
}
