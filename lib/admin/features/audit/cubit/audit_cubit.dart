import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../../domain/entities/audit_entry.dart';
import '../../../domain/repositories/admin_repository.dart';

part 'audit_cubit.freezed.dart';
part 'audit_state.dart';

/// The audit log: who did what, and which request it came from.
///
/// Read-only by construction — the repository exposes no way to write or amend
/// an entry, because a log the reviewers can edit is not evidence of anything.
class AuditCubit extends AppCubit<AuditState> {
  AuditCubit(this._admin) : super(const AuditState());

  final AdminRepository _admin;

  /// The server caps this at 500.
  static const List<int> limits = [50, 100, 250, 500];

  Future<void> load() async {
    emit(state.copyWith(entries: state.entries.toLoading()));
    final result = await _admin.auditLog(limit: state.limit);
    emit(
      state.copyWith(
        entries: result.fold(state.entries.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> setLimit(int limit) async {
    if (limit == state.limit) return;
    emit(state.copyWith(limit: limit));
    await load();
  }

  /// Free-text filter over action, target and actor. Client-side because the
  /// endpoint returns a bounded page and a reviewer scanning it wants the
  /// filter to respond as they type, not per keystroke round trip.
  void setQuery(String query) => emit(state.copyWith(query: query.trim()));
}
