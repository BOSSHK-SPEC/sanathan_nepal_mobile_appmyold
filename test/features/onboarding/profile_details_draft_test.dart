import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/datasources/onboarding_progress_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/repositories/onboarding_progress_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/user_profile_draft.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/cubit/profile_details_cubit.dart';

import 'helpers/test_helpers.dart';

/// The details form survives the app being closed part-way through.
void main() {
  late MockSubmitProfile submit;
  late OnboardingProgressRepositoryImpl progress;

  setUpAll(() => registerFallbackValue(const UserProfileDraft()));

  setUp(() {
    submit = MockSubmitProfile();
    progress = OnboardingProgressRepositoryImpl(
      OnboardingProgressLocalDataSourceImpl(InMemoryKeyValueStore()),
    );
  });

  Future<void> afterSaveDelay() => Future<void>.delayed(
    ProfileDetailsCubit.saveDelay + const Duration(milliseconds: 50),
  );

  test('opens on what was typed before the app closed', () async {
    await progress.saveDetailsDraft(
      const UserProfileDraft(fullName: 'Sita', gender: Gender.female),
    );
    final cubit = ProfileDetailsCubit(submitProfile: submit, progress: progress);
    expect(cubit.state.draft.fullName, 'Sita');
    expect(cubit.state.draft.gender, Gender.female);
    await cubit.close();
  });

  test('saves shortly after an edit, once rather than per keystroke', () async {
    final cubit = ProfileDetailsCubit(submitProfile: submit, progress: progress)
      ..setFullName('S')
      ..setFullName('Si')
      ..setFullName('Sita');
    expect(progress.detailsDraft, isNull, reason: 'not yet — still typing');
    await afterSaveDelay();
    expect(progress.detailsDraft?.fullName, 'Sita');
    await cubit.close();
  });

  test('leaving the screen writes an edit that was still pending', () async {
    final cubit = ProfileDetailsCubit(submitProfile: submit, progress: progress)
      ..setFullName('Sita');
    await cubit.close();
    expect(progress.detailsDraft?.fullName, 'Sita');
  });

  test('an accepted profile forgets the draft', () async {
    when(() => submit(any())).thenAnswer((_) async => const Result.success(null));
    await progress.saveDetailsDraft(
      UserProfileDraft(
        fullName: 'Sita',
        dateOfBirth: DateTime(1998, 4, 2),
        gender: Gender.female,
      ),
    );
    final cubit = ProfileDetailsCubit(submitProfile: submit, progress: progress);
    await cubit.submit();
    expect(progress.detailsDraft, isNull);
    await cubit.close();
    expect(progress.detailsDraft, isNull, reason: 'close must not resurrect it');
  });

  test('a rejected profile keeps the draft for the retry', () async {
    when(() => submit(any())).thenAnswer(
      (_) async => const Result.failure(NetworkFailure('offline')),
    );
    final cubit = ProfileDetailsCubit(submitProfile: submit, progress: progress)
      ..setFullName('Sita');
    await cubit.submit();
    await afterSaveDelay();
    expect(progress.detailsDraft?.fullName, 'Sita');
    await cubit.close();
  });

  test('surrounding spaces never reach the server', () async {
    when(() => submit(any())).thenAnswer(
      (_) async => const Result.failure(NetworkFailure('offline')),
    );
    final cubit = ProfileDetailsCubit(submitProfile: submit)
      ..setFullName('  Sita Sharma ')
      ..setEmail('   ')
      ..setBirthPlace(' Hetauda ');
    await cubit.submit();

    final sent =
        verify(() => submit(captureAny())).captured.single as UserProfileDraft;
    expect(sent.fullName, 'Sita Sharma');
    // A space-only "email" is no email: it used to be sent and rejected.
    expect(sent.email, isEmpty);
    expect(sent.birthPlace, 'Hetauda');
    await cubit.close();
  });
}
