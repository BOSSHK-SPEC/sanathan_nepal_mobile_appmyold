import 'package:shared_preferences/shared_preferences.dart';

/// Abstraction over local key–value persistence (DIP: features depend on this
/// interface, not on `shared_preferences`).
abstract interface class KeyValueStore {
  Future<bool> setString(String key, String value);
  String? getString(String key);
  Future<bool> setBool(String key, bool value);
  bool? getBool(String key);
  Future<bool> setInt(String key, int value);
  int? getInt(String key);
  Future<bool> setStringList(String key, List<String> value);
  List<String>? getStringList(String key);
  Future<bool> remove(String key);
  bool containsKey(String key);
}

class SharedPrefsKeyValueStore implements KeyValueStore {
  SharedPrefsKeyValueStore(this._prefs);
  final SharedPreferences _prefs;

  @override
  bool containsKey(String key) => _prefs.containsKey(key);
  @override
  bool? getBool(String key) => _prefs.getBool(key);
  @override
  int? getInt(String key) => _prefs.getInt(key);
  @override
  String? getString(String key) => _prefs.getString(key);
  @override
  List<String>? getStringList(String key) => _prefs.getStringList(key);
  @override
  Future<bool> remove(String key) => _prefs.remove(key);
  @override
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  @override
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);
  @override
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
  @override
  Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);
}

/// In-memory implementation for tests / previews.
class InMemoryKeyValueStore implements KeyValueStore {
  final Map<String, Object> _map = {};
  @override
  bool containsKey(String key) => _map.containsKey(key);
  @override
  bool? getBool(String key) => _map[key] as bool?;
  @override
  int? getInt(String key) => _map[key] as int?;
  @override
  String? getString(String key) => _map[key] as String?;
  @override
  List<String>? getStringList(String key) => _map[key] as List<String>?;
  @override
  Future<bool> remove(String key) async => _map.remove(key) != null;
  @override
  Future<bool> setBool(String key, bool value) async {
    _map[key] = value;
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _map[key] = value;
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _map[key] = value;
    return true;
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    _map[key] = value;
    return true;
  }
}
