import '../../../core/auth/auth_session_manager.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_guard.dart';
import '../../../core/session/app_role.dart';
import '../../domain/entities/admin_session.dart';

/// Sign-in for the console.
///
/// Deliberately its own thin data source rather than the app's onboarding one:
/// that flow also carries profile drafts, social providers and a multi-step
/// wizard, none of which a staff console has. Sharing it would couple the two
/// products' sign-up journeys together for the sake of two HTTP calls.
///
/// The token pair goes straight into [AuthSessionManager], which the shared
/// `ApiClient` interceptors already read — so every console request is
/// authenticated, traced and retried by the same chain the mobile app uses.
abstract interface class AdminAuthDataSource {
  /// Asks the server to issue a code. Returns the challenge id to echo back.
  Future<String> startPhoneChallenge(String phone);

  Future<AdminSession> verifyCode({
    required String challengeId,
    required String code,
    required String region,
  });

  /// Rebuilds the session from a stored refresh token, or null if there is
  /// none / it is no longer valid.
  Future<AdminSession?> restore();

  Future<void> signOut();
}

class ApiAdminAuthDataSource implements AdminAuthDataSource {
  const ApiAdminAuthDataSource({
    required ApiClient client,
    required AuthSessionManager session,
  }) : _client = client,
       _session = session;

  final ApiClient _client;
  final AuthSessionManager _session;

  @override
  Future<String> startPhoneChallenge(String phone) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.authPhoneStart,
      data: {'phone': phone},
    );
    final body = asJsonMap(response);
    final challengeId = body['challengeId'] as String?;
    if (challengeId == null || challengeId.isEmpty) {
      throw const ServerException('The server did not return a challenge id');
    }
    return challengeId;
  });

  @override
  Future<AdminSession> verifyCode({
    required String challengeId,
    required String code,
    required String region,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.authPhoneVerify,
      data: {'challengeId': challengeId, 'code': code, 'region': region},
    );
    final body = asJsonMap(response);

    final accessToken = body['accessToken'] as String?;
    final refreshToken = body['refreshToken'] as String?;
    if (accessToken == null || refreshToken == null) {
      throw const ServerException('Sign-in did not return a token pair');
    }

    // Adopted before the session is returned, so the very next request — the
    // dashboard's first fetch — is already authenticated.
    await _session.adopt(accessToken: accessToken, refreshToken: refreshToken);

    return _toSession(body);
  });

  @override
  Future<AdminSession?> restore() async {
    if (!_session.hasSession) return null;
    try {
      // The interceptor refreshes on a 401 and replays this, so a valid
      // refresh token is enough — there is no separate "exchange" call.
      final response = await _client.get<dynamic>(ApiEndpoints.authMe);
      return _toSession(asJsonMap(response));
    } catch (_) {
      // A refresh token that no longer works is not an error worth showing on
      // a landing page: it is simply a signed-out visitor.
      await _session.signOut(SignOutReason.sessionExpired);
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.post<dynamic>(ApiEndpoints.authSignOut);
    } catch (_) {
      // Revoking server-side is best effort. Whatever happened up there, the
      // local credentials must still be dropped — a sign-out that leaves a
      // usable refresh token on a shared machine is the worst of both.
    }
    await _session.signOut(SignOutReason.userInitiated);
  }

  /// Reads both shapes the API answers with: the sign-in body carries
  /// `userId`, while `GET /auth/me` returns the token's own claims with `id`.
  static AdminSession _toSession(Map<String, dynamic> json) {
    final rawRoles = json['roles'];
    final roles = <AppRole>{
      if (rawRoles is List)
        for (final role in rawRoles) AppRole.fromName(role?.toString()),
    };

    return AdminSession(
      userId: (json['userId'] ?? json['id'] ?? '') as String,
      // Never empty: an empty role set would render a console with no nav and
      // no explanation, where "seeker" produces the honest "not staff" screen.
      roles: roles.isEmpty ? {AppRole.seeker} : roles,
      region: json['region'] as String? ?? 'NP',
      displayName: json['displayName'] as String?,
      phone: json['phone'] as String?,
    );
  }
}
