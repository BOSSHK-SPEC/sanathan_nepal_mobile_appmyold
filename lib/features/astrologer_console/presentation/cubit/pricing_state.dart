part of 'pricing_cubit.dart';

@freezed
abstract class PricingState with _$PricingState {
  const PricingState._();

  const factory PricingState({
    @Default(LoadState.idle()) LoadState<ConsolePricing> pricing,
    @Default(LoadState.idle()) LoadState<ConsolePricing> saving,
    ConsolePricing? draft,
    String? saveError,
  }) = _PricingState;

  ConsolePricing get working =>
      draft ?? pricing.dataOrNull ?? const ConsolePricing();

  bool get hasChanges =>
      pricing.dataOrNull != null && working != pricing.dataOrNull;

  bool get canSave => working.isValid && !saving.isLoading;
}
