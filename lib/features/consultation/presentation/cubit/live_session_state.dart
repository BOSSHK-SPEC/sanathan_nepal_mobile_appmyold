part of 'live_session_cubit.dart';

@freezed
abstract class LiveSessionState with _$LiveSessionState {
  const LiveSessionState._();

  const factory LiveSessionState({
    @Default(LoadState.idle()) LoadState<Consultation> session,
    @Default(LoadState.idle()) LoadState<List<ChatMessage>> messages,
    @Default(LoadState.idle()) LoadState<Consultation> ending,

    /// Spendable wallet balance, refreshed when the session loads.
    @Default(0) double balance,

    /// Incremented once a second while active, purely to drive the meter's
    /// rebuild — the elapsed time itself is derived from timestamps.
    @Default(0) int tick,
    @Default('') String draft,
    @Default(false) bool muted,
    @Default(true) bool speakerOn,
    @Default(true) bool cameraOn,
  }) = _LiveSessionState;

  Consultation? get consultation => session.dataOrNull;

  List<ChatMessage> get chat => messages.dataOrNull ?? const [];

  /// Why ending failed, when it did.
  ///
  /// This was written to state and read by nobody: a failed end left the user
  /// tapping a button that confirmed, did nothing, and said nothing. Whatever
  /// the reason, they are owed a sentence.
  String? get endError => ending.failureOrNull?.message;

  /// True while the end request is in flight, so the button can show it.
  bool get isEnding => ending.isLoading;

  /// Whether the chat is genuinely still loading.
  ///
  /// Not the same as "the chat is empty": a consultation that has just been
  /// accepted has no messages yet, and that is the normal starting state. Both
  /// screens used to render a spinner whenever the list was empty, so a fresh
  /// session sat loading forever until somebody happened to send something.
  bool get isLoadingChat => chat.isEmpty && !messages.isLoaded && !messages.isFailed;

  /// Loaded, and there is nothing to show — invite the first message instead.
  bool get hasNoMessagesYet => chat.isEmpty && messages.isLoaded;

  /// The chat could not be fetched, and we have nothing cached to fall back on.
  String? get chatError => chat.isEmpty ? messages.failureOrNull?.message : null;


  bool get isQueued => consultation?.status == ConsultationStatus.queued;

  bool get isRinging => consultation?.status == ConsultationStatus.ringing;

  bool get isActive => consultation?.status == ConsultationStatus.active;

  bool get isOver => consultation?.status.isOver ?? false;

  int get elapsedSeconds => consultation?.elapsedSeconds() ?? 0;

  /// "12:04" — the live meter.
  String get elapsedLabel {
    final seconds = elapsedSeconds;
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  double get costSoFar => consultation?.costSoFar() ?? 0;

  double get remainingBalance => (balance - costSoFar).clamp(0, balance);

  /// Whole minutes still affordable at the session's rate.
  int get remainingMinutes {
    final rate = consultation?.ratePerMinute ?? 0;
    return rate <= 0 ? 0 : (remainingBalance / rate).floor();
  }

  /// Warn while there is still time to act, not once the money is gone.
  bool get isLowBalance =>
      isActive && remainingMinutes <= LiveSessionCubit.lowBalanceMinutes;

  bool get isOutOfBalance => isActive && remainingMinutes <= 0;

  bool get canSend => isActive && !isOutOfBalance && draft.trim().isNotEmpty;

  /// Rough wait while queued, at the mock's queue-drain rate.
  int get estimatedWaitMinutes {
    final position = consultation?.queuePosition ?? 0;
    return position == 0 ? 0 : (position * 6 / 60).ceil();
  }
}
