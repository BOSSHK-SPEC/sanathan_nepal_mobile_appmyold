import '../../../../core/auth/auth_session_manager.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/auth_session.dart';
import '../models/auth_session_model.dart';
import '../models/otp_challenge_model.dart';
import '../models/user_profile_draft_model.dart';
import 'auth_remote_data_source.dart';

/// Real authentication against the backend.
///
/// The tokens it receives go straight into [AuthSessionManager], which owns
/// them for the rest of the process — nothing else in the app reads or stores
/// a token, so there is exactly one place a session can be created or lost.
class ApiAuthDataSource implements AuthRemoteDataSource {
  ApiAuthDataSource({
    required ApiClient client,
    required AuthSessionManager session,
    required RegionResolver regions,
    required KeyValueStore store,
  }) : _client = client,
       _session = session,
       _regions = regions,
       _store = store;

  final ApiClient _client;
  final AuthSessionManager _session;
  final RegionResolver _regions;
  final KeyValueStore _store;

  /// The phone challenge id, kept between `requestOtp` and `verifyOtp`.
  ///
  /// Persisted rather than held in memory so the flow survives the app being
  /// backgrounded while the user reads the SMS — which is exactly when it is
  /// most likely to be killed.
  static const String _challengeKey = 'auth.otp.challenge_id';
  static const String _challengePhoneKey = 'auth.otp.phone';

  @override
  Future<AuthSessionModel> signInWithGoogle() =>
      _social(AuthProvider.google, 'google');

  @override
  Future<AuthSessionModel> signInWithApple() =>
      _social(AuthProvider.apple, 'apple');

  Future<AuthSessionModel> _social(AuthProvider provider, String wire) =>
      guardApi(() async {
        // The identity token comes from the platform sign-in SDK. Until those
        // are wired, the dev backend accepts any stable string and maps it to
        // one account — which keeps the whole flow testable.
        final idToken = await _obtainIdToken(wire);

        final response = await _client.post<dynamic>(
          ApiEndpoints.authSocial,
          data: {
            'provider': wire,
            'idToken': idToken,
            'region': _regions.region.code,
          },
        );

        return _adopt(asJsonMap(response), provider);
      });

  @override
  Future<OtpChallengeModel> requestOtp(String phoneNumber) =>
      guardApi(() async {
        final response = await _client.post<dynamic>(
          ApiEndpoints.authPhoneStart,
          data: {'phone': phoneNumber},
        );

        final body = asJsonMap(response);
        final challengeId = body['challengeId'] as String?;
        if (challengeId == null) {
          throw const ServerException('OTP challenge did not include an id');
        }

        await _store.setString(_challengeKey, challengeId);
        await _store.setString(_challengePhoneKey, phoneNumber);

        return OtpChallengeModel(phoneNumber: phoneNumber);
      });

  @override
  Future<AuthSessionModel> verifyOtp({
    required String phoneNumber,
    required String code,
  }) => guardApi(() async {
    final challengeId = _store.getString(_challengeKey);
    if (challengeId == null ||
        _store.getString(_challengePhoneKey) != phoneNumber) {
      // Asking for the code again is the only honest recovery: the server
      // ties the code to a challenge we no longer hold.
      throw const ValidationException(
        'That code has expired. Request a new one.',
        'code',
      );
    }

    final response = await _client.post<dynamic>(
      ApiEndpoints.authPhoneVerify,
      data: {
        'challengeId': challengeId,
        'code': code,
        'region': _regions.region.code,
      },
    );

    final model = await _adopt(asJsonMap(response), AuthProvider.phone);
    await _store.remove(_challengeKey);
    await _store.remove(_challengePhoneKey);
    return model;
  });

  @override
  Future<void> submitProfile(UserProfileDraftModel profile) =>
      guardApi(() async {
        await _client.patch<dynamic>(
          ApiEndpoints.profile,
          data: {
            if (profile.fullName.isNotEmpty) 'name': profile.fullName,
            if (profile.email.isNotEmpty) 'email': profile.email,
            if (profile.gender != null) 'gender': profile.gender!.name,
            if (profile.dateOfBirth != null)
              'dobAd': profile.dateOfBirth!.toIso8601String().substring(0, 10),
            // The draft stores minutes-from-midnight; the API wants "HH:mm".
            if (profile.birthTimeMinutes != null)
              'birthTime': _formatMinutes(profile.birthTimeMinutes!),
            if (profile.birthPlace.isNotEmpty) 'birthPlace': profile.birthPlace,
          },
        );
      });

  /// Stores the returned pair and maps the body onto the app's session model.
  Future<AuthSessionModel> _adopt(
    Map<String, dynamic> body,
    AuthProvider provider,
  ) async {
    final accessToken = body['accessToken'] as String?;
    final refreshToken = body['refreshToken'] as String?;
    if (accessToken == null || refreshToken == null) {
      throw const ServerException('Sign-in response did not include tokens');
    }

    await _session.adopt(accessToken: accessToken, refreshToken: refreshToken);

    return AuthSessionModel(
      userId: body['userId'] as String? ?? '',
      provider: provider,
      isNewUser: body['isNewUser'] as bool? ?? false,
      displayName: body['displayName'] as String?,
      phoneNumber: body['phone'] as String?,
      email: body['email'] as String?,
    );
  }

  static String _formatMinutes(int minutesOfDay) {
    final hours = (minutesOfDay ~/ 60).toString().padLeft(2, '0');
    final minutes = (minutesOfDay % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  /// Placeholder for the platform sign-in SDKs.
  ///
  /// Google and Apple sign-in need native configuration (an OAuth client id,
  /// an Apple services id and their entitlements) that does not exist yet, so
  /// this returns a stable per-install token the dev backend accepts. Wiring
  /// `google_sign_in` / `sign_in_with_apple` replaces this method and nothing
  /// else — the exchange, storage and refresh are already real.
  Future<String> _obtainIdToken(String provider) async {
    const key = 'auth.dev.install_id';
    final existing = _store.getString(key);
    if (existing != null) return '$provider:$existing';

    final installId = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    await _store.setString(key, installId);
    return '$provider:$installId';
  }
}
