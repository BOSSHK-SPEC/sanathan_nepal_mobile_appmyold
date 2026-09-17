import 'dart:developer' as developer;

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/geo_location.dart';
import '../../domain/entities/weather_bundle.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';

/// Weather from our API, with a second source behind it.
///
/// Falling back is deliberate — a home screen should show a forecast rather
/// than an error — but it used to be *silent*: every failure was caught the
/// same way and discarded. A backend answering 404 on every request then
/// looked exactly like a phone in a tunnel, so a broken primary path could run
/// for months while the screen kept looking healthy.
///
/// Each fall-through is now recorded with what actually went wrong, because
/// the responses differ: a missing endpoint is ours to fix and needs finding
/// today; an offline device is nobody's fault and needs nothing.
class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl({
    required WeatherDataSource remote,
    required WeatherDataSource fallback,
  }) : _remote = remote,
       _fallback = fallback;

  final WeatherDataSource _remote;
  final WeatherDataSource _fallback;

  @override
  Future<Result<WeatherBundle>> getForecast(GeoLocation location) =>
      guard(() async {
        try {
          return (await _remote.fetchForecast(location)).toEntity();
        } on Exception catch (error, stack) {
          _reportFallback(error, stack);
          final fallback = await _fallback.fetchForecast(location);
          return fallback.toEntity().copyWith(isFallback: true);
        }
      });

  /// Says why the primary source was abandoned, at a level matching whose
  /// problem it is.
  ///
  /// A [NotFoundException] means the endpoint this build calls does not exist
  /// on the server it is talking to — a wiring mistake that will never fix
  /// itself, and the one case worth shouting about.
  void _reportFallback(Exception error, StackTrace stack) {
    final (level, summary) = switch (error) {
      NotFoundException() => (
        1000, // SEVERE: the app and the API disagree about the contract.
        'weather endpoint is missing on this backend — check the API build',
      ),
      ServerException(:final statusCode) => (
        900, // WARNING: reachable, but unhappy.
        'weather request failed with status ${statusCode ?? 'unknown'}',
      ),
      NetworkException() => (
        800, // INFO: expected on a phone; nothing to fix.
        'weather unreachable — the device appears to be offline',
      ),
      _ => (900, 'weather request failed'),
    };

    developer.log(
      '$summary; serving the fallback forecast',
      name: 'weather',
      level: level,
      error: error,
      stackTrace: stack,
    );
  }
}
