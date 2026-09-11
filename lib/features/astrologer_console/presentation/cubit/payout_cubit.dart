import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/earnings.dart';
import '../../domain/entities/payout.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'payout_cubit.freezed.dart';
part 'payout_state.dart';

/// Payout account setup, withdrawals and payout history.
class PayoutCubit extends AppCubit<PayoutState> {
  PayoutCubit({
    required Region region,
    required GetPayoutAccount getAccount,
    required SavePayoutAccount saveAccount,
    required GetPayouts getPayouts,
    required RequestPayout requestPayout,
    required GetEarnings getEarnings,
    required GetTaxDocuments getTaxDocuments,
  }) : _getAccount = getAccount,
       _saveAccount = saveAccount,
       _getPayouts = getPayouts,
       _requestPayout = requestPayout,
       _getEarnings = getEarnings,
       _getTaxDocuments = getTaxDocuments,
       super(PayoutState(destinations: PayoutAccount.forRegion(region)));

  final GetPayoutAccount _getAccount;
  final SavePayoutAccount _saveAccount;
  final GetPayouts _getPayouts;
  final RequestPayout _requestPayout;
  final GetEarnings _getEarnings;
  final GetTaxDocuments _getTaxDocuments;

  Future<void> load() async {
    emit(state.copyWith(payouts: state.payouts.toLoading()));
    final accountFuture = _getAccount();
    final payoutsFuture = _getPayouts();
    final earningsFuture = _getEarnings(EarningsRange.year);
    final taxFuture = _getTaxDocuments();

    final account = await accountFuture;
    final payouts = await payoutsFuture;
    final earnings = await earningsFuture;
    final tax = await taxFuture;

    emit(
      state.copyWith(
        account: account.valueOrNull,
        accountLoaded: true,
        draftAccount:
            account.valueOrNull ??
            PayoutAccount(destination: state.destinations.first),
        payouts: payouts.fold(state.payouts.toFailed, LoadState.loaded),
        availableBalance: earnings.valueOrNull?.availableBalance ?? 0,
        taxDocuments: tax.valueOrNull ?? const [],
      ),
    );
  }

  void setDestination(PayoutDestination destination) => emit(
    state.copyWith(
      draftAccount: state.draft.copyWith(destination: destination),
      saveError: null,
    ),
  );

  void setIdentifier(String value) => emit(
    state.copyWith(
      draftAccount: state.draft.copyWith(identifier: value),
      saveError: null,
    ),
  );

  void setHolderName(String value) => emit(
    state.copyWith(draftAccount: state.draft.copyWith(holderName: value)),
  );

  void setBankName(String value) =>
      emit(state.copyWith(draftAccount: state.draft.copyWith(bankName: value)));

  Future<bool> saveAccount() async {
    emit(state.copyWith(saving: state.saving.toLoading(), saveError: null));
    final result = await _saveAccount(state.draft);
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            saving: state.saving.toFailed(failure),
            saveError: failure.message,
          ),
        );
        return false;
      },
      (account) {
        emit(
          state.copyWith(
            saving: LoadState.loaded(account),
            account: account,
            draftAccount: account,
          ),
        );
        return true;
      },
    );
  }

  void setWithdrawAmount(String raw) => emit(
    state.copyWith(
      withdrawAmount: double.tryParse(raw.trim()),
      withdrawError: null,
    ),
  );

  void withdrawAll() =>
      emit(state.copyWith(withdrawAmount: state.availableBalance));

  Future<bool> withdraw() async {
    final amount = state.withdrawAmount;
    if (amount == null) return false;
    emit(
      state.copyWith(
        withdrawing: state.withdrawing.toLoading(),
        withdrawError: null,
      ),
    );
    final result = await _requestPayout(amount);
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            withdrawing: state.withdrawing.toFailed(failure),
            withdrawError: failure.message,
          ),
        );
        return false;
      },
      (request) {
        emit(state.copyWith(withdrawing: LoadState.loaded(request)));
        unawaitedLoad();
        return true;
      },
    );
  }

  /// Refresh after a withdrawal without making callers await it.
  void unawaitedLoad() {
    load();
  }
}
