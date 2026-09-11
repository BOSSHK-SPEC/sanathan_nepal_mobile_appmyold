part of 'my_reports_cubit.dart';

@freezed
abstract class MyReportsState with _$MyReportsState {
  const MyReportsState._();

  const factory MyReportsState({
    @Default(LoadState.idle()) LoadState<List<PurchasedReport>> reports,
  }) = _MyReportsState;

  List<PurchasedReport> get all => reports.dataOrNull ?? const [];

  bool get hasGenerating => all.any((r) => r.isGenerating);

  bool get isEmpty => reports.isLoaded && all.isEmpty;
}
