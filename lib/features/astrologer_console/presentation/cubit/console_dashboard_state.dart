part of 'console_dashboard_cubit.dart';

/// What stands between the astrologer and the online switch.
///
/// An enum rather than a bare `canGoOnline` because the three reasons need
/// three different things said — and two of them need an action offered, not
/// just an explanation.
enum OnlineBlocker {
  /// Nothing — the switch works.
  none,

  /// Availability has not arrived yet.
  loading,

  /// Availability could not be read. Retrying is the fix, not scheduling.
  unavailable,

  /// Read fine, and there are no windows in it.
  noSchedule,
}

@freezed
abstract class ConsoleDashboardState with _$ConsoleDashboardState {
  const ConsoleDashboardState._();

  const factory ConsoleDashboardState({
    @Default(LoadState.idle()) LoadState<DashboardStats> stats,
    @Default(LoadState.idle()) LoadState<Availability> availability,
    @Default(LoadState.idle()) LoadState<List<QueueEntry>> queue,
    @Default(LoadState.idle()) LoadState<List<Consultation>> sessions,

    /// The request being offered right now, if any.
    IncomingRequest? pending,

    /// A go-online request is in flight, so the switch shows progress instead
    /// of sitting on the old value while the server decides.
    @Default(false) bool togglingOnline,
  }) = _ConsoleDashboardState;

  DashboardStats get metrics => stats.dataOrNull ?? const DashboardStats();

  Availability get schedule => availability.dataOrNull ?? const Availability();

  bool get isOnline => schedule.isOnline;

  List<QueueEntry> get waiting => queue.dataOrNull ?? const [];

  /// Why the online switch is unavailable, when it is.
  ///
  /// Split out because a failed availability load and a genuinely empty
  /// schedule both leave [schedule] at its empty default, and the screen used
  /// to blame the second for the first — telling an astrologer whose request
  /// had just been refused to "set your schedule first", which sends them to
  /// a screen where everything already looks correct.
  OnlineBlocker get onlineBlocker {
    if (availability.isFailed) return OnlineBlocker.unavailable;
    if (availability.isLoading || availability.isIdle) {
      return OnlineBlocker.loading;
    }
    if (!schedule.hasSchedule) return OnlineBlocker.noSchedule;
    return OnlineBlocker.none;
  }

  /// Going online requires a loaded availability with a schedule in it.
  bool get canGoOnline =>
      onlineBlocker == OnlineBlocker.none && !togglingOnline;

  /// The astrologer's own per-minute rate for a channel.
  ///
  /// Falls back to the seeded chat rate rather than zero: a session opened
  /// at zero would be free, which is a worse failure than a stale price.
  double rateFor(ConsultChannel channel) =>
      ConsoleSeed.pricing.rateFor(channel) ?? 25;

  /// Consultations that are running right now, newest first.
  ///
  /// Only `active` ones: a completed session belongs in history, and offering
  /// a way back into it would be a door onto a closed conversation.
  List<Consultation> get liveSessions => [
    for (final session in sessions.dataOrNull ?? const <Consultation>[])
      if (session.status == ConsultationStatus.active) session,
  ]..sort((a, b) => (b.startedAt ?? DateTime(0)).compareTo(a.startedAt ?? DateTime(0)));

  bool get hasLiveSessions => liveSessions.isNotEmpty;
}
