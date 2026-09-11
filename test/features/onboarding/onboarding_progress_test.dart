import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/datasources/auth_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/datasources/onboarding_progress_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/repositories/onboarding_progress_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/services/auth_presence_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/auth_session.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/onboarding_step.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/user_profile_draft.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/widgets/auth_flow_navigation.dart';

void main() {
  group('where onboarding resumes', () {
    // saved step, signed in → step to open
    final cases = <(OnboardingStep?, bool, OnboardingStep)>[
      (null, false, OnboardingStep.languageTheme),
      (OnboardingStep.languageTheme, false, OnboardingStep.languageTheme),
      (OnboardingStep.signIn, false, OnboardingStep.signIn),
      (OnboardingStep.signIn, true, OnboardingStep.signIn),
      (OnboardingStep.profileDetails, true, OnboardingStep.profileDetails),
      (OnboardingStep.notifications, true, OnboardingStep.notifications),
      // The login did not survive (sign-out, expired session): the details
      // form would only submit into a 401, so sign in first.
      (OnboardingStep.profileDetails, false, OnboardingStep.signIn),
      (OnboardingStep.notifications, false, OnboardingStep.signIn),
    ];
    for (final (saved, signedIn, expected) in cases) {
      test('$saved, signed in: $signedIn → $expected', () {
        expect(
          OnboardingStep.resume(saved: saved, signedIn: signedIn),
          expected,
        );
      });
    }

    test('an unknown saved value starts from the beginning', () {
      expect(OnboardingStep.tryParse('someOldStep'), isNull);
      expect(OnboardingStep.tryParse(null), isNull);
      expect(OnboardingStep.tryParse('profileDetails'), OnboardingStep.profileDetails);
    });
  });

  group('who still owes their details', () {
    AuthSession session({required bool isNew, String? name}) => AuthSession(
      userId: 'u1',
      provider: AuthProvider.phone,
      isNewUser: isNew,
      displayName: name,
    );

    test('a brand-new account', () {
      expect(AuthFlowNavigation.needsDetails(session(isNew: true, name: 'Sita')), isTrue);
    });

    test('a returning account the server still calls Guest', () {
      // Closed the app on the details form, then signed in again: the server
      // no longer says "new", but never received a name either.
      expect(AuthFlowNavigation.needsDetails(session(isNew: false, name: 'Guest')), isTrue);
      expect(AuthFlowNavigation.needsDetails(session(isNew: false, name: ' guest ')), isTrue);
      expect(AuthFlowNavigation.needsDetails(session(isNew: false)), isTrue);
      expect(AuthFlowNavigation.needsDetails(session(isNew: false, name: '')), isTrue);
    });

    test('a returning account with a real name goes straight in', () {
      expect(AuthFlowNavigation.needsDetails(session(isNew: false, name: 'Sita Sharma')), isFalse);
    });
  });

  group('progress store', () {
    late InMemoryKeyValueStore store;
    late OnboardingProgressRepositoryImpl repo;

    setUp(() {
      store = InMemoryKeyValueStore();
      repo = OnboardingProgressRepositoryImpl(
        OnboardingProgressLocalDataSourceImpl(store),
      );
    });

    test('remembers the step across instances, as across restarts', () async {
      expect(repo.step, isNull);
      await repo.saveStep(OnboardingStep.profileDetails);

      final reopened = OnboardingProgressRepositoryImpl(
        OnboardingProgressLocalDataSourceImpl(store),
      );
      expect(reopened.step, OnboardingStep.profileDetails);
    });

    test('keeps a half-filled details form', () async {
      final draft = UserProfileDraft(
        fullName: 'Sita',
        email: 'sita@example.com',
        dateOfBirth: DateTime(1998, 4, 2),
        gender: Gender.female,
        birthTimeMinutes: 16 * 60 + 12,
      );
      await repo.saveDetailsDraft(draft);
      expect(repo.detailsDraft, draft);

      await repo.clearDetailsDraft();
      expect(repo.detailsDraft, isNull);
    });

    test('a damaged draft is dropped, not thrown', () async {
      await store.setString(
        OnboardingProgressLocalDataSourceImpl.kDetailsDraft,
        '{not json',
      );
      expect(repo.detailsDraft, isNull);
      await Future<void>.delayed(Duration.zero);
      expect(
        store.getString(OnboardingProgressLocalDataSourceImpl.kDetailsDraft),
        isNull,
      );
    });

    test('clear forgets both step and draft', () async {
      await repo.saveStep(OnboardingStep.notifications);
      await repo.saveDetailsDraft(const UserProfileDraft(fullName: 'Sita'));
      await repo.clear();
      expect(repo.step, isNull);
      expect(repo.detailsDraft, isNull);
    });
  });

  test('mock sign-in presence follows the local login flag', () async {
    final store = InMemoryKeyValueStore();
    final presence = LocalAuthPresence(AuthLocalDataSourceImpl(store));
    expect(presence.isSignedIn, isFalse);
    await store.setBool(AuthLocalDataSourceImpl.kLoggedIn, true);
    expect(presence.isSignedIn, isTrue);
  });
}
