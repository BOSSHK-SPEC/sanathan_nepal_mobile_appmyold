import '../../../../core/storage/key_value_store.dart';
import '../models/app_preferences_model.dart';

abstract interface class AppPreferencesLocalDataSource {
  AppPreferencesModel read();
  Future<void> write(AppPreferencesModel model);
}

class AppPreferencesLocalDataSourceImpl
    implements AppPreferencesLocalDataSource {
  AppPreferencesLocalDataSourceImpl(this._store);
  final KeyValueStore _store;

  static const _kRegion = 'prefs.region';
  static const _kLanguage = 'prefs.language';
  static const _kTheme = 'prefs.theme';
  static const _kSilent = 'prefs.silent';
  static const _kOnboarded = 'prefs.onboarded';

  @override
  AppPreferencesModel read() => AppPreferencesModel(
    region: _store.getString(_kRegion),
    language: _store.getString(_kLanguage),
    theme: _store.getString(_kTheme),
    silent: _store.getBool(_kSilent),
    onboarded: _store.getBool(_kOnboarded),
  );

  @override
  Future<void> write(AppPreferencesModel model) async {
    await Future.wait([
      if (model.region != null) _store.setString(_kRegion, model.region!),
      if (model.language != null) _store.setString(_kLanguage, model.language!),
      if (model.theme != null) _store.setString(_kTheme, model.theme!),
      if (model.silent != null) _store.setBool(_kSilent, model.silent!),
      if (model.onboarded != null)
        _store.setBool(_kOnboarded, model.onboarded!),
    ]);
  }
}
