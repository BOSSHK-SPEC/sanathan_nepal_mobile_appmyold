import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/user_profile_draft.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/cubit/profile_details_cubit.dart';

import 'helpers/test_helpers.dart';

void main() {
  late MockSubmitProfile submit;

  setUpAll(() => registerFallbackValue(const UserProfileDraft()));
  setUp(() => submit = MockSubmitProfile());

  group('ProfileDetailsCubit', () {
    blocTest<ProfileDetailsCubit, ProfileDetailsState>(
      'setters update the draft',
      build: () => ProfileDetailsCubit(submitProfile: submit),
      act: (c) => c
        ..setFullName('Kritika')
        ..setGender(Gender.female)
        ..setZodiacSign(ZodiacSign.leo),
      expect: () => [
        const ProfileDetailsState(draft: UserProfileDraft(fullName: 'Kritika')),
        const ProfileDetailsState(
          draft: UserProfileDraft(fullName: 'Kritika', gender: Gender.female),
        ),
        const ProfileDetailsState(
          draft: UserProfileDraft(
            fullName: 'Kritika',
            gender: Gender.female,
            zodiacSign: ZodiacSign.leo,
          ),
        ),
      ],
    );

    blocTest<ProfileDetailsCubit, ProfileDetailsState>(
      'submit emits [submitting, success]',
      build: () {
        when(
          () => submit(any()),
        ).thenAnswer((_) async => const Result.success(null));
        return ProfileDetailsCubit(submitProfile: submit);
      },
      act: (c) => c.submit(),
      expect: () => const [
        ProfileDetailsState(submission: LoadState.loading()),
        ProfileDetailsState(submission: LoadState.loaded(null)),
      ],
    );

    blocTest<ProfileDetailsCubit, ProfileDetailsState>(
      'submit emits failure with message',
      build: () {
        when(() => submit(any())).thenAnswer(
          (_) async => const Result.failure(ValidationFailure('Incomplete')),
        );
        return ProfileDetailsCubit(submitProfile: submit);
      },
      act: (c) => c.submit(),
      expect: () => const [
        ProfileDetailsState(submission: LoadState.loading()),
        ProfileDetailsState(
          submission: LoadState.failed(ValidationFailure('Incomplete')),
        ),
      ],
    );
  });
}
