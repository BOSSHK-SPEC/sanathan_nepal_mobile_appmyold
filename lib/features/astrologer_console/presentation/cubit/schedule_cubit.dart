import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/availability.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'schedule_cubit.freezed.dart';
part 'schedule_state.dart';

/// Weekly availability and blackout dates.
class ScheduleCubit extends AppCubit<ScheduleState> {
  ScheduleCubit({
    required GetAvailability getAvailability,
    required SaveAvailability saveAvailability,
  }) : _get = getAvailability,
       _save = saveAvailability,
       super(const ScheduleState());

  final GetAvailability _get;
  final SaveAvailability _save;

  Future<void> load() async {
    emit(state.copyWith(availability: state.availability.toLoading()));
    final result = await _get();
    result.fold(
      (failure) => emit(
        state.copyWith(availability: state.availability.toFailed(failure)),
      ),
      (availability) => emit(
        state.copyWith(
          availability: LoadState.loaded(availability),
          draft: availability,
        ),
      ),
    );
  }

  void addWindow(AvailabilityWindow window) => emit(
    state.copyWith(
      draft: state.working.copyWith(
        windows: [...state.working.windows, window],
      ),
      saveError: null,
    ),
  );

  void removeWindow(AvailabilityWindow window) => emit(
    state.copyWith(
      draft: state.working.copyWith(
        windows: state.working.windows.where((w) => w != window).toList(),
      ),
      saveError: null,
    ),
  );

  void addBlackout(BlackoutDate blackout) => emit(
    state.copyWith(
      draft: state.working.copyWith(
        blackouts: [...state.working.blackouts, blackout]
          ..sort((a, b) => a.date.compareTo(b.date)),
      ),
    ),
  );

  void removeBlackout(BlackoutDate blackout) => emit(
    state.copyWith(
      draft: state.working.copyWith(
        blackouts: state.working.blackouts
            .where((b) => b.date != blackout.date)
            .toList(),
      ),
    ),
  );

  void setBuffer(int minutes) => emit(
    state.copyWith(draft: state.working.copyWith(bufferMinutes: minutes)),
  );

  /// Copies one day's windows onto every other weekday — the single most
  /// requested shortcut on a schedule screen.
  void copyToAllWeekdays(int weekday) {
    final source = state.working.windowsOn(weekday);
    if (source.isEmpty) return;
    final others = state.working.windows
        .where((w) => w.weekday == 6 || w.weekday == 7)
        .toList();
    emit(
      state.copyWith(
        draft: state.working.copyWith(
          windows: [
            for (var day = 1; day <= 5; day++)
              for (final w in source) w.copyWith(weekday: day),
            ...others.where((w) => w.weekday != weekday),
          ],
        ),
        saveError: null,
      ),
    );
  }

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
      (availability) {
        emit(
          state.copyWith(
            saving: LoadState.loaded(availability),
            availability: LoadState.loaded(availability),
            draft: availability,
          ),
        );
        return true;
      },
    );
  }
}
