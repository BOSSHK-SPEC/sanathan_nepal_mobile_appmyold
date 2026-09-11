import '../models/auth_session_model.dart';
import '../models/otp_challenge_model.dart';
import '../models/user_profile_draft_model.dart';

/// Remote authentication I/O (backend / identity providers).
///
/// Only [MockAuthDataSource] exists today; a real implementation would wrap
/// `ApiClient` + the Google/Apple sign-in SDKs.
abstract interface class AuthRemoteDataSource {
  Future<AuthSessionModel> signInWithGoogle();
  Future<AuthSessionModel> signInWithApple();
  Future<OtpChallengeModel> requestOtp(String phoneNumber);
  Future<AuthSessionModel> verifyOtp({
    required String phoneNumber,
    required String code,
  });
  Future<void> submitProfile(UserProfileDraftModel profile);
}
