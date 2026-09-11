part of 'marketplace_cubit.dart';

/// Top-level tabs under the category chips.
enum MarketplaceTab { boosted, boost, myProducts }

/// "Recent | Recommendation" feed toggle.
enum FeedTab { recent, recommendation }

@freezed
abstract class MarketplaceState with _$MarketplaceState {
  const MarketplaceState._();

  const factory MarketplaceState({
    @Default(MarketplaceTab.boosted) MarketplaceTab tab,
    @Default(FeedTab.recent) FeedTab feedTab,
    @Default(MarketplaceState.allCategoryId) String selectedCategoryId,
    @Default(LoadState.idle()) LoadState<List<Category>> categories,
    @Default(LoadState.idle()) LoadState<List<Product>> boosted,
    @Default(LoadState.idle()) LoadState<List<Product>> myProducts,
    @Default(LoadState.idle()) LoadState<List<Product>> recent,
    @Default(LoadState.idle()) LoadState<List<Product>> recommended,

    /// Last "delete my product" outcome (loaded = id of the removed listing).
    @Default(LoadState.idle()) LoadState<String> deletion,
  }) = _MarketplaceState;

  static const String allCategoryId = 'all';

  /// The feed slice selected by [feedTab].
  LoadState<List<Product>> get feed =>
      feedTab == FeedTab.recent ? recent : recommended;
}
