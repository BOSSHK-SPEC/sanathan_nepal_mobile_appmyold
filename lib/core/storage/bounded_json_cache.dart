import 'dart:convert';

import 'key_value_store.dart';

/// A small JSON cache on top of [KeyValueStore] that cannot grow without
/// bound.
///
/// For data that is deterministic once published — a computed panchanga day
/// never changes — so a copy fetched once can be shown offline indefinitely.
/// Entries are evicted oldest-first past [maxEntries], so a user browsing
/// years of calendar does not fill the device's preferences file.
class BoundedJsonCache {
  BoundedJsonCache(
    this._store, {
    required this.namespace,
    this.maxEntries = 120,
  });

  final KeyValueStore _store;
  final String namespace;
  final int maxEntries;

  String get _indexKey => '$namespace.__index';
  String _key(String key) => '$namespace.$key';

  Object? read(String key) {
    final raw = _store.getString(_key(key));
    if (raw == null) return null;
    try {
      return jsonDecode(raw);
    } on FormatException {
      // A corrupt entry is a miss, not a crash.
      return null;
    }
  }

  Map<String, dynamic>? readMap(String key) {
    final value = read(key);
    return value is Map ? Map<String, dynamic>.from(value) : null;
  }

  List<Map<String, dynamic>>? readList(String key) {
    final value = read(key);
    if (value is! List) return null;
    return [
      for (final entry in value)
        if (entry is Map) Map<String, dynamic>.from(entry),
    ];
  }

  Future<void> write(String key, Object? value) async {
    await _store.setString(_key(key), jsonEncode(value));
    final index = [...?_store.getStringList(_indexKey)]
      ..remove(key)
      ..add(key);
    while (index.length > maxEntries) {
      await _store.remove(_key(index.removeAt(0)));
    }
    await _store.setStringList(_indexKey, index);
  }
}
