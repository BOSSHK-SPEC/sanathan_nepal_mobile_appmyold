import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../../astrologers/domain/entities/consult_channel.dart';
import '../../../consultation/domain/entities/astrologer_session.dart';
import '../../../consultation/domain/entities/consultation.dart';
import '../../../consultation/domain/usecases/consultation_usecases.dart';
import '../../data/datasources/console_seed.dart';
import '../../domain/entities/availability.dart';
import '../../domain/entities/console_stats.dart';
import '../../domain/entities/queue_entry.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'console_dashboard_cubit.freezed.dart';
part 'console_dashboard_state.dart';

/// Dashboard, online switch and the live queue.
///
/// Polls while mounted: an astrologer leaves this screen open all day, and a
/// queue that only refreshes on pull-down means missed work.
class ConsoleDashboardCubit extends AppCubit<ConsoleDashboardState> {
  ConsoleDashboardCubit({
    required GetDashboard getDashboard,
    required GetAvailability getAvailability,
    required SetOnline setOnline,
    required GetQueue getQueue,
    required GetPendingRequest getPendingRequest,
    required RespondToRequest respondToRequest,
    required AcceptFromQueue acceptFromQueue,
    required GetAstrologerSessions getSessions,
  }) : _getDashboard = getDashboard,
       _getAvailability = getAvailability,
       _setOnline = setOnline,
       _getQueue = getQueue,
       _getPending = getPendingRequest,
       _respond = respondToRequest,
       _acceptFromQueue = acceptFromQueue,
       _getSessions = getSessions,
       super(const ConsoleDashboardState());

  final GetDashboard _getDashboard;
  final GetAvailability _getAvailability;
  final SetOnline _setOnline;
  final GetQueue _getQueue;
  final GetPendingRequest _getPending;
  final RespondToRequest _respond;
  final AcceptFromQueue _acceptFromQueue;
  final GetAstrologerSessions _getSessions;

  static const Duration pollInterval = Duration(seconds: 5);

  Timer? _poller;

  Future<void> load() async {
    emit(
      state.copyWith(
        stats: state.stats.toLoading(),
        availability: state.availability.toLoading(),
      ),
    );
    final statsFuture = _getDashboard();
    final availabilityFuture = _getAvailability();
    final stats = await statsFuture;
    final availability = await availabilityFuture;

    emit(
      state.copyWith(
        stats: stats.fold(state.stats.toFailed, LoadState.loaded),
        availability: availability.fold(
          state.availability.toFailed,
          LoadState.loaded,
        ),
      ),
    );
    await _refreshQueue();
    _startPolling();
  }

  void _startPolling() {
    _poller?.cancel();
    _poller = Timer.periodic(pollInterval, (_) => _refreshQueue());
  }

  Future<void> _refreshQueue() async {
    if (isClosed) return;
    final queueResult = await _getQueue();
    if (isClosed) return;
    queueResult.fold(
      (_) {},
      (entries) => emit(state.copyWith(queue: LoadState.loaded(entries))),
    );

    await _refreshSessions();

    // Only offer a request when the astrologer is online and idle; ringing
    // someone who is mid-session is how acceptance rates get destroyed.
    if (!state.isOnline || state.pending != null) return;
    final pendingResult = await _getPending();
    if (isClosed) return;
    pendingResult.fold(
      (_) {},
      (request) => emit(state.copyWith(pending: request)),
    );
  }

  /// Consultations already running.
  ///
  /// Accepting a request removes it from the queue server-side, so once the
  /// session screen is closed — a stray back tap, a backgrounded app, a flat
  /// battery — there was nothing left anywhere that pointed at it. The
  /// astrologer could not return to a conversation the seeker was still
  /// sitting in and being charged for. This is that way back.
  Future<void> _refreshSessions() async {
    if (isClosed) return;
    final result = await _getSessions();
    if (isClosed) return;
    result.fold(
      // A failed poll leaves the last known list on screen rather than
      // blanking a session the astrologer is about to tap.
      (failure) => emit(state.copyWith(sessions: state.sessions.toFailed(failure))),
      (sessions) => emit(state.copyWith(sessions: LoadState.loaded(sessions))),
    );
  }

  /// Flips the online switch.
  ///
  /// A second tap while the first is in flight is dropped: two racing calls
  /// can land in either order, leaving the switch showing the opposite of
  /// what the server actually stored.
  Future<void> toggleOnline() async {
    if (state.togglingOnline) return;
    final target = !state.isOnline;
    emit(state.copyWith(togglingOnline: true));

    final result = await _setOnline(target);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          togglingOnline: false,
          // `toFailed` keeps the last good value as `previous`, so the switch
          // falls back to what the server last confirmed rather than to
          // "offline", which would show a state nobody has stored.
          availability: state.availability.toFailed(failure),
        ),
      ),
      (availability) {
        emit(
          state.copyWith(
            togglingOnline: false,
            availability: LoadState.loaded(availability),
            pending: null,
            queue: const LoadState.idle(),
          ),
        );
        unawaited(_refreshQueue());
      },
    );
  }

  /// Re-reads availability on its own.
  ///
  /// Separate from [refresh] so the online card's Retry does not also pull
  /// the dashboard numbers and the queue: the astrologer is trying to get
  /// online, and a full reload puts a spinner over the entire screen to fix
  /// one card.
  Future<void> retryAvailability() async {
    emit(state.copyWith(availability: state.availability.toLoading()));
    final result = await _getAvailability();
    if (isClosed) return;
    emit(
      state.copyWith(
        availability: result.fold(
          state.availability.toFailed,
          LoadState.loaded,
        ),
      ),
    );
  }

  /// Responds to the offered request.
  ///
  /// On accept it also opens the session and returns its id, so the caller
  /// can route straight into the console — an accept that only dismisses a
  /// sheet leaves the seeker waiting in a room nobody entered.
  Future<String?> respond({required bool accept}) async {
    final request = state.pending;
    if (request == null) return null;
    emit(state.copyWith(pending: null));

    await _respond(RespondParams(requestId: request.entry.id, accept: accept));
    if (!accept) {
      await _refreshQueue();
      return null;
    }

    final entry = request.entry;
    final result = await _acceptFromQueue(
      QueueAcceptRequest(
        queueEntryId: entry.id,
        seekerName: entry.seekerName,
        channel: entry.channel,
        ratePerMinute: state.rateFor(entry.channel),
        question: entry.question,
      ),
    );
    await _refreshQueue();
    return result.valueOrNull?.id;
  }

  Future<void> refresh() async {
    final result = await _getDashboard();
    // A pull-to-refresh that fails must say so. The queue poller below stays
    // silent on purpose — it retries in seconds, and a flash of red every
    // time a phone changes cell tower would be noise, not information.
    emit(
      state.copyWith(
        stats: result.fold(state.stats.toFailed, LoadState.loaded),
      ),
    );
    await _refreshQueue();
  }

  @override
  Future<void> close() {
    _poller?.cancel();
    return super.close();
  }
}
