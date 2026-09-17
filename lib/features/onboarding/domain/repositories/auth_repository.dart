import '../../../../core/utils/result.dart';
import '../entities/auth_session.dart';
import '../entities/otp_challenge.dart';
import '../entities/user_profile_draft.dart';

/// Authentication contract used by the onboarding / auth flow: mobile number
/// and one-time code.
abstract interface class AuthRepository {
  /// Sends an OTP to [phoneNumber] and reports whether the number is already
  /// registered.
  Future<Result<OtpChallenge>> signInWithPhone(String phoneNumber);

  Future<Result<AuthSession>> verifyOtp({
    required String phoneNumber,
    required String code,
  });

  Future<Result<void>> submitProfile(UserProfileDraft draft);

  /// Whether a session was persisted from a previous run.
  bool get isLoggedIn;
}
