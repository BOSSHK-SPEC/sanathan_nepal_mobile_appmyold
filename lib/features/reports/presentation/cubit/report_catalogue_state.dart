part of 'report_catalogue_cubit.dart';

@freezed
abstract class ReportCatalogueState with _$ReportCatalogueState {
  const ReportCatalogueState._();

  const factory ReportCatalogueState({
    @Default(LoadState.idle()) LoadState<List<ReportProduct>> products,
  }) = _ReportCatalogueState;

  List<ReportProduct> get all => products.dataOrNull ?? const [];

  bool get isEmpty => products.isLoaded && all.isEmpty;
}
