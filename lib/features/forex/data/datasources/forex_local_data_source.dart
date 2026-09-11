import '../../../../core/region/region_all.dart';
import '../../../../core/storage/key_value_store.dart';

/// Persists the currencies pinned to the home page.
abstract interface class ForexLocalDataSource {
  List<String> readFavourites();
  Future<void> writeFavourites(List<String> iso3s);
}

/// Key-value backed store. Favourites are kept **per region** (key suffixed
/// with the region code) because the Nepal and India catalogues differ, and
/// each region has its own Figma default set.
class ForexLocalDataSourceImpl implements ForexLocalDataSource {
  const ForexLocalDataSourceImpl(
    this._store, [
    this._resolver = const FixedRegionResolver(Region.nepal),
  ]);
  final KeyValueStore _store;
  final RegionResolver _resolver;

  static const String _keyPrefix = 'forex.favourites';

  /// Nepal Figma default: USD / GBP / AUD are shown in the section header.
  static const List<String> defaults = ['USD', 'GBP', 'AUD'];

  /// India default: USD / GBP / EUR.
  static const List<String> defaultsIndia = ['USD', 'GBP', 'EUR'];

  /// Default pinned currencies for [region].
  static List<String> defaultsFor(Region region) => switch (region) {
    Region.nepal => defaults,
    Region.india => defaultsIndia,
  };

  String get _key => '$_keyPrefix.${_resolver.region.code}';

  @override
  List<String> readFavourites() =>
      _store.getStringList(_key) ?? List.of(defaultsFor(_resolver.region));

  @override
  Future<void> writeFavourites(List<String> iso3s) =>
      _store.setStringList(_key, iso3s);
}
