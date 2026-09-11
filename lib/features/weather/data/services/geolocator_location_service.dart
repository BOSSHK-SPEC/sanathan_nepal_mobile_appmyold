import 'package:geolocator/geolocator.dart';

import '../../domain/entities/geo_location.dart';
import '../../domain/repositories/location_service.dart';
import 'mock_location_service.dart';

/// Device location via `geolocator`.
///
/// Requests permission when needed; if the service is disabled, permission
/// is denied (or denied forever), or anything throws, it resolves to
/// [fallback] – never surfacing an error to the caller.
class GeolocatorLocationService implements LocationService {
  const GeolocatorLocationService({
    LocationService fallback = const MockLocationService(),
    Duration timeout = const Duration(seconds: 5),
  }) : _fallback = fallback,
       _timeout = timeout;

  final LocationService _fallback;
  final Duration _timeout;

  @override
  Future<GeoLocation> currentLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return _fallback.currentLocation();
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        return _fallback.currentLocation();
      }
      // Prefer an instant cached fix; only wait for a fresh one when there is
      // none. The outer `.timeout` guards against providers that never answer
      // (emulators, airplane mode) so the UI is never blocked for long.
      final position =
          await Geolocator.getLastKnownPosition() ??
          await Geolocator.getCurrentPosition(
            locationSettings: LocationSettings(
              accuracy: LocationAccuracy.low,
              timeLimit: _timeout,
            ),
          ).timeout(_timeout);
      return GeoLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        // Reverse geocoding is out of scope (no geocoding package), so the
        // header shows a generic "My location" label for GPS fixes.
        name: 'My Location',
        nameNe: 'मेरो स्थान',
        nameHi: 'मेरा स्थान',
      );
    } catch (_) {
      return _fallback.currentLocation();
    }
  }
}
