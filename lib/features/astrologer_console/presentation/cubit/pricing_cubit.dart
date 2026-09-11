import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../domain/entities/console_pricing.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'pricing_cubit.freezed.dart';
part 'pricing_state.dart';

/// Per-channel rates and first-session offers.
class PricingCubit extends AppCubit<PricingState> {
  PricingCubit({
    required GetPricing getPricing,
    required SavePricing savePricing,
  }) : _get = getPricing,
       _save = savePricing,
       super(const PricingState());

  final GetPricing _get;
  final SavePricing _save;

  Future<void> load() async {
    emit(state.copyWith(pricing: state.pricing.toLoading()));
    final result = await _get();
    result.fold(
      (failure) =>
          emit(state.copyWith(pricing: state.pricing.toFailed(failure))),
      (pricing) => emit(
        state.copyWith(pricing: LoadState.loaded(pricing), draft: pricing),
      ),
    );
  }

  void setRate(ConsultChannel channel, double? rate) {
    final next = {...state.working.ratePerMinute};
    if (rate == null || rate <= 0) {
      next.remove(channel);
    } else {
      next[channel] = rate;
    }
    emit(
      state.copyWith(
        draft: state.working.copyWith(ratePerMinute: next),
        saveError: null,
      ),
    );
  }

  void setFreeMinutes(int minutes) => emit(
    state.copyWith(draft: state.working.copyWith(freeFirstMinutes: minutes)),
  );

  Future<bool> save() async {
    emit(state.copyWith(saving: state.saving.toLoading(), saveError: null));
    final result = await _save(state.working);
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
      (pricing) {
        emit(
          state.copyWith(
            saving: LoadState.loaded(pricing),
            pricing: LoadState.loaded(pricing),
            draft: pricing,
          ),
        );
        return true;
      },
    );
  }
}
