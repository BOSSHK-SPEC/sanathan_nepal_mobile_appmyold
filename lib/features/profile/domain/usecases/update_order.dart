import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/order_summary.dart';
import '../repositories/activity_repository.dart';

part 'update_order.freezed.dart';

/// Parameters for [UpdateOrderStatus].
@freezed
abstract class UpdateOrderStatusParams with _$UpdateOrderStatusParams {
  const factory UpdateOrderStatusParams({
    required String id,
    required OrderStatus status,
  }) = _UpdateOrderStatusParams;
}

/// Accept / cancel / complete an order.
class UpdateOrderStatus
    implements UseCase<OrderSummary, UpdateOrderStatusParams> {
  const UpdateOrderStatus(this._repo);
  final ActivityRepository _repo;

  @override
  Future<Result<OrderSummary>> call(UpdateOrderStatusParams params) =>
      _repo.updateOrderStatus(params.id, params.status);
}

/// Parameters for [RateOrder].
@freezed
abstract class RateOrderParams with _$RateOrderParams {
  const factory RateOrderParams({required String id, required int rating}) =
      _RateOrderParams;
}

/// Rate a completed purchase (1–5 stars).
class RateOrder implements UseCase<OrderSummary, RateOrderParams> {
  const RateOrder(this._repo);
  final ActivityRepository _repo;

  @override
  Future<Result<OrderSummary>> call(RateOrderParams params) =>
      _repo.rateOrder(params.id, params.rating);
}
