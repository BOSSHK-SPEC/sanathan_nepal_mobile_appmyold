import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/order_tracking.dart';
import '../../domain/usecases/order_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'orders_list_cubit.freezed.dart';
part 'orders_list_state.dart';

/// Buyer orders, or seller orders, depending on [OrdersScope].
///
/// One cubit for both because the list is the same shape; what differs is
/// which side of the transaction you are on and therefore which actions the
/// rows offer.
class OrdersListCubit extends AppCubit<OrdersListState> {
  OrdersListCubit({
    required OrdersScope scope,
    required GetMyOrders getMyOrders,
    required GetSellerOrders getSellerOrders,
    required AdvanceOrder advanceOrder,
  }) : _getMyOrders = getMyOrders,
       _getSellerOrders = getSellerOrders,
       _advance = advanceOrder,
       super(OrdersListState(scope: scope));

  final GetMyOrders _getMyOrders;
  final GetSellerOrders _getSellerOrders;
  final AdvanceOrder _advance;

  Future<void> load() async {
    emit(state.copyWith(orders: state.orders.toLoading()));
    final result = state.scope == OrdersScope.buyer
        ? await _getMyOrders()
        : await _getSellerOrders();
    emit(
      state.copyWith(
        orders: result.fold(state.orders.toFailed, LoadState.loaded),
      ),
    );
  }

  void setFilter(OrderFilter filter) => emit(state.copyWith(filter: filter));

  Future<bool> advance(
    TrackedOrder order, {
    String? courierName,
    String? trackingNumber,
  }) async {
    final next = order.fulfilmentIndex + 1;
    if (next >= OrderStage.fulfilment.length) return false;

    emit(state.copyWith(advancing: state.advancing.toLoading()));
    final result = await _advance(
      AdvanceOrderParams(
        orderId: order.id,
        stage: OrderStage.fulfilment[next],
        courierName: courierName,
        trackingNumber: trackingNumber,
      ),
    );
    return result.fold(
      (failure) {
        emit(state.copyWith(advancing: state.advancing.toFailed(failure)));
        return false;
      },
      (updated) async {
        emit(state.copyWith(advancing: LoadState.loaded(updated)));
        await load();
        return true;
      },
    );
  }
}
