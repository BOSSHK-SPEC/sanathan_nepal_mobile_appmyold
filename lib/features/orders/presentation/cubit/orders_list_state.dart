part of 'orders_list_cubit.dart';

/// Which side of the transaction the list is showing.
enum OrdersScope { buyer, seller }

/// Coarse filter over the lifecycle.
enum OrderFilter { active, delivered, returns, all }

@freezed
abstract class OrdersListState with _$OrdersListState {
  const OrdersListState._();

  const factory OrdersListState({
    required OrdersScope scope,
    @Default(LoadState.idle()) LoadState<List<TrackedOrder>> orders,
    @Default(LoadState.idle()) LoadState<TrackedOrder> advancing,
    @Default(OrderFilter.active) OrderFilter filter,
  }) = _OrdersListState;

  List<TrackedOrder> get all => orders.dataOrNull ?? const [];

  List<TrackedOrder> get visible => switch (filter) {
    OrderFilter.active =>
      all.where((o) => !o.stage.isTerminal && !o.stage.isReturnFlow).toList(),
    OrderFilter.delivered =>
      all.where((o) => o.stage == OrderStage.delivered).toList(),
    OrderFilter.returns => all.where((o) => o.stage.isReturnFlow).toList(),
    OrderFilter.all => all,
  };

  bool get isEmpty => orders.isLoaded && visible.isEmpty;

  int get activeCount =>
      all.where((o) => !o.stage.isTerminal && !o.stage.isReturnFlow).length;
}
