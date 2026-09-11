part of 'transactions_cubit.dart';

@freezed
abstract class TransactionsState with _$TransactionsState {
  const TransactionsState._();

  const factory TransactionsState({
    @Default(LoadState.idle()) LoadState<List<WalletTransaction>> transactions,
    @Default(TransactionFilter()) TransactionFilter filter,
  }) = _TransactionsState;

  List<WalletTransaction> get entries => transactions.dataOrNull ?? const [];

  bool get isEmpty => transactions.isLoaded && entries.isEmpty;

  double get totalIn => entries
      .where((t) => t.isCredit)
      .fold<double>(0, (sum, t) => sum + t.amount);

  double get totalOut => entries
      .where((t) => !t.isCredit)
      .fold<double>(0, (sum, t) => sum + t.amount);

  /// Entries grouped by calendar day, newest day first — the shape a ledger
  /// is actually read in.
  Map<DateTime, List<WalletTransaction>> get byDay {
    final grouped = <DateTime, List<WalletTransaction>>{};
    for (final t in entries) {
      final day = DateTime(
        t.createdAt.year,
        t.createdAt.month,
        t.createdAt.day,
      );
      grouped.putIfAbsent(day, () => []).add(t);
    }
    return grouped;
  }
}
