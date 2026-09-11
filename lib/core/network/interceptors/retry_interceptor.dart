import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';

/// Retries transient failures with exponential backoff and jitter.
///
/// Deliberately conservative about *what* it retries. A timeout on a POST is
/// ambiguous — the request may have been applied server-side — so replaying it
/// could double-charge. Only two cases are retried:
///
///  * safe methods (GET/HEAD), which are idempotent by definition;
///  * POSTs that carry an `Idempotency-Key`, where the server guarantees a
///    replay returns the first response instead of acting twice.
///
/// Jitter matters on mobile: without it, every device that lost connectivity
/// during an outage retries in lockstep and hits the server as one wave.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({this.maxAttempts = 3, Dio? client}) : _client = client;

  final int maxAttempts;
  final Dio? _client;
  final Random _random = Random();

  static const Set<DioExceptionType> _transient = {
    DioExceptionType.connectionTimeout,
    DioExceptionType.sendTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.connectionError,
  };

  bool _isRetryable(DioException error) {
    final options = error.requestOptions;
    final method = options.method.toUpperCase();

    final safeMethod = method == 'GET' || method == 'HEAD';
    final replayable =
        safeMethod || options.headers.containsKey('Idempotency-Key');
    if (!replayable) return false;

    if (_transient.contains(error.type)) return true;

    // 502/503/504 mean the request never reached working code; 500 might have
    // had a side effect, so it is not retried.
    final status = error.response?.statusCode;
    return status == 502 || status == 503 || status == 504;
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = (options.extra['retryAttempt'] as int? ?? 0) + 1;

    if (!_isRetryable(err) || attempt >= maxAttempts) {
      handler.next(err);
      return;
    }

    // 250ms, 500ms, 1s … plus up to 250ms of jitter.
    final backoff = Duration(
      milliseconds: 250 * (1 << (attempt - 1)) + _random.nextInt(250),
    );
    await Future<void>.delayed(backoff);

    options.extra['retryAttempt'] = attempt;

    try {
      final client = _client ?? Dio();
      final response = await client.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }
}
