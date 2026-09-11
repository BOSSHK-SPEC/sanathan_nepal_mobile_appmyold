part of 'clients_cubit.dart';

/// Ordering on the client list.
enum ClientSort { recent, value, sessions }

@freezed
abstract class ClientsState with _$ClientsState {
  const ClientsState._();

  const factory ClientsState({
    @Default(LoadState.idle()) LoadState<List<AstrologerClient>> clients,
    @Default('') String query,
    @Default(ClientSort.recent) ClientSort sort,
  }) = _ClientsState;

  List<AstrologerClient> get all => clients.dataOrNull ?? const [];

  /// Filtered and sorted in the state rather than the cubit, so typing does
  /// not need a round trip to the data source for a list this size.
  List<AstrologerClient> get visible {
    final q = query.trim().toLowerCase();
    final filtered = q.isEmpty
        ? [...all]
        : all.where((c) => c.name.toLowerCase().contains(q)).toList();

    switch (sort) {
      case ClientSort.recent:
        filtered.sort((a, b) => b.lastSessionAt.compareTo(a.lastSessionAt));
      case ClientSort.value:
        filtered.sort((a, b) => b.lifetimeValue.compareTo(a.lifetimeValue));
      case ClientSort.sessions:
        filtered.sort((a, b) => b.sessionCount.compareTo(a.sessionCount));
    }
    return filtered;
  }

  bool get isEmpty => clients.isLoaded && all.isEmpty;

  int get repeatCount => all.where((c) => c.isRepeat).length;

  double get lifetimeValue =>
      all.fold<double>(0, (sum, c) => sum + c.lifetimeValue);
}
