import 'dart:async';

import 'package:dio/dio.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';
import 'result.dart';

/// Wraps a data-source call and converts thrown exceptions into [Failure]s.
///
/// Repositories should use this instead of hand-writing try/catch blocks –
/// it keeps error mapping in exactly one place (SRP / DRY).
Future<Result<T>> guard<T>(FutureOr<T> Function() body) async {
  try {
    return Result.success(await body());
  } on ServerException catch (e) {
    return Result.failure(Failure.server(e.message));
  } on NetworkException catch (e) {
    return Result.failure(Failure.network(e.message));
  } on CacheException catch (e) {
    return Result.failure(Failure.cache(e.message));
  } on NotFoundException catch (e) {
    return Result.failure(Failure.notFound(e.message));
  } on PermissionException catch (e) {
    return Result.failure(Failure.permission(e.message));
  } on ValidationException catch (e) {
    return Result.failure(Failure.validation(e.message));
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const Result.failure(Failure.network());
    }
    return Result.failure(Failure.server(e.message ?? 'Server error'));
  } on FormatException catch (e) {
    return Result.failure(Failure.server('Malformed response: ${e.message}'));
  } catch (e) {
    return Result.failure(Failure.unknown(e.toString()));
  }
}
