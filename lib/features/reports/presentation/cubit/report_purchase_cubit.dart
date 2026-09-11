import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/billing/spending_account.dart';
import '../../../../core/state/load_state.dart';
import '../../../kundli/domain/entities/birth_profile.dart';
import '../../../kundli/domain/usecases/kundli_usecases.dart';
import '../../domain/entities/purchased_report.dart';
import '../../domain/entities/report_product.dart';
import '../../domain/repositories/report_repository.dart';
import '../../domain/usecases/report_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'report_purchase_cubit.freezed.dart';
part 'report_purchase_state.dart';

/// Buying one report: pick whose chart it is for, then pay.
///
/// The balance is loaded only to *explain* an unaffordable purchase up
/// front; the charge itself still decides, so a stale balance can never let
/// a purchase through.
class ReportPurchaseCubit extends AppCubit<ReportPurchaseState> {
  ReportPurchaseCubit({
    required String productId,
    required GetReportProduct getProduct,
    required GetBirthProfiles getProfiles,
    required PurchaseReport purchaseReport,
    required SpendingAccount wallet,
  }) : _productId = productId,
       _getProduct = getProduct,
       _getProfiles = getProfiles,
       _purchase = purchaseReport,
       _wallet = wallet,
       super(const ReportPurchaseState());

  final String _productId;
  final GetReportProduct _getProduct;
  final GetBirthProfiles _getProfiles;
  final PurchaseReport _purchase;
  final SpendingAccount _wallet;

  Future<void> load() async {
    emit(
      state.copyWith(
        product: state.product.toLoading(),
        profiles: state.profiles.toLoading(),
      ),
    );

    // Concurrently: the product and the buyer's saved charts are unrelated,
    // and awaiting them in turn doubles the wait before the page is usable.
    final (product, profiles, balance) = await (
      _getProduct(_productId),
      _getProfiles(),
      _wallet.spendable(),
    ).wait;

    emit(
      state.copyWith(
        product: product.fold(state.product.toFailed, LoadState.loaded),
        profiles: profiles.fold(state.profiles.toFailed, LoadState.loaded),
        balance: balance,
        // Most purchases are for the buyer, so preselect that profile and
        // let them change it rather than starting from nothing.
        selectedProfileId:
            state.selectedProfileId ??
            _defaultProfileId(profiles.valueOrNull ?? const []),
      ),
    );
  }

  String? _defaultProfileId(List<BirthProfile> profiles) {
    if (profiles.isEmpty) return null;
    return profiles
        .firstWhere(
          (p) => p.relation == ChartRelation.self,
          orElse: () => profiles.first,
        )
        .id;
  }

  void selectProfile(String id) =>
      emit(state.copyWith(selectedProfileId: id, purchaseError: null));

  void selectPartner(String id) =>
      emit(state.copyWith(partnerProfileId: id, purchaseError: null));

  Future<PurchasedReport?> buy() async {
    final product = state.product.dataOrNull;
    final profile = state.selectedProfile;
    if (product == null || profile == null) return null;

    emit(
      state.copyWith(purchase: state.purchase.toLoading(), purchaseError: null),
    );
    final result = await _purchase(
      ReportOrder(
        productId: product.id,
        profileId: profile.id,
        profileName: profile.name,
        partnerProfileId: state.partnerProfile?.id,
        partnerName: state.partnerProfile?.name,
      ),
    );
    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            purchase: state.purchase.toFailed(failure),
            purchaseError: failure.message,
          ),
        );
        return null;
      },
      (report) {
        emit(state.copyWith(purchase: LoadState.loaded(report)));
        return report;
      },
    );
  }
}
