import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_details_cubit.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;
  setUp(() => stack = MarketplaceTestStack());

  group('ProductDetailsCubit', () {
    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'load returns the product, default options and similar products',
      build: () => stack.detailsCubit(),
      act: (c) => c.load('p4'),
      wait: const Duration(milliseconds: 500),
      verify: (c) {
        expect(c.state.product.isLoaded, isTrue);
        expect(c.state.product.dataOrNull?.id, 'p4');
        expect(c.state.selectedOptions['Caret'], '5');
        final similar = c.state.similar.dataOrNull!;
        expect(similar.every((p) => p.id != 'p4'), isTrue);
        expect(similar.every((p) => p.categoryId == 'gemstones'), isTrue);
      },
    );

    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'load of an unknown id fails',
      build: () => stack.detailsCubit(),
      act: (c) => c.load('nope'),
      wait: const Duration(milliseconds: 300),
      verify: (c) => expect(c.state.product.isFailed, isTrue),
    );

    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'selectOption / selectTab / addToCart update state and cart',
      build: () => stack.detailsCubit(),
      act: (c) async {
        await c.load('p4');
        c.selectOption('Caret', '7');
        c.selectTab(DetailsTab.comments);
        c.selectImage(1);
        await c.addToCart();
      },
      wait: const Duration(milliseconds: 500),
      verify: (c) async {
        expect(c.state.selectedOptions['Caret'], '7');
        expect(c.state.tab, DetailsTab.comments);
        expect(c.state.selectedImage, 1);
        expect(c.state.addToCart.isLoaded, isTrue);
        final cart = (await stack.cart.getCart()).valueOrNull!;
        expect(cart.items.single.product.id, 'p4');
        expect(cart.items.single.selectedOptions['Caret'], '7');
      },
    );
  });
}
