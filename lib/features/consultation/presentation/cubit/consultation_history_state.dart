part of 'consultation_history_cubit.dart';

@freezed
abstract class ConsultationHistoryState with _$ConsultationHistoryState {
  const ConsultationHistoryState._();

  const factory ConsultationHistoryState({
    @Default(LoadState.idle()) LoadState<List<Consultation>> sessions,
  }) = _ConsultationHistoryState;

  List<Consultation> get items => sessions.dataOrNull ?? const [];

  bool get isEmpty => sessions.isLoaded && items.isEmpty;

  /// Only completed sessions cost money, so cancelled ones are excluded
  /// from the lifetime total rather than counted as zero.
  double get totalSpent => items
      .where((c) => c.status == ConsultationStatus.completed)
      .fold<double>(0, (sum, c) => sum + c.amountCharged);

  int get totalMinutes => items.fold<int>(
    0,
    (sum, c) =>
        sum + (c.billedSeconds == 0 ? 0 : (c.billedSeconds / 60).ceil()),
  );
}
