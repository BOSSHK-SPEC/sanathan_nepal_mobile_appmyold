import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/auth_session.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/entities/otp_challenge.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/domain/usecases/verify_otp.dart';
import 'package:sanathan_nepal_mobile_app/features/onboarding/presentation/cubit/auth_cubit.dart';

import 'helpers/test_helpers.dart';

void main() {
  late MockSignInWithPhone phone;
  late MockVerifyOtp verifyUc;

  const challenge = OtpChallenge(
    phoneNumber: '9841000002',
    isRegistered: true,
    displayName: 'Sita Sharma',
  );
  const session = AuthSession(
    userId: 'phone-9841000002',
    provider: AuthProvider.phone,
    isNewUser: false,
    displayName: 'Sita Sharma',
  );

  setUpAll(() {
    registerFallbackValue(const VerifyOtpParams(phoneNumber: '', code: ''));
  });

  setUp(() {
    phone = MockSignInWithPhone();
    verifyUc = MockVerifyOtp();
  });

  AuthCubit build() => AuthCubit(signInWithPhone: phone, verifyOtp: verifyUc);

  group('AuthCubit', () {
    blocTest<AuthCubit, AuthState>(
      'requestOtp emits [loading, otpSent] with the challenge',
      build: () {
        when(
          () => phone('9841000002'),
        ).thenAnswer((_) async => const Result.success(challenge));
        return build();
      },
      act: (c) => c.requestOtp('9841000002'),
      expect: () => const [
        AuthState(challenge: LoadState.loading()),
        AuthState(challenge: LoadState.loaded(challenge)),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'requestOtp emits failure for an invalid number',
      build: () {
        when(() => phone('123')).thenAnswer(
          (_) async => const Result.failure(ValidationFailure('Invalid')),
        );
        return build();
      },
      act: (c) => c.requestOtp('123'),
      expect: () => const [
        AuthState(challenge: LoadState.loading()),
        AuthState(challenge: LoadState.failed(ValidationFailure('Invalid'))),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'verifyOtp emits authenticated with the session',
      build: () {
        when(
          () => verifyUc(any()),
        ).thenAnswer((_) async => const Result.success(session));
        return build();
      },
      seed: () => const AuthState(challenge: LoadState.loaded(challenge)),
      act: (c) => c.verifyOtp('123456'),
      expect: () => const [
        AuthState(
          challenge: LoadState.loaded(challenge),
          session: LoadState.loading(),
        ),
        AuthState(
          challenge: LoadState.loaded(challenge),
          session: LoadState.loaded(session),
        ),
      ],
      verify: (_) => verify(
        () => verifyUc(
          const VerifyOtpParams(phoneNumber: '9841000002', code: '123456'),
        ),
      ).called(1),
    );

    blocTest<AuthCubit, AuthState>(
      'reset returns to the initial state',
      build: build,
      seed: () =>
          const AuthState(session: LoadState.failed(ServerFailure('x'))),
      act: (c) => c.reset(),
      expect: () => const [AuthState()],
    );
  });
}
