import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/order_tracking.dart';
import '../../domain/repositories/order_tracking_repository.dart';
import '../datasources/order_tracking_data_source.dart';

class OrderTrackingRepositoryImpl implements OrderTrackingRepository {
  const OrderTrackingRepositoryImpl(this._source);

  final OrderTrackingDataSource _source;

  @override
  Future<Result<List<TrackedOrder>>> myOrders() => guard(_source.myOrders);

  @override
  Future<Result<TrackedOrder>> order(String orderId) =>
      guard(() => _source.order(orderId));

  @override
  Future<Result<TrackedOrder>> requestReturn(ReturnDraft draft) =>
      guard(() => _source.requestReturn(draft));

  @override
  Future<Result<List<TrackedOrder>>> sellerOrders() =>
      guard(_source.sellerOrders);

  @override
  Future<Result<TrackedOrder>> advance({
    required String orderId,
    required OrderStage stage,
    String? courierName,
    String? trackingNumber,
  }) => guard(
    () => _source.advance(
      orderId: orderId,
      stage: stage,
      courierName: courierName,
      trackingNumber: trackingNumber,
    ),
  );
}
