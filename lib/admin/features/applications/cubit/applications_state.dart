part of 'applications_cubit.dart';

@freezed
abstract class ApplicationsState with _$ApplicationsState {
  const ApplicationsState._();

  const factory ApplicationsState({
    @Default(LoadState<List<AstrologerApplication>>.idle())
    LoadState<List<AstrologerApplication>> applications,

    /// The row currently being decided, so only its buttons show a spinner
    /// while the rest of the queue stays usable.
    String? decidingId,

    /// A decision that failed. Separate from the list's own failure: the queue
    /// on screen is still valid, only the action was refused.
    String? decisionError,
  }) = _ApplicationsState;

  List<AstrologerApplication> get items => applications.dataOrNull ?? const [];

  /// Still awaiting a decision — what the queue is actually for.
  List<AstrologerApplication> get pending => [
    for (final a in items)
      if (!a.status.isDecided) a,
  ];

  bool isDeciding(String id) => decidingId == id;
}
