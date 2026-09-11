part of 'boost_cubit.dart';

/// Two-step flow: pick products → fill the boost form.
enum BoostStep { select, form }

@freezed
abstract class BoostState with _$BoostState {
  const BoostState._();

  const factory BoostState({
    @Default(BoostStep.select) BoostStep step,
    @Default(LoadState.idle()) LoadState<List<Product>> products,
    @Default(LoadState.idle()) LoadState<List<BoostPlan>> plans,
    @Default({}) Set<String> selectedIds,
    @Default(ProductSort.latest) ProductSort sort,
    BoostPlan? plan,

    /// Result of the last submit (loading while in flight).
    @Default(LoadState.idle()) LoadState<BoostReceipt> submission,
  }) = _BoostState;

  double get total => (plan?.pricePerProduct ?? 0) * selectedIds.length;
}
