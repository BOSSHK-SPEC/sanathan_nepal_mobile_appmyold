import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/order_summary.dart';
import '../repositories/activity_repository.dart';

part 'update_order.freezed.dart';

/// Parameters for [ApplyOrderAction].
@freezed
abstract class ApplyOrderActionParams with _$ApplyOrderActionParams {
  const factory ApplyOrderActionParams({
    required OrderSummary order,
    required OrderAction action,
  }) = _ApplyOrderActionParams;
}

/// Accept, ship, complete or cancel an order.
///
/// Refuses an action the order does not offer before any request is made: the
/// server would reject it anyway, and a round trip to learn that is a round
/// trip the user waits through.
class ApplyOrderAction
    implements UseCase<OrderSummary, ApplyOrderActionParams> {
  const ApplyOrderAction(this._repo);
  final ActivityRepository _repo;

  @override
  Future<Result<OrderSummary>> call(ApplyOrderActionParams params) {
    if (!params.order.availableActions.contains(params.action)) {
      return Future.value(
        const Result.failure(
          ValidationFailure('That is no longer possible for this order'),
        ),
      );
    }
    return _repo.applyOrderAction(params.order, params.action);
  }
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
