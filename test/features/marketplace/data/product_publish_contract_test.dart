import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/api_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_draft.dart';

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

ResponseBody _json(Object? body) => ResponseBody.fromString(
  jsonEncode(body),
  200,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

Map<String, dynamic> _product() => {
  'id': '01JPROD00000000000000001',
  'title': {'en': 'Rudraksha Mala'},
  'description': {'en': '108 beads'},
  'location': {'en': 'Kathmandu'},
  'priceMinor': '250000',
  'categoryId': '01M1RFR5GRB0SB48F866ASY6ZG',
  'imageKeys': <String>[],
};

/// What the publish request must look like on the wire.
///
/// These are contract tests for the two fields the server rejected in
/// production: a category identified by a bundled slug instead of the server's
/// ULID, and a timestamp with no timezone. Both produced a 400 only at the very
/// end of a filled-in form, which is the most expensive moment to find out.
void main() {
  late _StubAdapter adapter;
  late ApiProductDataSource source;

  setUp(() {
    adapter = _StubAdapter((options) async {
      if (options.path.contains('categories')) {
        return _json([
          {
            'id': '01M1RFR5GRB0SB48F866ASY6ZG',
            'slug': 'puja-items',
            'name': {'en': 'Puja Items', 'ne': 'पूजा सामग्री'},
            'iconName': 'lamp',
          },
        ]);
      }
      return _json(_product());
    });
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost:3100/api/v1'))
      ..httpClientAdapter = adapter;
    source = ApiProductDataSource(ApiClient(dio: dio));
  });

  const draft = ProductDraft(
    title: 'Rudraksha Mala',
    categoryId: '01M1RFR5GRB0SB48F866ASY6ZG',
    description: '108 beads',
    location: 'Kathmandu',
    price: 2500,
    phone: '+977-9800000000',
    expiryDays: 30,
  );

  test('expiresAt is sent in UTC, with a zone the server accepts', () async {
    await source.create(draft);

    final body = adapter.requests.last.data! as Map<String, dynamic>;
    final expiresAt = body['expiresAt']! as String;

    // A local `toIso8601String()` emits no suffix at all, and the server's
    // RFC-3339 check rejects it outright.
    expect(expiresAt, endsWith('Z'));
    expect(DateTime.parse(expiresAt).isUtc, isTrue);
    // Still the right instant, not just the right shape.
    expect(
      DateTime.parse(expiresAt).difference(DateTime.now().toUtc()).inDays,
      inInclusiveRange(29, 30),
    );
  });

  test('categories come from the server, with its ULIDs', () async {
    final categories = await source.fetchCategories();

    expect(categories, hasLength(1));
    expect(categories.single.id, '01M1RFR5GRB0SB48F866ASY6ZG');
    expect(categories.single.iconName, 'lamp');
    // The bundled slug must not leak through: publishing with it is a 400.
    expect(categories.single.id, isNot('poojaSamagri'));
  });

  test('the repository reads categories from its source, not a constant', () async {
    final repo = ProductRepositoryImpl(source);

    final result = await repo.getCategories();

    expect(result.valueOrNull?.single.id, '01M1RFR5GRB0SB48F866ASY6ZG');
    // Proves the call actually went out — the old implementation returned a
    // hardcoded list and never touched the data source at all.
    expect(
      adapter.requests.map((r) => r.path),
      contains(contains('categories')),
    );
  });

  test('the mock source still serves the bundled catalogue offline', () async {
    final repo = ProductRepositoryImpl(
      MockProductDataSource(resolver: const FixedRegionResolver(Region.nepal)),
    );

    final result = await repo.getCategories();

    expect(result.valueOrNull, isNotEmpty);
  });
}
