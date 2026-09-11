part of 'report_purchase_cubit.dart';

@freezed
abstract class ReportPurchaseState with _$ReportPurchaseState {
  const ReportPurchaseState._();

  const factory ReportPurchaseState({
    @Default(LoadState.idle()) LoadState<ReportProduct> product,
    @Default(LoadState.idle()) LoadState<List<BirthProfile>> profiles,
    @Default(LoadState.idle()) LoadState<PurchasedReport> purchase,
    @Default(0) double balance,
    String? selectedProfileId,
    String? partnerProfileId,
    String? purchaseError,
  }) = _ReportPurchaseState;

  List<BirthProfile> get allProfiles => profiles.dataOrNull ?? const [];

  BirthProfile? get selectedProfile => _profileById(selectedProfileId);

  BirthProfile? get partnerProfile => _profileById(partnerProfileId);

  BirthProfile? _profileById(String? id) {
    if (id == null) return null;
    for (final p in allProfiles) {
      if (p.id == id) return p;
    }
    return null;
  }

  double get price => product.dataOrNull?.price ?? 0;

  bool get needsPartner => product.dataOrNull?.needsSecondProfile ?? false;

  bool get canAfford => balance >= price;

  /// Everything the purchase needs is chosen. Affordability is shown but not
  /// enforced here — the wallet decides, and blocking the button on a stale
  /// balance would strand a user who just topped up.
  bool get isComplete =>
      selectedProfile != null && (!needsPartner || partnerProfile != null);

  bool get isBuying => purchase.isLoading;
}
