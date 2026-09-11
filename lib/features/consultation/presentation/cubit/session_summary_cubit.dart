import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/entities/session_summary.dart';
import '../../domain/usecases/consultation_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'session_summary_cubit.freezed.dart';
part 'session_summary_state.dart';

/// Post-session screen: receipt, the astrologer's notes and remedies.
class SessionSummaryCubit extends AppCubit<SessionSummaryState> {
  SessionSummaryCubit({
    required String consultationId,
    required GetConsultation getConsultation,
    required GetSessionSummary getSummary,
  }) : _id = consultationId,
       _get = getConsultation,
       _getSummary = getSummary,
       super(const SessionSummaryState());

  final String _id;
  final GetConsultation _get;
  final GetSessionSummary _getSummary;

  Future<void> load() async {
    emit(
      state.copyWith(
        session: state.session.toLoading(),
        summary: state.summary.toLoading(),
      ),
    );
    final sessionFuture = _get(_id);
    final summaryFuture = _getSummary(_id);
    final session = await sessionFuture;
    final summary = await summaryFuture;
    emit(
      state.copyWith(
        session: session.fold(state.session.toFailed, LoadState.loaded),
        summary: summary.fold(state.summary.toFailed, LoadState.loaded),
      ),
    );
  }
}
