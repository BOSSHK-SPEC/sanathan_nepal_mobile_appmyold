import '../../../../core/utils/result.dart';
import '../entities/geo_location.dart';
import '../entities/weather_bundle.dart';

/// Contract for fetching a forecast for a location.
abstract interface class WeatherRepository {
  Future<Result<WeatherBundle>> getForecast(GeoLocation location);
}
