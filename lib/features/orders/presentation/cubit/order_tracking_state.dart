part of 'order_tracking_cubit.dart';

@freezed
abstract class OrderTrackingState with _$OrderTrackingState {
  const OrderTrackingState._();

  const factory OrderTrackingState({
    @Default(LoadState.idle()) LoadState<TrackedOrder> order,
    @Default(LoadState.idle()) LoadState<TrackedOrder> returning,
    ReturnReason? reason,
    @Default('') String details,
    @Default(<String>{}) Set<String> selectedItems,
  }) = _OrderTrackingState;

  TrackedOrder? get tracked => order.dataOrNull;

  /// At least one item, a reason, and an explanation when the reason is
  /// "other" — the same rules the data source enforces.
  bool get canSubmitReturn =>
      tracked != null &&
      reason != null &&
      selectedItems.isNotEmpty &&
      (reason != ReturnReason.other || details.trim().isNotEmpty) &&
      !returning.isLoading;
}
