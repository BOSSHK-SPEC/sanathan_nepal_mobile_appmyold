import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/notification_prefs.dart';
import '../../domain/usecases/get_notification_prefs.dart';
import '../../domain/usecases/save_notification_prefs.dart';
import '../../../../core/state/app_cubit.dart';

part 'notification_prefs_cubit.freezed.dart';
part 'notification_prefs_state.dart';

/// Loads / edits / saves the onboarding notification preferences.
class NotificationPrefsCubit extends AppCubit<NotificationPrefsState> {
  NotificationPrefsCubit({
    required GetNotificationPrefs getPrefs,
    required SaveNotificationPrefs savePrefs,
  }) : _get = getPrefs,
       _save = savePrefs,
       super(const NotificationPrefsState());

  final GetNotificationPrefs _get;
  final SaveNotificationPrefs _save;

  Future<void> load() async {
    emit(state.copyWith(prefs: state.prefs.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        prefs: result.fold(state.prefs.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Applies [change] to the current prefs (kept generic to avoid a setter
  /// per field).
  void update(NotificationPrefs Function(NotificationPrefs) change) =>
      emit(state.copyWith(prefs: LoadState.loaded(change(state.current))));

  Future<void> save() async {
    emit(state.copyWith(save: state.save.toLoading()));
    final result = await _save(state.current);
    emit(
      state.copyWith(
        save: result.fold(
          state.save.toFailed,
          (_) => const LoadState.loaded(null),
        ),
      ),
    );
  }
}
