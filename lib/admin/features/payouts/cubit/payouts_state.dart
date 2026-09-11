part of 'payouts_cubit.dart';

@freezed
abstract class PayoutsState with _$PayoutsState {
  const PayoutsState._();

  const factory PayoutsState({
    @Default(LoadState<List<PendingPayout>>.idle())
    LoadState<List<PendingPayout>> payouts,
    String? decidingId,
    String? actionError,

    /// The status the server returned for the last decision, shown as a
    /// confirmation so a reviewer sees the outcome and not just an absence.
    String? lastOutcome,
  }) = _PayoutsState;

  List<PendingPayout> get items => payouts.dataOrNull ?? const [];

  bool isDeciding(String id) => decidingId == id;

  /// Total sitting in the queue — the number a finance reviewer wants before
  /// they start approving anything.
  double get totalRequested =>
      items.fold(0, (sum, payout) => sum + payout.amount);
}
