import '../../../../core/region/region_all.dart';
import '../../domain/entities/geo_location.dart';
import '../../domain/repositories/location_service.dart';

/// Always resolves to a fixed location. Without an explicit [location] it
/// returns the active region's default city (Kathmandu / New Delhi), read
/// from [RegionResolver] at call time. Used in tests and as the fallback for
/// the real geolocator implementation.
class MockLocationService implements LocationService {
  const MockLocationService({
    this.location,
    RegionResolver resolver = const FixedRegionResolver(Region.nepal),
  }) : _resolver = resolver;

  /// Fixed location; when null the region default is used.
  final GeoLocation? location;
  final RegionResolver _resolver;

  @override
  Future<GeoLocation> currentLocation() async =>
      location ?? GeoLocation.fromGeoPoint(_resolver.config.defaultCity);
}
