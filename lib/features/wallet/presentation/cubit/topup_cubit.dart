import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/region/region.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/payment_intent.dart';
import '../../domain/entities/topup_option.dart';
import '../../domain/usecases/wallet_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'topup_cubit.freezed.dart';
part 'topup_state.dart';

/// Two-step top-up: choose an amount, then a payment method.
///
/// Creating the intent is the last thing that happens, so backing out of
/// the method step never leaves a stray payment attempt behind.
class TopUpCubit extends AppCubit<TopUpState> {
  TopUpCubit({
    required GetTopUpOptions getOptions,
    required CreateTopUp createTopUp,
    required List<PaymentRail> availableRails,
  }) : _getOptions = getOptions,
       _createTopUp = createTopUp,
       super(TopUpState(rails: availableRails));

  final GetTopUpOptions _getOptions;
  final CreateTopUp _createTopUp;

  /// Bounds for the custom-amount field, in the region's currency.
  static const double minAmount = 50;
  static const double maxAmount = 100000;

  Future<void> load() async {
    emit(state.copyWith(options: state.options.toLoading()));
    final result = await _getOptions();
    emit(
      state.copyWith(
        options: result.fold(state.options.toFailed, LoadState.loaded),
        // Pre-select the tier marked popular so the common path is one tap.
        selectedAmount:
            state.selectedAmount ??
            result.valueOrNull
                ?.where((o) => o.popular)
                .map((o) => o.amount)
                .firstOrNull,
      ),
    );
  }

  void selectAmount(double amount) => emit(
    state.copyWith(selectedAmount: amount, customAmount: '', amountError: null),
  );

  void setCustomAmount(String raw) {
    final parsed = double.tryParse(raw.trim());
    emit(
      state.copyWith(
        customAmount: raw,
        selectedAmount: parsed,
        amountError: null,
      ),
    );
  }

  void selectRail(PaymentRail rail) => emit(state.copyWith(rail: rail));

  void goToMethodStep() {
    final amount = state.selectedAmount;
    if (amount == null || amount < minAmount || amount > maxAmount) {
      emit(state.copyWith(amountError: TopUpAmountError.outOfRange));
      return;
    }
    emit(state.copyWith(step: 1, amountError: null));
  }

  void backToAmountStep() => emit(state.copyWith(step: 0));

  /// Creates the payment attempt. The caller routes to the status screen
  /// with the returned id and polls from there.
  Future<PaymentIntent?> pay() async {
    final amount = state.selectedAmount;
    final rail = state.rail;
    if (amount == null || rail == null) return null;

    emit(state.copyWith(intent: state.intent.toLoading()));
    final result = await _createTopUp(TopUpParams(amount: amount, rail: rail));
    return result.fold(
      (failure) {
        emit(state.copyWith(intent: state.intent.toFailed(failure)));
        return null;
      },
      (intent) {
        emit(state.copyWith(intent: LoadState.loaded(intent)));
        return intent;
      },
    );
  }
}
