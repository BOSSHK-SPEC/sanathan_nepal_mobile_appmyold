import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/data/datasources/mock_astrologer_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/astrologer_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/astrologer_review.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/specialty.dart';

void main() {
  late InMemoryKeyValueStore store;

  MockAstrologerDataSource sourceFor(Region region) =>
      MockAstrologerDataSource(store, FixedRegionResolver(region));

  setUp(() => store = InMemoryKeyValueStore());

  group('Region catalogue', () {
    test('Nepal and India return different astrologers', () async {
      final np = await sourceFor(
        Region.nepal,
      ).getAstrologers(const AstrologerFilter());
      final ind = await sourceFor(
        Region.india,
      ).getAstrologers(const AstrologerFilter());
      expect(np, isNotEmpty);
      expect(ind, isNotEmpty);
      expect(
        np.map((a) => a.id).toSet().intersection(ind.map((a) => a.id).toSet()),
        isEmpty,
      );
    });

    test('Nepal offers Nepali, India does not', () async {
      final np = await sourceFor(Region.nepal).getLanguages();
      final ind = await sourceFor(Region.india).getLanguages();
      expect(np, contains('ne'));
      expect(ind, isNot(contains('ne')));
      expect(ind, contains('hi'));
    });
  });

  group('Filtering', () {
    test('onlineOnly excludes offline astrologers', () async {
      final result = await sourceFor(
        Region.nepal,
      ).getAstrologers(const AstrologerFilter(onlineOnly: true));
      expect(result, isNotEmpty);
      expect(result.every((a) => a.isOnline), isTrue);
    });

    test('specialty filter matches on any of the selected values', () async {
      final result = await sourceFor(
        Region.nepal,
      ).getAstrologers(const AstrologerFilter(specialties: {Specialty.tarot}));
      expect(result, isNotEmpty);
      expect(
        result.every((a) => a.specialties.contains(Specialty.tarot)),
        isTrue,
      );
    });

    test('channel filter keeps only astrologers offering it', () async {
      final result = await sourceFor(Region.india).getAstrologers(
        const AstrologerFilter(channels: {ConsultChannel.video}),
      );
      expect(result, isNotEmpty);
      expect(
        result.every((a) => a.channels.contains(ConsultChannel.video)),
        isTrue,
      );
    });

    test('maxRate compares against the cheapest channel', () async {
      final result = await sourceFor(
        Region.nepal,
      ).getAstrologers(const AstrologerFilter(maxRate: 15));
      expect(result.every((a) => a.lowestRate <= 15), isTrue);
    });

    test('minRating and minExperience narrow together', () async {
      final result = await sourceFor(Region.nepal).getAstrologers(
        const AstrologerFilter(minRating: 4.7, minExperience: 20),
      );
      expect(
        result.every((a) => a.rating >= 4.7 && a.experienceYears >= 20),
        isTrue,
      );
    });

    test('query matches across languages', () async {
      final source = sourceFor(Region.nepal);
      final byEnglish = await source.getAstrologers(
        const AstrologerFilter(query: 'Sarita'),
      );
      final byNepali = await source.getAstrologers(
        const AstrologerFilter(query: 'सरिता'),
      );
      expect(byEnglish.single.id, 'np-sarita');
      expect(byNepali.single.id, 'np-sarita');
    });

    test('an impossible combination returns empty, not an error', () async {
      final result = await sourceFor(
        Region.nepal,
      ).getAstrologers(const AstrologerFilter(minRating: 5, minExperience: 50));
      expect(result, isEmpty);
    });
  });

  group('Sorting', () {
    test('recommended puts free-now above busy above offline', () async {
      final result = await sourceFor(
        Region.nepal,
      ).getAstrologers(const AstrologerFilter());
      int rank(bool online, int queue) => !online ? 2 : (queue == 0 ? 0 : 1);
      final ranks = [for (final a in result) rank(a.isOnline, a.queueLength)];
      expect(
        List<int>.from(ranks)..sort(),
        ranks,
        reason: 'presence groups must not interleave',
      );
    });

    test('priceLow is ascending by cheapest rate', () async {
      final result = await sourceFor(
        Region.nepal,
      ).getAstrologers(const AstrologerFilter(sort: AstrologerSort.priceLow));
      final rates = result.map((a) => a.lowestRate).toList();
      expect(List<double>.from(rates)..sort(), rates);
    });

    test('experienceHigh is descending by years', () async {
      final result = await sourceFor(Region.nepal).getAstrologers(
        const AstrologerFilter(sort: AstrologerSort.experienceHigh),
      );
      final years = result.map((a) => a.experienceYears).toList();
      expect(years, List<int>.from(years)..sort((a, b) => b.compareTo(a)));
    });
  });

  group('Follow', () {
    test('toggles and persists across data source instances', () async {
      final following = await sourceFor(Region.nepal).toggleFollow('np-uttam');
      expect(following, isTrue);

      // A fresh instance reads the same store — as a real account would.
      final list = await sourceFor(
        Region.nepal,
      ).getAstrologers(const AstrologerFilter());
      expect(list.firstWhere((a) => a.id == 'np-uttam').isFollowing, isTrue);

      expect(await sourceFor(Region.nepal).toggleFollow('np-uttam'), isFalse);
    });

    test('followingOnly narrows to followed astrologers', () async {
      final source = sourceFor(Region.nepal);
      await source.toggleFollow('np-uttam');

      final following = await source.getAstrologers(
        const AstrologerFilter(followingOnly: true),
      );
      expect(following.map((a) => a.id), ['np-uttam']);
      expect(following.single.isFollowing, isTrue);
    });

    test('following nobody yields an empty list, not everybody', () async {
      final following = await sourceFor(
        Region.nepal,
      ).getAstrologers(const AstrologerFilter(followingOnly: true));
      expect(following, isEmpty);
    });

    test('followingOnly survives clearing the filter sheet', () {
      const filter = AstrologerFilter(
        followingOnly: true,
        onlineOnly: true,
        minRating: 4,
      );
      final cleared = filter.cleared();
      expect(cleared.followingOnly, isTrue);
      expect(cleared.onlineOnly, isFalse);
      expect(cleared.hasFilters, isFalse);
    });
  });

  group('Reviews', () {
    test('submitted reviews appear first', () async {
      final source = sourceFor(Region.nepal);
      await source.submitReview(
        const ReviewDraft(
          astrologerId: 'np-uttam',
          rating: 5,
          comment: 'Excellent',
        ),
      );
      final reviews = await source.getReviews('np-uttam');
      expect(reviews.first.comment, 'Excellent');
      expect(reviews.length, greaterThan(1));
    });

    test('rejects an out-of-range rating as a validation error', () async {
      expect(
        () => sourceFor(
          Region.nepal,
        ).submitReview(const ReviewDraft(astrologerId: 'np-uttam', rating: 0)),
        throwsA(isA<ValidationException>()),
      );
    });

    test('reviews are scoped to their astrologer', () async {
      final reviews = await sourceFor(Region.nepal).getReviews('np-sarita');
      expect(reviews, isNotEmpty);
      expect(reviews.every((r) => r.astrologerId == 'np-sarita'), isTrue);
    });
  });

  group('Reporting', () {
    test('"other" requires details', () async {
      expect(
        () => sourceFor(Region.nepal).report(
          const ReportDraft(
            astrologerId: 'np-uttam',
            reason: ReportReason.other,
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a specific reason needs no details', () async {
      await expectLater(
        sourceFor(Region.nepal).report(
          const ReportDraft(
            astrologerId: 'np-uttam',
            reason: ReportReason.rude,
          ),
        ),
        completes,
      );
    });
  });

  group('Recent searches', () {
    test('newest first, de-duplicated case-insensitively, capped', () async {
      final source = sourceFor(Region.nepal);
      await source.saveSearch('tarot');
      await source.saveSearch('vaastu');
      await source.saveSearch('TAROT');
      expect(await source.recentSearches(), ['TAROT', 'vaastu']);

      for (var i = 0; i < 12; i++) {
        await source.saveSearch('query $i');
      }
      expect((await source.recentSearches()).length, 8);
    });

    test('blank queries are not recorded', () async {
      final source = sourceFor(Region.nepal);
      await source.saveSearch('   ');
      expect(await source.recentSearches(), isEmpty);
    });
  });

  test('an unknown id is a not-found error', () async {
    expect(
      () => sourceFor(Region.nepal).getAstrologer('nope'),
      throwsA(isA<NotFoundException>()),
    );
  });
}
