import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_review.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/pending_reviews_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/product_reviews_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/cubit/write_product_review_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/pending_reviews_page.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/product_reviews_page.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/presentation/pages/write_product_review_page.dart';

import '../helpers/test_helpers.dart';

void main() {
  late MarketplaceTestStack stack;

  setUp(() => stack = MarketplaceTestStack());

  void sizePhone(WidgetTester tester) {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
  }

  group('ProductReviewsPage', () {
    Future<ProductReviewsCubit> pump(
      WidgetTester tester, {
      String productId = 'np-p1',
      bool isSeller = false,
    }) async {
      sizePhone(tester);
      final cubit = stack.reviewsCubit(productId)..load();
      await tester.pumpWidget(
        wrapPage(
          ProductReviewsView(productId: productId, isSeller: isSeller),
          providers: [BlocProvider<ProductReviewsCubit>(create: (_) => cubit)],
        ),
      );
      await settle(tester);
      return cubit;
    }

    testWidgets('shows the score, the breakdown and the reviews', (
      tester,
    ) async {
      await pump(tester);

      expect(find.text('Ratings and reviews'), findsOneWidget);
      // 5 + 4 + 3 over three reviews.
      expect(find.text('4.0'), findsOneWidget);
      expect(find.text('Verified purchase'), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a product with no reviews invites the first one', (
      tester,
    ) async {
      await pump(tester, productId: 'np-nothing');

      expect(find.text('No reviews yet'), findsOneWidget);
      expect(find.text('Be the first to review'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the seller sees a reply action, a buyer does not', (
      tester,
    ) async {
      await pump(tester, isSeller: true);
      expect(find.text('Reply'), findsWidgets);

      await pump(tester);
      expect(find.text('Reply'), findsNothing);
    });

    testWidgets('a star filter narrows the list', (tester) async {
      final cubit = await pump(tester);
      final before = cubit.state.all.length;

      await tester.runAsync(() => cubit.setMinRating(5));
      await settle(tester);

      expect(cubit.state.all.length, lessThan(before));
      expect(cubit.state.all.every((r) => r.rating >= 5), isTrue);
      // The summary still counts everything, so the headline does not move.
      expect(cubit.state.scores.total, before);
    });
  });

  group('WriteProductReviewPage', () {
    testWidgets('cannot post without a star, can with one', (tester) async {
      sizePhone(tester);
      final cubit = stack.writeReviewCubit('np-p9');
      await tester.pumpWidget(
        wrapPage(
          const WriteProductReviewView(),
          providers: [
            BlocProvider<WriteProductReviewCubit>(create: (_) => cubit),
          ],
        ),
      );
      await settle(tester);

      expect(cubit.state.canSubmit, isFalse);

      cubit.setRating(4);
      await settle(tester);
      expect(cubit.state.canSubmit, isTrue);
      // A comment is never required — a star alone is a review.
      expect(cubit.state.draft.comment, isEmpty);
      expect(tester.takeException(), isNull);
    });

    testWidgets('an order id is carried into the draft', (tester) async {
      final cubit = stack.writeReviewCubit('np-p9', orderId: 'ord-1042');
      expect(cubit.state.draft.orderId, 'ord-1042');
    });
  });

  group('PendingReviewsPage', () {
    testWidgets('lists delivered purchases waiting on a review', (
      tester,
    ) async {
      sizePhone(tester);
      await tester.pumpWidget(
        wrapPage(
          const PendingReviewsView(),
          providers: [
            BlocProvider<PendingReviewsCubit>(
              create: (_) => stack.pendingReviewsCubit()..load(),
            ),
          ],
        ),
      );
      await settle(tester);

      expect(find.text('Rate your purchases'), findsOneWidget);
      expect(find.text('Rate it'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });

  group('Summary maths', () {
    test('an empty list summarises as empty', () {
      const summary = ProductRatingSummary();
      expect(summary.isEmpty, isTrue);
      expect(summary.shareOf(4), 0);
    });
  });
}
