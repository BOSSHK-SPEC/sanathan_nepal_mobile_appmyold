part of 'consult_intake_cubit.dart';

@freezed
abstract class ConsultIntakeState with _$ConsultIntakeState {
  const ConsultIntakeState._();

  const factory ConsultIntakeState({
    required ConsultIntake intake,
    @Default(LoadState.idle()) LoadState<Astrologer> astrologer,
    @Default(LoadState.idle()) LoadState<Consultation> starting,
    @Default(0) double balance,
  }) = _ConsultIntakeState;

  Astrologer? get provider => astrologer.dataOrNull;

  double get ratePerMinute => provider?.rateFor(intake.channel) ?? 0;

  /// Whole minutes the current balance buys at the selected channel's rate —
  /// the number that tells the seeker whether to top up first.
  int get affordableMinutes =>
      ratePerMinute <= 0 ? 0 : (balance / ratePerMinute).floor();

  /// One chargeable minute is the minimum to begin.
  bool get hasEnoughBalance => ratePerMinute > 0 && balance >= ratePerMinute;

  bool get canStart =>
      intake.isValid && hasEnoughBalance && !starting.isLoading;
}
