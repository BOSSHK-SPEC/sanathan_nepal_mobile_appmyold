import '../../domain/entities/product.dart';
import '../models/cart_model.dart';

/// Where the cart lives.
///
/// Every operation returns the **whole** cart rather than void, because the
/// authority on totals, discounts and availability is whoever holds it: the
/// server re-prices from the live listing on each change, so a client that
/// mutated its own copy and assumed the result would drift the moment a price
/// moved.
///
/// This exists because the cart used to be local-only while checkout read the
/// *server's* cart — so every order failed with "Your cart is empty" no matter
/// what the app showed.
abstract interface class CartDataSource {
  Future<CartModel> read();

  /// [product] is passed whole because the local implementation stores the
  /// display data itself; the remote one needs nothing but the id, and the
  /// server answers with its own view of the item.
  Future<CartModel> addItem(
    Product product, {
    int quantity = 1,
    Map<String, String> selectedOptions = const {},
  });

  /// A quantity of zero removes the line, matching the server's contract.
  Future<CartModel> setQuantity(String productId, int quantity);

  Future<CartModel> removeItem(String productId);

  /// An unknown code clears any discount rather than failing: the field is a
  /// try-it-and-see box, and an error toast for a typo is noise.
  Future<CartModel> applyCoupon(String code);

  Future<CartModel> clear();
}
