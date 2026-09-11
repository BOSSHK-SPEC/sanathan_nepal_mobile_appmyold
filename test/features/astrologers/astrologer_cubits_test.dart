import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/localized_text.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/astrologer.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/astrologer_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/astrologer_review.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/consult_channel.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/entities/specialty.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/usecases/get_astrologers.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/usecases/get_consult_languages.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/usecases/manage_recent_searches.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/usecases/submit_astrologer_review.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/domain/usecases/toggle_follow_astrologer.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/presentation/cubit/astrologer_list_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/presentation/cubit/write_review_cubit.dart';

class _MockGetAstrologers extends Mock implements GetAstrologers {}

class _MockGetLanguages extends Mock implements GetConsultLanguages {}

class _MockToggleFollow extends Mock implements ToggleFollowAstrologer {}

class _MockGetRecent extends Mock implements GetRecentSearches {}

class _MockSaveRecent extends Mock implements SaveRecentSearch {}

class _MockClearRecent extends Mock implements ClearRecentSearches {}

class _MockSubmitReview extends Mock implements SubmitAstrologerReview {}

const _astrologer = Astrologer(
  id: 'a1',
  name: LocalizedText(ne: 'क', en: 'Ram'),
  headline: LocalizedText(ne: 'क', en: 'Vedic'),
  about: LocalizedText(ne: 'क', en: 'About'),
  specialties: [Specialty.vedic],
  languageCodes: ['en'],
  experienceYears: 10,
  rating: 4.5,
  reviewCount: 12,
  ratePerMinute: {ConsultChannel.chat: 20},
);

void main() {
  late _MockGetAstrologers getAstrologers;
  late _MockGetLanguages getLanguages;
  late _MockToggleFollow toggleFollow;
  late _MockGetRecent getRecent;
  late _MockSaveRecent saveRecent;
  late _MockClearRecent clearRecent;

  setUpAll(() {
    registerFallbackValue(const AstrologerFilter());
    registerFallbackValue(const ReviewDraft(astrologerId: 'a1', rating: 5));
  });

  setUp(() {
    getAstrologers = _MockGetAstrologers();
    getLanguages = _MockGetLanguages();
    toggleFollow = _MockToggleFollow();
    getRecent = _MockGetRecent();
    saveRecent = _MockSaveRecent();
    clearRecent = _MockClearRecent();

    when(
      () => getAstrologers(any()),
    ).thenAnswer((_) async => const Result.success([_astrologer]));
    when(
      getLanguages.call,
    ).thenAnswer((_) async => const Result.success(['en']));
    when(getRecent.call).thenAnswer((_) async => const Result.success(['x']));
    when(
      () => saveRecent(any()),
    ).thenAnswer((_) async => const Result.success(null));
    when(clearRecent.call).thenAnswer((_) async => const Result.success(null));
  });

  AstrologerListCubit build() => AstrologerListCubit(
    getAstrologers: getAstrologers,
    getLanguages: getLanguages,
    toggleFollow: toggleFollow,
    getRecentSearches: getRecent,
    saveRecentSearch: saveRecent,
    clearRecentSearches: clearRecent,
  );

  group('AstrologerListCubit', () {
    blocTest<AstrologerListCubit, AstrologerListState>(
      'load fills astrologers, languages and recent searches',
      build: build,
      act: (c) => c.load(),
      verify: (c) {
        expect(c.state.results, [_astrologer]);
        expect(c.state.languages, const LoadState.loaded(['en']));
        expect(c.state.recentSearches, ['x']);
        expect(c.state.isEmpty, isFalse);
      },
    );

    blocTest<AstrologerListCubit, AstrologerListState>(
      'a failure keeps the screen usable and carries the message',
      build: () {
        when(() => getAstrologers(any())).thenAnswer(
          (_) async => const Result.failure(Failure.network('offline')),
        );
        return build();
      },
      act: (c) => c.refresh(),
      verify: (c) {
        expect(c.state.astrologers.isFailed, isTrue);
        expect(c.state.astrologers.errorMessage, 'offline');
      },
    );

    blocTest<AstrologerListCubit, AstrologerListState>(
      'the filter sheet draft is discarded unless applied',
      build: build,
      act: (c) async {
        await c.load();
        c
          ..beginFilterEdit()
          ..updateDraft(
            c.state.draftFilter.copyWith(onlineOnly: true, minRating: 4),
          );
      },
      verify: (c) {
        expect(c.state.draftFilter.onlineOnly, isTrue);
        // Not applied: the live filter is untouched.
        expect(c.state.filter.onlineOnly, isFalse);
        expect(c.state.filter.activeCount, 0);
      },
    );

    blocTest<AstrologerListCubit, AstrologerListState>(
      'applyFilter promotes the draft and refetches',
      build: build,
      act: (c) async {
        await c.load();
        c
          ..beginFilterEdit()
          ..updateDraft(c.state.draftFilter.copyWith(onlineOnly: true));
        await c.applyFilter();
      },
      verify: (c) {
        expect(c.state.filter.onlineOnly, isTrue);
        expect(c.state.filter.activeCount, 1);
        verify(() => getAstrologers(any())).called(greaterThan(1));
      },
    );

    blocTest<AstrologerListCubit, AstrologerListState>(
      'resetDraft keeps the query and sort',
      build: build,
      act: (c) {
        c
          ..search('tarot')
          ..setSort(AstrologerSort.priceLow)
          ..beginFilterEdit()
          ..updateDraft(c.state.draftFilter.copyWith(minExperience: 10))
          ..resetDraft();
      },
      verify: (c) {
        expect(c.state.draftFilter.minExperience, 0);
        expect(c.state.draftFilter.query, 'tarot');
        expect(c.state.draftFilter.sort, AstrologerSort.priceLow);
      },
    );

    blocTest<AstrologerListCubit, AstrologerListState>(
      'follow is optimistic and reverts on failure',
      build: () {
        when(
          () => toggleFollow(any()),
        ).thenAnswer((_) async => const Result.failure(Failure.network()));
        return build();
      },
      act: (c) async {
        await c.load();
        await c.toggleFollow('a1');
      },
      verify: (c) {
        expect(c.state.results.single.isFollowing, isFalse);
      },
    );

    blocTest<AstrologerListCubit, AstrologerListState>(
      'follow keeps the server-confirmed state on success',
      build: () {
        when(
          () => toggleFollow(any()),
        ).thenAnswer((_) async => const Result.success(true));
        return build();
      },
      act: (c) async {
        await c.load();
        await c.toggleFollow('a1');
      },
      verify: (c) => expect(c.state.results.single.isFollowing, isTrue),
    );

    blocTest<AstrologerListCubit, AstrologerListState>(
      'submitSearch records the query',
      build: build,
      act: (c) => c.submitSearch('vaastu'),
      verify: (_) => verify(() => saveRecent('vaastu')).called(1),
    );
  });

  group('WriteReviewCubit', () {
    late _MockSubmitReview submitReview;

    setUp(() {
      submitReview = _MockSubmitReview();
      when(() => submitReview(any())).thenAnswer(
        (_) async => Result.success(
          AstrologerReview(
            id: 'r1',
            astrologerId: 'a1',
            authorName: 'You',
            rating: 5,
            comment: 'Great',
            createdAt: DateTime(2026),
          ),
        ),
      );
    });

    WriteReviewCubit build() =>
        // A consultation is required now: the server only accepts a review
        // tied to a completed session, so a cubit without one can never
        // submit — which is what these tests are exercising around.
        WriteReviewCubit(
          astrologerId: 'a1',
          consultationId: 'c1',
          submitReview: submitReview,
        );

    blocTest<WriteReviewCubit, WriteReviewState>(
      'cannot submit without a star rating',
      build: build,
      act: (c) => c.submit(),
      verify: (c) {
        expect(c.state.canSubmit, isFalse);
        verifyNever(() => submitReview(any()));
      },
    );

    blocTest<WriteReviewCubit, WriteReviewState>(
      'a rating alone is enough — the comment is optional',
      build: build,
      act: (c) async {
        c.setRating(4);
        await c.submit();
      },
      verify: (c) {
        expect(c.state.isSubmitted, isTrue);
        verify(() => submitReview(any())).called(1);
      },
    );

    blocTest<WriteReviewCubit, WriteReviewState>(
      'tags toggle on and off',
      build: build,
      act: (c) => c
        ..toggleTag('accurate')
        ..toggleTag('patient')
        ..toggleTag('accurate'),
      verify: (c) => expect(c.state.tags, {'patient'}),
    );

    blocTest<WriteReviewCubit, WriteReviewState>(
      'a failed submission surfaces the message and stays editable',
      build: () {
        when(() => submitReview(any())).thenAnswer(
          (_) async => const Result.failure(Failure.validation('too short')),
        );
        return build();
      },
      act: (c) async {
        c.setRating(3);
        await c.submit();
      },
      verify: (c) {
        expect(c.state.submission.isFailed, isTrue);
        expect(c.state.submission.errorMessage, 'too short');
        expect(c.state.canSubmit, isTrue);
      },
    );
  });
}
