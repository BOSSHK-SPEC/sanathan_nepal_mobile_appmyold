import 'package:freezed_annotation/freezed_annotation.dart';

import 'wallet_transaction.dart';

part 'wallet_balance.freezed.dart';

/// Spendable balance plus the recent entries the wallet home shows.
///
/// [promotional] is tracked separately because bonus credit is usually
/// non-withdrawable — spending it and cashing it out are different rights,
/// and collapsing them into one number makes that impossible to express.
@freezed
abstract class WalletBalance with _$WalletBalance {
  const WalletBalance._();

  const factory WalletBalance({
    @Default(0) double available,
    @Default(0) double promotional,
    @Default(<WalletTransaction>[]) List<WalletTransaction> recent,
    DateTime? updatedAt,
  }) = _WalletBalance;

  /// What the user can actually spend on a consultation.
  double get spendable => available + promotional;

  bool get isEmpty => spendable <= 0;

  /// Minutes affordable at [ratePerMinute] — drives the low-balance warning
  /// during a live session.
  int minutesAffordable(double ratePerMinute) =>
      ratePerMinute <= 0 ? 0 : (spendable / ratePerMinute).floor();
}
