import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_listing_cubit.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;
  setUp(() => stack = MarketplaceTestStack());

  group('ProductListingCubit', () {
    blocTest<ProductListingCubit, ProductListingState>(
      'load with category filters and sorts by latest',
      build: () => stack.listingCubit(),
      act: (c) => c.load(categoryId: 'gemstones'),
      wait: const Duration(milliseconds: 300),
      verify: (c) {
        expect(c.state.products.isLoaded, isTrue);
        final products = c.state.products.dataOrNull!;
        expect(products, isNotEmpty);
        expect(products.every((p) => p.categoryId == 'gemstones'), isTrue);
        expect(c.state.category?.nameEn, 'Gem Stones');
        for (var i = 1; i < products.length; i++) {
          expect(
            products[i - 1].postedAt.isAfter(products[i].postedAt) ||
                products[i - 1].postedAt == products[i].postedAt,
            isTrue,
          );
        }
      },
    );

    blocTest<ProductListingCubit, ProductListingState>(
      'search + setSort priceLowToHigh orders ascending',
      build: () => stack.listingCubit(),
      act: (c) async {
        await c.load();
        await c.search('kathmandu');
        await c.setSort(ProductSort.priceLowToHigh);
      },
      wait: const Duration(milliseconds: 300),
      verify: (c) {
        final prices = c.state.products.dataOrNull!
            .map((p) => p.price)
            .toList();
        expect(prices, isNotEmpty);
        expect(prices, orderedEquals([...prices]..sort()));
        expect(c.state.filter.query, 'kathmandu');
      },
    );

    blocTest<ProductListingCubit, ProductListingState>(
      'toggleFavourite flips the flag on the listed product',
      build: () => stack.listingCubit(),
      act: (c) async {
        await c.load(categoryId: 'automobiles');
        await c.toggleFavourite(c.state.products.dataOrNull!.first.id);
      },
      wait: const Duration(milliseconds: 300),
      verify: (c) =>
          expect(c.state.products.dataOrNull!.first.isFavourite, isTrue),
    );
  });
}
