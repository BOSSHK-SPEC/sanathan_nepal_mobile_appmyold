import 'package:dio/dio.dart';

import '../error/failures.dart';

/// A failure the server described, or a transport failure we classified.
///
/// Carries the server's stable [code] and per-field messages so the UI can key
/// off an identifier rather than parsing a sentence, plus the [traceId] a user
/// can quote to support.
class ApiException implements Exception {
  const ApiException({
    required this.failure,
    required this.code,
    this.fields = const {},
    this.traceId,
    this.statusCode,
  });

  final Failure failure;

  /// Stable identifier, e.g. `WALLET_INSUFFICIENT`. Never shown to a user.
  final String code;

  /// Field path to message, for inline form errors.
  final Map<String, String> fields;

  final String? traceId;
  final int? statusCode;

  bool get isUnauthenticated =>
      code == 'UNAUTHENTICATED' || code == 'TOKEN_EXPIRED';
  bool get isRateLimited => code == 'RATE_LIMITED';

  @override
  String toString() =>
      'ApiException($code, status: $statusCode, trace: $traceId)';
}

/// Translates a `DioException` into an [ApiException].
///
/// The server always answers with `{ error: { kind, code, message, fields?,
/// traceId } }`, which maps one-to-one onto [Failure] — so the client never
/// parses a message string to decide what happened. Transport problems that
/// never reached the server are classified here instead.
ApiException mapDioException(DioException error) {
  final response = error.response;
  final body = response?.data;

  if (body is Map && body['error'] is Map) {
    final envelope = Map<String, dynamic>.from(body['error'] as Map);
    final kind = envelope['kind'] as String? ?? 'unknown';
    final message = _messageOf(envelope['message']);
    final code = envelope['code'] as String? ?? 'UNKNOWN_ERROR';

    final rawFields = envelope['fields'];
    final fields = rawFields is Map
        ? rawFields.map((k, v) => MapEntry(k.toString(), v.toString()))
        : const <String, String>{};

    return ApiException(
      failure: _failureFor(kind, message),
      code: code,
      fields: fields,
      traceId: envelope['traceId'] as String?,
      statusCode: response?.statusCode,
    );
  }

  // Nothing usable came back — classify the transport failure.
  return switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => const ApiException(
      failure: Failure.network('The connection timed out. Please try again.'),
      code: 'TIMEOUT',
    ),
    DioExceptionType.connectionError => const ApiException(
      failure: Failure.network('No internet connection'),
      code: 'OFFLINE',
    ),
    DioExceptionType.cancel => const ApiException(
      failure: Failure.unknown('Request cancelled'),
      code: 'CANCELLED',
    ),
    DioExceptionType.badCertificate => const ApiException(
      failure: Failure.network('Could not establish a secure connection'),
      code: 'BAD_CERTIFICATE',
    ),
    // badResponse, unknown, transformTimeout and anything Dio adds later.
    _ => ApiException(
      failure: const Failure.server('Server error'),
      code: 'SERVER_ERROR',
      statusCode: response?.statusCode,
    ),
  };
}

/// The server may send a plain string or a `{en, ne, hi}` object.
String _messageOf(Object? raw) {
  if (raw is String) return raw;
  if (raw is Map) {
    return (raw['en'] ?? raw['ne'] ?? raw['hi'] ?? 'Something went wrong')
        .toString();
  }
  return 'Something went wrong';
}

/// Mirrors the server's `FailureKind` union exactly.
Failure _failureFor(String kind, String message) => switch (kind) {
  'validation' => Failure.validation(message),
  'notFound' => Failure.notFound(message),
  'permission' => Failure.permission(message),
  'network' => Failure.network(message),
  'cache' => Failure.cache(message),
  'server' => Failure.server(message),
  _ => Failure.unknown(message),
};
