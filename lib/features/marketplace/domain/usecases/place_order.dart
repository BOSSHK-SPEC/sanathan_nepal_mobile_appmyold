import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

/// Places an order for the current cart.
class PlaceOrder implements UseCase<Order, OrderRequest> {
  const PlaceOrder(this._repo);
  final OrderRepository _repo;

  @override
  Future<Result<Order>> call(OrderRequest params) => _repo.placeOrder(params);
}
