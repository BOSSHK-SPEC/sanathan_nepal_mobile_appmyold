import 'package:dio/dio.dart';

import '../auth/auth_session_manager.dart';
import '../config/app_environment.dart';
import '../region/region_resolver.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/context_interceptor.dart';
import 'interceptors/idempotency_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

/// Thin wrapper around [Dio] shared by all remote data sources.
///
/// New endpoints go through feature-specific data sources that receive this
/// client by constructor injection — never `Dio()` inline, or a request skips
/// authentication, tracing and retry.
class ApiClient {
  ApiClient({Dio? dio, String? baseUrl})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl ?? '',
              connectTimeout: AppEnvironment.connectTimeout,
              receiveTimeout: AppEnvironment.receiveTimeout,
              sendTimeout: AppEnvironment.sendTimeout,
              headers: const {'Accept': 'application/json'},
              // 4xx and 5xx must raise, so one error path handles them all.
              validateStatus: (status) => status != null && status < 400,
            ),
          );

  /// The app's own API, with the full interceptor chain.
  ///
  /// Order is deliberate and load-bearing:
  ///
  /// 1. **logging** first, so it sees the request as the app made it;
  /// 2. **context** adds region, trace id and language;
  /// 3. **idempotency** stamps a key *before* retry exists, so every retry of
  ///    one attempt carries the same key;
  /// 4. **auth** attaches the token and owns the single-flight refresh;
  /// 5. **retry** last, so a replay re-enters with a refreshed token.
  factory ApiClient.forBackend({
    required AuthSessionManager session,
    required RegionResolver regions,
    required String Function() languageCode,
  }) {
    BaseOptions options() => BaseOptions(
      baseUrl: AppEnvironment.apiRoot,
      connectTimeout: AppEnvironment.connectTimeout,
      receiveTimeout: AppEnvironment.receiveTimeout,
      sendTimeout: AppEnvironment.sendTimeout,
      headers: const {'Accept': 'application/json'},
      validateStatus: (status) => status != null && status < 400,
    );

    final dio = Dio(options());

    // A bare client for refresh and for replaying a request. It must have no
    // interceptors: refreshing through the main chain would recurse when the
    // refresh call itself comes back unauthorised.
    final plainClient = Dio(options());

    dio.interceptors.addAll([
      LoggingInterceptor(logBodies: AppEnvironment.logNetworkBodies),
      ContextInterceptor(regions: regions, languageCode: languageCode),
      IdempotencyInterceptor(),
      AuthInterceptor(session: session, refreshClient: plainClient),
      RetryInterceptor(client: plainClient),
    ]);

    return ApiClient(dio: dio);
  }

  final Dio dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
  }) => dio.get<T>(
    path,
    queryParameters: query,
    options: options,
    cancelToken: cancelToken,
  );

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
    Options? options,
    CancelToken? cancelToken,
  }) => dio.post<T>(
    path,
    data: data,
    queryParameters: query,
    options: options,
    cancelToken: cancelToken,
  );

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
    Options? options,
  }) => dio.put<T>(path, data: data, queryParameters: query, options: options);

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
    Options? options,
  }) =>
      dio.patch<T>(path, data: data, queryParameters: query, options: options);

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
    Options? options,
  }) =>
      dio.delete<T>(path, data: data, queryParameters: query, options: options);
}
