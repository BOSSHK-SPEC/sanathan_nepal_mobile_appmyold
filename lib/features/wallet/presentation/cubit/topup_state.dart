part of 'topup_cubit.dart';

/// The only way an amount can be wrong, so the UI needs no message plumbing.
enum TopUpAmountError { outOfRange }

@freezed
abstract class TopUpState with _$TopUpState {
  const TopUpState._();

  const factory TopUpState({
    /// Payment rails offered in the active region.
    required List<PaymentRail> rails,
    @Default(LoadState.idle()) LoadState<List<TopUpOption>> options,
    @Default(LoadState.idle()) LoadState<PaymentIntent> intent,

    /// 0 = amount, 1 = payment method.
    @Default(0) int step,
    double? selectedAmount,
    @Default('') String customAmount,
    PaymentRail? rail,
    TopUpAmountError? amountError,
  }) = _TopUpState;

  List<TopUpOption> get tiers => options.dataOrNull ?? const [];

  /// Bonus attached to the chosen amount, if it matches a tier exactly.
  double get bonus => tiers
      .where((o) => o.amount == selectedAmount)
      .fold<double>(0, (_, o) => o.bonus);

  double get totalCredited => (selectedAmount ?? 0) + bonus;

  bool get canContinue => selectedAmount != null && selectedAmount! > 0;

  bool get canPay => canContinue && rail != null && !intent.isLoading;
}
