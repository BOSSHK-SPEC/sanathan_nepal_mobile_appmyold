import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../../domain/entities/pending_payout.dart';
import '../../../domain/repositories/admin_repository.dart';

part 'payouts_cubit.freezed.dart';
part 'payouts_state.dart';

/// The payout queue — the one screen in the console that moves real money.
///
/// Every decision here is a transfer someone is owed, so the flow is
/// deliberately slower than the rest: the UI collects a note and a bank
/// reference before it will submit, and the list is refetched afterwards so a
/// second reviewer cannot approve the same request twice from a stale row.
class PayoutsCubit extends AppCubit<PayoutsState> {
  PayoutsCubit(this._admin) : super(const PayoutsState());

  final AdminRepository _admin;

  Future<void> load() async {
    emit(state.copyWith(payouts: state.payouts.toLoading()));
    final result = await _admin.pendingPayouts();
    emit(
      state.copyWith(
        payouts: result.fold(state.payouts.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> decide({
    required String payoutId,
    required bool approve,
    required String note,
    String? reference,
  }) async {
    emit(state.copyWith(decidingId: payoutId, actionError: null));

    final result = await _admin.decidePayout(
      payoutId: payoutId,
      approve: approve,
      note: note,
      reference: reference,
    );

    await result.fold(
      (failure) async =>
          emit(state.copyWith(decidingId: null, actionError: failure.message)),
      (outcome) async {
        emit(state.copyWith(decidingId: null, lastOutcome: outcome.status));
        await load();
      },
    );
  }
}
