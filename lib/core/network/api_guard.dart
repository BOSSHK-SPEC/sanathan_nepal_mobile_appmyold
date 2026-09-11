import 'package:dio/dio.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';
import 'api_exception.dart';

/// Runs a remote call and converts transport failures into domain exceptions.
///
/// Every remote data source wraps its I/O in this. Without it each one would
/// re-implement the same try/catch, and the ones that forgot would leak a raw
/// `DioException` past the data layer — which the repository's `guard()` would
/// then report as an opaque "unknown" failure, losing the server's error code.
Future<T> guardApi<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (error) {
    final mapped = mapDioException(error);
    throw _toDataException(mapped);
  }
}

/// Bridges [ApiException] onto the data-layer exceptions repositories already
/// catch, so `guard()` produces the right `Failure` without any feature
/// knowing that HTTP was involved.
///
/// Exhaustive `switch` on the sealed union rather than freezed's `map`, which
/// `build.yaml` disables deliberately — the compiler then flags this the day a
/// new failure kind is added.
Exception _toDataException(ApiException api) => switch (api.failure) {
  ServerFailure(:final message) => ServerException(message, api.statusCode),
  NetworkFailure(:final message) => NetworkException(message),
  CacheFailure(:final message) => CacheException(message),
  ValidationFailure(:final message) => ValidationException(
    message,
    api.fields.isEmpty ? null : api.fields.keys.first,
  ),
  NotFoundFailure(:final message) => NotFoundException(message),
  PermissionFailure(:final message) => PermissionException(message),
  UnknownFailure(:final message) => ServerException(message, api.statusCode),
};

/// Reads a JSON object body, or throws if the server sent something else.
Map<String, dynamic> asJsonMap(Response<dynamic> response) {
  final data = response.data;
  if (data is Map<String, dynamic>) return data;
  if (data is Map) return Map<String, dynamic>.from(data);
  throw const ServerException('Expected a JSON object from the server');
}

/// Reads a JSON array body as a list of objects.
List<Map<String, dynamic>> asJsonList(Response<dynamic> response) {
  final data = response.data;
  if (data is List) {
    return data
        .whereType<Map>()
        .map(Map<String, dynamic>.from)
        .toList(growable: false);
  }
  throw const ServerException('Expected a JSON array from the server');
}

/// Reads the `items` array of a cursor page.
List<Map<String, dynamic>> asPageItems(Response<dynamic> response) {
  final body = asJsonMap(response);
  final items = body['items'];
  if (items is List) {
    return items
        .whereType<Map>()
        .map(Map<String, dynamic>.from)
        .toList(growable: false);
  }
  throw const ServerException('Expected a paged response with an items array');
}
