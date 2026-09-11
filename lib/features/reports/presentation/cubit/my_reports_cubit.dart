import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/purchased_report.dart';
import '../../domain/usecases/report_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'my_reports_cubit.freezed.dart';
part 'my_reports_state.dart';

/// The buyer's report library.
class MyReportsCubit extends AppCubit<MyReportsState> {
  MyReportsCubit({required GetMyReports getMyReports})
    : _get = getMyReports,
      super(const MyReportsState());

  final GetMyReports _get;

  /// Reports finish on a clock, so while any is generating the list polls.
  /// Cheap here, and it means a finished PDF appears without a pull.
  static const Duration _pollInterval = Duration(seconds: 5);
  Timer? _poll;

  Future<void> load() async {
    emit(state.copyWith(reports: state.reports.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        reports: result.fold(state.reports.toFailed, LoadState.loaded),
      ),
    );
    _syncPolling();
  }

  Future<void> refresh() async {
    final result = await _get();
    emit(
      state.copyWith(
        reports: result.fold(state.reports.toFailed, LoadState.loaded),
      ),
    );
    _syncPolling();
  }

  void _syncPolling() {
    if (state.hasGenerating) {
      _poll ??= Timer.periodic(_pollInterval, (_) => refresh());
    } else {
      _poll?.cancel();
      _poll = null;
    }
  }

  @override
  Future<void> close() {
    _poll?.cancel();
    return super.close();
  }
}
