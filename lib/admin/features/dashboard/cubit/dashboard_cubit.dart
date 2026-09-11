import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/app_cubit.dart';
import '../../../../core/state/load_state.dart';
import '../../../domain/entities/financial_summary.dart';
import '../../../domain/repositories/admin_repository.dart';

part 'dashboard_cubit.freezed.dart';
part 'dashboard_state.dart';

/// The finance overview.
///
/// Changing the window refetches rather than slicing a cached total: the server
/// aggregates over the period, and pretending a 7-day figure can be derived
/// from a 30-day one on the client is how a dashboard starts lying.
class DashboardCubit extends AppCubit<DashboardState> {
  DashboardCubit(this._admin) : super(const DashboardState());

  final AdminRepository _admin;

  /// Windows offered in the UI, in days.
  static const List<int> windows = [7, 30, 90, 365];

  Future<void> load() async {
    emit(state.copyWith(summary: state.summary.toLoading()));
    final result = await _admin.financialSummary(days: state.days);
    emit(
      state.copyWith(
        summary: result.fold(state.summary.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> setWindow(int days) async {
    if (days == state.days) return;
    // The previous figures stay on screen while the new window loads — a
    // dashboard that blanks on every filter change is unreadable to compare.
    emit(state.copyWith(days: days));
    await load();
  }
}
