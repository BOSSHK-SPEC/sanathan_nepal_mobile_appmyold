import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/boost.dart';
import '../../domain/entities/earnings.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'boost_cubit.freezed.dart';
part 'boost_state.dart';

/// Buying visibility, and seeing whether it worked.
class ConsoleBoostCubit extends AppCubit<ConsoleBoostState> {
  ConsoleBoostCubit({
    required GetBoostPlans getPlans,
    required GetBoostCampaigns getCampaigns,
    required BuyBoost buyBoost,
    required GetEarnings getEarnings,
  }) : _getPlans = getPlans,
       _getCampaigns = getCampaigns,
       _buy = buyBoost,
       _getEarnings = getEarnings,
       super(const ConsoleBoostState());

  final GetBoostPlans _getPlans;
  final GetBoostCampaigns _getCampaigns;
  final BuyBoost _buy;
  final GetEarnings _getEarnings;

  Future<void> load() async {
    emit(state.copyWith(plans: state.plans.toLoading()));
    final plansFuture = _getPlans();
    final campaignsFuture = _getCampaigns();
    final earningsFuture = _getEarnings(EarningsRange.year);

    final plans = await plansFuture;
    final campaigns = await campaignsFuture;
    final earnings = await earningsFuture;

    emit(
      state.copyWith(
        plans: plans.fold(state.plans.toFailed, LoadState.loaded),
        campaigns: campaigns.fold(state.campaigns.toFailed, LoadState.loaded),
        availableBalance: earnings.valueOrNull?.availableBalance ?? 0,
      ),
    );
  }

  void select(String planId) =>
      emit(state.copyWith(selectedPlanId: planId, buyError: null));

  Future<bool> buy() async {
    final planId = state.selectedPlanId;
    if (planId == null) return false;
    emit(state.copyWith(buying: state.buying.toLoading(), buyError: null));
    final result = await _buy(planId);
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            buying: state.buying.toFailed(failure),
            buyError: failure.message,
          ),
        );
        return false;
      },
      (campaign) async {
        emit(state.copyWith(buying: LoadState.loaded(campaign)));
        await load();
        return true;
      },
    );
  }
}
