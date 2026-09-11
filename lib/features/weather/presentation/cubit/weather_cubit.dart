import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/geo_location.dart';
import '../../domain/entities/weather_bundle.dart';
import '../../domain/usecases/get_weather.dart';
import '../../domain/usecases/get_weather_for_location.dart';
import '../../../../core/state/app_cubit.dart';

part 'weather_cubit.freezed.dart';
part 'weather_state.dart';

/// Loads the forecast for the device location (or an explicit one) and
/// tracks which hourly card is highlighted.
class WeatherCubit extends AppCubit<WeatherState> {
  WeatherCubit({
    required GetWeather getWeather,
    required GetWeatherForLocation getWeatherForLocation,
  }) : _getWeather = getWeather,
       _getForLocation = getWeatherForLocation,
       super(const WeatherState());

  final GetWeather _getWeather;
  final GetWeatherForLocation _getForLocation;

  /// Loads weather for the current device location (falls back to the
  /// region's default city).
  Future<void> load() async {
    emit(
      state.copyWith(
        weather: state.weather.toLoading(),
        explicitLocation: null,
      ),
    );
    _emitResult(await _getWeather());
  }

  /// Loads weather for an explicit [location].
  Future<void> loadFor(GeoLocation location) async {
    emit(
      state.copyWith(
        weather: state.weather.toLoading(),
        explicitLocation: location,
      ),
    );
    _emitResult(await _getForLocation(location));
  }

  /// Re-fetches for the explicit location already shown, or the device /
  /// region-default location.
  Future<void> refresh() {
    final loc = state.explicitLocation;
    return loc == null ? load() : loadFor(loc);
  }

  void selectHour(int index) {
    if (index < 0 || index == state.selectedHourIndex) return;
    emit(state.copyWith(selectedHourIndex: index));
  }

  void _emitResult(Result<WeatherBundle> result) {
    if (isClosed) return;
    emit(
      state.copyWith(
        weather: result.fold(state.weather.toFailed, LoadState.loaded),
        // A fresh forecast starts at the current hour again.
        selectedHourIndex: result.isSuccess ? 0 : state.selectedHourIndex,
      ),
    );
  }
}
