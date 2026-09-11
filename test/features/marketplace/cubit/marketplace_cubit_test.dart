import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/category.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/delete_product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_boosted_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_categories.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_my_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/get_products.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/usecases/toggle_favourite.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/marketplace_cubit.dart';

import '../helpers/test_helpers.dart';

class _MockGetCategories extends Mock implements GetCategories {}

class _MockGetBoosted extends Mock implements GetBoostedProducts {}

class _MockGetProducts extends Mock implements GetProducts {}

class _MockGetMyProducts extends Mock implements GetMyProducts {}

class _MockToggleFavourite extends Mock implements ToggleFavourite {}

class _MockDeleteProduct extends Mock implements DeleteProduct {}

void main() {
  late _MockGetCategories getCategories;
  late _MockGetBoosted getBoosted;
  late _MockGetProducts getProducts;
  late _MockGetMyProducts getMyProducts;
  late _MockToggleFavourite toggleFavourite;
  late _MockDeleteProduct deleteProduct;

  final p1 = sampleProduct(id: 'a');
  final p2 = sampleProduct(id: 'b');
  const cat = Category(id: 'gemstones', nameEn: 'Gems', nameNe: 'रत्न');

  setUpAll(() => registerFallbackValue(const ProductFilter()));

  setUp(() {
    getCategories = _MockGetCategories();
    getBoosted = _MockGetBoosted();
    getProducts = _MockGetProducts();
    getMyProducts = _MockGetMyProducts();
    toggleFavourite = _MockToggleFavourite();
    deleteProduct = _MockDeleteProduct();
    when(
      () => getCategories(),
    ).thenAnswer((_) async => const Result.success([cat]));
    when(() => getBoosted()).thenAnswer((_) async => Result.success([p1]));
    when(() => getMyProducts()).thenAnswer((_) async => Result.success([p2]));
    when(
      () => getProducts(any()),
    ).thenAnswer((_) async => Result.success([p1, p2]));
  });

  MarketplaceCubit build() => MarketplaceCubit(
    getCategories: getCategories,
    getBoosted: getBoosted,
    getProducts: getProducts,
    getMyProducts: getMyProducts,
    toggleFavourite: toggleFavourite,
    deleteProduct: deleteProduct,
  );

  group('MarketplaceCubit', () {
    blocTest<MarketplaceCubit, MarketplaceState>(
      'load emits loading then success with all sections',
      build: build,
      act: (c) => c.load(),
      expect: () => [
        const MarketplaceState(
          categories: LoadState.loading(),
          boosted: LoadState.loading(),
          myProducts: LoadState.loading(),
          recent: LoadState.loading(),
          recommended: LoadState.loading(),
        ),
        MarketplaceState(
          categories: const LoadState.loaded([cat]),
          boosted: LoadState.loaded([p1]),
          myProducts: LoadState.loaded([p2]),
          recent: LoadState.loaded([p1, p2]),
          recommended: LoadState.loaded([p1, p2]),
        ),
      ],
    );

    blocTest<MarketplaceCubit, MarketplaceState>(
      'load emits failure when the feed fails',
      build: () {
        when(
          () => getProducts(any()),
        ).thenAnswer((_) async => const Result.failure(ServerFailure('boom')));
        return build();
      },
      act: (c) => c.load(),
      expect: () => [
        const MarketplaceState(
          categories: LoadState.loading(),
          boosted: LoadState.loading(),
          myProducts: LoadState.loading(),
          recent: LoadState.loading(),
          recommended: LoadState.loading(),
        ),
        MarketplaceState(
          categories: const LoadState.loaded([cat]),
          boosted: LoadState.loaded([p1]),
          myProducts: LoadState.loaded([p2]),
          recent: const LoadState.failed(ServerFailure('boom')),
          recommended: const LoadState.failed(ServerFailure('boom')),
        ),
      ],
    );

    blocTest<MarketplaceCubit, MarketplaceState>(
      'selectTab / selectFeedTab / selectCategory update state',
      build: build,
      act: (c) async {
        c.selectTab(MarketplaceTab.boost);
        c.selectFeedTab(FeedTab.recommendation);
        await c.selectCategory('gemstones');
      },
      expect: () => [
        const MarketplaceState(tab: MarketplaceTab.boost),
        const MarketplaceState(
          tab: MarketplaceTab.boost,
          feedTab: FeedTab.recommendation,
        ),
        const MarketplaceState(
          tab: MarketplaceTab.boost,
          feedTab: FeedTab.recommendation,
          selectedCategoryId: 'gemstones',
          recent: LoadState.loading(),
          recommended: LoadState.loading(),
        ),
        MarketplaceState(
          tab: MarketplaceTab.boost,
          feedTab: FeedTab.recommendation,
          selectedCategoryId: 'gemstones',
          recent: LoadState.loaded([p1, p2]),
          recommended: LoadState.loaded([p1, p2]),
        ),
      ],
      verify: (_) {
        final captured = verify(
          () => getProducts(captureAny()),
        ).captured.cast<ProductFilter>();
        expect(captured.every((f) => f.categoryId == 'gemstones'), isTrue);
      },
    );

    blocTest<MarketplaceCubit, MarketplaceState>(
      'toggleFavourite replaces the product in every list',
      build: () {
        when(() => toggleFavourite('a')).thenAnswer(
          (_) async => Result.success(p1.copyWith(isFavourite: true)),
        );
        return build();
      },
      seed: () => MarketplaceState(
        boosted: LoadState.loaded([p1]),
        recent: LoadState.loaded([p1, p2]),
      ),
      act: (c) => c.toggleFavourite('a'),
      expect: () => [
        MarketplaceState(
          boosted: LoadState.loaded([p1.copyWith(isFavourite: true)]),
          recent: LoadState.loaded([p1.copyWith(isFavourite: true), p2]),
        ),
      ],
    );

    blocTest<MarketplaceCubit, MarketplaceState>(
      'deleteMyProduct drops the listing from every slice',
      build: () {
        when(
          () => deleteProduct('b'),
        ).thenAnswer((_) async => const Result.success(null));
        return build();
      },
      seed: () => MarketplaceState(
        myProducts: LoadState.loaded([p2]),
        recent: LoadState.loaded([p1, p2]),
      ),
      act: (c) => c.deleteMyProduct('b'),
      expect: () => [
        MarketplaceState(
          myProducts: LoadState.loaded([p2]),
          recent: LoadState.loaded([p1, p2]),
          deletion: const LoadState.loading(),
        ),
        MarketplaceState(
          myProducts: const LoadState.loaded([]),
          recent: LoadState.loaded([p1]),
          deletion: const LoadState.loaded('b'),
        ),
      ],
    );

    blocTest<MarketplaceCubit, MarketplaceState>(
      'deleteMyProduct keeps lists when the use case fails',
      build: () {
        when(() => deleteProduct('b')).thenAnswer(
          (_) async => const Result.failure(PermissionFailure('nope')),
        );
        return build();
      },
      seed: () => MarketplaceState(myProducts: LoadState.loaded([p2])),
      act: (c) => c.deleteMyProduct('b'),
      expect: () => [
        MarketplaceState(
          myProducts: LoadState.loaded([p2]),
          deletion: const LoadState.loading(),
        ),
        MarketplaceState(
          myProducts: LoadState.loaded([p2]),
          deletion: const LoadState.failed(PermissionFailure('nope')),
        ),
      ],
    );
  });
}
