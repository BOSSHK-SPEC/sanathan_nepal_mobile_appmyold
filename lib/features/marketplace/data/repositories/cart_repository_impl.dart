import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_data_source.dart';

/// Delegates every cart change to whoever holds the cart.
///
/// Deliberately thin. The rules — pricing, delivery, coupon validity — belong
/// to the holder: the server applies its own and answers with the result, and
/// the local source applies stand-ins. A repository that recomputed totals on
/// top of the server's answer would be a second, quieter source of truth.
class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl(this._source);

  final CartDataSource _source;

  @override
  Future<Result<Cart>> getCart() =>
      guard(() async => (await _source.read()).toEntity());

  @override
  Future<Result<Cart>> addItem(
    Product product, {
    int quantity = 1,
    Map<String, String> selectedOptions = const {},
  }) => guard(
    () async => (await _source.addItem(
      product,
      quantity: quantity,
      selectedOptions: selectedOptions,
    )).toEntity(),
  );

  @override
  Future<Result<Cart>> updateQuantity(String productId, int quantity) =>
      guard(() async => (await _source.setQuantity(productId, quantity)).toEntity());

  @override
  Future<Result<Cart>> removeItem(String productId) =>
      guard(() async => (await _source.removeItem(productId)).toEntity());

  @override
  Future<Result<Cart>> applyCoupon(String code) =>
      guard(() async => (await _source.applyCoupon(code)).toEntity());

  @override
  Future<Result<Cart>> clear() =>
      guard(() async => (await _source.clear()).toEntity());
}
