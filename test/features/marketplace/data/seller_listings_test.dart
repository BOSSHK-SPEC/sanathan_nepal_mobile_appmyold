import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region.dart';
import 'package:sanathan_nepal_mobile_app/core/region/region_resolver.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/api_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/mock_product_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/product_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_draft.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/domain/entities/product_filter.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/data/datasources/mock_business_data_source.dart';

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

Map<String, dynamic> _product({
  String id = '01JPROD000000000000000001',
  bool isMine = true,
  String? businessId = '01JBIZ0000000000000000000A',
}) => {
  'id': id,
  'title': {'en': 'Brass diyo', 'ne': 'पित्तल दियो'},
  'description': {'en': 'Handmade', 'ne': 'हस्तनिर्मित'},
  'location': {'en': 'Kathmandu', 'ne': 'काठमाडौं'},
  'priceMinor': '45000',
  'currency': 'NPR',
  'categoryId': '01JCAT0000000000000000001',
  'businessId': businessId,
  'condition': 'brandNew',
  'isService': false,
  'negotiable': true,
  'imageKeys': <String>[],
  'videoKeys': <String>[],
  'specs': <String, String>{},
  'options': <String, List<String>>{},
  'seller': {'id': 's1', 'name': 'Uttam', 'avatarUrl': null},
  'viewCount': 0,
  'likeCount': 0,
  'ratingAvg': 0,
  'ratingCount': 0,
  'isBoosted': false,
  'isFavourite': false,
  'isMine': isMine,
  'publishedAt': '2026-09-01T00:00:00.000Z',
  'expiresAt': null,
};

void main() {
  group('a seller reads their own listings from their own endpoint', () {
    late _StubAdapter adapter;
    late ProductRepositoryImpl repo;

    setUp(() {
      adapter = _StubAdapter((options) async {
        if (options.path.endsWith('/products/mine')) {
          return _json([_product()]);
        }
        // The public feed deliberately answers with somebody else's listings:
        // if "My Products" ever reads this, the test fails.
        return _json({
          'items': [_product(id: '01JOTHER00000000000000001', isMine: false)],
          'nextCursor': null,
        });
      });
      final client = ApiClient(baseUrl: 'http://localhost/api/v1')
        ..dio.httpClientAdapter = adapter;
      repo = ProductRepositoryImpl(ApiProductDataSource(client));
    });

    test('it asks for /products/mine, not the public feed', () async {
      final result = await repo.myProducts();

      // It used to fetch one page of the region-wide feed and keep the rows
      // marked `isMine`. Past a page of newer listings by other people, a
      // seller's own products vanished from their own screen.
      expect(
        adapter.requests.single.path,
        endsWith('/marketplace/products/mine'),
      );
      expect(result.valueOrNull, hasLength(1));
      expect(result.valueOrNull!.single.id, '01JPROD000000000000000001');
    });

    test('a listing carries the shop it belongs to', () async {
      final result = await repo.myProducts();

      expect(
        result.valueOrNull!.single.businessId,
        '01JBIZ0000000000000000000A',
      );
    });

    test('one shop\'s catalogue is asked for by id', () async {
      await repo.getProducts(
        const ProductFilter(businessId: '01JBIZ0000000000000000000A'),
      );

      expect(
        adapter.requests.last.uri.queryParameters['businessId'],
        '01JBIZ0000000000000000000A',
      );
    });
  });

  group('under mocks', () {
    late MockProductDataSource source;

    setUp(
      () => source = MockProductDataSource(
        resolver: const FixedRegionResolver(Region.nepal),
      ),
    );

    test('a shop\'s tab shows only that shop\'s listings', () async {
      final listings = await source.fetchProducts(
        const ProductFilter(businessId: 'biz-2'),
      );

      expect(listings, isNotEmpty);
      expect(listings.every((p) => p.businessId == 'biz-2'), isTrue);
    });

    test(
      'a newly published listing belongs to the seller\'s own shop',
      () async {
        final created = await source.create(
          const ProductDraft(title: 'New diyo', price: 450),
        );

        // Otherwise it would be published to the marketplace and still be
        // missing from the seller's own shop page.
        expect(created.businessId, MockBusinessDataSource.myBusinessId);
        expect(created.isMine, isTrue);

        final onTheShopPage = await source.fetchProducts(
          const ProductFilter(businessId: MockBusinessDataSource.myBusinessId),
        );
        expect(onTheShopPage.map((p) => p.id), contains(created.id));
      },
    );

    test('the seller\'s own listings are theirs alone', () async {
      final mine = await source.myProducts();

      expect(mine, isNotEmpty);
      expect(mine.every((p) => p.isMine), isTrue);
    });
  });
}
