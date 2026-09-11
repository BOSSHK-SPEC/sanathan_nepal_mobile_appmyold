import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/product_review_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_review.dart';

void main() {
  late InMemoryKeyValueStore store;

  MockProductReviewDataSource sourceFor([Region region = Region.nepal]) =>
      MockProductReviewDataSource(store, FixedRegionResolver(region));

  const seededProduct = 'np-p1';

  setUp(() => store = InMemoryKeyValueStore());

  group('Reading', () {
    test('seeded reviews come back for the product they belong to', () async {
      final reviews = await sourceFor().reviews(seededProduct);
      expect(reviews, isNotEmpty);
      expect(reviews.every((r) => r.productId == seededProduct), isTrue);
    });

    test('a product with no reviews returns an empty list', () async {
      expect(await sourceFor().reviews('np-nothing'), isEmpty);
    });

    test('recent sort is newest first', () async {
      final reviews = await sourceFor().reviews(seededProduct);
      for (var i = 1; i < reviews.length; i++) {
        expect(
          reviews[i - 1].createdAt.isBefore(reviews[i].createdAt),
          isFalse,
        );
      }
    });

    test('helpful sort leads with the most-voted review', () async {
      final reviews = await sourceFor().reviews(
        seededProduct,
        sort: ReviewSort.helpful,
      );
      for (var i = 1; i < reviews.length; i++) {
        expect(reviews[i - 1].helpfulCount >= reviews[i].helpfulCount, isTrue);
      }
    });

    test('a star filter excludes everything below it', () async {
      final reviews = await sourceFor().reviews(seededProduct, minRating: 4);
      expect(reviews, isNotEmpty);
      expect(reviews.every((r) => r.rating >= 4), isTrue);
    });

    test('the photo filter keeps only reviews with photos', () async {
      final reviews = await sourceFor().reviews(
        seededProduct,
        withPhotosOnly: true,
      );
      expect(reviews, isNotEmpty);
      expect(reviews.every((r) => r.hasPhotos), isTrue);
    });
  });

  group('Summary', () {
    test('average and total match the reviews they came from', () async {
      final source = sourceFor();
      final reviews = await source.reviews(seededProduct);
      final summary = await source.summary(seededProduct);

      final expected =
          reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;
      expect(summary.total, reviews.length);
      expect(summary.average, closeTo(expected, 0.001));
    });

    test('the distribution sums to the total', () async {
      final summary = await sourceFor().summary(seededProduct);
      final counted = summary.distribution.values.reduce((a, b) => a + b);
      expect(counted, summary.total);
    });

    test('shares are a fraction of the whole', () async {
      final summary = await sourceFor().summary(seededProduct);
      var sum = 0.0;
      for (var star = 1; star <= 5; star++) {
        sum += summary.shareOf(star);
      }
      expect(sum, closeTo(1, 0.001));
    });

    test(
      'a product with no reviews summarises as empty, not as zero-star',
      () async {
        final summary = await sourceFor().summary('np-nothing');
        expect(summary.isEmpty, isTrue);
        expect(summary.average, 0);
        expect(summary.shareOf(5), 0);
      },
    );

    test('verified count only counts reviews with an order', () async {
      final source = sourceFor();
      final reviews = await source.reviews(seededProduct);
      final summary = await source.summary(seededProduct);
      expect(
        summary.verifiedCount,
        reviews.where((r) => r.orderId != null).length,
      );
    });
  });

  group('Submitting', () {
    test('a rating alone is a valid review', () async {
      final source = sourceFor();
      final review = await source.submit(
        const ProductReviewDraft(productId: 'np-p9', rating: 5),
      );
      expect(review.rating, 5);
      expect(review.comment, isEmpty);
      expect(review.isVerifiedPurchase, isFalse);
    });

    test('a review without a rating is refused', () async {
      await expectLater(
        sourceFor().submit(
          const ProductReviewDraft(productId: 'np-p9', comment: 'Nice'),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('an order id makes the review a verified purchase', () async {
      final review = await sourceFor().submit(
        const ProductReviewDraft(
          productId: 'np-p9',
          rating: 4,
          orderId: 'ord-1042',
        ),
      );
      expect(review.isVerifiedPurchase, isTrue);
    });

    test('the same buyer cannot review one product twice', () async {
      final source = sourceFor();
      await source.submit(
        const ProductReviewDraft(productId: 'np-p9', rating: 4),
      );
      await expectLater(
        source.submit(const ProductReviewDraft(productId: 'np-p9', rating: 1)),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a new review moves the average', () async {
      final source = sourceFor();
      final before = await source.summary(seededProduct);
      await source.submit(
        const ProductReviewDraft(productId: seededProduct, rating: 1),
      );
      final after = await source.summary(seededProduct);

      expect(after.total, before.total + 1);
      expect(after.average, lessThan(before.average));
    });
  });

  group('Helpful votes', () {
    test('marking is reflected in the list and survives a reload', () async {
      final source = sourceFor();
      final first = (await source.reviews(
        seededProduct,
      )).firstWhere((r) => r.helpfulCount > 0);
      await source.toggleHelpful(first.id);

      final reloaded = (await sourceFor().reviews(
        seededProduct,
      )).firstWhere((r) => r.id == first.id);
      expect(reloaded.markedHelpful, isTrue);
      expect(reloaded.helpfulCount, first.helpfulCount + 1);
    });

    test('marking twice takes the vote back', () async {
      final source = sourceFor();
      final first = (await source.reviews(seededProduct)).first;
      await source.toggleHelpful(first.id);
      await source.toggleHelpful(first.id);

      final reloaded = (await source.reviews(
        seededProduct,
      )).firstWhere((r) => r.id == first.id);
      expect(reloaded.markedHelpful, isFalse);
      expect(reloaded.helpfulCount, first.helpfulCount);
    });

    test('an unknown review is not found', () async {
      await expectLater(
        sourceFor().toggleHelpful('rev-nope'),
        throwsA(isA<NotFoundException>()),
      );
    });
  });

  group('Seller replies', () {
    test('a reply is stored against the review', () async {
      final source = sourceFor();
      final target = (await source.reviews(
        seededProduct,
      )).firstWhere((r) => !r.hasReply);

      final replied = await source.reply(target.id, 'Thank you for writing.');
      expect(replied.hasReply, isTrue);
      expect(replied.repliedAt, isNotNull);

      final reloaded = (await source.reviews(
        seededProduct,
      )).firstWhere((r) => r.id == target.id);
      expect(reloaded.sellerReply, 'Thank you for writing.');
    });

    test('a second reply is refused', () async {
      final source = sourceFor();
      final target = (await source.reviews(
        seededProduct,
      )).firstWhere((r) => !r.hasReply);
      await source.reply(target.id, 'Thank you for writing.');

      await expectLater(
        source.reply(target.id, 'And again.'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('an empty reply is refused', () async {
      final source = sourceFor();
      final target = (await source.reviews(seededProduct)).first;
      await expectLater(
        source.reply(target.id, '   '),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('Pending reviews', () {
    test('delivered purchases are listed', () async {
      expect(await sourceFor().pendingReviews(), isNotEmpty);
    });

    test('reviewing one removes it from the prompt', () async {
      final source = sourceFor();
      final pending = await source.pendingReviews();
      final first = pending.first;

      await source.submit(
        ProductReviewDraft(
          productId: first.productId,
          rating: 5,
          orderId: first.orderId,
        ),
      );

      final after = await source.pendingReviews();
      expect(after.map((p) => p.productId), isNot(contains(first.productId)));
      expect(after.length, pending.length - 1);
    });
  });

  group('Regions', () {
    test('each region seeds reviews against its own catalogue', () async {
      final india = await sourceFor(Region.india).reviews('in-p1');
      expect(india, isNotEmpty);
      expect(await sourceFor(Region.india).reviews('np-p1'), isEmpty);
    });
  });
}
