part of 'payout_cubit.dart';

@freezed
abstract class PayoutState with _$PayoutState {
  const PayoutState._();

  const factory PayoutState({
    /// Destinations offered in the active region.
    required List<PayoutDestination> destinations,
    @Default(LoadState.idle()) LoadState<List<PayoutRequest>> payouts,
    @Default(LoadState.idle()) LoadState<PayoutAccount> saving,
    @Default(LoadState.idle()) LoadState<PayoutRequest> withdrawing,
    PayoutAccount? account,
    @Default(false) bool accountLoaded,
    PayoutAccount? draftAccount,
    @Default(0) double availableBalance,
    double? withdrawAmount,
    @Default(<TaxDocument>[]) List<TaxDocument> taxDocuments,
    String? saveError,
    String? withdrawError,
  }) = _PayoutState;

  PayoutAccount get draft =>
      draftAccount ?? PayoutAccount(destination: destinations.first);

  List<PayoutRequest> get history => payouts.dataOrNull ?? const [];

  bool get needsAccount => accountLoaded && account == null;

  bool get isBank => draft.destination == PayoutDestination.bankAccount;

  bool get canSaveAccount =>
      draft.identifier.trim().isNotEmpty &&
      draft.holderName.trim().isNotEmpty &&
      (!isBank || draft.bankName.trim().isNotEmpty) &&
      !saving.isLoading;

  /// The button is enabled whenever an amount is entered; the amount rules
  /// themselves are enforced by the data source, which is the one authority.
  bool get canWithdraw =>
      account != null &&
      withdrawAmount != null &&
      withdrawAmount! > 0 &&
      !withdrawing.isLoading;

  double get pendingTotal => history
      .where((p) => p.isOpen)
      .fold<double>(0, (sum, p) => sum + p.amount);
}
