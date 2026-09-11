import '../entities/geo_location.dart';

/// Abstraction over device location so the domain never depends on
/// `geolocator`. Implementations must never throw – on permission denial
/// or any error they resolve to a sensible fallback (Kathmandu).
abstract interface class LocationService {
  Future<GeoLocation> currentLocation();
}
