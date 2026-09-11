import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../domain/entities/auth_session.dart';
import '../models/auth_session_model.dart';
import '../models/otp_challenge_model.dart';
import '../models/user_profile_draft_model.dart';
import 'auth_remote_data_source.dart';

/// Deterministic in-memory implementation of [AuthRemoteDataSource].
///
/// Rules (documented so QA can exercise both flows):
/// * Phone numbers whose **last digit is even** are treated as already
///   registered (OTP popup shows "Existing User" + a seeded name).
/// * Odd last digit → new user → Details Input page after OTP.
/// * Any 6-digit OTP is accepted except `000000` (simulates a wrong code).
/// * Google / Apple sign-in return a registered session.
/// * Seeded names and the E.164 user id follow the active region
///   ([RegionResolver] – read per call, never cached).
class MockAuthDataSource implements AuthRemoteDataSource {
  MockAuthDataSource({
    required RegionResolver regions,
    this.delay = const Duration(milliseconds: 700),
  }) : _regions = regions;

  final RegionResolver _regions;
  final Duration delay;

  /// Seeded display names for registered numbers (keyed by last digit),
  /// per region.
  static const Map<Region, Map<String, String>> _registeredNames = {
    Region.nepal: {
      '0': 'Kritika Paudel',
      '2': 'Sita Sharma',
      '4': 'Ram Bahadur Thapa',
      '6': 'Anita Gurung',
      '8': 'Bikash Shrestha',
    },
    Region.india: {
      '0': 'Kritika Verma',
      '2': 'Sita Mishra',
      '4': 'Ram Kumar Singh',
      '6': 'Anita Patel',
      '8': 'Vikas Gupta',
    },
  };

  RegionConfig get _config => _regions.config;

  String? _seededName(String phone) => isRegisteredNumber(phone)
      ? _registeredNames[_config.region]![phone[phone.length - 1]]
      : null;

  /// The number in E.164, e.g. `+9779841000002`.
  ///
  /// Numbers arrive from the domain layer already carrying their prefix; a
  /// bare national number is only seen when a test calls this data source
  /// directly, and prefixing it keeps the seeded ids stable either way.
  String _international(String phone) =>
      phone.startsWith('+') ? phone : '${_config.phonePrefix}$phone';

  static bool isRegisteredNumber(String phone) {
    if (phone.isEmpty) return false;
    final last = int.tryParse(phone[phone.length - 1]);
    return last != null && last.isEven;
  }

  Future<void> _wait() => Future<void>.delayed(delay);

  @override
  Future<AuthSessionModel> signInWithGoogle() async {
    await _wait();
    return const AuthSessionModel(
      userId: 'google-1001',
      provider: AuthProvider.google,
      isNewUser: false,
      displayName: 'Sanatan User',
      email: 'user@gmail.com',
    );
  }

  @override
  Future<AuthSessionModel> signInWithApple() async {
    await _wait();
    return const AuthSessionModel(
      userId: 'apple-1001',
      provider: AuthProvider.apple,
      isNewUser: false,
      displayName: 'Sanatan User',
      email: 'user@icloud.com',
    );
  }

  @override
  Future<OtpChallengeModel> requestOtp(String phoneNumber) async {
    await _wait();
    return OtpChallengeModel(
      phoneNumber: phoneNumber,
      isRegistered: isRegisteredNumber(phoneNumber),
      displayName: _seededName(phoneNumber),
    );
  }

  @override
  Future<AuthSessionModel> verifyOtp({
    required String phoneNumber,
    required String code,
  }) async {
    await _wait();
    if (code == '000000') {
      throw const ServerException('Incorrect OTP', 401);
    }
    return AuthSessionModel(
      userId: 'phone-${_international(phoneNumber)}',
      provider: AuthProvider.phone,
      isNewUser: !isRegisteredNumber(phoneNumber),
      phoneNumber: phoneNumber,
      displayName: _seededName(phoneNumber),
    );
  }

  @override
  Future<void> submitProfile(UserProfileDraftModel profile) => _wait();
}
