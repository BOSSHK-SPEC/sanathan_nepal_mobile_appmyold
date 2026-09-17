import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/otp_challenge.dart';
import '../../domain/usecases/sign_in_with_phone.dart';
import '../../domain/usecases/verify_otp.dart';
import '../../../../core/state/app_cubit.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

/// Drives the SIGNUP / LOGIN screen, the phone-number sheet and OTP popups.
///
/// Mobile number + one-time code is the only way in.
class AuthCubit extends AppCubit<AuthState> {
  AuthCubit({
    required SignInWithPhone signInWithPhone,
    required VerifyOtp verifyOtp,
  }) : _phone = signInWithPhone,
       _verify = verifyOtp,
       super(const AuthState());

  final SignInWithPhone _phone;
  final VerifyOtp _verify;

  /// Requests an OTP for [phoneNumber]; on success `challenge` is loaded.
  Future<void> requestOtp(String phoneNumber) async {
    emit(state.copyWith(challenge: state.challenge.toLoading()));
    final result = await _phone(phoneNumber);
    emit(
      state.copyWith(
        challenge: result.fold(state.challenge.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Verifies [code] for the pending challenge (or an explicit [phoneNumber]).
  Future<void> verifyOtp(String code, {String? phoneNumber}) async {
    final phone = phoneNumber ?? state.challenge.dataOrNull?.phoneNumber;
    if (phone == null) {
      emit(
        state.copyWith(
          session: state.session.toFailed(const Failure.validation('No phone')),
        ),
      );
      return;
    }
    emit(state.copyWith(session: state.session.toLoading()));
    final result = await _verify(
      VerifyOtpParams(phoneNumber: phone, code: code),
    );
    _emitSession(result);
  }

  /// Re-sends the OTP for the pending challenge.
  Future<void> resendOtp() async {
    final phone = state.challenge.dataOrNull?.phoneNumber;
    if (phone != null) await requestOtp(phone);
  }

  /// Returns to the idle state (e.g. after an error snackbar / dialog close).
  void reset() => emit(const AuthState());

  void _emitSession(Result<AuthSession> result) => emit(
    state.copyWith(
      session: result.fold(state.session.toFailed, LoadState.loaded),
    ),
  );
}
