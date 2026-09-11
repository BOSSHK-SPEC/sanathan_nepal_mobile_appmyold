import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/mock_order_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(this._source);
  final OrderDataSource _source;

  @override
  Future<Result<Order>> placeOrder(OrderRequest request) =>
      guard(() => _source.placeOrder(request));
}
