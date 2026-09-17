import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/bounded_json_cache.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';

/// Computed panchanga is cached so a day fetched once shows exactly offline.
/// These pin that the cache round-trips JSON and cannot grow without bound.
void main() {
  late InMemoryKeyValueStore store;
  late BoundedJsonCache cache;

  setUp(() {
    store = InMemoryKeyValueStore();
    cache = BoundedJsonCache(store, namespace: 'test', maxEntries: 3);
  });

  test('round-trips a map and a list', () async {
    await cache.write('day', {'tithi': 'Tritiya', 'index': 2});
    await cache.write('month', [
      {'date': '2026-09-14'},
      {'date': '2026-09-15'},
    ]);
    expect(cache.readMap('day'), {'tithi': 'Tritiya', 'index': 2});
    expect(cache.readList('month'), hasLength(2));
  });

  test('misses cleanly on an absent key or the wrong shape', () async {
    expect(cache.readMap('nothing'), isNull);
    await cache.write('list', [1, 2]);
    expect(cache.readMap('list'), isNull);
  });

  test('treats a corrupt entry as a miss', () async {
    await store.setString('test.broken', '{not json');
    expect(cache.readMap('broken'), isNull);
  });

  test('evicts the oldest entry past its limit', () async {
    for (final key in ['a', 'b', 'c', 'd']) {
      await cache.write(key, {'key': key});
    }
    expect(cache.readMap('a'), isNull);
    expect(cache.readMap('d'), {'key': 'd'});
    expect(store.getStringList('test.__index'), ['b', 'c', 'd']);
  });

  test('rewriting a key refreshes it instead of evicting it', () async {
    await cache.write('a', 1);
    await cache.write('b', 2);
    await cache.write('c', 3);
    await cache.write('a', 10);
    await cache.write('d', 4);
    expect(cache.read('a'), 10);
    expect(cache.read('b'), isNull);
  });
}
