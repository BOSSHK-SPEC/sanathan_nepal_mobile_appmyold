import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/sitting_option.dart';
import 'package:sanathan_nepal_mobile_app/core/calendar/calendar.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/appointment_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/astrologer_seed.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/models/appointment_model.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/repositories/appointment_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/booking_request.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/localized_text.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/presentation/widgets/appointment_format.dart';

/// Resolver whose region can change between calls (runtime region switch).
class _SwitchableResolver implements RegionResolver {
  _SwitchableResolver(this.region);
  @override
  Region region;
  @override
  RegionConfig get config => region.config;
}

void main() {
  final now = DateTime(2026, 8, 17, 10);

  group('MockAppointmentDataSource – India region', () {
    late AppointmentRepositoryImpl repo;
    setUp(
      () => repo = AppointmentRepositoryImpl(
        MockAppointmentDataSource(
          now: () => now,
          region: const FixedRegionResolver(Region.india),
        ),
      ),
    );

    test('lists Indian astrologers with INR prices and +91 phones', () async {
      final astrologers = (await repo.getAstrologers()).valueOrNull!;
      expect(astrologers.map((p) => p.id), [
        indiaFeaturedAstrologerId,
        indiaSecondAstrologerId,
      ]);
      final pandit = astrologers.first;
      expect(pandit.name.en, 'Pandit Rajesh Sharma');
      expect(pandit.name.hi, 'पंडित राजेश शर्मा');
      // Sittings are derived from per-minute rates: ₹25/min × 30 min.
      expect(pandit.services.first.channel, SittingChannel.chat);
      expect(pandit.services.first.price, 750);
      expect(
        const AppointmentFormat(
          config: RegionConfig.india,
          languageCode: 'en',
        ).money(pandit.services.first.price),
        '₹750',
      );
    });

    test('appointment list only contains Indian bookings', () async {
      final list = (await repo.getAppointments()).valueOrNull!;
      expect(list, isNotEmpty);
      expect(
        list.every(
          (a) =>
              a.astrologerId == indiaFeaturedAstrologerId ||
              a.astrologerId == indiaSecondAstrologerId,
        ),
        isTrue,
      );
      expect(list.first.paymentMethod, PaymentMethod.upi);
      expect(list.first.country, 'India');
    });

    test('books with UPI for an Indian astrologer', () async {
      final day = _workingDay(now, 6);
      final slots = (await repo.getTimeSlots(
        SlotQuery(astrologerId: indiaFeaturedAstrologerId, date: day),
      )).valueOrNull!;
      final free = slots.firstWhere((s) => s.available);
      final booked = (await repo.book(
        BookingRequest(
          astrologerId: indiaFeaturedAstrologerId,
          serviceId: 'chat',
          quantity: 1,
          date: day,
          slotId: free.id,
          customerName: 'Rahul',
          phone: '9876543210',
          email: 'rahul@example.com',
          country: 'India',
          paymentMethod: PaymentMethod.upi,
        ),
      )).valueOrNull!;
      // ₹25 a minute for half an hour.
      expect(booked.totalAmount, 750);
      expect(booked.paymentMethod.rail, PaymentRail.upi);
      // JSON round trip keeps the new payment codes + Hindi text.
      final model = AppointmentModel.fromEntity(booked);
      final decoded = AppointmentModel.fromJson(model.toJson());
      expect(decoded, equals(model));
      expect(decoded.paymentMethod, PaymentMethod.upi);
      expect(decoded.service.name.hi, 'चैट');
      expect(decoded.service.channel, SittingChannel.chat);
    });
  });

  test('region is read at call time (Nepal → India switch)', () async {
    final resolver = _SwitchableResolver(Region.nepal);
    final source = MockAppointmentDataSource(now: () => now, region: resolver);
    expect((await source.fetchAstrologers()).single.id, featuredAstrologerId);
    expect((await source.fetchAppointments()).length, 4);
    resolver.region = Region.india;
    expect(
      (await source.fetchAstrologers()).map((p) => p.id),
      contains(indiaFeaturedAstrologerId),
    );
    expect(
      (await source.fetchAppointments()).every(
        (a) => a.astrologerId != featuredAstrologerId,
      ),
      isTrue,
    );
    // Old ids still resolve after the switch.
    expect(
      (await source.fetchAstrologer(featuredAstrologerId)).id,
      featuredAstrologerId,
    );
  });

  group('PaymentMethod ↔ PaymentRail', () {
    test('every region rail maps to a method and back', () {
      for (final config in [RegionConfig.nepal, RegionConfig.india]) {
        for (final rail in config.paymentRails) {
          expect(PaymentMethod.fromRail(rail).rail, rail);
        }
      }
      expect(PaymentMethod.fromCode('paypal').rail, PaymentRail.bankTransfer);
      expect(PaymentMethod.fromCode('net_banking'), PaymentMethod.netBanking);
    });
  });

  group('AppointmentFormat', () {
    final date = DateTime(2026, 8, 18);
    test('India / English uses Saka + ₹ + IST', () {
      const fmt = AppointmentFormat(
        config: RegionConfig.india,
        languageCode: 'en',
      );
      expect(fmt.eraLabel, 'Saka');
      expect(fmt.traditionalDate(date), 'Shravana 27, 1948');
      expect(fmt.dateLine(date), 'Shravana 27, 1948 | 18 Aug, 2026, Tuesday');
      expect(fmt.money(1100), '₹1,100');
      expect(fmt.moneyRange(4000, 9000), '₹4,000 - 9,000');
      expect(fmt.timeZoneNow(DateTime(2026, 8, 18, 14, 27)), 'IST (2:27 PM)');
      expect(fmt.phone('9876543210'), '+91 9876543210');
      expect(fmt.calendar, isA<SakaCalendar>());
    });

    test('India / Hindi uses Devanagari digits and Hindi names', () {
      const fmt = AppointmentFormat(
        config: RegionConfig.india,
        languageCode: 'hi',
      );
      expect(fmt.eraLabel, 'शक');
      expect(fmt.traditionalDate(date), 'श्रावण २७, १९४८');
      expect(fmt.dateLine(date), 'श्रावण २७, १९४८ | १८ अगस्त, २०२६, मंगलवार');
      expect(fmt.money(1100), '₹१,१००');
      expect(
        fmt.slotLabel(MockAppointmentDataSource.slotAt(20, 30)),
        '८:३० PM',
      );
    });

    test('Nepal keeps Bikram Sambat and रु.', () {
      const en = AppointmentFormat(
        config: RegionConfig.nepal,
        languageCode: 'en',
      );
      const ne = AppointmentFormat(
        config: RegionConfig.nepal,
        languageCode: 'ne',
      );
      expect(en.eraLabel, 'B.S.');
      expect(
        en.dateLine(DateTime(2023, 3, 30)),
        'Chaitra 16, 2079 | 30 Mar, 2023, Thursday',
      );
      expect(
        ne.dateLine(DateTime(2023, 3, 30)),
        'चैत १६, २०७९ | ३० मार्च, २०२३, बिहीबार',
      );
      expect(en.money(2000), 'Rs. 2,000');
      expect(ne.money(2000), 'रु. २,०००');
      expect(en.timeZoneNow(DateTime(2026, 1, 1, 9, 5)), 'NST (9:05 AM)');
    });
  });

  test('LocalizedText falls back to English for Hindi', () {
    const t = LocalizedText(ne: 'ने', en: 'en');
    expect(t.forLanguage('hi'), 'en');
    expect(t.forLanguage('ne'), 'ने');
    expect(
      const LocalizedText(ne: 'ने', en: 'en', hi: 'हि').forLanguage('hi'),
      'हि',
    );
  });
}

/// The next day at or after [offset] on which the seeded astrologers keep
/// hours — a fixed offset made the test depend on which weekday `now` was.
DateTime _workingDay(DateTime now, int offset) {
  var day = DateTime(now.year, now.month, now.day).add(Duration(days: offset));
  while (day.weekday > DateTime.friday) {
    day = day.add(const Duration(days: 1));
  }
  return day;
}
