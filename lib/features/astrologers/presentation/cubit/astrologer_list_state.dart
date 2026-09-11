part of 'astrologer_list_cubit.dart';

@freezed
abstract class AstrologerListState with _$AstrologerListState {
  const AstrologerListState._();

  const factory AstrologerListState({
    @Default(LoadState.idle()) LoadState<List<Astrologer>> astrologers,
    @Default(LoadState.idle()) LoadState<List<String>> languages,

    /// Applied to the list.
    @Default(AstrologerFilter()) AstrologerFilter filter,

    /// Being edited in the filter sheet; discarded unless applied.
    @Default(AstrologerFilter()) AstrologerFilter draftFilter,
    @Default(<String>[]) List<String> recentSearches,
  }) = _AstrologerListState;

  List<Astrologer> get results => astrologers.dataOrNull ?? const [];

  bool get isSearching => filter.query.trim().isNotEmpty;

  /// True only when a *completed* load returned nothing — so the empty state
  /// never flashes while the first request is still in flight.
  bool get isEmpty => astrologers.isLoaded && results.isEmpty;

  int get onlineCount => results.where((a) => a.isOnline).length;
}
