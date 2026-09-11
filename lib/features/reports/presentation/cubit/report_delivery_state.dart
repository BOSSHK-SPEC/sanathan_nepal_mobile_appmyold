part of 'report_delivery_cubit.dart';

@freezed
abstract class ReportDeliveryState with _$ReportDeliveryState {
  const ReportDeliveryState._();

  const factory ReportDeliveryState({
    @Default(LoadState.idle()) LoadState<PurchasedReport> report,
  }) = _ReportDeliveryState;

  bool get isGenerating => report.dataOrNull?.isGenerating ?? false;
}
