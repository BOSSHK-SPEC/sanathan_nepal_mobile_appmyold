import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_draft.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_form_cubit.dart';

import '../helpers/test_helpers.dart';

void main() {
  // Everything the API requires: a listing missing a location or a photo is
  // rejected server-side, so the form must not consider it valid.
  const valid = ProductDraft(
    title: 'Rudraksha Mala',
    categoryId: 'poojaSamagri',
    description: '108 beads',
    location: 'Kathmandu',
    images: ['https://cdn.test/mala.jpg'],
    price: 2500,
    phone: '+977-9800000000',
  );

  group('ProductFormCubit', () {
    test('validate flags every empty / invalid field', () {
      final errors = ProductFormCubit.validate(const ProductDraft());
      expect(errors, {
        ProductFormField.title: ProductFormError.required,
        ProductFormField.category: ProductFormError.invalidCategory,
        ProductFormField.description: ProductFormError.required,
        ProductFormField.location: ProductFormError.required,
        ProductFormField.price: ProductFormError.invalidPrice,
        ProductFormField.phone: ProductFormError.invalidPhone,
      });
      expect(ProductFormCubit.validate(valid), isEmpty);
    });

    blocTest<ProductFormCubit, ProductFormState>(
      'init (create) pre-fills the region city + phone prefix and loads '
      'categories',
      build: () => MarketplaceTestStack(region: Region.india).formCubit(),
      act: (c) => c.init(),
      verify: (c) {
        expect(c.state.isEdit, isFalse);
        expect(c.state.draft.location, 'New Delhi');
        expect(c.state.draft.phone, '+91-');
        expect(c.state.categories.dataOrNull, isNotEmpty);
      },
    );

    blocTest<ProductFormCubit, ProductFormState>(
      'init (edit) loads the product into the draft',
      build: () => MarketplaceTestStack().formCubit(),
      act: (c) => c.init(productId: 'p4'),
      wait: const Duration(milliseconds: 400),
      verify: (c) {
        expect(c.state.isEdit, isTrue);
        expect(c.state.initial.dataOrNull?.id, 'p4');
        expect(c.state.draft.title, 'Pearl (मोती)');
        expect(c.state.draft.categoryId, 'gemstones');
      },
    );

    blocTest<ProductFormCubit, ProductFormState>(
      'init (edit) with unknown id fails gracefully',
      build: () => MarketplaceTestStack().formCubit(),
      act: (c) => c.init(productId: 'nope'),
      wait: const Duration(milliseconds: 400),
      verify: (c) =>
          expect(c.state.initial.failureOrNull, isA<NotFoundFailure>()),
    );

    blocTest<ProductFormCubit, ProductFormState>(
      // Six, not seven: photos are optional, so an empty draft is invalid
      // on title, category, description, location, price and phone only.
      'submit with an empty draft records errors and does not create',
      build: () => MarketplaceTestStack().formCubit(),
      act: (c) => c.submit(),
      expect: () => [
        isA<ProductFormState>()
            .having((s) => s.submitted, 'submitted', isTrue)
            .having((s) => s.errors.length, 'errors', 6)
            .having(
              (s) => s.submission,
              'submission',
              const LoadState<Product>.idle(),
            ),
      ],
    );

    blocTest<ProductFormCubit, ProductFormState>(
      'patch after a failed submit re-validates live; submit then creates',
      build: () => MarketplaceTestStack().formCubit(),
      act: (c) async {
        await c.submit();
        c.patch((_) => valid);
        await c.submit();
      },
      wait: const Duration(milliseconds: 400),
      verify: (c) {
        expect(c.state.errors, isEmpty);
        final created = c.state.submission.dataOrNull;
        expect(created, isNotNull);
        expect(created!.isMine, isTrue);
        expect(created.title, 'Rudraksha Mala');
      },
    );

    blocTest<ProductFormCubit, ProductFormState>(
      // Photos are optional end to end: the server accepts an empty
      // `imageKeys`, and a listing with none renders a category placeholder.
      // A seller with nothing to photograph must still be able to publish.
      'publishes a listing with no photos at all',
      build: () => MarketplaceTestStack().formCubit(),
      act: (c) async {
        c.patch((_) => valid.copyWith(images: const []));
        await c.submit();
      },
      wait: const Duration(milliseconds: 400),
      verify: (c) {
        expect(c.state.errors, isEmpty);
        expect(c.state.submission.dataOrNull, isNotNull);
        expect(c.state.draft.images, isEmpty);
      },
    );

    test('validation never blocks on photos', () {
      expect(
        ProductFormCubit.validate(valid.copyWith(images: const [])),
        isEmpty,
      );
      // ...and the field is not reported as an error on an empty draft either,
      // so no inline "required" message can appear under the picker.
      expect(
        ProductFormCubit.validate(const ProductDraft()),
        isNot(contains(ProductFormField.photos)),
      );
    });

    blocTest<ProductFormCubit, ProductFormState>(
      'clearImages discards every photo in one state change',
      build: () => MarketplaceTestStack().formCubit(),
      act: (c) {
        for (var i = 0; i < 3; i++) {
          c.addImage('https://cdn.test/photo-$i.jpg');
        }
        c.clearImages();
        // A second call is a no-op rather than another emitted state.
        c.clearImages();
      },
      verify: (c) => expect(c.state.draft.images, isEmpty),
    );

    blocTest<ProductFormCubit, ProductFormState>(
      'addImage / removeImage manage uploaded photos (max 6)',
      build: () => MarketplaceTestStack().formCubit(),
      act: (c) {
        c.patch((d) => d.copyWith(categoryId: 'gemstones'));
        for (var i = 0; i < 8; i++) {
          c.addImage('https://cdn.test/photo-$i.jpg');
        }
        c.removeImage(0);
      },
      verify: (c) {
        expect(c.state.draft.images.length, 5);
        expect(c.state.draft.images.first, 'https://cdn.test/photo-1.jpg');
      },
    );

    blocTest<ProductFormCubit, ProductFormState>(
      'renameCategory keeps a display override',
      build: () => MarketplaceTestStack().formCubit(),
      act: (c) => c.renameCategory('gemstones', 'Ratna'),
      expect: () => [
        const ProductFormState(categoryNames: {'gemstones': 'Ratna'}),
      ],
    );

    blocTest<ProductFormCubit, ProductFormState>(
      'delete removes the edited listing',
      build: () => MarketplaceTestStack().formCubit(),
      act: (c) async {
        await c.init(productId: 'p4');
        await c.delete();
      },
      wait: const Duration(milliseconds: 600),
      verify: (c) => expect(c.state.deletion, const LoadState.loaded(true)),
    );
  });
}
