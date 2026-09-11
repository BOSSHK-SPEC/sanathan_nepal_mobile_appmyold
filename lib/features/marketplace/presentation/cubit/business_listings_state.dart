part of 'business_listings_cubit.dart';

@freezed
abstract class BusinessListingsState with _$BusinessListingsState {
  const BusinessListingsState._();

  const factory BusinessListingsState({
    @Default(LoadState<List<Product>>.idle()) LoadState<List<Product>> listings,
    @Default(LoadState<String>.idle()) LoadState<String> deletion,
  }) = _BusinessListingsState;

  List<Product> get all => listings.dataOrNull ?? const [];

  List<Product> get products => [
    for (final p in all)
      if (!p.isService) p,
  ];

  List<Product> get services => [
    for (final p in all)
      if (p.isService) p,
  ];
}
