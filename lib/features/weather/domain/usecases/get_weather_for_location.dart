import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/geo_location.dart';
import '../entities/weather_bundle.dart';
import '../repositories/weather_repository.dart';

/// Loads the forecast for an explicit [GeoLocation] (e.g. a city picked by
/// the user).
class GetWeatherForLocation implements UseCase<WeatherBundle, GeoLocation> {
  const GetWeatherForLocation(this._repository);
  final WeatherRepository _repository;

  @override
  Future<Result<WeatherBundle>> call(GeoLocation params) =>
      _repository.getForecast(params);
}
