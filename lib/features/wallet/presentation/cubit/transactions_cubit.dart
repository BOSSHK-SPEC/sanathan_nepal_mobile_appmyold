import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/transaction_filter.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'transactions_cubit.freezed.dart';
part 'transactions_state.dart';

/// The wallet ledger, with range / category / direction filters.
class TransactionsCubit extends AppCubit<TransactionsState> {
  TransactionsCubit({required GetTransactions getTransactions})
    : _getTransactions = getTransactions,
      super(const TransactionsState());

  final GetTransactions _getTransactions;

  Future<void> load() async {
    emit(state.copyWith(transactions: state.transactions.toLoading()));
    final result = await _getTransactions(state.filter);
    emit(
      state.copyWith(
        transactions: result.fold(
          state.transactions.toFailed,
          LoadState.loaded,
        ),
      ),
    );
  }

  Future<void> setRange(LedgerRange range) {
    emit(state.copyWith(filter: state.filter.copyWith(range: range)));
    return load();
  }

  Future<void> setDirection(TransactionDirection? direction) {
    emit(
      state.copyWith(
        filter: TransactionFilter(
          range: state.filter.range,
          categories: state.filter.categories,
          direction: direction,
        ),
      ),
    );
    return load();
  }

  Future<void> setCategories(Set<TransactionCategory> categories) {
    emit(state.copyWith(filter: state.filter.copyWith(categories: categories)));
    return load();
  }

  Future<void> clearFilters() {
    emit(state.copyWith(filter: const TransactionFilter()));
    return load();
  }
}
