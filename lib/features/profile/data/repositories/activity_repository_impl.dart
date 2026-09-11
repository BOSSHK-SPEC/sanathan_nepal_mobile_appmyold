import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/appointment_summary.dart';
import '../../domain/entities/order_summary.dart';
import '../../domain/repositories/activity_repository.dart';
import '../datasources/mock_activity_data_source.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  ActivityRepositoryImpl(this._source);
  final ActivityDataSource _source;

  @override
  Future<Result<List<AppointmentSummary>>> getAppointments() =>
      guard(_source.getAppointments);

  @override
  Future<Result<List<OrderSummary>>> getOrders() => guard(_source.getOrders);

  @override
  Future<Result<OrderSummary>> updateOrderStatus(
    String id,
    OrderStatus status,
  ) => guard(() => _source.updateOrderStatus(id, status));

  @override
  Future<Result<OrderSummary>> rateOrder(String id, int rating) =>
      guard(() => _source.rateOrder(id, rating));
}
