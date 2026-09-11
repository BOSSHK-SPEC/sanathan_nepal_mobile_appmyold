import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/cart.dart';
import '../entities/product.dart';
import '../repositories/cart_repository.dart';

part 'add_to_cart.freezed.dart';

/// Parameters for [AddToCart].
@freezed
abstract class AddToCartParams with _$AddToCartParams {
  const factory AddToCartParams({
    required Product product,
    @Default(1) int quantity,
    @Default({}) Map<String, String> selectedOptions,
  }) = _AddToCartParams;
}

/// Adds a product (or increments it) in the cart.
class AddToCart implements UseCase<Cart, AddToCartParams> {
  const AddToCart(this._repo);
  final CartRepository _repo;

  @override
  Future<Result<Cart>> call(AddToCartParams params) => _repo.addItem(
    params.product,
    quantity: params.quantity,
    selectedOptions: params.selectedOptions,
  );
}
