import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/calendar/data/datasources/api_calendar_events_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/content/data/datasources/api_article_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/content/domain/entities/article.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/data/datasources/api_legal_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/api_appointment_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/forex/data/datasources/api_forex_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/home/data/datasources/api_metal_rates_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/legal/domain/entities/legal_document.dart';
import 'package:sanathan_nepal_mobile_app/features/puja/data/datasources/api_puja_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/reports/data/datasources/api_report_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/data/datasources/api_weather_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/weather/domain/entities/geo_location.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';

/// Contract tests against a **running** backend.
///
/// Unit tests prove the mapper handles a payload we wrote by hand; these prove
/// the payload the server actually sends is that payload. They are the only
/// thing that catches a field the server renamed, so they are worth the
/// requirement of a live stack.
///
/// They skip themselves when nothing is listening, so `flutter test` still
/// passes on a machine with nothing started — a test that fails because of a
/// missing dependency trains people to ignore red.
///
///   cd ../sanathan-nepal-backend && npm run infra:up && npm run dev:api
///   flutter test test/live
/// Overridable so the suite can be pointed at a second instance while the
/// usual one keeps running: `flutter test --dart-define=API_BASE_URL=…`.
const _baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:3100',
);

Future<bool> _backendIsUp() async {
  try {
    final probe = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 2),
        receiveTimeout: const Duration(seconds: 2),
      ),
    );
    final response = await probe.get<dynamic>('/healthz');
    return response.statusCode == 200;
  } on Object {
    return false;
  }
}

void main() {
  late ApiClient client;
  var reachable = false;

  setUpAll(() async {
    reachable = await _backendIsUp();
    // Anonymous client: every endpoint exercised here is public, which keeps
    // the test independent of a seeded user.
    client = ApiClient(baseUrl: '$_baseUrl/api/v1');
  });

  setUp(() {
    if (!reachable) {
      markTestSkipped('No backend on $_baseUrl — start it to run these.');
    }
  });

  group('content', () {
    test('articles parse from the live server', () async {
      if (!reachable) return;
      final articles = await ApiArticleDataSource(
        client,
      ).fetchArticles(ArticleType.blog);

      expect(articles, isNotEmpty, reason: 'run npm run db:seed');
      final article = articles.first;
      expect(article.id, isNotEmpty);
      expect(article.title.en, isNotEmpty);
      // The seed is bilingual; a missing `ne` would mean the server dropped
      // the localized object somewhere.
      expect(article.title.ne, isNotNull);
      expect(article.publishedAt.year, greaterThan(2000));
    });
  });

  group('calendar', () {
    test('events in a range parse and are sorted', () async {
      if (!reachable) return;
      final now = DateTime.now();
      final events = await ApiCalendarEventsDataSource(
        client,
      ).fetchEvents(from: now, to: now.add(const Duration(days: 60)));

      expect(events, isNotEmpty, reason: 'seed creates Dashain and Tihar');
      for (var i = 1; i < events.length; i++) {
        expect(
          events[i].date.isBefore(events[i - 1].date),
          isFalse,
          reason: 'events must come back in date order',
        );
      }
      expect(events.first.titleEn, isNotEmpty);
      expect(events.first.titleNe, isNotEmpty);
    });
  });

  group('legal', () {
    test('terms parse with intro and section bodies', () async {
      if (!reachable) return;
      final document = await ApiLegalDataSource(
        client,
      ).fetch(LegalDocumentType.termsConditions);

      expect(document.type, LegalDocumentType.termsConditions);
      expect(document.title.en, 'Terms of Service');
      expect(document.title.ne, isNotEmpty);
      expect(document.intro.en, isNotEmpty);
      expect(document.sections, isNotEmpty);

      final section = document.sections.first;
      expect(section.heading.en, isNotEmpty);
      // This is the field the server was missing until the DTO was widened —
      // an empty body here means the contract regressed.
      expect(section.body.en, isNotEmpty);
      expect(section.level, greaterThanOrEqualTo(1));
    });
  });

  group('market data', () {
    test('forex rates parse as money, not as strings', () async {
      if (!reachable) return;
      final today = DateTime.now();
      final days = await ApiForexDataSource(
        client,
      ).fetchRates(from: today.subtract(const Duration(days: 7)), to: today);

      expect(days, isNotEmpty, reason: 'the server publishes a rate table');
      final rate = days.last.rates.first;
      expect(rate.currency.iso3, hasLength(3));
      // Minor units arrive as integer strings; a rate of zero here means the
      // conversion silently swallowed them.
      expect(rate.buy, greaterThan(0));
      expect(rate.sell, greaterThanOrEqualTo(rate.buy));
    });

    test('metal rates come back in the region\'s own unit', () async {
      if (!reachable) return;
      final rates = await ApiMetalRatesDataSource(
        client,
        const FixedRegionResolver(Region.nepal),
      ).fetchToday();

      expect(rates.gold, greaterThan(0));
      expect(rates.silver, greaterThan(0));
      expect(rates.unit, isNotEmpty);
      expect(rates.currency, 'NPR');
    });

    test('the forecast has a current reading and a week of days', () async {
      if (!reachable) return;
      final bundle = await ApiWeatherDataSource(client).fetchForecast(
        const GeoLocation(
          latitude: 27.7172,
          longitude: 85.3240,
          name: 'Kathmandu',
        ),
      );

      expect(bundle.daily, hasLength(7));
      expect(bundle.hourly, isNotEmpty);
      expect(bundle.current.temperature, isNot(0));
      // Sunrise before sunset on every day, or the day/night artwork inverts.
      for (final day in bundle.daily) {
        expect(day.sunrise.isBefore(day.sunset), isTrue);
      }
    });
  });

  group('bookings', () {
    test('providers and their slots parse', () async {
      if (!reachable) return;
      final source = ApiAppointmentDataSource(client);
      final providers = await source.fetchAstrologers();

      expect(providers, isNotEmpty, reason: 'run npm run db:seed');
      final provider = providers.first;
      expect(provider.name.en, isNotEmpty);
      expect(provider.services, isNotEmpty);
      expect(provider.services.first.price, greaterThan(0));

      // Asked for on a day the astrologer actually works, not blindly
      // tomorrow: the seed keeps weekday hours, so "tomorrow" was empty every
      // Friday and the contract looked broken when only the calendar was shut.
      final calendar = await source.fetchAstrologerSlots(provider.id);
      expect(
        calendar,
        isNotEmpty,
        reason: 'run npm run db:seed — the seed publishes weekly hours',
      );
      final day = calendar.first.day;
      final slots = await source.fetchTimeSlots(provider.id, day);
      expect(slots, isNotEmpty, reason: 'the calendar said this day is open');
      expect(slots.first.hour, inInclusiveRange(0, 23));
    });

    test('the puja catalogue prices its add-ons', () async {
      if (!reachable) return;
      final services = await ApiPujaDataSource(client, () => 'en').catalogue();

      expect(services, isNotEmpty);
      final service = services.first;
      expect(service.name.en, isNotEmpty);
      expect(service.basePrice, greaterThan(0));
      expect(service.modes, isNotEmpty);
      expect(service.duration.inMinutes, greaterThan(0));
    });
  });

  group('reports', () {
    test('the catalogue carries what the buyer compares', () async {
      if (!reachable) return;
      final products = await ApiReportDataSource(
        client,
        () => 'en',
      ).catalogue();

      expect(products, isNotEmpty);
      final product = products.first;
      expect(product.title.en, isNotEmpty);
      expect(product.price, greaterThan(0));
      // Page count and delivery time are the two numbers the purchase screen
      // sets expectations with.
      expect(product.pageCount, greaterThan(0));
      expect(product.deliveryTime.inMinutes, greaterThan(0));
    });
  });
}
