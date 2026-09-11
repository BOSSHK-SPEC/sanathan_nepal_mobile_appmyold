import '../../../../core/utils/result.dart';
import '../entities/cart.dart';
import '../entities/product.dart';

/// Shopping-cart persistence (in-memory + local storage).
abstract interface class CartRepository {
  Future<Result<Cart>> getCart();
  Future<Result<Cart>> addItem(
    Product product, {
    int quantity = 1,
    Map<String, String> selectedOptions = const {},
  });
  Future<Result<Cart>> updateQuantity(String productId, int quantity);
  Future<Result<Cart>> removeItem(String productId);
  Future<Result<Cart>> applyCoupon(String code);
  Future<Result<Cart>> clear();
}
