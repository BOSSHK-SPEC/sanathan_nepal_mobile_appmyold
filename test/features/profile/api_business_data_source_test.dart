import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/exceptions.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/api_profile_data_sources.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/business_profile.dart';

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

Map<String, dynamic> _business({String status = 'pending'}) => {
  'id': '01JBIZ0000000000000000001',
  'ownerId': '01JOWNER00000000000000001',
  'name': 'Pashupati Puja Store',
  'category': 'Puja items',
  'description': 'Ritual supplies',
  'status': status,
  'statusNote': status == 'rejected' ? 'Registration papers unreadable' : '',
  'phone': '+9779812345678',
  'email': 'store@example.com',
  'items': <Object>[],
  'reviews': <Object>[],
};

/// These cover the moderation write path, which was silently broken: the
/// decision was routed through `upsert`, so it posted to `/business/mine` —
/// the *reviewer's* own business — and its payload carried no status at all.
/// Asserting the URL and the body is the only thing that catches that class of
/// bug, because every layer above it looked like it was working.
void main() {
  late _StubAdapter adapter;
  late ApiBusinessDataSource source;

  ApiBusinessDataSource build(
    Future<ResponseBody> Function(RequestOptions options) handler,
  ) {
    adapter = _StubAdapter(handler);
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost:3100/api/v1'))
      ..httpClientAdapter = adapter;
    return ApiBusinessDataSource(ApiClient(dio: dio));
  }

  group('setStatus', () {
    test('posts the decision to the admin endpoint, not to /business/mine', () async {
      source = build((_) async => _json(_business(status: 'approved')));

      await source.setStatus('01JBIZ0000000000000000001', BusinessStatus.approved);

      final request = adapter.requests.single;
      expect(request.method, 'POST');
      expect(
        request.path,
        '/admin/businesses/01JBIZ0000000000000000001/decision',
      );
      expect(request.path, isNot(contains('mine')));
    });

    test('sends the status the server names, with the note', () async {
      source = build((_) async => _json(_business(status: 'rejected')));

      await source.setStatus(
        '01JBIZ0000000000000000001',
        BusinessStatus.rejected,
        note: 'Registration papers unreadable',
      );

      final body = adapter.requests.single.data! as Map<String, dynamic>;
      // The server takes `status`, not the `approve` boolean the astrologer and
      // payout endpoints use. Sending the wrong shape is a 400 at best and a
      // no-op at worst.
      expect(body['status'], 'rejected');
      expect(body['note'], 'Registration papers unreadable');
      expect(body.containsKey('approve'), isFalse);
    });

    test('reads the decided status back off the response', () async {
      source = build((_) async => _json(_business(status: 'approved')));

      final result = await source.setStatus(
        '01JBIZ0000000000000000001',
        BusinessStatus.approved,
      );

      expect(result.status, BusinessStatus.approved);
      expect(result.verified, isTrue);
    });

    test('refuses to move a business back to pending', () async {
      source = build((_) async => _json(_business()));

      await expectLater(
        source.setStatus('01JBIZ0000000000000000001', BusinessStatus.pending),
        throwsA(isA<ValidationException>()),
      );
      // Refused before the request is made, not after the server rejects it.
      expect(adapter.requests, isEmpty);
    });
  });

  group('listBusinesses', () {
    test('reads the moderation queue, not the caller own business', () async {
      source = build((_) async => _json([_business(), _business()]));

      final all = await source.listBusinesses();

      expect(all, hasLength(2));
      expect(adapter.requests.single.path, '/admin/businesses');
    });

    test('pushes the status filter to the server', () async {
      source = build((_) async => _json(<Object>[]));

      await source.listBusinesses(status: BusinessStatus.pending);

      expect(
        adapter.requests.single.queryParameters['status'],
        'pending',
      );
    });

    test('sends no status parameter when the filter is "all"', () async {
      source = build((_) async => _json(<Object>[]));

      await source.listBusinesses();

      expect(adapter.requests.single.queryParameters.containsKey('status'), isFalse);
    });
  });
}
