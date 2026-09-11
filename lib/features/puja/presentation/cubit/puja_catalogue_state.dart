part of 'puja_catalogue_cubit.dart';

@freezed
abstract class PujaCatalogueState with _$PujaCatalogueState {
  const PujaCatalogueState._();

  const factory PujaCatalogueState({
    @Default(LoadState.idle()) LoadState<List<PujaService>> services,
    PujaPurpose? purpose,
  }) = _PujaCatalogueState;

  List<PujaService> get all => services.dataOrNull ?? const [];

  bool get isEmpty => services.isLoaded && all.isEmpty;
}
