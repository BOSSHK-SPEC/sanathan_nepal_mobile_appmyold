import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/events/data_changes.dart';

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
///
/// Lives as long as the Profile tab, which the bottom bar keeps alive, so it
/// reloads whenever [DataChanges] reports new orders or appointments — an
/// order placed from the marketplace otherwise never appeared here.
class ActivityCubit extends AppCubit<ActivityState> {
  ActivityCubit({
    required GetAppointments getAppointments,
    required GetOrders getOrders,
    required ApplyOrderAction applyOrderAction,
    required RateOrder rateOrder,
    DataChanges? changes,
  }) : _getAppointments = getAppointments,
       _getOrders = getOrders,
       _applyOrderAction = applyOrderAction,
       _rateOrder = rateOrder,
       super(const ActivityState()) {
    _changes = changes
        ?.on(const {DataTopic.orders, DataTopic.appointments})
        .listen((_) => load());
  }

  StreamSubscription<DataTopic>? _changes;

  final GetAppointments _getAppointments;
  final GetOrders _getOrders;
  final ApplyOrderAction _applyOrderAction;
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

  /// Accepts, ships, completes or cancels [order].
  ///
  /// One entry point rather than a method per action: the card decides what is
  /// offered from [OrderSummary.availableActions], and anything else is refused
  /// by the use case before a request is made.
  ///
  /// The order is held pending while the request is out so its buttons can be
  /// disabled — two taps on Accept sent two requests, and the second came back
  /// "an order cannot move from processing to processing".
  Future<void> act(OrderSummary order, OrderAction action) async {
    if (state.pendingOrderId != null) return;
    emit(state.copyWith(pendingOrderId: order.id, actionError: null));

    final result = await _applyOrderAction(
      ApplyOrderActionParams(order: order, action: action),
    );
    if (isClosed) return;
    emit(state.copyWith(pendingOrderId: null));
    _apply(result);
  }

  Future<void> rate(String id, int rating) async {
    final result = await _rateOrder(RateOrderParams(id: id, rating: rating));
    if (isClosed) return;
    _apply(result);
  }

  /// Clears the message once the UI has shown it, so it is not shown twice.
  void clearActionError() => emit(state.copyWith(actionError: null));

  @override
  Future<void> close() async {
    await _changes?.cancel();
    return super.close();
  }

  /// Folds the outcome of an action into the list.
  ///
  /// A failure no longer moves `orders` to `failed`: the tab only reads that
  /// when the list is empty, so a rejected Accept changed nothing on screen and
  /// the button looked dead. The list is left exactly as it was and the reason
  /// is put where a listener can show it.
  void _apply(Result<OrderSummary> result) => emit(
    result.fold(
      (failure) => state.copyWith(actionError: failure.message),
      (updated) => state.copyWith(
        orders: LoadState.loaded([
          for (final o in state.orders.dataOrNull ?? const <OrderSummary>[])
            o.id == updated.id ? updated : o,
        ]),
      ),
    ),
  );
}
