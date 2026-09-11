import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/console_stats.dart';
import '../../domain/entities/earnings.dart';
import '../../domain/entities/payout.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'earnings_cubit.freezed.dart';
part 'earnings_state.dart';

/// Earnings ledger, payout balances and performance metrics.
class EarningsCubit extends AppCubit<EarningsState> {
  EarningsCubit({
    required GetEarnings getEarnings,
    required GetPerformance getPerformance,
    required GetPayoutAccount getAccount,
  }) : _getEarnings = getEarnings,
       _getPerformance = getPerformance,
       _getAccount = getAccount,
       super(const EarningsState());

  final GetEarnings _getEarnings;
  final GetPerformance _getPerformance;
  final GetPayoutAccount _getAccount;

  Future<void> load() async {
    emit(
      state.copyWith(
        summary: state.summary.toLoading(),
        performance: state.performance.toLoading(),
      ),
    );
    final summaryFuture = _getEarnings(state.range);
    final performanceFuture = _getPerformance(state.range);
    final accountFuture = _getAccount();

    final summary = await summaryFuture;
    final performance = await performanceFuture;
    final account = await accountFuture;

    emit(
      state.copyWith(
        summary: summary.fold(state.summary.toFailed, LoadState.loaded),
        performance: performance.fold(
          state.performance.toFailed,
          LoadState.loaded,
        ),
        account: account.valueOrNull,
        accountLoaded: true,
      ),
    );
  }

  Future<void> setRange(EarningsRange range) {
    emit(state.copyWith(range: range));
    return load();
  }
}
