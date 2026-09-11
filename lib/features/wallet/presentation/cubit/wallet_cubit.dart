import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/topup_option.dart';
import '../../domain/entities/wallet_balance.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'wallet_cubit.freezed.dart';
part 'wallet_state.dart';

/// Wallet home: balance, quick top-up tiers and recent activity.
class WalletCubit extends AppCubit<WalletState> {
  WalletCubit({
    required GetWalletBalance getBalance,
    required GetTopUpOptions getOptions,
  }) : _getBalance = getBalance,
       _getOptions = getOptions,
       super(const WalletState());

  final GetWalletBalance _getBalance;
  final GetTopUpOptions _getOptions;

  Future<void> load() async {
    emit(
      state.copyWith(
        balance: state.balance.toLoading(),
        options: state.options.toLoading(),
      ),
    );
    final balanceFuture = _getBalance();
    final optionsFuture = _getOptions();
    final balance = await balanceFuture;
    final options = await optionsFuture;
    emit(
      state.copyWith(
        balance: balance.fold(state.balance.toFailed, LoadState.loaded),
        options: options.fold(state.options.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Called after a top-up settles so the header reflects the new balance
  /// without a full screen reload.
  Future<void> refreshBalance() async {
    final result = await _getBalance();
    emit(
      state.copyWith(
        balance: result.fold(state.balance.toFailed, LoadState.loaded),
      ),
    );
  }
}
