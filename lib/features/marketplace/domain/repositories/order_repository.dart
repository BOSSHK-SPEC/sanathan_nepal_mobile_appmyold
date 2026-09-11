import '../../../../core/utils/result.dart';
import '../entities/order.dart';

/// Order placement.
abstract interface class OrderRepository {
  Future<Result<Order>> placeOrder(OrderRequest request);
}
