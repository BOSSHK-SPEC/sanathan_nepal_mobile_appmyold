import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/report_product.dart';
import '../../domain/usecases/report_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'report_catalogue_cubit.freezed.dart';
part 'report_catalogue_state.dart';

/// The paid-report storefront.
class ReportCatalogueCubit extends AppCubit<ReportCatalogueState> {
  ReportCatalogueCubit({required GetReportCatalogue getCatalogue})
    : _get = getCatalogue,
      super(const ReportCatalogueState());

  final GetReportCatalogue _get;

  Future<void> load() async {
    emit(state.copyWith(products: state.products.toLoading()));
    final result = await _get();
    emit(
      state.copyWith(
        products: result.fold(state.products.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> refresh() => load();
}
