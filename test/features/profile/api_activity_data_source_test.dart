import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/api_profile_data_sources.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/order_summary.dart';

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

  test('an order names the other side, and carries a way to reach them', () async {
    // One payload answers both /orders and /orders/selling, so the same order
    // comes back once as a purchase and once as a sale — which is exactly the
    // pair that has to disagree about who the counterparty is.
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = _StubAdapter([
        {
          'id': '01JORDER00000000000000001',
          'status': 'placed',
          'totalMinor': '30000',
          'updatedAt': '2026-09-20T04:15:00.000Z',
          'shipping': {
            'firstName': 'Ram',
            'lastName': 'Bahadur',
            'phone': '+977-9812345678',
          },
          'items': [
            {
              'title': {'en': 'mouse'},
              'sellerId': '01JSELLER0000000000000001',
              'businessId': '01JBIZ0000000000000000001',
              'sellerName': 'Uttam Astro & Gems',
              'sellerPhone': '+977-9841234567',
            },
          ],
        },
      ]);

    final orders = await ApiActivityDataSource(client).getOrders();
    final purchase = orders.firstWhere((o) => o.role == OrderRole.buyer);
    final sale = orders.firstWhere((o) => o.role == OrderRole.seller);

    // Both roles used to read the shipping name, which belongs to whoever
    // placed the order — so a purchase card told the buyer it was "From"
    // themselves.
    expect(purchase.counterpartyName, 'Uttam Astro & Gems');
    expect(sale.counterpartyName, 'Ram Bahadur');

    // Chat is keyed on the business, never on the seller's user id.
    expect(purchase.counterpartyBusinessId, '01JBIZ0000000000000000001');
    expect(purchase.canChat, isTrue);
    expect(purchase.counterpartyPhone, '+977-9841234567');

    // A seller owns the only shop in the conversation and cannot write to it.
    expect(sale.counterpartyBusinessId, isNull);
    expect(sale.canChat, isFalse);
    expect(sale.counterpartyPhone, '+977-9812345678');
  });

  test('a listing with no shop behind it offers no conversation', () async {
    final client = ApiClient(baseUrl: 'http://localhost/api/v1')
      ..dio.httpClientAdapter = _StubAdapter([
        {
          'id': '01JORDER00000000000000002',
          'status': 'placed',
          'totalMinor': '30000',
          'updatedAt': '2026-09-20T04:15:00.000Z',
          'shipping': {'firstName': 'Ram', 'lastName': 'Bahadur'},
          'items': [
            {
              'title': {'en': 'mouse'},
              'sellerId': '01JSELLER0000000000000001',
              'businessId': null,
              'sellerName': 'Ram Prasad',
              'sellerPhone': '',
            },
          ],
        },
      ]);

    final purchase = (await ApiActivityDataSource(client).getOrders())
        .firstWhere((o) => o.role == OrderRole.buyer);

    // An individual seller, or a listing from before the one-catalogue
    // migration: the card must draw nothing rather than push a null id.
    expect(purchase.canChat, isFalse);
    expect(purchase.canCall, isFalse);
    expect(purchase.counterpartyName, 'Ram Prasad');
  });
}
