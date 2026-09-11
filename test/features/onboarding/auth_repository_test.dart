import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/datasources/auth_local_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/datasources/mock_auth_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/data/repositories/auth_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/user_profile_draft.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/sign_in_with_phone.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/submit_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/verify_otp.dart';

void main() {
  const nepal = FixedRegionResolver(Region.nepal);
  const india = FixedRegionResolver(Region.india);
  late InMemoryKeyValueStore store;
  late AuthRepositoryImpl repo;

  AuthRepositoryImpl buildRepo(RegionResolver regions) => AuthRepositoryImpl(
    remote: MockAuthDataSource(regions: regions, delay: Duration.zero),
    local: AuthLocalDataSourceImpl(store),
  );

  setUp(() {
    store = InMemoryKeyValueStore();
    repo = buildRepo(nepal);
  });

  group('AuthRepositoryImpl + MockAuthDataSource', () {
    test('even last digit → registered challenge with a name', () async {
      final result = await repo.signInWithPhone('9841000002');
      final challenge = result.valueOrNull!;
      expect(challenge.isRegistered, isTrue);
      expect(challenge.displayName, 'Sita Sharma');
    });

    test('odd last digit → new user', () async {
      final result = await repo.signInWithPhone('9841000001');
      expect(result.valueOrNull!.isRegistered, isFalse);
      expect(result.valueOrNull!.displayName, isNull);
    });

    test('verifyOtp persists the logged-in flag and session', () async {
      expect(repo.isLoggedIn, isFalse);
      final result = await repo.verifyOtp(
        phoneNumber: '9841000001',
        code: '123456',
      );
      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull!.isNewUser, isTrue);
      expect(repo.isLoggedIn, isTrue);
      expect(store.getBool(AuthLocalDataSourceImpl.kLoggedIn), isTrue);
      expect(
        AuthLocalDataSourceImpl(store).readSession()?.phoneNumber,
        '9841000001',
      );
    });

    test('verifyOtp with 000000 → ServerFailure', () async {
      final result = await repo.verifyOtp(
        phoneNumber: '9841000002',
        code: '000000',
      );
      expect(result.failureOrNull, isA<ServerFailure>());
      expect(repo.isLoggedIn, isFalse);
    });

    test('social sign-in returns a registered session', () async {
      final result = await repo.signInWithGoogle();
      expect(result.valueOrNull!.isNewUser, isFalse);
      expect(repo.isLoggedIn, isTrue);
    });

    test('submitProfile stores the draft locally', () async {
      final draft = UserProfileDraft(
        fullName: 'Kritika Paudel',
        dateOfBirth: DateTime(1998, 5, 12),
        gender: Gender.female,
        zodiacSign: ZodiacSign.leo,
      );
      final result = await repo.submitProfile(draft);
      expect(result.isSuccess, isTrue);
      final stored = AuthLocalDataSourceImpl(store).readProfile();
      expect(stored?.fullName, 'Kritika Paudel');
      expect(stored?.zodiacSign, ZodiacSign.leo);
      expect(stored?.dateOfBirth, DateTime(1998, 5, 12));
    });
  });

  group('MockAuthDataSource · India region', () {
    test('seeds Indian names and a +91 user id', () async {
      final indiaRepo = buildRepo(india);
      final challenge = (await indiaRepo.signInWithPhone(
        '9876543212',
      )).valueOrNull!;
      expect(challenge.isRegistered, isTrue);
      expect(challenge.displayName, 'Sita Mishra');

      final session = (await indiaRepo.verifyOtp(
        phoneNumber: '9876543212',
        code: '123456',
      )).valueOrNull!;
      expect(session.userId, 'phone-+919876543212');
      expect(session.phoneNumber, '9876543212');
    });

    test('Nepal seeds keep +977 user id', () async {
      final session = (await repo.verifyOtp(
        phoneNumber: '9841000002',
        code: '123456',
      )).valueOrNull!;
      expect(session.userId, 'phone-+9779841000002');
      expect(session.displayName, 'Sita Sharma');
    });
  });

  group('use cases', () {
    const np = RegionConfig.nepal;
    const ind = RegionConfig.india;

    test('SignInWithPhone normalises +977 and rejects short numbers', () async {
      expect(
        SignInWithPhone.normalize('+977 984-1000002', config: np),
        '9841000002',
      );
      expect(
        SignInWithPhone.normalize('9779841000002', config: np),
        '9841000002',
      );
      expect(SignInWithPhone.isValid('98410', config: np), isFalse);
      final r = await SignInWithPhone(repo, nepal)('98410');
      expect(r.failureOrNull, isA<ValidationFailure>());
      final ok = await SignInWithPhone(repo, nepal)('+977 9841000002');
      expect(ok.isSuccess, isTrue);
    });

    test('SignInWithPhone (Nepal) accepts 96/97/98 numbers only', () {
      expect(SignInWithPhone.isValid('9741000002', config: np), isTrue);
      expect(SignInWithPhone.isValid('9641000002', config: np), isTrue);
      expect(SignInWithPhone.isValid('8123456789', config: np), isFalse);
      // A +91 prefix is not stripped in Nepal → 12 digits → invalid.
      expect(SignInWithPhone.isValid('+91 9876543210', config: np), isFalse);
    });

    test(
      'SignInWithPhone (India) normalises +91 and validates 6–9 leading',
      () async {
        expect(
          SignInWithPhone.normalize('+91 98765-43210', config: ind),
          '9876543210',
        );
        expect(
          SignInWithPhone.normalize('0091 9876543210', config: ind),
          '9876543210',
        );
        expect(
          SignInWithPhone.normalize('919876543210', config: ind),
          '9876543210',
        );
        expect(SignInWithPhone.isValid('6123456789', config: ind), isTrue);
        expect(SignInWithPhone.isValid('7123456789', config: ind), isTrue);
        expect(SignInWithPhone.isValid('8123456789', config: ind), isTrue);
        expect(SignInWithPhone.isValid('9876543210', config: ind), isTrue);
        expect(SignInWithPhone.isValid('5123456789', config: ind), isFalse);
        expect(SignInWithPhone.isValid('98765', config: ind), isFalse);
        // A +977 prefix is not stripped in India.
        expect(
          SignInWithPhone.isValid('+977 9841000002', config: ind),
          isFalse,
        );

        final indiaRepo = buildRepo(india);
        final useCase = SignInWithPhone(indiaRepo, india);
        expect(useCase.normalizePhone('+91 9876543210'), '9876543210');
        expect(useCase.isValidPhone('+91 9876543210'), isTrue);
        final ok = await useCase('+91 9876543210');
        expect(ok.isSuccess, isTrue);
        // What leaves the domain layer is E.164, not the national number the
        // user typed: the prefix is shown beside the field, so without this
        // the API receives a number with no country and rejects it.
        expect(ok.valueOrNull!.phoneNumber, '+919876543210');
        final bad = await useCase('5123456789');
        expect(bad.failureOrNull, isA<ValidationFailure>());
      },
    );

    test('a requested number is E.164, whatever the user typed', () async {
      /// The exact pattern the server validates `POST /auth/phone/start`
      /// against. A number this rejects fails as "request validation failed"
      /// on the device, which is why the format is pinned here.
      final serverPattern = RegExp(r'^\+[1-9]\d{7,14}$');

      for (final (config, typed) in [
        (np, '9841000002'),
        (np, '+977 9841000002'),
        (np, '984-100-0002'),
        (ind, '9876543210'),
        (ind, '+91 98765-43210'),
        (ind, '0091 9876543210'),
      ]) {
        final e164 = SignInWithPhone.toE164(typed, config: config);
        expect(
          serverPattern.hasMatch(e164),
          isTrue,
          reason: 'the server would reject "\$e164" (typed "\$typed")',
        );
      }
    });

    test('adding the prefix twice is not possible', () {
      // Resending an OTP feeds the challenge's own number back in, so this
      // runs on an already-prefixed string every time.
      final once = SignInWithPhone.toE164('9841000002', config: np);
      expect(SignInWithPhone.toE164(once, config: np), once);
    });

    test('VerifyOtp rejects non-numeric codes', () async {
      final r = await VerifyOtp(repo)(
        const VerifyOtpParams(phoneNumber: '9841000002', code: 'abcd'),
      );
      expect(r.failureOrNull, isA<ValidationFailure>());
    });

    test('SubmitProfile rejects an incomplete draft', () async {
      final r = await SubmitProfile(repo)(const UserProfileDraft());
      expect(r, isA<ResultFailure<dynamic>>());
      expect(r.failureOrNull, isA<ValidationFailure>());
    });
  });
}
