import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/presentation/cubit/astrologer_profile_cubit.dart';
import 'package:sanathan_nepal_mobile_app/features/astrologers/presentation/cubit/write_review_cubit.dart';

/// A review is only accepted against a completed consultation — that rule is
/// what keeps ratings honest, so the app has to respect it rather than
/// discover it from a 400 after someone has written three paragraphs.
void main() {
  group('write review', () {
    test('cannot be submitted without a consultation', () {
      const state = WriteReviewState(
        astrologerId: '01M1XFMN55B154TDSC5H4SSZ9H',
        rating: 5,
      );

      expect(state.needsConsultation, isTrue);
      // Rated, written, and still not submittable — because it would be
      // refused. The old build sent `consultationId: null` and got a 400.
      expect(state.canSubmit, isFalse);
    });

    test('can be submitted once one is attached', () {
      const state = WriteReviewState(
        astrologerId: '01M1XFMN55B154TDSC5H4SSZ9H',
        consultationId: '01M1CONSULT0000000000000AA',
        rating: 5,
      );

      expect(state.needsConsultation, isFalse);
      expect(state.canSubmit, isTrue);
    });

    test('still needs a rating', () {
      const state = WriteReviewState(
        astrologerId: '01M1XFMN55B154TDSC5H4SSZ9H',
        consultationId: '01M1CONSULT0000000000000AA',
      );

      expect(state.canSubmit, isFalse);
    });

    test('is not submittable while a submission is in flight', () {
      const state = WriteReviewState(
        astrologerId: '01M1XFMN55B154TDSC5H4SSZ9H',
        consultationId: '01M1CONSULT0000000000000AA',
        rating: 4,
        submission: LoadState.loading(),
      );

      expect(state.canSubmit, isFalse);
    });
  });

  group('astrologer profile', () {
    test('offers the review button only with a consultation to attach', () {
      const without = AstrologerProfileState();
      const with_ = AstrologerProfileState(
        reviewConsultationId: '01M1CONSULT0000000000000AA',
      );

      expect(without.canWriteReview, isFalse);
      expect(with_.canWriteReview, isTrue);
    });
  });
}
