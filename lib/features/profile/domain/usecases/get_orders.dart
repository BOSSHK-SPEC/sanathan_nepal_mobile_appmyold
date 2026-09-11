import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/order_summary.dart';
import '../repositories/activity_repository.dart';

/// Loads purchases and sales of the user.
class GetOrders implements NoParamsUseCase<List<OrderSummary>> {
  const GetOrders(this._repo);
  final ActivityRepository _repo;

  @override
  Future<Result<List<OrderSummary>>> call() => _repo.getOrders();
}
