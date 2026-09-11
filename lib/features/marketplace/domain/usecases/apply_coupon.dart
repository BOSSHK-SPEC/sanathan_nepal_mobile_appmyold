import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Applies a coupon code to the cart.
class ApplyCoupon implements UseCase<Cart, String> {
  const ApplyCoupon(this._repo);
  final CartRepository _repo;

  @override
  Future<Result<Cart>> call(String params) => _repo.applyCoupon(params);
}
