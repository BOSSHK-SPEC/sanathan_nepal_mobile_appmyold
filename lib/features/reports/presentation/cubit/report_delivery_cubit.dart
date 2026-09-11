import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/purchased_report.dart';
import '../../domain/usecases/report_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'report_delivery_cubit.freezed.dart';
part 'report_delivery_state.dart';

/// Watches one purchased report until it is delivered.
class ReportDeliveryCubit extends AppCubit<ReportDeliveryState> {
  ReportDeliveryCubit({
    required String reportId,
    required GetPurchasedReport getReport,
  }) : _reportId = reportId,
       _get = getReport,
       super(const ReportDeliveryState());

  final String _reportId;
  final GetPurchasedReport _get;

  static const Duration _pollInterval = Duration(seconds: 3);
  Timer? _poll;

  Future<void> load() async {
    emit(state.copyWith(report: state.report.toLoading()));
    await _fetch();
  }

  Future<void> _fetch() async {
    final result = await _get(_reportId);
    emit(
      state.copyWith(
        report: result.fold(state.report.toFailed, LoadState.loaded),
      ),
    );
    // Polling stops the moment the report lands, so a delivered report does
    // not keep waking the app up.
    if (state.report.dataOrNull?.isGenerating ?? false) {
      _poll ??= Timer.periodic(_pollInterval, (_) => _fetch());
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
