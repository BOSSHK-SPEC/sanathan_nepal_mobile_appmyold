import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

part 'update_cart_item.freezed.dart';

/// Parameters for [UpdateCartItem].
@freezed
abstract class UpdateCartItemParams with _$UpdateCartItemParams {
  const factory UpdateCartItemParams({
    required String productId,
    required int quantity,
  }) = _UpdateCartItemParams;
}

/// Sets the quantity of a cart line (0 removes it).
class UpdateCartItem implements UseCase<Cart, UpdateCartItemParams> {
  const UpdateCartItem(this._repo);
  final CartRepository _repo;

  @override
  Future<Result<Cart>> call(UpdateCartItemParams params) =>
      _repo.updateQuantity(params.productId, params.quantity);
}
