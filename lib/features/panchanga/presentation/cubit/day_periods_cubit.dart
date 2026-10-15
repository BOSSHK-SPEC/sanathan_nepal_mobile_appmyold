import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../domain/entities/panchanga.dart';
import '../../domain/entities/time_window.dart';
import '../../domain/services/panchanga_names.dart';
import '../../domain/services/sun_calculator.dart';
import '../../domain/repositories/birth_star_repository.dart';
import '../../domain/services/day_factors.dart';
import '../../domain/services/day_periods.dart';
import '../../domain/usecases/get_panchanga.dart';

part 'day_periods_cubit.freezed.dart';
part 'day_periods_state.dart';

/// Drives the day-periods screen: Choghadiya, hora and the kaal windows, all
/// read off one day's sunrise and sunset.
///
/// It loads two days, not one. Everything after sunset is measured against
/// *tomorrow's* sunrise, so the night half of the screen is a second day's
/// data — and if that day cannot be fetched the night says so rather than
/// being drawn from a guessed sunrise.
class DayPeriodsCubit extends AppCubit<DayPeriodsState> {
  DayPeriodsCubit({
    required GetPanchanga getPanchanga,
    required BirthStarRepository birthStars,
    DateTime? date,
    DateTime Function()? clock,
  }) : _getPanchanga = getPanchanga,
       _birthStars = birthStars,
       _clock = clock ?? DateTime.now,
       super(
         DayPeriodsState(
           date: _midnight(date ?? (clock ?? DateTime.now)()),
           now: (clock ?? DateTime.now)(),
           birthPada: birthStars.padaIndex,
         ),
       );

  final GetPanchanga _getPanchanga;
  final BirthStarRepository _birthStars;
  final DateTime Function() _clock;

  static DateTime _midnight(DateTime d) => DateTime(d.year, d.month, d.day);

  Future<void> load() async {
    emit(
      state.copyWith(
        now: _clock(),
        today: state.today.toLoading(),
        tomorrow: state.tomorrow.toLoading(),
      ),
    );
    final today = _getPanchanga(state.date);
    final tomorrow = _getPanchanga(state.date.add(const Duration(days: 1)));
    final todayResult = await today;
    final tomorrowResult = await tomorrow;
    emit(
      state.copyWith(
        now: _clock(),
        today: todayResult.fold(state.today.toFailed, LoadState.loaded),
        tomorrow: tomorrowResult.fold(
          state.tomorrow.toFailed,
          LoadState.loaded,
        ),
      ),
    );
  }

  void selectView(DayPeriodView view) {
    if (view == state.view) return;
    emit(state.copyWith(view: view, now: _clock()));
  }

  /// Remembers the reader's birth pada, which is what tara bala, chandra bala
  /// and chandrashtama are counted from. [pada] is 1–4.
  Future<void> setBirthStar({required int nakshatra, required int pada}) async {
    await _birthStars.save(nakshatra * 4 + (pada - 1));
    emit(state.copyWith(birthPada: _birthStars.padaIndex));
  }

  /// Moves the "now" marker. The screen calls this on a timer, and on resume —
  /// a page left open overnight must not keep pointing at last evening.
  void tick() => emit(state.copyWith(now: _clock()));
}
