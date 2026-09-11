import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/order_tracking.dart';
import '../repositories/order_tracking_repository.dart';

class GetMyOrders implements NoParamsUseCase<List<TrackedOrder>> {
  const GetMyOrders(this._repo);
  final OrderTrackingRepository _repo;

  @override
  Future<Result<List<TrackedOrder>>> call() => _repo.myOrders();
}

class GetTrackedOrder implements UseCase<TrackedOrder, String> {
  const GetTrackedOrder(this._repo);
  final OrderTrackingRepository _repo;

  @override
  Future<Result<TrackedOrder>> call(String params) => _repo.order(params);
}

class RequestReturn implements UseCase<TrackedOrder, ReturnDraft> {
  const RequestReturn(this._repo);
  final OrderTrackingRepository _repo;

  @override
  Future<Result<TrackedOrder>> call(ReturnDraft params) =>
      _repo.requestReturn(params);
}

class GetSellerOrders implements NoParamsUseCase<List<TrackedOrder>> {
  const GetSellerOrders(this._repo);
  final OrderTrackingRepository _repo;

  @override
  Future<Result<List<TrackedOrder>>> call() => _repo.sellerOrders();
}

class AdvanceOrderParams {
  const AdvanceOrderParams({
    required this.orderId,
    required this.stage,
    this.courierName,
    this.trackingNumber,
  });

  final String orderId;
  final OrderStage stage;
  final String? courierName;
  final String? trackingNumber;
}

class AdvanceOrder implements UseCase<TrackedOrder, AdvanceOrderParams> {
  const AdvanceOrder(this._repo);
  final OrderTrackingRepository _repo;

  @override
  Future<Result<TrackedOrder>> call(AdvanceOrderParams params) => _repo.advance(
    orderId: params.orderId,
    stage: params.stage,
    courierName: params.courierName,
    trackingNumber: params.trackingNumber,
  );
}
