part of 'notification_prefs_cubit.dart';

/// Onboarding notification step: loaded/edited [prefs] + [save] outcome.
@freezed
abstract class NotificationPrefsState with _$NotificationPrefsState {
  const NotificationPrefsState._();

  const factory NotificationPrefsState({
    @Default(LoadState.idle()) LoadState<NotificationPrefs> prefs,
    @Default(LoadState.idle()) LoadState<void> save,
  }) = _NotificationPrefsState;

  /// Preferences to render/edit – defaults until loaded.
  NotificationPrefs get current =>
      prefs.dataOrNull ?? const NotificationPrefs();

  bool get isSaving => save.isLoading;
}
