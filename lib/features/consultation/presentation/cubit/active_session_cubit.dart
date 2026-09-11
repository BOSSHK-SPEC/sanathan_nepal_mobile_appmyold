import 'dart:async';

import '../../domain/entities/consultation.dart';
import '../../domain/usecases/consultation_usecases.dart';
import '../../../../core/state/app_cubit.dart';

/// Manages the live consultation session state for the active call bar.
///
/// Executes on-demand checks when requested (e.g. app launch, starting/ending calls)
/// rather than background polling, preventing unnecessary network traffic.
class ActiveSessionCubit extends AppCubit<Consultation?> {
  ActiveSessionCubit({required GetActiveSession getActiveSession})
    : _get = getActiveSession,
      super(null);

  final GetActiveSession _get;

  /// Redraws the UI elapsed time locally when an active call is present, without making network requests.
  static const Duration tickInterval = Duration(seconds: 1);

  Timer? _ticker;

  /// On-demand check for active session (e.g., app load or user refresh).
  void start() {
    check();
  }

  /// Refreshes active session state on demand.
  Future<void> check() async {
    if (isClosed) return;
    final result = await _get();
    if (isClosed) return;
    result.fold((_) => _updateSession(null), _updateSession);
  }

  void _updateSession(Consultation? session) {
    emit(session);
    _syncTicker(session);
  }

  void _syncTicker(Consultation? session) {
    _ticker?.cancel();
    if (session != null) {
      _ticker = Timer.periodic(tickInterval, (_) {
        if (isClosed || state == null) {
          _ticker?.cancel();
          return;
        }
        // Re-emit updated elapsed time for UI meter without making HTTP calls
        emit(state!.copyWith(billedSeconds: state!.elapsedSeconds()));
      });
    }
  }

  /// Manually clears active session (e.g., call ended/cancelled).
  void clearSession() {
    _updateSession(null);
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
