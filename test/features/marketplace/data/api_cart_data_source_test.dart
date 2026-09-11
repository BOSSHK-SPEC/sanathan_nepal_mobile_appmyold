import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/network/api_client.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/datasources/api_cart_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/marketplace/data/repositories/cart_repository_impl.dart';

import '../helpers/test_helpers.dart';

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

/// The server's cart, exactly as `GET /cart` returns it.
Map<String, dynamic> _cart({int quantity = 2}) => {
  'id': '01M24R3XWFMNEMA2DSZT73B4WT',
  'items': [
    {
      'id': '01M24R3XWK73QZJGQREKRD0TBP',
      'productId': '01M22ZJMKW9A7FC3ZD47TMX1Z3',
      'title': {'en': 'Brass Diyo', 'ne': 'पित्तलको दियो'},
      'imageKey': 'catalog/diyo.png',
      'quantity': quantity,
      'unitPriceMinor': '45000',
      'lineTotalMinor': '${45000 * quantity}',
      'selectedOptions': <String, String>{},
      'available': true,
    },
  ],
  'subtotalMinor': '${45000 * quantity}',
  'discountMinor': '0',
  'totalMinor': '${45000 * quantity}',
  'currency': 'NPR',
  'couponCode': null,
};

ResponseBody _json(Object body) => ResponseBody.fromString(
  jsonEncode(body),
  200,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

/// The cart used to live only on the device while `POST /orders/checkout` read
/// the server's — so every order failed with "Your cart is empty" however full
/// the app looked. These tests pin the two things that fixes: the mutation
/// actually goes out, and the server's answer is what the app then shows.
void main() {
  late _StubAdapter adapter;
  late ApiCartDataSource source;

  setUp(() {
    adapter = _StubAdapter((_) async => _json(_cart()));
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost:3100/api/v1'))
      ..httpClientAdapter = adapter;
    source = ApiCartDataSource(ApiClient(dio: dio));
  });

  test('adding an item posts to the server cart', () async {
    await source.addItem(sampleProduct(id: '01M22ZJMKW9A7FC3ZD47TMX1Z3'));

    final request = adapter.requests.single;
    expect(request.method, 'POST');
    expect(request.path, '/cart/items');
    expect(
      (request.data! as Map)['productId'],
      '01M22ZJMKW9A7FC3ZD47TMX1Z3',
    );
  });

  test('the cart shown is the one the server returned', () async {
    final cart = (await source.read()).toEntity();

    expect(cart.items, hasLength(1));
    expect(cart.items.single.quantity, 2);
    expect(cart.items.single.product.price, 450);
    expect(cart.items.single.product.title, 'Brass Diyo');
    expect(cart.items.single.product.titleNe, 'पित्तलको दियो');
    expect(cart.subtotal, 900);
  });

  test('quantity, removal and clearing each hit their own route', () async {
    await source.setQuantity('p1', 3);
    await source.removeItem('p1');
    await source.clear();

    expect(
      adapter.requests.map((r) => '${r.method} ${r.path}'),
      ['PATCH /cart/items/p1', 'DELETE /cart/items/p1', 'DELETE /cart'],
    );
  });

  test('delivery is not quoted before an address exists', () async {
    // The server bills it at checkout from the shipping address, so a number
    // here would be a guess the final total contradicts.
    expect((await source.read()).toEntity().shippingCost, 0);
  });

  test('the repository passes the server cart straight through', () async {
    final result = await CartRepositoryImpl(source).getCart();

    expect(result.isSuccess, isTrue);
    expect(result.valueOrNull?.items.single.product.id, '01M22ZJMKW9A7FC3ZD47TMX1Z3');
  });
}
