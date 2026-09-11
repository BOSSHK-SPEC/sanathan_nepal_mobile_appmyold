import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../../domain/entities/abuse_report.dart';
import '../../../domain/repositories/admin_repository.dart';

part 'moderation_cubit.freezed.dart';
part 'moderation_state.dart';

/// Abuse reports, open and closed.
class ModerationCubit extends AppCubit<ModerationState> {
  ModerationCubit(this._admin) : super(const ModerationState());

  final AdminRepository _admin;

  Future<void> load() async {
    emit(state.copyWith(reports: state.reports.toLoading()));
    final result = await _admin.reports(resolved: state.showResolved);
    emit(
      state.copyWith(
        reports: result.fold(state.reports.toFailed, LoadState.loaded),
      ),
    );
  }

  /// Open and resolved are two different server queries, not a client filter.
  Future<void> setShowResolved(bool resolved) async {
    if (resolved == state.showResolved) return;
    emit(state.copyWith(showResolved: resolved));
    await load();
  }

  Future<void> resolve(String reportId) async {
    emit(state.copyWith(resolvingId: reportId, actionError: null));
    final result = await _admin.resolveReport(reportId);

    await result.fold(
      (failure) async =>
          emit(state.copyWith(resolvingId: null, actionError: failure.message)),
      (_) async {
        emit(state.copyWith(resolvingId: null));
        await load();
      },
    );
  }
}
