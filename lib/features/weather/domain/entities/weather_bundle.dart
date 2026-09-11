import 'package:freezed_annotation/freezed_annotation.dart';

import 'current_weather.dart';
import 'daily_forecast.dart';
import 'geo_location.dart';
import 'hourly_forecast.dart';

part 'weather_bundle.freezed.dart';

/// Everything the weather screens need for one location, fetched in a
/// single call.
@freezed
abstract class WeatherBundle with _$WeatherBundle {
  const WeatherBundle._();

  const factory WeatherBundle({
    required GeoLocation location,
    required CurrentWeather current,

    /// Hourly forecast starting from the current hour (typically 24+ entries).
    required List<HourlyForecast> hourly,

    /// Daily forecast starting today (typically 7 entries).
    required List<DailyForecast> daily,

    /// True when the data came from the offline mock (network unavailable).
    @Default(false) bool isFallback,
  }) = _WeatherBundle;

  /// Today's entry, or `null` when [daily] is empty.
  DailyForecast? get today => daily.isEmpty ? null : daily.first;

  /// Hourly entries from the current hour onwards, capped to [count].
  List<HourlyForecast> upcomingHours({int count = 24}) {
    final now = current.time;
    final start = hourly.indexWhere((h) => !h.time.isBefore(now));
    final from = start < 0 ? 0 : start;
    return hourly.skip(from).take(count).toList(growable: false);
  }
}
