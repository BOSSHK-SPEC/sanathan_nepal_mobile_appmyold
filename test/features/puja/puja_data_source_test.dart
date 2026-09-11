import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/puja/data/datasources/mock_puja_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/puja/domain/entities/puja_booking.dart';
import 'package:sanathan_nepal_mobile_app/features/puja/domain/entities/puja_service.dart';
import 'package:sanathan_nepal_mobile_app/features/puja/domain/repositories/puja_repository.dart';

void main() {
  late InMemoryKeyValueStore store;

  MockPujaDataSource sourceFor([Region region = Region.nepal]) =>
      MockPujaDataSource(store, FixedRegionResolver(region));

  /// Far enough out that every muhurta of the day is still offered.
  DateTime someDay() {
    final now = DateTime.now().add(const Duration(days: 3));
    return DateTime(now.year, now.month, now.day);
  }

  PujaBookingRequest requestFor(
    PujaService service,
    DateTime at, {
    PujaMode? mode,
    String? address,
    String name = 'Asha Sharma',
    bool withSamagri = false,
  }) => PujaBookingRequest(
    serviceId: service.id,
    mode: mode ?? service.modes.first,
    scheduledAt: at,
    sankalp: SankalpDetails(fullName: name),
    withSamagri: withSamagri,
    paymentRail: PaymentRail.esewa,
    address: address,
  );

  setUp(() => store = InMemoryKeyValueStore());

  group('Catalogue', () {
    test('every puja is priced, timed and offered in some mode', () async {
      final services = await sourceFor().catalogue();
      expect(services, isNotEmpty);
      for (final s in services) {
        expect(s.basePrice, greaterThan(0));
        expect(s.duration.inMinutes, greaterThan(0));
        expect(s.modes, isNotEmpty);
      }
    });

    test('purpose filter narrows to that purpose', () async {
      final source = sourceFor();
      final filtered = await source.catalogue(purpose: PujaPurpose.prosperity);
      expect(filtered, isNotEmpty);
      expect(
        filtered.every((s) => s.purpose == PujaPurpose.prosperity),
        isTrue,
      );
    });

    test('India uses its own temples', () async {
      final nepal = await sourceFor().catalogue();
      final india = await sourceFor(Region.india).catalogue();
      final nepalTemple = nepal
          .firstWhere((s) => s.id == 'puja-rudrabhishek')
          .templeName!
          .en;
      final indiaTemple = india
          .firstWhere((s) => s.id == 'puja-rudrabhishek')
          .templeName!
          .en;
      expect(indiaTemple, isNot(nepalTemple));
    });

    test('price includes only the chosen extras', () async {
      final service = (await sourceFor().catalogue()).firstWhere(
        (s) => s.supportsAtHome && s.includesSamagriOption,
      );
      expect(
        service.priceFor(mode: PujaMode.templeOnline, withSamagri: false),
        service.basePrice,
      );
      expect(
        service.priceFor(mode: PujaMode.atHome, withSamagri: true),
        service.basePrice + service.atHomeSurcharge + service.samagriPrice,
      );
    });
  });

  group('Availability', () {
    test('slots are at least two hours out', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).first;
      final times = await source.availableTimes(
        serviceId: service.id,
        date: DateTime.now(),
      );
      final cutoff = DateTime.now().add(const Duration(hours: 2));
      expect(times.every((t) => t.isAfter(cutoff)), isTrue);
    });

    test('a booked hour is no longer offered', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).first;
      final before = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );
      await source.book(requestFor(service, before.first));

      final after = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );
      expect(after, isNot(contains(before.first)));
      expect(after.length, before.length - 1);
    });
  });

  group('Booking', () {
    test('a booking that pays up front is confirmed', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).first;
      final times = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );

      final booking = await source.book(requestFor(service, times.first));
      expect(booking.status, PujaBookingStatus.confirmed);
      expect(booking.amount, service.basePrice);
    });

    test('paying in person leaves the booking awaiting payment', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).first;
      final times = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );

      final booking = await source.book(
        PujaBookingRequest(
          serviceId: service.id,
          mode: service.modes.first,
          scheduledAt: times.first,
          sankalp: const SankalpDetails(fullName: 'Asha'),
          withSamagri: false,
          paymentRail: PaymentRail.cashOnDelivery,
        ),
      );
      expect(booking.status, PujaBookingStatus.pendingPayment);
    });

    test('an at-home booking without an address is refused', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).firstWhere(
        (s) => s.supportsAtHome,
      );
      final times = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );

      await expectLater(
        source.book(requestFor(service, times.first, mode: PujaMode.atHome)),
        throwsA(isA<ValidationException>()),
      );
      expect(await source.myBookings(), isEmpty);
    });

    test('a sankalp without a name is refused', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).first;
      final times = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );

      await expectLater(
        source.book(requestFor(service, times.first, name: '  ')),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a mode the puja does not offer is refused', () async {
      final source = sourceFor();
      final onlineOnly = (await source.catalogue()).firstWhere(
        (s) => !s.supportsAtHome,
      );
      final times = await source.availableTimes(
        serviceId: onlineOnly.id,
        date: someDay(),
      );

      await expectLater(
        source.book(
          requestFor(
            onlineOnly,
            times.first,
            mode: PujaMode.atHome,
            address: 'Somewhere',
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a time that is not offered is refused', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).first;
      final notAMuhurta = someDay().add(const Duration(hours: 3, minutes: 17));

      await expectLater(
        source.book(requestFor(service, notAMuhurta)),
        throwsA(isA<ValidationException>()),
      );
    });

    test('an online booking gets a stream, an at-home one does not', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).firstWhere(
        (s) => s.supportsAtHome && s.supportsOnline,
      );
      final times = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );

      final online = await source.book(
        requestFor(service, times[0], mode: PujaMode.templeOnline),
      );
      final atHome = await source.book(
        requestFor(
          service,
          times[1],
          mode: PujaMode.atHome,
          address: 'Lalitpur',
        ),
      );
      expect(online.streamUrl, isNotNull);
      expect(atHome.streamUrl, isNull);
      expect(atHome.address, 'Lalitpur');
    });
  });

  group('Cancellation', () {
    test('a booking days away can be cancelled', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).first;
      final times = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );
      final booking = await source.book(requestFor(service, times.first));

      final cancelled = await source.cancel(booking.id, 'Travelling');
      expect(cancelled.status, PujaBookingStatus.cancelled);
      expect(cancelled.cancellationReason, 'Travelling');
    });

    test('cancelling twice is refused', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).first;
      final times = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );
      final booking = await source.book(requestFor(service, times.first));
      await source.cancel(booking.id, 'Travelling');

      await expectLater(
        source.cancel(booking.id, 'Again'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a cancelled slot is offered again', () async {
      final source = sourceFor();
      final service = (await source.catalogue()).first;
      final times = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );
      final booking = await source.book(requestFor(service, times.first));
      await source.cancel(booking.id, 'Travelling');

      final after = await source.availableTimes(
        serviceId: service.id,
        date: someDay(),
      );
      expect(after, contains(times.first));
    });

    test('an unknown booking is not found', () async {
      await expectLater(
        sourceFor().cancel('puja-nope', 'x'),
        throwsA(isA<NotFoundException>()),
      );
    });
  });
}
