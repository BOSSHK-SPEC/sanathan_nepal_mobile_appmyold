import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../domain/entities/work_preferences.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'work_preferences_cubit.freezed.dart';
part 'work_preferences_state.dart';

/// Alerting and request-routing preferences.
///
/// These save on every change rather than behind a button: a toggle that
/// needs confirming reads as broken, and there is nothing here that is only
/// meaningful as part of a set.
class WorkPreferencesCubit extends AppCubit<WorkPreferencesState> {
  WorkPreferencesCubit({
    required GetWorkPreferences getPreferences,
    required SaveWorkPreferences savePreferences,
  }) : _get = getPreferences,
       _save = savePreferences,
       super(const WorkPreferencesState());

  final GetWorkPreferences _get;
  final SaveWorkPreferences _save;

  Future<void> load() async {
    emit(state.copyWith(prefs: state.prefs.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        prefs: result.fold(state.prefs.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Applies [next] optimistically and reverts if the save is rejected, so a
  /// switch never sits in a state the server did not accept.
  Future<void> _update(WorkPreferences next) async {
    final previous = state.working;
    emit(state.copyWith(prefs: LoadState.loaded(next), saveError: null));
    final result = await _save(next);
    result.fold(
      (failure) => emit(
        state.copyWith(
          prefs: LoadState.loaded(previous),
          saveError: failure.message,
        ),
      ),
      (saved) => emit(state.copyWith(prefs: LoadState.loaded(saved))),
    );
  }

  Future<void> setNewRequestAlerts(bool v) =>
      _update(state.working.copyWith(newRequestAlerts: v));

  Future<void> setAlertSound(bool v) =>
      _update(state.working.copyWith(alertSound: v));

  Future<void> setRingUntilAnswered(bool v) =>
      _update(state.working.copyWith(ringUntilAnswered: v));

  Future<void> setScheduleReminders(bool v) =>
      _update(state.working.copyWith(scheduleReminders: v));

  Future<void> setPayoutAlerts(bool v) =>
      _update(state.working.copyWith(payoutAlerts: v));

  Future<void> setReviewAlerts(bool v) =>
      _update(state.working.copyWith(reviewAlerts: v));

  Future<void> setMarketingAlerts(bool v) =>
      _update(state.working.copyWith(marketingAlerts: v));

  Future<void> setQuietHoursEnabled(bool v) =>
      _update(state.working.copyWith(quietHoursEnabled: v));

  Future<void> setQuietWindow({int? startMinute, int? endMinute}) => _update(
    state.working.copyWith(
      quietStartMinute: startMinute ?? state.working.quietStartMinute,
      quietEndMinute: endMinute ?? state.working.quietEndMinute,
    ),
  );

  Future<void> toggleChannel(ConsultChannel channel) {
    final next = {...state.working.acceptedChannels};
    next.contains(channel) ? next.remove(channel) : next.add(channel);
    // Every channel selected is the same as none selected — store the
    // canonical empty set so `acceptsChannel` has one meaning.
    return _update(
      state.working.copyWith(
        acceptedChannels: next.length == ConsultChannel.values.length
            ? const {}
            : next,
      ),
    );
  }

  Future<void> setMaxQueueLength(int v) =>
      _update(state.working.copyWith(maxQueueLength: v));

  Future<void> setAutoDeclineAfter(int seconds) =>
      _update(state.working.copyWith(autoDeclineAfterSeconds: seconds));

  Future<void> setAutoAcceptRepeatClients(bool v) =>
      _update(state.working.copyWith(autoAcceptRepeatClients: v));
}
