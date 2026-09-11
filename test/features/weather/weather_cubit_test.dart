import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/state/load_state.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/data/datasources/mock_weather_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/domain/entities/geo_location.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/domain/entities/weather_bundle.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/domain/usecases/get_weather.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/domain/usecases/get_weather_for_location.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/presentation/cubit/weather_cubit.dart';

class _MockGetWeather extends Mock implements GetWeather {}

class _MockGetForLocation extends Mock implements GetWeatherForLocation {}

void main() {
  late _MockGetWeather getWeather;
  late _MockGetForLocation getForLocation;
  late WeatherBundle bundle;

  setUpAll(() => registerFallbackValue(GeoLocation.kathmandu));

  setUp(() async {
    getWeather = _MockGetWeather();
    getForLocation = _MockGetForLocation();
    bundle = (await MockWeatherDataSource(
      now: DateTime(2024, 3, 1, 9),
    ).fetchForecast(GeoLocation.kathmandu)).toEntity();
  });

  WeatherCubit build() => WeatherCubit(
    getWeather: getWeather,
    getWeatherForLocation: getForLocation,
  );

  blocTest<WeatherCubit, WeatherState>(
    'load emits [loading, success] with the bundle',
    build: () {
      when(() => getWeather()).thenAnswer((_) async => Result.success(bundle));
      return build();
    },
    act: (c) => c.load(),
    expect: () => [
      const WeatherState(weather: LoadState.loading()),
      WeatherState(weather: LoadState.loaded(bundle)),
    ],
  );

  blocTest<WeatherCubit, WeatherState>(
    'load emits [loading, failure] when the use case fails',
    build: () {
      when(() => getWeather()).thenAnswer(
        (_) async => const Result.failure(NetworkFailure('offline')),
      );
      return build();
    },
    act: (c) => c.load(),
    expect: () => const [
      WeatherState(weather: LoadState.loading()),
      WeatherState(weather: LoadState.failed(NetworkFailure('offline'))),
    ],
    verify: (c) => expect(c.state.weather.errorMessage, 'offline'),
  );

  blocTest<WeatherCubit, WeatherState>(
    'selectHour updates the highlighted index',
    build: build,
    seed: () => WeatherState(weather: LoadState.loaded(bundle)),
    act: (c) => c.selectHour(2),
    expect: () => [
      WeatherState(weather: LoadState.loaded(bundle), selectedHourIndex: 2),
    ],
  );

  blocTest<WeatherCubit, WeatherState>(
    'loadFor uses the explicit-location use case',
    build: () {
      when(
        () => getForLocation(any()),
      ).thenAnswer((_) async => Result.success(bundle));
      return build();
    },
    act: (c) => c.loadFor(GeoLocation.kathmandu),
    verify: (_) =>
        verify(() => getForLocation(GeoLocation.kathmandu)).called(1),
  );
}
