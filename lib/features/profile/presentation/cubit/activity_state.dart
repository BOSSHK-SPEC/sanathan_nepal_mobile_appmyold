part of 'activity_cubit.dart';

/// State of the ACTIVITIES tab (appointments + orders).
///
/// A failed order action moves [orders] to `failed` while keeping the current
/// list as `previous`.
@freezed
abstract class ActivityState with _$ActivityState {
  const factory ActivityState({
    @Default(LoadState.idle()) LoadState<List<AppointmentSummary>> appointments,
    @Default(LoadState.idle()) LoadState<List<OrderSummary>> orders,
  }) = _ActivityState;

  const ActivityState._();

  List<OrderSummary> get purchases => (orders.dataOrNull ?? const [])
      .where((o) => o.role == OrderRole.buyer)
      .toList();
  List<OrderSummary> get sales => (orders.dataOrNull ?? const [])
      .where((o) => o.role == OrderRole.seller)
      .toList();
}
