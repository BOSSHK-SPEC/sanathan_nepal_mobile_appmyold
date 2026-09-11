import '../../../../core/utils/result.dart';
import '../entities/appointment_summary.dart';
import '../entities/order_summary.dart';

/// User activity: appointments and marketplace orders.
abstract interface class ActivityRepository {
  Future<Result<List<AppointmentSummary>>> getAppointments();
  Future<Result<List<OrderSummary>>> getOrders();
  Future<Result<OrderSummary>> updateOrderStatus(String id, OrderStatus status);
  Future<Result<OrderSummary>> rateOrder(String id, int rating);
}
