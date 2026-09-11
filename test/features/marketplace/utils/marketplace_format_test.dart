import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/utils/marketplace_format.dart';

void main() {
  group('MarketplaceFormat', () {
    test('groups digits Nepali style', () {
      expect(MarketplaceFormat.groupNepali(4000000), '40,00,000');
      expect(MarketplaceFormat.groupNepali(50000), '50,000');
      expect(MarketplaceFormat.groupNepali(999), '999');
      expect(MarketplaceFormat.groupNepali(1408), '1,408');
      expect(MarketplaceFormat.groupNepali(12000000), '1,20,00,000');
      expect(MarketplaceFormat.groupNepali(450, decimals: true), '450.00');
    });

    test('renders currency per region and language', () {
      const np = RegionConfig.nepal;
      const ind = RegionConfig.india;
      expect(
        MarketplaceFormat.price(2000, config: np, languageCode: 'en'),
        'Rs. 2,000',
      );
      expect(
        MarketplaceFormat.price(2000, config: np, languageCode: 'ne'),
        'रु. २,०००',
      );
      expect(
        MarketplaceFormat.price(4000000, config: ind, languageCode: 'en'),
        '₹40,00,000',
      );
      expect(
        MarketplaceFormat.price(
          450,
          config: ind,
          languageCode: 'hi',
          decimals: true,
        ),
        '₹४५०.००',
      );
      expect(MarketplaceFormat.count(1408, devanagari: true), '१,४०८');
      expect(MarketplaceFormat.count(1408, devanagari: false), '1,408');
    });
  });
}
