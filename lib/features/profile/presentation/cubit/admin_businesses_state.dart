part of 'admin_businesses_cubit.dart';

/// State of the admin business-approvals page.
@freezed
abstract class AdminBusinessesState with _$AdminBusinessesState {
  const AdminBusinessesState._();

  const factory AdminBusinessesState({
    @Default(LoadState.idle()) LoadState<List<BusinessProfile>> businesses,

    /// Active status filter; `null` = all listings.
    @Default(BusinessStatus.pending) BusinessStatus? filter,
  }) = _AdminBusinessesState;

  /// Listings matching [filter] (empty until loaded).
  List<BusinessProfile> get visible {
    final all = businesses.dataOrNull ?? const [];
    final f = filter;
    return f == null ? all : all.where((b) => b.status == f).toList();
  }

  /// Number of listings per status (for the filter chips).
  int countFor(BusinessStatus? status) => status == null
      ? (businesses.dataOrNull?.length ?? 0)
      : (businesses.dataOrNull?.where((b) => b.status == status).length ?? 0);
}
