import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/core/theme/app_theme.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_form_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/product_form_page.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/widgets/product_image_picker.dart';

import '../helpers/test_helpers.dart';

void main() {
  Widget build(
    MarketplaceTestStack stack, {
    String? productId,
    ThemeData? theme,
    Locale locale = const Locale('en'),
  }) => wrapPage(
    const ProductFormView(),
    theme: theme,
    locale: locale,
    region: stack.region,
    providers: [
      BlocProvider<ProductFormCubit>(
        create: (_) => stack.formCubit()..init(productId: productId),
      ),
    ],
  );

  void setPhone(WidgetTester tester, {double width = 375}) {
    tester.view.physicalSize = Size(width, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  testWidgets('create: validation errors, then a valid save publishes', (
    tester,
  ) async {
    setPhone(tester);
    final stack = MarketplaceTestStack();
    await tester.pumpWidget(build(stack));
    await settle(tester);

    expect(find.text('Add Product'), findsOneWidget);
    expect(find.text('Photos (0/6)'), findsOneWidget);
    final scrollable = find.byType(Scrollable).first;
    // Region defaults (fields further down the lazy list).
    await tester.scrollUntilVisible(
      find.text('+977-'),
      200,
      scrollable: scrollable,
    );
    expect(find.text('+977-'), findsOneWidget);
    expect(find.text('Kathmandu'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Save'),
      300,
      scrollable: scrollable,
    );
    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(find.text('Product published'), findsNothing);
    await tester.scrollUntilVisible(
      find.text('Enter a valid price'),
      -300,
      scrollable: scrollable,
    );
    expect(find.text('Enter a valid price'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Please choose a category'),
      -300,
      scrollable: scrollable,
    );
    expect(find.text('Please choose a category'), findsOneWidget);
    expect(find.text('This field is required'), findsWidgets);
    expect(tester.takeException(), isNull);

    // Fill the form via the cubit's public API + text fields.
    final cubit = tester
        .element(find.byType(ProductFormView))
        .read<ProductFormCubit>();
    cubit.patch(
      (d) => d.copyWith(
        title: 'Rudraksha Mala',
        categoryId: 'poojaSamagri',
        description: '108 beads',
        // A location and at least one photo are required by the API, so the
        // form now blocks on them too rather than failing at publish.
        location: 'Kathmandu',
        images: const ['https://cdn.test/mala.jpg'],
        price: 2500,
        phone: '+977-9800000000',
      ),
    );
    await tester.pump();
    expect(find.text('Enter a valid price'), findsNothing);
    await tester.scrollUntilVisible(
      find.text('Save'),
      300,
      scrollable: scrollable,
    );
    await tester.tap(find.text('Save'));
    await settle(tester);
    expect(find.text('Product published'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('edit (dark, 320 px): pre-filled fields, photo picker, delete', (
    tester,
  ) async {
    setPhone(tester, width: 320);
    final stack = MarketplaceTestStack();
    await tester.pumpWidget(
      build(stack, productId: 'p4', theme: AppTheme.dark()),
    );
    await settle(tester);

    expect(find.text('Edit Product'), findsOneWidget);
    expect(find.text('Pearl (मोती)'), findsOneWidget);
    expect(find.byType(ProductImagePicker), findsOneWidget);
    expect(find.text('Photos (3/6)'), findsOneWidget);

    // "Add photo" opens the picker rather than inventing a photo. Product
    // images are public, so the sheet offers the camera and the gallery and
    // not the file browser — a PDF could never be a product photo.
    await tester.tap(find.text('Add photo'));
    await tester.pumpAndSettle();
    expect(find.text('Take a photo'), findsOneWidget);
    expect(find.text('Choose from gallery'), findsOneWidget);
    expect(find.text('Choose a file'), findsNothing);
    expect(find.text('Max 8 MB'), findsOneWidget);

    // Dismissing it adds nothing.
    Navigator.of(tester.element(find.text('Take a photo'))).pop();
    await tester.pumpAndSettle();
    expect(find.text('Photos (3/6)'), findsOneWidget);

    // Delete via the app-bar action → confirm popup.
    await tester.tap(find.byTooltip('Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Delete this product?'), findsOneWidget);
    await tester.tap(find.text('Delete').last);
    await settle(tester);
    expect(find.text('Product deleted'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Nepali labels render on the create form', (tester) async {
    setPhone(tester);
    final stack = MarketplaceTestStack();
    await tester.pumpWidget(build(stack, locale: const Locale('ne')));
    await settle(tester);
    expect(find.text('उत्पादन थप्नुहोस्'), findsOneWidget);
    expect(find.text('फोटोहरू (०/६)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('India region shows ₹ prefix and +91 phone', (tester) async {
    setPhone(tester);
    final stack = MarketplaceTestStack(region: Region.india);
    await tester.pumpWidget(build(stack));
    await settle(tester);
    expect(find.text('Price (INR) *', findRichText: true), findsOneWidget);
    expect(find.text('₹'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('+91-'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('+91-'), findsOneWidget);
    expect(find.text('New Delhi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
