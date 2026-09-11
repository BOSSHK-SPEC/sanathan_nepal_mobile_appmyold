import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/appointment_summary.dart';
import '../../domain/entities/order_summary.dart';
import '../../domain/usecases/get_appointments.dart';
import '../../domain/usecases/get_orders.dart';
import '../../domain/usecases/update_order.dart';
import '../../../../core/state/app_cubit.dart';

part 'activity_cubit.freezed.dart';
part 'activity_state.dart';

/// Loads appointments/orders and applies order actions.
class ActivityCubit extends AppCubit<ActivityState> {
  ActivityCubit({
    required GetAppointments getAppointments,
    required GetOrders getOrders,
    required UpdateOrderStatus updateOrderStatus,
    required RateOrder rateOrder,
  }) : _getAppointments = getAppointments,
       _getOrders = getOrders,
       _updateOrderStatus = updateOrderStatus,
       _rateOrder = rateOrder,
       super(const ActivityState());

  final GetAppointments _getAppointments;
  final GetOrders _getOrders;
  final UpdateOrderStatus _updateOrderStatus;
  final RateOrder _rateOrder;

  Future<void> load() async {
    emit(
      state.copyWith(
        appointments: state.appointments.toLoading(),
        orders: state.orders.toLoading(),
      ),
    );
    final apts = await _getAppointments();
    final orders = await _getOrders();
    emit(
      state.copyWith(
        appointments: apts.fold(state.appointments.toFailed, LoadState.loaded),
        orders: orders.fold(state.orders.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> cancelOrder(String id) => _update(id, OrderStatus.cancelled);
  Future<void> acceptOrder(String id) => _update(id, OrderStatus.processing);
  Future<void> completeOrder(String id) => _update(id, OrderStatus.sold);

  Future<void> rate(String id, int rating) async {
    final result = await _rateOrder(RateOrderParams(id: id, rating: rating));
    _apply(result);
  }

  Future<void> _update(String id, OrderStatus status) async {
    final result = await _updateOrderStatus(
      UpdateOrderStatusParams(id: id, status: status),
    );
    _apply(result);
  }

  void _apply(Result<OrderSummary> result) => emit(
    state.copyWith(
      orders: result.fold(
        state.orders.toFailed,
        (updated) => LoadState.loaded([
          for (final o in state.orders.dataOrNull ?? const <OrderSummary>[])
            o.id == updated.id ? updated : o,
        ]),
      ),
    ),
  );
}
