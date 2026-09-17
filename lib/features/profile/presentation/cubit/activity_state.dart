part of 'activity_cubit.dart';

/// State of the ACTIVITIES tab (appointments + orders).
///
/// A failed order action leaves [orders] untouched and reports itself through
/// [actionError]: the list on screen is still correct, and replacing it with an
/// error hid the card the person was acting on.
@freezed
abstract class ActivityState with _$ActivityState {
  const factory ActivityState({
    @Default(LoadState.idle()) LoadState<List<AppointmentSummary>> appointments,
    @Default(LoadState.idle()) LoadState<List<OrderSummary>> orders,

    /// Why the last accept / ship / cancel failed. Shown once, then cleared.
    String? actionError,

    /// The order with a request in flight. Its buttons are disabled, so a
    /// second tap cannot send a second transition.
    String? pendingOrderId,
  }) = _ActivityState;

  const ActivityState._();

  List<OrderSummary> get purchases => (orders.dataOrNull ?? const [])
      .where((o) => o.role == OrderRole.buyer)
      .toList();
  List<OrderSummary> get sales => (orders.dataOrNull ?? const [])
      .where((o) => o.role == OrderRole.seller)
      .toList();

  /// Whether [order] has a request in flight.
  bool isPending(OrderSummary order) => pendingOrderId == order.id;
}
