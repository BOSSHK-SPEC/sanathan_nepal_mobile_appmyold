part of 'compliance_cubit.dart';

@freezed
abstract class ComplianceState with _$ComplianceState {
  const ComplianceState._();

  const factory ComplianceState({
    @Default(LoadState.idle()) LoadState<List<ComplianceNotice>> notices,

    /// The notice a request is in flight for, so only its row shows a spinner.
    String? busyNoticeId,
    String? actionError,
  }) = _ComplianceState;

  List<ComplianceNotice> get all => notices.dataOrNull ?? const [];

  List<ComplianceNotice> get open => all.where((n) => n.isOpen).toList();

  List<ComplianceNotice> get past => all.where((n) => !n.isOpen).toList();

  /// Drives the dashboard badge.
  int get openCount => open.length;

  bool get hasCritical =>
      open.any((n) => n.severity == ComplianceSeverity.critical);

  bool get isEmpty => notices.isLoaded && all.isEmpty;
}
