import '../../../../core/region/region_all.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/geo_location.dart';
import '../entities/weather_bundle.dart';
import '../repositories/location_service.dart';
import '../repositories/weather_repository.dart';

/// Resolves the device location (falling back to the active region's
/// default city – Kathmandu / New Delhi) and loads the forecast for it.
class GetWeather implements NoParamsUseCase<WeatherBundle> {
  const GetWeather({
    required WeatherRepository repository,
    required LocationService locationService,
    RegionResolver resolver = const FixedRegionResolver(Region.nepal),
  }) : _repository = repository,
       _location = locationService,
       _resolver = resolver;

  final WeatherRepository _repository;
  final LocationService _location;
  final RegionResolver _resolver;

  @override
  Future<Result<WeatherBundle>> call() async {
    GeoLocation location;
    try {
      location = await _location.currentLocation();
    } catch (_) {
      location = GeoLocation.fromGeoPoint(_resolver.config.defaultCity);
    }
    return _repository.getForecast(location);
  }
}
