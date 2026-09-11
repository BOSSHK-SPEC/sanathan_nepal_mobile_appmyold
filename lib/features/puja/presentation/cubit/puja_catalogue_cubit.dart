import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/puja_service.dart';
import '../../domain/usecases/puja_usecases.dart';
import '../../../../core/state/app_cubit.dart';

part 'puja_catalogue_cubit.freezed.dart';
part 'puja_catalogue_state.dart';

/// The puja catalogue, filtered by what the devotee is asking for.
class PujaCatalogueCubit extends AppCubit<PujaCatalogueState> {
  PujaCatalogueCubit({required GetPujaCatalogue getCatalogue})
    : _get = getCatalogue,
      super(const PujaCatalogueState());

  final GetPujaCatalogue _get;

  Future<void> load() async {
    emit(state.copyWith(services: state.services.toLoading()));
    final result = await _get(state.purpose);
    emit(
      state.copyWith(
        services: result.fold(state.services.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> refresh() => load();

  /// Passing the selected purpose again clears it — the chip row behaves as
  /// a toggle, which is what a single-select filter row is expected to do.
  Future<void> selectPurpose(PujaPurpose? purpose) async {
    emit(state.copyWith(purpose: purpose == state.purpose ? null : purpose));
    await load();
  }
}
