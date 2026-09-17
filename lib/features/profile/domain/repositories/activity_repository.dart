import '../../../../core/utils/result.dart';
import '../entities/appointment_summary.dart';
import '../entities/order_summary.dart';

/// User activity: appointments and marketplace orders.
abstract interface class ActivityRepository {
  Future<Result<List<AppointmentSummary>>> getAppointments();
  Future<Result<List<OrderSummary>>> getOrders();
  /// Applies [action] to [order].
  ///
  /// Takes the whole order rather than an id: the buyer's cancel and the
  /// seller's are different endpoints, so the caller's role decides which is
  /// used, and it is carried here rather than guessed in the data source.
  Future<Result<OrderSummary>> applyOrderAction(
    OrderSummary order,
    OrderAction action,
  );
  Future<Result<OrderSummary>> rateOrder(String id, int rating);
}
