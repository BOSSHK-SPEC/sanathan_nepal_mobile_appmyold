import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/api_appointment_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/booking_request.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/sitting_option.dart';

/// The booking flow now books *astrologers*, not centres. These pin the parts
/// of that contract the compiler cannot: which endpoints are called, what the
/// booking body says, and how an astrologer's rates become bookable sittings.
void main() {
  late _StubAdapter adapter;
  late ApiAppointmentDataSource source;

  ApiAppointmentDataSource build(_StubAdapter stub) {
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = stub;
    return ApiAppointmentDataSource(client);
  }

  group('the picker reads the astrologer directory', () {
    setUp(() {
      adapter = _StubAdapter(
        (_) async => _json({
          'items': [
            _astrologerJson(id: '01JASTRO00000000000000001'),
            // Priced nothing: listed in the directory, but there is no sitting
            // to open a wizard onto.
            _astrologerJson(id: '01JASTRO00000000000000002', rates: {}),
          ],
          'hasMore': false,
          'nextCursor': null,
        }),
      );
      source = build(adapter);
    });

    test('it is a cursor page, not a bare array', () async {
      await source.fetchAstrologers();
      expect(adapter.requests.last.uri.path, '/api/v1/astrologers');
    });

    test('an astrologer who has priced nothing is not offered', () async {
      final astrologers = await source.fetchAstrologers();
      expect(astrologers.map((a) => a.id), ['01JASTRO00000000000000001']);
    });

    test('per-minute rates become half-hour sittings, cheapest first', () async {
      final astrologer = (await source.fetchAstrologers()).single;

      expect(astrologer.services.map((s) => s.channel), [
        SittingChannel.chat,
        SittingChannel.voice,
        SittingChannel.video,
      ]);
      // Rs. 20 / 35 / 50 a minute, for thirty minutes.
      expect(astrologer.services.map((s) => s.price), [600, 1050, 1500]);
      expect(astrologer.services.every((s) => s.durationMinutes == 30), isTrue);
      expect(astrologer.cheapestSitting?.channel, SittingChannel.chat);
      // The channel names itself, so the wizard, the card and the details page
      // cannot call the same sitting three different things.
      expect(astrologer.services.first.name.en, 'Chat');
      expect(astrologer.services.first.name.ne, 'च्याट');
    });

    test('a sitting carries the rate its total came from', () async {
      final astrologer = (await source.fetchAstrologers()).single;

      // Without this the wizard can only print a total, and a four-figure
      // quote beside a profile advertising a per-minute rate reads as a bug.
      // Every price must be able to show its own arithmetic.
      for (final sitting in astrologer.services) {
        expect(
          sitting.price,
          (sitting.ratePerMinute * sitting.durationMinutes).round(),
          reason: '${sitting.id} must equal rate × minutes',
        );
      }
      expect(astrologer.services.first.ratePerMinute, 20);
    });

    test('it carries what a booking needs, and nothing more', () async {
      final astrologer = (await source.fetchAstrologers()).single;

      expect(astrologer.name.en, 'Pandit Sharma');
      expect(astrologer.title.en, 'Vedic astrologer, 15 years');
      expect(astrologer.rating, 4.5);
      expect(astrologer.reviewCount, 42);
      expect(astrologer.isOnline, isTrue);
      expect(astrologer.isVerified, isTrue);
      expect(astrologer.isBookable, isTrue);
      // The bio, credentials and reviews are the astrologer profile's job;
      // carrying a second copy here is what let two profiles drift apart.
      expect(
        astrologer.toString(),
        isNot(anyOf(contains('about'), contains('specialties'))),
      );
    });
  });

  test(
    'the booking names an astrologer and the channel it is held on',
    () async {
      adapter = _StubAdapter(
        (_) async => _json({
          'id': '01JAPPT000000000000000001',
          'astrologerId': '01JASTRO00000000000000001',
          'astrologerName': {'en': 'Pandit Sharma'},
          'slotId': '01JSLOT000000000000000001',
          'status': 'confirmed',
          'startsAt': '2026-09-14T04:05:00.000Z',
          'priceMinor': '150000',
          'quantity': 1,
        }),
      );
      source = build(adapter);

      final booked = await source.book(
        BookingRequest(
          astrologerId: '01JASTRO00000000000000001',
          serviceId: 'video',
          quantity: 1,
          date: _aDay,
          slotId: '01JSLOT000000000000000001',
          customerName: 'Yash',
          phone: '9686912639',
          email: '',
          country: 'Nepal',
          paymentMethod: PaymentMethod.esewa,
        ),
      );

      final body = adapter.requests.last.data! as Map<String, dynamic>;
      expect(body['astrologerId'], '01JASTRO00000000000000001');
      // The centre is gone: there is no second owner to disagree about.
      expect(body.containsKey('providerId'), isFalse);
      // The channel decides the price, so it is what the server is told —
      // a `serviceId` would name a catalogue row an astrologer does not have.
      expect(body['channel'], 'video');
      expect(body.containsKey('serviceId'), isFalse);
      expect(body['quantity'], 1);

      expect(booked.astrologerId, '01JASTRO00000000000000001');
      expect(booked.astrologerName.en, 'Pandit Sharma');
    },
  );
}

final _aDay = DateTime.utc(2026, 9, 14);

Map<String, dynamic> _astrologerJson({
  required String id,
  Map<String, String> rates = const {
    'video': '5000',
    'chat': '2000',
    'voice': '3500',
  },
}) => {
  'id': id,
  'name': {'en': 'Pandit Sharma', 'ne': 'पण्डित शर्मा'},
  'headline': {'en': 'Vedic astrologer, 15 years'},
  'about': {'en': 'Specialises in kundli and marriage matching.'},
  'location': {'en': 'Kathmandu'},
  'avatarKey': null,
  'languageCodes': ['ne', 'en'],
  'specialties': ['vedic'],
  'experienceYears': 15,
  'ratingAvg': 4.5,
  'ratingCount': 42,
  'ratingBreakdown': {'5': 30, '4': 12},
  'recommendedPercent': 89,
  'followerCount': 116000,
  'isOnline': true,
  'isVerified': true,
  'ratePerMinute': rates,
};

ResponseBody _json(Object body) => ResponseBody.fromString(
  jsonEncode(body),
  200,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.handler);

  final Future<ResponseBody> Function(RequestOptions options) handler;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    requests.add(options);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}
