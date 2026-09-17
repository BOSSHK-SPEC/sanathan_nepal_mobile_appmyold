import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/api_appointment_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/booking_request.dart';

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

ResponseBody _json(Object body) => ResponseBody.fromString(
  jsonEncode(body),
  200,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

Map<String, dynamic> _appointment() => {
  'id': '01JAPPT000000000000000001',
  'astrologerId': '01JPROV000000000000000001',
  'astrologerName': {'en': 'Delhi Jyotish Kendra'},
  'serviceId': '01JSVC0000000000000000001',
  'serviceName': {'en': 'Kundli consultation'},
  'slotId': '01JSLOT000000000000000001',
  'status': 'confirmed',
  'startsAt': '2026-09-08T10:00:00.000Z',
  'endsAt': '2026-09-08T11:00:00.000Z',
  'priceMinor': '120000',
  'currency': 'INR',
  'note': 'first sitting',
  'contactName': 'Yash',
  'contactPhone': '9686912639',
  'contactEmail': 'yash@example.com',
  'country': 'India',
  'quantity': 1,
  'paymentMethod': 'upi',
  'intake': {
    'birthPlace': 'Hassan',
    'birthDate': '1995-01-01',
    'birthTime': '12:00',
  },
  'attachments': {
    'cheenaMediaId': '01JMEDIA000000000000000001',
    'receiptMediaId': '01JMEDIA000000000000000002',
  },
  'cancelReason': null,
  'createdAt': '2026-09-06T08:00:00.000Z',
};

void main() {
  late _StubAdapter adapter;
  late ApiAppointmentDataSource source;

  ApiAppointmentDataSource build(_StubAdapter stub) {
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = stub;
    return ApiAppointmentDataSource(client);
  }

  setUp(() {
    adapter = _StubAdapter((_) async => _json(_appointment()));
    source = build(adapter);
  });

  test('booking sends the files the customer attached', () async {
    await source.book(
      BookingRequest(
        astrologerId: '01JPROV000000000000000001',
        serviceId: '01JSVC0000000000000000001',
        quantity: 1,
        date: DateTime(2026, 9, 8),
        slotId: '01JSLOT000000000000000001',
        customerName: 'Yash',
        phone: '9686912639',
        email: 'yash@example.com',
        country: 'India',
        paymentMethod: PaymentMethod.upi,
        cheenaMediaId: '01JMEDIA000000000000000001',
        receiptMediaId: '01JMEDIA000000000000000002',
      ),
    );

    final body = adapter.requests.last.data! as Map<String, dynamic>;
    // Uploaded and then dropped on the floor is indistinguishable, to the
    // customer, from an upload that never worked.
    expect(body['attachments'], {
      'cheenaMediaId': '01JMEDIA000000000000000001',
      'receiptMediaId': '01JMEDIA000000000000000002',
    });
  });

  test('a booking with nothing attached sends no attachments key', () async {
    await source.book(
      BookingRequest(
        astrologerId: '01JPROV000000000000000001',
        serviceId: '01JSVC0000000000000000001',
        quantity: 1,
        date: DateTime(2026, 9, 8),
        slotId: '01JSLOT000000000000000001',
        customerName: 'Yash',
        phone: '9686912639',
        email: '',
        country: 'India',
        paymentMethod: PaymentMethod.upi,
      ),
    );

    final body = adapter.requests.last.data! as Map<String, dynamic>;
    expect(body.containsKey('attachments'), isFalse);
  });

  test('attachments come back on the appointment', () async {
    final appointment = await source.fetchAppointment(
      '01JAPPT000000000000000001',
    );

    expect(appointment.cheenaMediaId, '01JMEDIA000000000000000001');
    expect(appointment.receiptMediaId, '01JMEDIA000000000000000002');
    expect(appointment.email, 'yash@example.com');
  });

  test(
    "the day's slots are filtered out of the astrologer's calendar",
    () async {
      adapter = _StubAdapter(
        (_) async => _json([
          {
            'id': 'slot-a',
            'startsAt': '2026-09-08T03:30:00.000Z',
            'endsAt': '2026-09-08T04:00:00.000Z',
            'available': true,
          },
          {
            'id': 'slot-b',
            'startsAt': '2026-09-09T03:30:00.000Z',
            'endsAt': '2026-09-09T04:00:00.000Z',
            'available': true,
          },
        ]),
      );
      source = build(adapter);

      // Asked for in the reader's own day, which is what the calendar shows.
      final firstSlotLocal = DateTime.utc(2026, 9, 8, 3, 30).toLocal();
      final slots = await source.fetchTimeSlots(
        '01JPROV000000000000000001',
        firstSlotLocal,
        serviceId: 'video',
      );

      // One calendar, asked for once. The channel is deliberately not in the
      // query: the same half hour cannot be free for chat and taken for video,
      // and asking per channel would let it be sold three times.
      expect(
        adapter.requests.last.uri.path,
        '/api/v1/appointments/astrologers/01JPROV000000000000000001/slots',
      );
      expect(adapter.requests.last.uri.queryParameters, isEmpty);
      // Only the requested day survives the filter — the next day's slot is a
      // day later in every time zone, so this holds wherever the test runs.
      expect(slots.map((s) => s.id), ['slot-a']);
      expect(slots.single.hour, firstSlotLocal.hour);
      expect(slots.single.minute, firstSlotLocal.minute);
    },
  );
}
