import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/notification_settings.dart';
import '../../domain/usecases/get_notification_settings.dart';
import '../../domain/usecases/save_notification_settings.dart';
import '../../../../core/state/app_cubit.dart';

part 'notification_settings_cubit.freezed.dart';
part 'notification_settings_state.dart';

/// Loads and persists [NotificationSettings]; every change is saved at once
/// (optimistic emit, then write).
class NotificationSettingsCubit extends AppCubit<NotificationSettingsState> {
  NotificationSettingsCubit({
    required GetNotificationSettings getSettings,
    required SaveNotificationSettings saveSettings,
  }) : _get = getSettings,
       _save = saveSettings,
       super(const NotificationSettingsState());

  final GetNotificationSettings _get;
  final SaveNotificationSettings _save;

  Future<void> load() async {
    emit(state.copyWith(settings: state.settings.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        settings: result.fold(state.settings.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Applies [next] immediately and persists it.
  Future<void> update(NotificationSettings next) async {
    emit(
      state.copyWith(
        settings: LoadState.loaded(next),
        save: state.save.toLoading(),
      ),
    );
    final result = await _save(next);
    emit(
      state.copyWith(
        save: result.fold(
          state.save.toFailed,
          (_) => const LoadState.loaded(null),
        ),
      ),
    );
  }

  Future<void> setHoroscopeEnabled(bool v) =>
      update(state.current.copyWith(horoscopeEnabled: v));
  Future<void> setHoroscopeDaily(bool v) =>
      update(state.current.copyWith(horoscopeDaily: v));
  Future<void> setHoroscopeMonthly(bool v) =>
      update(state.current.copyWith(horoscopeMonthly: v));
  Future<void> setHoroscopeYearly(bool v) =>
      update(state.current.copyWith(horoscopeYearly: v));
  Future<void> setHoroscopeTime(NotificationTime t) =>
      update(state.current.copyWith(horoscopeTime: t));
  Future<void> setImportantHinduFestivals(bool v) =>
      update(state.current.copyWith(importantHinduFestivals: v));
  Future<void> setCommonFestivals(bool v) =>
      update(state.current.copyWith(commonFestivals: v));
  Future<void> setPublicHolidays(bool v) =>
      update(state.current.copyWith(publicHolidays: v));
  Future<void> setFestivalRemindDays(int d) =>
      update(state.current.copyWith(festivalRemindDays: d < 0 ? 0 : d));
  Future<void> setFestivalRemindTime(NotificationTime t) =>
      update(state.current.copyWith(festivalRemindTime: t));
  Future<void> setBirthdayEnabled(bool v) =>
      update(state.current.copyWith(birthdayEnabled: v));
  Future<void> setBirthdayRemindDays(int d) =>
      update(state.current.copyWith(birthdayRemindDays: d < 0 ? 0 : d));
  Future<void> setBirthdayRemindTime(NotificationTime t) =>
      update(state.current.copyWith(birthdayRemindTime: t));

  /// Header toggle of the festivals section: turns all three options on/off.
  Future<void> setFestivalsEnabled(bool v) => update(
    state.current.copyWith(
      importantHinduFestivals: v,
      commonFestivals: v,
      publicHolidays: v,
    ),
  );
}
