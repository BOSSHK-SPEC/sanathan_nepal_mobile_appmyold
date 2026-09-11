import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/core/storage/key_value_store.dart';
import 'package:sanathan_nepal_mobile_app/features/account/data/datasources/mock_account_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/account/domain/entities/account_entities.dart';

void main() {
  late InMemoryKeyValueStore store;

  MockAccountDataSource sourceFor([Region region = Region.nepal]) =>
      MockAccountDataSource(store, FixedRegionResolver(region));

  setUp(() => store = InMemoryKeyValueStore());

  const newAddress = SavedAddress(
    id: '',
    fullName: 'Ram Thapa',
    phone: '9800000000',
    line1: 'Jhamsikhel',
    city: 'Lalitpur',
  );

  group('Addresses', () {
    test('seeds one default address', () async {
      final all = await sourceFor().addresses();
      expect(all, hasLength(1));
      expect(all.single.isDefault, isTrue);
    });

    test('saving assigns an id and keeps exactly one default', () async {
      final source = sourceFor();
      await source.addresses();

      final saved = await source.saveAddress(
        newAddress.copyWith(isDefault: true),
      );
      expect(saved.id, isNotEmpty);

      final all = await source.addresses();
      expect(all.where((a) => a.isDefault), hasLength(1));
      expect(all.first.id, saved.id);
    });

    test('rejects an incomplete address', () async {
      expect(
        () => sourceFor().saveAddress(newAddress.copyWith(city: '  ')),
        throwsA(isA<ValidationException>()),
      );
    });

    test('deleting the default promotes another', () async {
      final source = sourceFor();
      final seeded = (await source.addresses()).single;
      await source.saveAddress(newAddress);

      await source.deleteAddress(seeded.id);
      final all = await source.addresses();
      expect(all, hasLength(1));
      expect(all.single.isDefault, isTrue);
    });

    test('setDefault moves the flag rather than adding one', () async {
      final source = sourceFor();
      final seeded = (await source.addresses()).single;
      final added = await source.saveAddress(newAddress);

      await source.setDefaultAddress(added.id);
      final all = await source.addresses();
      expect(all.where((a) => a.isDefault), hasLength(1));
      expect(all.firstWhere((a) => a.isDefault).id, added.id);
      expect(all.firstWhere((a) => a.id == seeded.id).isDefault, isFalse);
    });

    test('summary joins only the parts that exist', () {
      const address = SavedAddress(
        id: 'a',
        fullName: 'A',
        phone: 'p',
        line1: 'Line 1',
        city: 'City',
      );
      expect(address.summary, 'Line 1, City');
      expect(
        address.copyWith(line2: 'Flat 3', region: 'Bagmati').summary,
        'Line 1, Flat 3, City, Bagmati',
      );
    });
  });

  group('Security', () {
    test('rejects a malformed email', () async {
      final source = sourceFor();
      final settings = await source.security();
      expect(
        () => source.updateSecurity(settings.copyWith(email: 'not-an-email')),
        throwsA(isA<ValidationException>()),
      );
    });

    test('settings round-trip', () async {
      final source = sourceFor();
      final settings = await source.security();
      await source.updateSecurity(settings.copyWith(twoFactorEnabled: true));
      expect((await sourceFor().security()).twoFactorEnabled, isTrue);
    });

    test('the current device cannot be revoked', () async {
      final source = sourceFor();
      final current = (await source.devices()).firstWhere((d) => d.isCurrent);
      expect(
        () => source.revokeDevice(current.id),
        throwsA(isA<ValidationException>()),
      );
    });

    test('revoking another device removes it', () async {
      final source = sourceFor();
      final other = (await source.devices()).firstWhere((d) => !d.isCurrent);
      await source.revokeDevice(other.id);
      final after = await source.devices();
      expect(after.map((d) => d.id), isNot(contains(other.id)));
    });

    test('revoking all others keeps only the current device', () async {
      final source = sourceFor();
      await source.revokeAllOtherDevices();
      final after = await source.devices();
      expect(after, hasLength(1));
      expect(after.single.isCurrent, isTrue);
    });

    test('a long-idle device is flagged as stale', () async {
      final devices = await sourceFor().devices();
      expect(devices.any((d) => d.isStale), isTrue);
    });
  });

  group('Privacy', () {
    test('both request kinds start at none', () async {
      final requests = await sourceFor().dataRequests();
      expect(requests, hasLength(2));
      expect(requests.every((r) => r.status == DataRequestStatus.none), isTrue);
    });

    test('a request becomes pending and blocks a duplicate', () async {
      final source = sourceFor();
      final request = await source.requestData(DataRequestKind.deletion);
      expect(request.isOpen, isTrue);
      expect(
        () => source.requestData(DataRequestKind.deletion),
        throwsA(isA<ValidationException>()),
      );
      // The other kind is unaffected.
      await expectLater(source.requestData(DataRequestKind.export), completes);
    });
  });

  group('Support', () {
    test('seeds tickets, newest first', () async {
      final tickets = await sourceFor().tickets();
      expect(tickets, isNotEmpty);
      for (var i = 1; i < tickets.length; i++) {
        expect(
          tickets[i - 1].updatedAt.isBefore(tickets[i].updatedAt),
          isFalse,
        );
      }
    });

    test('rejects a blank subject and a too-short body', () async {
      final source = sourceFor();
      expect(
        () => source.createTicket(
          subject: '  ',
          topic: TicketTopic.other,
          body: 'Long enough body here',
        ),
        throwsA(isA<ValidationException>()),
      );
      expect(
        () => source.createTicket(
          subject: 'Subject',
          topic: TicketTopic.other,
          body: 'short',
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('a created ticket opens with the first message', () async {
      final source = sourceFor();
      final ticket = await source.createTicket(
        subject: 'Wallet issue',
        topic: TicketTopic.payment,
        body: 'My top-up has not arrived yet.',
      );
      expect(ticket.status, TicketStatus.open);
      expect(ticket.messages, hasLength(1));
      expect(ticket.messages.single.fromSupport, isFalse);
    });

    test('replying appends and moves it back to open', () async {
      final source = sourceFor();
      final waiting = (await source.tickets()).firstWhere(
        (t) => t.status == TicketStatus.waitingOnYou,
      );
      final replied = await source.replyToTicket(
        ticketId: waiting.id,
        body: 'The reference is ESW-1234.',
      );
      expect(replied.status, TicketStatus.open);
      expect(replied.messages.length, waiting.messages.length + 1);
    });

    test('rejects an empty reply', () async {
      final source = sourceFor();
      final ticket = (await source.tickets()).first;
      expect(
        () => source.replyToTicket(ticketId: ticket.id, body: '   '),
        throwsA(isA<ValidationException>()),
      );
    });

    test('an unknown ticket is a not-found error', () async {
      expect(
        () => sourceFor().ticket('nope'),
        throwsA(isA<NotFoundException>()),
      );
    });
  });

  group('Offers', () {
    test('separates usable from used and expired', () async {
      final offers = await sourceFor().offers();
      expect(offers.where((o) => o.isUsable), isNotEmpty);
      expect(offers.where((o) => !o.isUsable), isNotEmpty);
      for (final offer in offers) {
        expect(offer.isUsable, !offer.used && !offer.isExpired);
      }
    });

    test('flags offers about to expire', () async {
      final offers = await sourceFor().offers();
      expect(offers.any((o) => o.isExpiringSoon), isTrue);
      for (final offer in offers.where((o) => o.isExpiringSoon)) {
        expect(offer.daysLeft, lessThanOrEqualTo(3));
      }
    });

    test('referral counts are internally consistent', () async {
      final referral = await sourceFor().referral();
      expect(referral.pending, referral.invited - referral.joined);
      expect(
        referral.conversionRate,
        closeTo(referral.joined / referral.invited, 0.001),
      );
    });
  });
}
