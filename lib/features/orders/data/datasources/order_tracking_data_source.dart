import '../../domain/entities/order_tracking.dart';

abstract interface class OrderTrackingDataSource {
  Future<List<TrackedOrder>> myOrders();
  Future<TrackedOrder> order(String orderId);
  Future<TrackedOrder> requestReturn(ReturnDraft draft);
  Future<List<TrackedOrder>> sellerOrders();
  Future<TrackedOrder> advance({
    required String orderId,
    required OrderStage stage,
    String? courierName,
    String? trackingNumber,
  });
}
