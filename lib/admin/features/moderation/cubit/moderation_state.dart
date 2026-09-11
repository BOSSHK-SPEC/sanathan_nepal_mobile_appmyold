part of 'moderation_cubit.dart';

@freezed
abstract class ModerationState with _$ModerationState {
  const ModerationState._();

  const factory ModerationState({
    @Default(false) bool showResolved,
    @Default(LoadState<List<AbuseReport>>.idle())
    LoadState<List<AbuseReport>> reports,
    String? resolvingId,
    String? actionError,
  }) = _ModerationState;

  List<AbuseReport> get items => reports.dataOrNull ?? const [];

  bool isResolving(String id) => resolvingId == id;

  /// Reports grouped by what they are about, so a moderator can work one kind
  /// of target at a time instead of context-switching down a mixed list.
  Map<String, List<AbuseReport>> get byTarget {
    final grouped = <String, List<AbuseReport>>{};
    for (final report in items) {
      grouped.putIfAbsent(report.targetType, () => []).add(report);
    }
    return grouped;
  }
}
