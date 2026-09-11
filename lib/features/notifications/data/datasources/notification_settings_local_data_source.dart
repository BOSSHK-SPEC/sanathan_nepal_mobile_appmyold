import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/key_value_store.dart';
import '../models/notification_settings_model.dart';

/// Persists [NotificationSettingsModel] as a JSON string in [KeyValueStore].
abstract interface class NotificationSettingsLocalDataSource {
  NotificationSettingsModel read();
  Future<void> write(NotificationSettingsModel settings);
}

class NotificationSettingsLocalDataSourceImpl
    implements NotificationSettingsLocalDataSource {
  NotificationSettingsLocalDataSourceImpl(this._store);

  final KeyValueStore _store;

  static const String storageKey = 'notifications.settings';

  @override
  NotificationSettingsModel read() {
    try {
      return NotificationSettingsModel.decode(_store.getString(storageKey));
    } on FormatException {
      return const NotificationSettingsModel();
    }
  }

  @override
  Future<void> write(NotificationSettingsModel settings) async {
    final ok = await _store.setString(storageKey, settings.encode());
    if (!ok) throw const CacheException('Could not save notification settings');
  }
}
