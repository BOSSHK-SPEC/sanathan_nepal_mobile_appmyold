/// Data-layer exceptions thrown by data sources. Repositories catch these
/// and convert them into [Failure]s.
class ServerException implements Exception {
  const ServerException([this.message = 'Server error', this.statusCode]);
  final String message;
  final int? statusCode;
  @override
  String toString() => 'ServerException($statusCode): $message';
}

class NetworkException implements Exception {
  const NetworkException([this.message = 'No internet connection']);
  final String message;
  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  const CacheException([this.message = 'Cache error']);
  final String message;
  @override
  String toString() => 'CacheException: $message';
}

class NotFoundException implements Exception {
  const NotFoundException([this.message = 'Not found']);
  final String message;
  @override
  String toString() => 'NotFoundException: $message';
}

class PermissionException implements Exception {
  const PermissionException([this.message = 'Permission denied']);
  final String message;
  @override
  String toString() => 'PermissionException: $message';
}

/// Input the data layer rejected before any I/O — surfaced to the user as a
/// form error rather than a system failure.
class ValidationException implements Exception {
  const ValidationException([this.message = 'Invalid input', this.field]);
  final String message;

  /// Field the error belongs to, when it maps to one input.
  final String? field;
  @override
  String toString() => 'ValidationException: $message';
}
