part of 'weather_cubit.dart';

/// UI state for the weather page and the home summary card.
@freezed
abstract class WeatherState with _$WeatherState {
  const WeatherState._();

  const factory WeatherState({
    @Default(LoadState.idle()) LoadState<WeatherBundle> weather,

    /// Index into `bundle.upcomingHours()` of the highlighted hourly card.
    @Default(0) int selectedHourIndex,

    /// Location chosen explicitly via `loadFor` (null = device / region
    /// default location).
    GeoLocation? explicitLocation,
  }) = _WeatherState;

  bool get isLoading => weather.isLoading;
  bool get hasData => weather.dataOrNull != null;
}
