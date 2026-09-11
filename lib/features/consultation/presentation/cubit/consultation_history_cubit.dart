import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/consultation.dart';
import '../../domain/usecases/consultation_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'consultation_history_cubit.freezed.dart';
part 'consultation_history_state.dart';

/// Past consultations, newest first.
class ConsultationHistoryCubit extends AppCubit<ConsultationHistoryState> {
  ConsultationHistoryCubit({required GetConsultationHistory getHistory})
    : _getHistory = getHistory,
      super(const ConsultationHistoryState());

  final GetConsultationHistory _getHistory;

  Future<void> load() async {
    emit(state.copyWith(sessions: state.sessions.toLoading()));
    final result = await _getHistory();
    emit(
      state.copyWith(
        sessions: result.fold(state.sessions.toFailed, LoadState.loaded),
      ),
    );
  }
}
