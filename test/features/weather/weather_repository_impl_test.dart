import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_all.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/data/datasources/mock_weather_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/data/models/weather_bundle_model.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/data/services/mock_location_service.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/domain/entities/geo_location.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/domain/entities/weather_condition.dart';

class _MockRemote extends Mock implements WeatherDataSource {}

void main() {
  late _MockRemote remote;
  late WeatherRepositoryImpl repo;
  final clock = DateTime(2024, 3, 1, 10);

  setUpAll(() => registerFallbackValue(GeoLocation.kathmandu));

  setUp(() {
    remote = _MockRemote();
    repo = WeatherRepositoryImpl(
      remote: remote,
      fallback: MockWeatherDataSource(now: clock),
    );
  });

  test('returns remote data when the network call succeeds', () async {
    final model = await MockWeatherDataSource(
      now: clock,
    ).fetchForecast(GeoLocation.kathmandu);
    final remoteModel = WeatherBundleModel(
      location: model.location,
      current: model.current,
      hourly: model.hourly,
      daily: model.daily,
    );
    when(
      () => remote.fetchForecast(any()),
    ).thenAnswer((_) async => remoteModel);

    final result = await repo.getForecast(GeoLocation.kathmandu);

    expect(result.isSuccess, isTrue);
    expect(result.valueOrNull!.isFallback, isFalse);
    expect(result.valueOrNull!.current.temperature, 26);
  });

  test('falls back to the mock data source when the remote throws', () async {
    when(() => remote.fetchForecast(any())).thenThrow(const NetworkException());

    final result = await repo.getForecast(GeoLocation.kathmandu);

    expect(result.isSuccess, isTrue);
    final bundle = result.valueOrNull!;
    expect(bundle.isFallback, isTrue);
    expect(bundle.daily, hasLength(7));
    expect(bundle.upcomingHours(count: 5), hasLength(5));
    expect(bundle.current.condition, WeatherCondition.partlyCloudy);
  });

  test('a missing endpoint still serves a forecast, marked as fallback', () async {
    // The failure that hid for months: if the app calls a path this backend
    // does not serve, every request 404s and the fallback quietly covers for
    // it. The screen must still show weather — and the bundle must admit it
    // is not live, which is what the page's banner reads.
    when(
      () => remote.fetchForecast(any()),
    ).thenThrow(const NotFoundException('Cannot GET /market/weather'));

    final result = await repo.getForecast(GeoLocation.kathmandu);

    expect(result.isSuccess, isTrue);
    expect(result.valueOrNull!.isFallback, isTrue);
  });

  test('a server error falls back too, rather than failing the screen', () async {
    // A 500 is not the user's problem to look at: weather is ambient, so the
    // home screen degrades instead of erroring.
    when(
      () => remote.fetchForecast(any()),
    ).thenThrow(const ServerException('upstream unavailable', 503));

    final result = await repo.getForecast(GeoLocation.kathmandu);

    expect(result.isSuccess, isTrue);
    expect(result.valueOrNull!.isFallback, isTrue);
  });

  test('live data is never marked as fallback', () async {
    // The flag is what the page trusts to decide whether to warn the user, so
    // a success path that mislabels itself is worse than no flag at all.
    final model = await MockWeatherDataSource(
      now: clock,
    ).fetchForecast(GeoLocation.kathmandu);
    when(() => remote.fetchForecast(any())).thenAnswer(
      (_) async => WeatherBundleModel(
        location: model.location,
        current: model.current,
        hourly: model.hourly,
        daily: model.daily,
      ),
    );

    final result = await repo.getForecast(GeoLocation.kathmandu);

    expect(result.valueOrNull!.isFallback, isFalse);
  });

  test('WeatherBundleModel parses Open-Meteo JSON', () {
    final json = <String, dynamic>{
      'current': {
        'time': '2024-03-01T10:00',
        'temperature_2m': 21.4,
        'weather_code': 61,
        'relative_humidity_2m': 70,
        'wind_speed_10m': 12.5,
      },
      'hourly': {
        'time': ['2024-03-01T10:00', '2024-03-01T11:00'],
        'temperature_2m': [21.4, 22.0],
        'precipitation_probability': [30, 45],
        'weather_code': [61, 63],
      },
      'daily': {
        'time': ['2024-03-01'],
        'temperature_2m_max': [24.0],
        'temperature_2m_min': [12.0],
        'weather_code': [3],
        'sunrise': ['2024-03-01T06:26'],
        'sunset': ['2024-03-01T18:06'],
      },
    };
    final model = WeatherBundleModel.fromOpenMeteo(
      json,
      location: GeoLocation.kathmandu,
    );
    expect(model.current.condition, WeatherCondition.rain);
    expect(model.current.precipitationProbability, 30);
    expect(model.current.isDay, isTrue);
    expect(model.hourly, hasLength(2));
    expect(model.daily.first.condition, WeatherCondition.overcast);
    expect(model.daily.first.sunrise.hour, 6);
    // Round-trips through the app's own JSON shape and back to the entity.
    final copy = WeatherBundleModel.fromJson(model.toJson());
    expect(copy, model);
    expect(copy.toEntity().current.temperature, 21.4);
    expect(copy.toEntity().location, GeoLocation.kathmandu);
  });

  test('MockLocationService follows the region default city', () async {
    const nepal = MockLocationService();
    const india = MockLocationService(
      resolver: FixedRegionResolver(Region.india),
    );
    expect(await nepal.currentLocation(), GeoLocation.kathmandu);
    final delhi = await india.currentLocation();
    expect(delhi, GeoLocation.newDelhi);
    expect(delhi.displayName(languageCode: 'hi'), 'नई दिल्ली');
    expect(delhi.displayName(languageCode: 'en'), 'New Delhi');
    // An explicit location wins over the region default.
    const fixed = MockLocationService(
      location: GeoLocation.kathmandu,
      resolver: FixedRegionResolver(Region.india),
    );
    expect(await fixed.currentLocation(), GeoLocation.kathmandu);
  });

  test('WeatherCondition labels exist for Hindi', () {
    for (final c in WeatherCondition.values) {
      expect(c.label(languageCode: 'hi'), isNotEmpty);
      expect(c.label(languageCode: 'ne'), c.labelNe);
      expect(c.label(languageCode: 'en'), c.labelEn);
    }
  });
}
