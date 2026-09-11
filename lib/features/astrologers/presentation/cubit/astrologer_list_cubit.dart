import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/load_state.dart';
import '../../domain/entities/astrologer.dart';
import '../../domain/entities/astrologer_filter.dart';
import '../../domain/usecases/get_astrologers.dart';
import '../../domain/usecases/get_consult_languages.dart';
import '../../domain/usecases/manage_recent_searches.dart';
import '../../domain/usecases/toggle_follow_astrologer.dart';
import '../../../../core/state/app_cubit.dart';

part 'astrologer_list_cubit.freezed.dart';
part 'astrologer_list_state.dart';

/// Drives the discovery list, its search field and its filter sheet.
///
/// The sheet edits [AstrologerListState.draftFilter] and only [applyFilter]
/// promotes it to the live [AstrologerListState.filter] — so dismissing the
/// sheet discards the edits, which is what "Cancel" should mean.
class AstrologerListCubit extends AppCubit<AstrologerListState> {
  AstrologerListCubit({
    required GetAstrologers getAstrologers,
    required GetConsultLanguages getLanguages,
    required ToggleFollowAstrologer toggleFollow,
    required GetRecentSearches getRecentSearches,
    required SaveRecentSearch saveRecentSearch,
    required ClearRecentSearches clearRecentSearches,
    AstrologerFilter? initialFilter,
  }) : _getAstrologers = getAstrologers,
       _getLanguages = getLanguages,
       _toggleFollow = toggleFollow,
       _getRecentSearches = getRecentSearches,
       _saveRecentSearch = saveRecentSearch,
       _clearRecentSearches = clearRecentSearches,
       super(
         AstrologerListState(
           filter: initialFilter ?? const AstrologerFilter(),
           draftFilter: initialFilter ?? const AstrologerFilter(),
         ),
       );

  final GetAstrologers _getAstrologers;
  final GetConsultLanguages _getLanguages;
  final ToggleFollowAstrologer _toggleFollow;
  final GetRecentSearches _getRecentSearches;
  final SaveRecentSearch _saveRecentSearch;
  final ClearRecentSearches _clearRecentSearches;

  /// Debounce so typing does not fire a request per keystroke.
  static const Duration _searchDebounce = Duration(milliseconds: 300);
  Timer? _debounce;

  Future<void> load() async {
    await Future.wait([_fetch(), _loadLanguages(), _loadRecentSearches()]);
  }

  Future<void> refresh() => _fetch();

  Future<void> _fetch() async {
    emit(state.copyWith(astrologers: state.astrologers.toLoading()));
    final result = await _getAstrologers(state.filter);
    emit(
      state.copyWith(
        astrologers: result.fold(state.astrologers.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> _loadLanguages() async {
    final result = await _getLanguages();
    emit(
      state.copyWith(
        languages: result.fold(state.languages.toFailed, LoadState.loaded),
      ),
    );
  }

  Future<void> _loadRecentSearches() async {
    final result = await _getRecentSearches();
    emit(state.copyWith(recentSearches: result.valueOrNull ?? const []));
  }

  /// Live search as the user types.
  void search(String query) {
    emit(state.copyWith(filter: state.filter.copyWith(query: query)));
    _debounce?.cancel();
    _debounce = Timer(_searchDebounce, _fetch);
  }

  /// Commits a search to the recent list — call on submit, not on keystroke.
  Future<void> submitSearch(String query) async {
    _debounce?.cancel();
    await _saveRecentSearch(query);
    await Future.wait([_fetch(), _loadRecentSearches()]);
  }

  Future<void> clearRecentSearches() async {
    await _clearRecentSearches();
    emit(state.copyWith(recentSearches: const []));
  }

  void setSort(AstrologerSort sort) {
    emit(state.copyWith(filter: state.filter.copyWith(sort: sort)));
    unawaited(_fetch());
  }

  // --- Filter sheet ---------------------------------------------------

  /// Opens the sheet with the live filter as the starting draft.
  void beginFilterEdit() => emit(state.copyWith(draftFilter: state.filter));

  void updateDraft(AstrologerFilter draft) =>
      emit(state.copyWith(draftFilter: draft));

  /// Clears the narrowing filters in the draft, keeping query and sort.
  void resetDraft() =>
      emit(state.copyWith(draftFilter: state.draftFilter.cleared()));

  Future<void> applyFilter() async {
    emit(state.copyWith(filter: state.draftFilter));
    await _fetch();
  }

  // --- Row actions ----------------------------------------------------

  /// Optimistic follow toggle: the row flips immediately and reverts if the
  /// call fails, so the list never feels laggy.
  Future<void> toggleFollow(String astrologerId) async {
    final current = state.astrologers.dataOrNull;
    if (current == null) return;

    List<Astrologer> withFollow(bool following) => [
      for (final a in current)
        if (a.id == astrologerId) a.copyWith(isFollowing: following) else a,
    ];

    final wasFollowing = current
        .firstWhere((a) => a.id == astrologerId)
        .isFollowing;
    emit(
      state.copyWith(astrologers: LoadState.loaded(withFollow(!wasFollowing))),
    );

    final result = await _toggleFollow(astrologerId);
    result.fold(
      (_) => emit(
        state.copyWith(astrologers: LoadState.loaded(withFollow(wasFollowing))),
      ),
      (following) {
        emit(
          state.copyWith(astrologers: LoadState.loaded(withFollow(following))),
        );
        // On a following-only list an unfollow means the row no longer
        // belongs; refetch rather than leaving a stale card behind.
        if (!following && state.filter.followingOnly) unawaited(_fetch());
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
