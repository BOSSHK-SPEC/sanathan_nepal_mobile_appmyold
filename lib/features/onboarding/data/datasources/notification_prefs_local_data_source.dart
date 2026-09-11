import 'dart:convert';

import '../../../../core/storage/key_value_store.dart';
import '../models/notification_prefs_model.dart';

/// Local persistence of onboarding notification preferences.
abstract interface class NotificationPrefsLocalDataSource {
  NotificationPrefsModel read();
  Future<void> write(NotificationPrefsModel model);
}

class NotificationPrefsLocalDataSourceImpl
    implements NotificationPrefsLocalDataSource {
  NotificationPrefsLocalDataSourceImpl(this._store);
  final KeyValueStore _store;

  static const String kPrefs = 'onboarding.notification_prefs';

  @override
  NotificationPrefsModel read() {
    final raw = _store.getString(kPrefs);
    if (raw == null) return const NotificationPrefsModel();
    return NotificationPrefsModel.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> write(NotificationPrefsModel model) =>
      _store.setString(kPrefs, jsonEncode(model.toJson()));
}
