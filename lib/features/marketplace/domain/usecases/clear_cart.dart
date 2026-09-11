import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Empties the cart (after a successful order).
class ClearCart implements NoParamsUseCase<Cart> {
  const ClearCart(this._repo);
  final CartRepository _repo;

  @override
  Future<Result<Cart>> call() => _repo.clear();
}
