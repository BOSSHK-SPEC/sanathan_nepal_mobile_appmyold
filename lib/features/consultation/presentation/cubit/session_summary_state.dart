part of 'session_summary_cubit.dart';

@freezed
abstract class SessionSummaryState with _$SessionSummaryState {
  const SessionSummaryState._();

  const factory SessionSummaryState({
    @Default(LoadState.idle()) LoadState<Consultation> session,
    @Default(LoadState.idle()) LoadState<SessionSummary> summary,
  }) = _SessionSummaryState;

  Consultation? get consultation => session.dataOrNull;

  SessionSummary? get notes => summary.dataOrNull;

  /// Notes are written by the astrologer after the call, so an empty
  /// summary is a normal "not yet", not a failure.
  bool get isAwaitingNotes => summary.isLoaded && (notes?.isEmpty ?? true);
}
