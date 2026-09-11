import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Reads the persisted shopping cart.
class GetCart implements NoParamsUseCase<Cart> {
  const GetCart(this._repo);
  final CartRepository _repo;

  @override
  Future<Result<Cart>> call() => _repo.getCart();
}
