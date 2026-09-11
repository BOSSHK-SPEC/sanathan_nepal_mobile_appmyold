import '../../../../core/utils/result.dart';
import '../entities/order_tracking.dart';

/// Order tracking for buyers, and fulfilment for sellers.
abstract interface class OrderTrackingRepository {
  /// Orders the signed-in user placed.
  Future<Result<List<TrackedOrder>>> myOrders();

  Future<Result<TrackedOrder>> order(String orderId);

  Future<Result<TrackedOrder>> requestReturn(ReturnDraft draft);

  /// Orders placed with the signed-in seller.
  Future<Result<List<TrackedOrder>>> sellerOrders();

  /// Moves an order to the next fulfilment stage.
  Future<Result<TrackedOrder>> advance({
    required String orderId,
    required OrderStage stage,
    String? courierName,
    String? trackingNumber,
  });
}
