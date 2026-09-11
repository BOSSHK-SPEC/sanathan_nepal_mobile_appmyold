import 'package:freezed_annotation/freezed_annotation.dart';

import 'wallet_transaction.dart';

part 'transaction_filter.freezed.dart';

/// Time window offered on the ledger.
enum LedgerRange {
  last7Days,
  last30Days,
  last90Days,
  all;

  Duration? get duration => switch (this) {
    LedgerRange.last7Days => const Duration(days: 7),
    LedgerRange.last30Days => const Duration(days: 30),
    LedgerRange.last90Days => const Duration(days: 90),
    LedgerRange.all => null,
  };
}

@freezed
abstract class TransactionFilter with _$TransactionFilter {
  const TransactionFilter._();

  const factory TransactionFilter({
    @Default(LedgerRange.last30Days) LedgerRange range,

    /// Empty means every category.
    @Default(<TransactionCategory>{}) Set<TransactionCategory> categories,

    /// Null means both directions.
    TransactionDirection? direction,
  }) = _TransactionFilter;

  int get activeCount =>
      (categories.isEmpty ? 0 : 1) +
      (direction == null ? 0 : 1) +
      (range == LedgerRange.last30Days ? 0 : 1);

  bool get hasFilters => activeCount > 0;
}
