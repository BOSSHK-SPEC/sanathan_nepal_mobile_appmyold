import 'dart:async';

import 'package:dio/dio.dart';

import '../../auth/auth_session_manager.dart';
import '../api_endpoints.dart';

/// Attaches the access token and refreshes it exactly once when it expires.
///
/// The hard part is concurrency. A screen typically fires several requests at
/// once; when the access token expires they all get a 401 at the same moment.
/// Refreshing per-request would send N refreshes with the same token — and
/// because refresh tokens rotate and the server treats a replayed one as
/// theft, the 2nd through Nth would revoke the whole session family and sign
/// the user out mid-use.
///
/// So refresh is single-flight: the first 401 starts it, every other waits on
/// the same future, and all of them retry once with the new token.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required AuthSessionManager session,
    required Dio refreshClient,
  }) : _session = session,
       _refreshClient = refreshClient;

  final AuthSessionManager _session;

  /// A bare Dio with no interceptors. Refreshing through the main client would
  /// recurse: the refresh call 401s, which triggers a refresh, and so on.
  final Dio _refreshClient;

  Future<void>? _inFlightRefresh;

  /// Paths that must never carry a bearer token or trigger a refresh.
  static const Set<String> _anonymousPaths = {
    ApiEndpoints.authPhoneStart,
    ApiEndpoints.authPhoneVerify,
    ApiEndpoints.authRefresh,
  };

  bool _isAnonymous(RequestOptions options) =>
      _anonymousPaths.any(options.path.endsWith);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_isAnonymous(options)) {
      final token = _session.accessToken;
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final options = err.requestOptions;

    // The server answers an expired token with 403 + code TOKEN_EXPIRED (403
    // rather than 401 because the Failure union has no "unauthenticated"
    // kind), so the code is what identifies a refreshable failure.
    final code = _errorCode(response?.data);
    final refreshable =
        !_isAnonymous(options) &&
        (code == 'TOKEN_EXPIRED' ||
            code == 'UNAUTHENTICATED' ||
            _isStaleRoleDenial(code)) &&
        options.extra['retriedAfterRefresh'] != true;

    if (!refreshable || !_session.hasSession) {
      handler.next(err);
      return;
    }

    // The token may already have been refreshed while this request was in
    // flight. Several requests typically go out together with the same stale
    // token and all fail; the first triggers the refresh, and by the time the
    // rest are handled the session already holds a fresh token. Refreshing
    // again would replay a rotated refresh token — which the server correctly
    // treats as theft and answers by revoking the entire session family.
    final tokenUsed = _bearerOf(options);
    if (tokenUsed != null && tokenUsed != _session.accessToken) {
      await _retry(options, handler, err);
      return;
    }

    try {
      await _refreshOnce();
    } on Object {
      // Refresh failed: the session is genuinely over. Signing out here rather
      // than letting every queued request fail separately means the user sees
      // one sign-in prompt, not a cascade of errors.
      await _session.signOut(
        code == 'REFRESH_REUSED'
            ? SignOutReason.sessionRevoked
            : SignOutReason.sessionExpired,
      );
      handler.next(err);
      return;
    }

    await _retry(options, handler, err);
  }

  /// A permission denial that a fresh token might lift.
  ///
  /// Roles travel inside the access token, so a user whose role changed
  /// server-side — a seller the moment their business is approved — keeps
  /// being refused until their token is reissued. From here the two are
  /// indistinguishable, so the honest move is to refresh once and retry: if
  /// the denial was real the retry fails the same way and falls through,
  /// costing one request. Without it a newly approved seller cannot publish
  /// anything until their access token happens to expire.
  static bool _isStaleRoleDenial(String? code) =>
      code != null && code.startsWith('PERMISSION_');

  /// Replays a request with whatever token the session now holds.
  Future<void> _retry(
    RequestOptions options,
    ErrorInterceptorHandler handler,
    DioException original,
  ) async {
    try {
      // Marked so a second failure on the retry falls through instead of looping.
      options.extra['retriedAfterRefresh'] = true;
      final token = _session.accessToken;
      if (token != null) options.headers['Authorization'] = 'Bearer $token';

      final retried = await _refreshClient.fetch<dynamic>(options);
      handler.resolve(retried);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  static String? _bearerOf(RequestOptions options) {
    final header = options.headers['Authorization'];
    if (header is! String || !header.startsWith('Bearer ')) return null;
    return header.substring('Bearer '.length);
  }

  /// Runs at most one refresh at a time; concurrent callers await the same one.
  Future<void> _refreshOnce() {
    final existing = _inFlightRefresh;
    if (existing != null) return existing;

    final future = _performRefresh().whenComplete(() {
      _inFlightRefresh = null;
    });
    _inFlightRefresh = future;
    return future;
  }

  Future<void> _performRefresh() async {
    final refreshToken = _session.refreshToken;
    if (refreshToken == null) {
      throw StateError('No refresh token to exchange');
    }

    final response = await _refreshClient.post<Map<String, dynamic>>(
      ApiEndpoints.authRefresh,
      data: {'refreshToken': refreshToken},
    );

    final body = response.data;
    final access = body?['accessToken'] as String?;
    final refresh = body?['refreshToken'] as String?;
    if (access == null || refresh == null) {
      throw StateError('Refresh response did not contain a token pair');
    }

    await _session.rotate(accessToken: access, refreshToken: refresh);
  }

  static String? _errorCode(Object? body) {
    if (body is Map && body['error'] is Map) {
      return (body['error'] as Map)['code'] as String?;
    }
    return null;
  }
}
