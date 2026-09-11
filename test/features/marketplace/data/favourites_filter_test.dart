import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_filter.dart';

void main() {
  MockProductDataSource sourceFor([Region region = Region.nepal]) =>
      MockProductDataSource(resolver: FixedRegionResolver(region));

  group('favouritesOnly', () {
    test(
      'nothing saved yields an empty list, not the whole catalogue',
      () async {
        final source = sourceFor();
        final all = await source.fetchProducts(const ProductFilter());
        final saved = await source.fetchProducts(
          const ProductFilter(favouritesOnly: true),
        );

        expect(all, isNotEmpty);
        expect(saved.where((p) => !p.isFavourite), isEmpty);
        expect(saved.length, lessThan(all.length));
      },
    );

    test('a favourited product appears in the saved list', () async {
      final source = sourceFor();
      final target = (await source.fetchProducts(
        const ProductFilter(),
      )).firstWhere((p) => !p.isFavourite);
      await source.toggleFavourite(target.id);

      final saved = await source.fetchProducts(
        const ProductFilter(favouritesOnly: true),
      );
      expect(saved.map((p) => p.id), contains(target.id));
      expect(saved.every((p) => p.isFavourite), isTrue);
    });

    test('un-favouriting removes it again', () async {
      final source = sourceFor();
      final target = (await source.fetchProducts(
        const ProductFilter(),
      )).firstWhere((p) => !p.isFavourite);

      await source.toggleFavourite(target.id);
      await source.toggleFavourite(target.id);

      final saved = await source.fetchProducts(
        const ProductFilter(favouritesOnly: true),
      );
      expect(saved.map((p) => p.id), isNot(contains(target.id)));
    });

    test(
      'it composes with the other axes rather than replacing them',
      () async {
        final source = sourceFor();
        final all = await source.fetchProducts(const ProductFilter());
        final target = all.firstWhere((p) => !p.isFavourite);
        await source.toggleFavourite(target.id);

        // Saved, but filtered to a category the product is not in.
        final otherCategory = all
            .map((p) => p.categoryId)
            .firstWhere((c) => c != target.categoryId);
        final narrowed = await source.fetchProducts(
          ProductFilter(favouritesOnly: true, categoryId: otherCategory),
        );
        expect(narrowed.map((p) => p.id), isNot(contains(target.id)));
      },
    );

    test('the default filter does not narrow to favourites', () {
      expect(const ProductFilter().favouritesOnly, isFalse);
    });
  });
}
