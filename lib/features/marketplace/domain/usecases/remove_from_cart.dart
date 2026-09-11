import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Removes a product line from the cart.
class RemoveFromCart implements UseCase<Cart, String> {
  const RemoveFromCart(this._repo);
  final CartRepository _repo;

  @override
  Future<Result<Cart>> call(String params) => _repo.removeItem(params);
}
