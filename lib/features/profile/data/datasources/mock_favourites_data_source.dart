import '../../../../core/region/region.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/region/region_resolver.dart';
import '../../domain/entities/favourite_product.dart';

/// Source of the user's favourite products.
abstract interface class FavouritesDataSource {
  Future<List<FavouriteProduct>> getFavourites();
}

/// Deterministic seed favourites (Figma "Blue Sapphire" cards); currency and
/// seller locations follow the active region (read at call time).
class MockFavouritesDataSource implements FavouritesDataSource {
  const MockFavouritesDataSource(this._resolver);
  final RegionResolver _resolver;

  static String _range(RegionConfig c, num from, num to) =>
      '${RegionFormat.money(from, config: c, languageCode: 'en')} - '
      '${RegionFormat.money(to, config: c, languageCode: 'en')}';

  @override
  Future<List<FavouriteProduct>> getFavourites() async {
    final now = DateTime.now();
    final c = _resolver.config;
    final india = c.isIndia;
    return [
      FavouriteProduct(
        // Ids match the marketplace seed so taps open real product details.
        id: india ? 'ip5' : 'p5',
        name: 'Blue Sapphire',
        description:
            'Blue Sapphire (Neelam Stone) is a profoundly valuable gemstone..',
        priceLabel: india ? _range(c, 8000, 16000) : _range(c, 10000, 20000),
        condition: 'Brand New',
        sellerName: india ? 'Pt. Rajesh Sharma' : 'Dr. Uttam Upadhyaya',
        location: india
            ? 'Chandni Chowk, New Delhi'
            : 'Basantapur (New Road), Kathmandu',
        views: 1408,
        sold: 400,
        rating: 4,
        postedAt: now.subtract(const Duration(minutes: 4)),
      ),
      FavouriteProduct(
        // India seed has a Rudraksha listing; Nepal seed maps to the pearl.
        id: india ? 'ip11' : 'p4',
        name: 'Rudraksha Mala',
        description: india
            ? 'Five-mukhi Rudraksha mala with 108 beads, energised at Kashi..'
            : 'Five-mukhi Rudraksha mala with 108 beads, energised at '
                  'Pashupati..',
        priceLabel: india ? _range(c, 1800, 3000) : _range(c, 2500, 4000),
        condition: 'Brand New',
        sellerName: 'Shree Gems & Jewels',
        location: india ? 'Zaveri Bazaar, Mumbai' : 'Boudha, Kathmandu',
        views: 980,
        sold: 215,
        rating: 5,
        postedAt: now.subtract(const Duration(hours: 2)),
      ),
    ];
  }
}
