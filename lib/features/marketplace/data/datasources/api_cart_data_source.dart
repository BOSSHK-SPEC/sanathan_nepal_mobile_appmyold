import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_localized.dart';
import '../../../../core/network/api_money.dart';
import '../../domain/entities/product.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../models/seller_model.dart';
import 'cart_data_source.dart';

/// The signed-in user's cart, held by the server.
///
/// Server-held rather than device-held for two reasons that matter: checkout
/// reads this cart, so a local-only one can never be ordered from; and the
/// server re-prices every line from the live listing, so a stale price on the
/// device cannot become a stale price on an order.
class ApiCartDataSource implements CartDataSource {
  const ApiCartDataSource(this._client);

  final ApiClient _client;

  @override
  Future<CartModel> read() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.cart);
    return _toCart(asJsonMap(response));
  });

  @override
  Future<CartModel> addItem(
    Product product, {
    int quantity = 1,
    Map<String, String> selectedOptions = const {},
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.cartItems,
      data: {
        'productId': product.id,
        'quantity': quantity,
        'selectedOptions': selectedOptions,
      },
    );
    return _toCart(asJsonMap(response));
  });

  @override
  Future<CartModel> setQuantity(String productId, int quantity) =>
      guardApi(() async {
        final response = await _client.patch<dynamic>(
          ApiEndpoints.cartItem(productId),
          data: {'quantity': quantity},
        );
        return _toCart(asJsonMap(response));
      });

  @override
  Future<CartModel> removeItem(String productId) => guardApi(() async {
    final response = await _client.delete<dynamic>(
      ApiEndpoints.cartItem(productId),
    );
    return _toCart(asJsonMap(response));
  });

  @override
  Future<CartModel> applyCoupon(String code) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.cartCoupon,
      data: {'code': code.trim().toUpperCase()},
    );
    return _toCart(asJsonMap(response));
  });

  @override
  Future<CartModel> clear() => guardApi(() async {
    final response = await _client.delete<dynamic>(ApiEndpoints.cart);
    return _toCart(asJsonMap(response));
  });

  /// Maps the server's cart onto the app's shape.
  ///
  /// The wire item carries only what a cart row displays — title, image,
  /// prices — not a whole listing, so the [ProductModel] built here is a
  /// display stand-in and is documented as such. Everything the cart tile
  /// reads is real; anything else is a default, and no screen but the cart
  /// ever sees these objects.
  static CartModel _toCart(Map<String, dynamic> json) {
    final rawItems = json['items'];
    final items = <CartItemModel>[
      if (rawItems is List)
        for (final raw in rawItems.whereType<Map>())
          _toItem(Map<String, dynamic>.from(raw)),
    ];

    return CartModel(
      items: items,
      couponCode: json['couponCode'] as String?,
      discount: ApiMoney.toMajor(json['discountMinor']),
      // The server bills delivery at checkout, from the shipping address it is
      // given — there is no address yet, so quoting a number here would be a
      // guess the final total then contradicts.
      shippingCost: 0,
    );
  }

  static CartItemModel _toItem(Map<String, dynamic> json) {
    final title = asLocalizedMap(json['title']);
    final quantity = (json['quantity'] as num?)?.toInt() ?? 1;
    final unitPrice = ApiMoney.toMajor(json['unitPriceMinor']);

    return CartItemModel(
      product: ProductModel(
        id: json['productId'] as String? ?? '',
        title: title['en'] ?? '',
        titleNe: title['ne'] ?? title['en'] ?? '',
        description: '',
        descriptionNe: '',
        price: unitPrice,
        // The wire item carries no category. It is only used for a label
        // beside the row, which simply does not render without one.
        categoryId: '',
        images: [
          if (json['imageKey'] is String && (json['imageKey'] as String).isNotEmpty)
            json['imageKey'] as String,
        ],
        seller: const SellerModel(id: '', name: ''),
        location: '',
        locationNe: '',
        postedAt: DateTime.fromMillisecondsSinceEpoch(0),
      ),
      quantity: quantity,
      selectedOptions: {
        for (final entry
            in (json['selectedOptions'] as Map? ?? const {}).entries)
          entry.key.toString(): entry.value.toString(),
      },
    );
  }
}
