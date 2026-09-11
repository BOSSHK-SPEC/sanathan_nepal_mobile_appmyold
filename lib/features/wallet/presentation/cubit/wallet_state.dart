part of 'wallet_cubit.dart';

@freezed
abstract class WalletState with _$WalletState {
  const WalletState._();

  const factory WalletState({
    @Default(LoadState.idle()) LoadState<WalletBalance> balance,
    @Default(LoadState.idle()) LoadState<List<TopUpOption>> options,
  }) = _WalletState;

  WalletBalance get wallet => balance.dataOrNull ?? const WalletBalance();

  List<TopUpOption> get topUpOptions => options.dataOrNull ?? const [];

  /// True only once a load has completed, so the "add money" empty state
  /// never flashes over a balance that is still arriving.
  bool get isEmptyWallet => balance.isLoaded && wallet.isEmpty;
}
