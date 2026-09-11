import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/compliance_notice.dart';
import '../../domain/usecases/console_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'compliance_cubit.freezed.dart';
part 'compliance_state.dart';

/// Warnings, penalties and policy notices.
class ComplianceCubit extends AppCubit<ComplianceState> {
  ComplianceCubit({
    required GetComplianceNotices getNotices,
    required AcknowledgeNotice acknowledge,
    required AppealNotice appeal,
  }) : _get = getNotices,
       _acknowledge = acknowledge,
       _appeal = appeal,
       super(const ComplianceState());

  final GetComplianceNotices _get;
  final AcknowledgeNotice _acknowledge;
  final AppealNotice _appeal;

  Future<void> load() async {
    emit(state.copyWith(notices: state.notices.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        notices: result.fold(state.notices.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> refresh() => load();

  Future<void> acknowledge(String noticeId) async {
    emit(state.copyWith(busyNoticeId: noticeId, actionError: null));
    final result = await _acknowledge(noticeId);
    _applyResult(result.fold((f) => f.message, (n) => n));
  }

  Future<bool> appeal(String noticeId, String reason) async {
    emit(state.copyWith(busyNoticeId: noticeId, actionError: null));
    final result = await _appeal(
      AppealNoticeParams(noticeId: noticeId, reason: reason),
    );
    return result.fold(
      (failure) {
        _applyResult(failure.message);
        return false;
      },
      (notice) {
        _applyResult(notice);
        return true;
      },
    );
  }

  /// Replaces the one changed notice in place rather than refetching — the
  /// list keeps its scroll position and the rest of the rows do not flicker.
  void _applyResult(Object outcome) {
    if (outcome is String) {
      emit(state.copyWith(busyNoticeId: null, actionError: outcome));
      return;
    }
    final updated = outcome as ComplianceNotice;
    emit(
      state.copyWith(
        busyNoticeId: null,
        notices: LoadState.loaded([
          for (final n in state.all)
            if (n.id == updated.id) updated else n,
        ]),
      ),
    );
  }
}
