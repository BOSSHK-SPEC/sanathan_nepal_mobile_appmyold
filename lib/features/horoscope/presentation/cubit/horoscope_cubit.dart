import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/horoscope_period.dart';
import '../../domain/entities/horoscope_prediction.dart';
import '../../domain/entities/zodiac_sign.dart';
import '../../domain/usecases/get_all_predictions.dart';
import '../../../../core/state/app_cubit.dart';

part 'horoscope_cubit.freezed.dart';
part 'horoscope_state.dart';

/// Drives the horoscope listing page and the compact home section.
///
/// It holds no player. A clip is a url on someone else's platform and is
/// opened there; the cubit's part is only to say whether a sign has one
/// ([HoroscopeState.clipUrlOf]). This used to run a one-second timer that
/// advanced a progress bar with no audio behind it.
class HoroscopeCubit extends AppCubit<HoroscopeState> {
  HoroscopeCubit({required GetAllPredictions getAllPredictions})
    : _getAll = getAllPredictions,
      super(const HoroscopeState());

  final GetAllPredictions _getAll;

  /// Loads predictions for the current period.
  Future<void> load() => _load(state.period);

  /// Switches दैनिक / साप्ताहिक / मासिक / वार्षिक and reloads.
  Future<void> selectPeriod(HoroscopePeriod period) {
    if (period == state.period && state.predictions.isLoaded) {
      return Future.value();
    }
    emit(state.copyWith(period: period));
    return _load(period);
  }

  /// Highlights a sign (home section / dropdown).
  void selectSign(ZodiacSign sign) => emit(state.copyWith(selectedSign: sign));

  /// Toggles the ♥ of [sign].
  void toggleLike(ZodiacSign sign) {
    final liked = {...state.likedSigns};
    if (!liked.remove(sign)) liked.add(sign);
    emit(state.copyWith(likedSigns: liked));
  }

  /// Opens / closes the "More Details" area of [sign].
  void toggleDetails(ZodiacSign sign) {
    final open = {...state.expandedSigns};
    if (!open.remove(sign)) open.add(sign);
    emit(state.copyWith(expandedSigns: open));
  }

  Future<void> _load(HoroscopePeriod period) async {
    emit(state.copyWith(predictions: state.predictions.toLoading()));
    final result = await _getAll(period);
    if (isClosed) return;
    emit(
      state.copyWith(
        predictions: result.fold(state.predictions.toFailed, LoadState.loaded),
      ),
    );
  }

}
