part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    /// Current wall-clock time (ticks periodically).
    required DateTime now,
    @Default(LoadState.idle()) LoadState<MetalRates> metalRates,
  }) = _HomeState;
}
