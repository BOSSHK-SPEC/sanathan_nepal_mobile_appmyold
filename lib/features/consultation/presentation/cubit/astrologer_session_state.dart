part of 'astrologer_session_cubit.dart';

@freezed
abstract class AstrologerSessionState with _$AstrologerSessionState {
  const AstrologerSessionState._();

  const factory AstrologerSessionState({
    @Default(LoadState.idle()) LoadState<Consultation> session,
    @Default(LoadState.idle()) LoadState<List<ChatMessage>> messages,
    @Default(LoadState.idle()) LoadState<Consultation> ending,
    @Default(LoadState.idle()) LoadState<SessionSummary> savingNotes,
    @Default(0) int tick,
    @Default('') String draft,

    /// Local call controls. No media stack yet, so these only drive the UI;
    /// they are here rather than in the widget so state survives a rebuild
    /// and a rotation mid-call.
    @Default(false) bool muted,
    @Default(true) bool speakerOn,
    @Default(true) bool cameraOn,
    @Default('') String notes,
    @Default(<Remedy>[]) List<Remedy> remedies,
  }) = _AstrologerSessionState;

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


  bool get isActive => consultation?.status == ConsultationStatus.active;

  bool get isOver => consultation?.status.isOver ?? false;

  int get elapsedSeconds => consultation?.elapsedSeconds() ?? 0;

  String get elapsedLabel {
    final seconds = elapsedSeconds;
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  /// What the astrologer has earned so far, gross of commission.
  double get grossSoFar => consultation?.costSoFar() ?? 0;

  bool get canSend => isActive && draft.trim().isNotEmpty;

  /// Mirrors the data source: enough prose, or at least one remedy.
  bool get canSaveNotes =>
      (notes.trim().length >= 20 || remedies.isNotEmpty) &&
      !savingNotes.isLoading;
}
