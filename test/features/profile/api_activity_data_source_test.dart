import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/api_profile_data_sources.dart';

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.body);
  final Object body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    jsonEncode(body),
    200,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}

void main() {
  test('an appointment is shown in the device clock, not in UTC', () async {
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = _StubAdapter([
        {
          'id': '01JAPPT000000000000000001',
          'serviceName': {'en': 'Kundli consultation'},
          'astrologerName': {'en': 'Delhi Jyotish Kendra'},
          'startsAt': '2026-09-07T10:00:00.000Z',
        },
      ]);

    final list = await ApiActivityDataSource(client).getAppointments();

    // The activity card used to print 10:00 AM for the appointment the
    // details page called 3:30 PM, because this mapper kept the UTC value.
    expect(list.single.dateTime, DateTime.utc(2026, 9, 7, 10).toLocal());
    expect(list.single.dateTime.isUtc, isFalse);
  });
}
