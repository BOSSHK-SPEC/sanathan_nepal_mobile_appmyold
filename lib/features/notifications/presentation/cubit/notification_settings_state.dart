part of 'notification_settings_cubit.dart';

/// State of the notification settings tab.
@freezed
abstract class NotificationSettingsState with _$NotificationSettingsState {
  const NotificationSettingsState._();

  const factory NotificationSettingsState({
    /// Persisted settings (loaded once, then updated optimistically).
    @Default(LoadState.idle()) LoadState<NotificationSettings> settings,

    /// Outcome of the most recent save.
    @Default(LoadState.idle()) LoadState<void> save,
  }) = _NotificationSettingsState;

  /// Settings to render/edit – defaults until loaded.
  NotificationSettings get current =>
      settings.dataOrNull ?? const NotificationSettings();
}
