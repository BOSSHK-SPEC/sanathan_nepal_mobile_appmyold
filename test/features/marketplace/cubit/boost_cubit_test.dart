import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/boost_cubit.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;
  setUp(() => stack = MarketplaceTestStack());

  group('BoostCubit', () {
    blocTest<BoostCubit, BoostState>(
      'load lists only my products and selects the first plan',
      build: () => stack.boostCubit(),
      act: (c) => c.load(),
      wait: const Duration(milliseconds: 300),
      verify: (c) {
        expect(c.state.products.isLoaded, isTrue);
        final products = c.state.products.dataOrNull!;
        expect(products, isNotEmpty);
        expect(products.every((p) => p.isMine), isTrue);
        expect(c.state.plan?.hours, 12);
        expect(c.state.plans.dataOrNull?.length, 4);
      },
    );

    blocTest<BoostCubit, BoostState>(
      'next is ignored with no selection, then moves to the form',
      build: () => stack.boostCubit(),
      act: (c) async {
        await c.load();
        c.next();
        c.toggleSelection('p4');
        c.toggleSelection('p5');
        c.next();
      },
      wait: const Duration(milliseconds: 300),
      verify: (c) {
        expect(c.state.step, BoostStep.form);
        expect(c.state.selectedIds, {'p4', 'p5'});
        expect(c.state.total, 2000);
      },
    );

    blocTest<BoostCubit, BoostState>(
      'setSort re-queries, submit returns a receipt and resets the flow',
      build: () => stack.boostCubit(),
      act: (c) async {
        await c.load();
        await c.setSort(ProductSort.priceHighToLow);
        c.toggleSelection('p4');
        c.selectPlan(c.state.plans.dataOrNull![1]);
        c.next();
        await c.submit(
          firstName: 'Ram',
          lastName: 'Thapa',
          phone: '+977-9800000000',
          productLink: 'https://x',
        );
      },
      wait: const Duration(milliseconds: 800),
      verify: (c) {
        expect(c.state.submission.isLoaded, isTrue);
        final receipt = c.state.submission.dataOrNull;
        expect(receipt?.total, 1800);
        expect(receipt?.referenceId, startsWith('BST'));
        expect(c.state.step, BoostStep.select);
        expect(c.state.selectedIds, isEmpty);
        expect(c.state.sort, ProductSort.priceHighToLow);
      },
    );
  });
}
