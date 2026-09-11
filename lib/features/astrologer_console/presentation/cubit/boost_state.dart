part of 'boost_cubit.dart';

@freezed
abstract class ConsoleBoostState with _$ConsoleBoostState {
  const ConsoleBoostState._();

  const factory ConsoleBoostState({
    @Default(LoadState.idle()) LoadState<List<BoostPlan>> plans,
    @Default(LoadState.idle()) LoadState<List<BoostCampaign>> campaigns,
    @Default(LoadState.idle()) LoadState<BoostCampaign> buying,
    @Default(0) double availableBalance,
    String? selectedPlanId,
    String? buyError,
  }) = _ConsoleBoostState;

  List<BoostPlan> get allPlans => plans.dataOrNull ?? const [];

  List<BoostCampaign> get allCampaigns => campaigns.dataOrNull ?? const [];

  List<BoostCampaign> get active =>
      allCampaigns.where((c) => c.isActive()).toList();

  List<BoostCampaign> get past =>
      allCampaigns.where((c) => !c.isActive()).toList();

  BoostPlan? get selected =>
      allPlans.where((p) => p.id == selectedPlanId).firstOrNull;

  /// Affordability is checked by the data source too; this only decides
  /// whether the button looks available.
  bool get canBuy =>
      selected != null &&
      selected!.price <= availableBalance &&
      !buying.isLoading;

  bool get cannotAfford =>
      selected != null && selected!.price > availableBalance;
}
