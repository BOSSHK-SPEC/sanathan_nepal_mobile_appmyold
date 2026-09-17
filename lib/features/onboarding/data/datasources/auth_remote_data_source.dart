import '../models/auth_session_model.dart';
import '../models/otp_challenge_model.dart';
import '../models/user_profile_draft_model.dart';

/// Remote authentication I/O: a one-time code sent to a mobile number.
abstract interface class AuthRemoteDataSource {
  Future<OtpChallengeModel> requestOtp(String phoneNumber);
  Future<AuthSessionModel> verifyOtp({
    required String phoneNumber,
    required String code,
  });
  Future<void> submitProfile(UserProfileDraftModel profile);
}
