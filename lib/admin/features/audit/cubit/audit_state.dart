part of 'audit_cubit.dart';

@freezed
abstract class AuditState with _$AuditState {
  const AuditState._();

  const factory AuditState({
    @Default(100) int limit,
    @Default('') String query,
    @Default(LoadState<List<AuditEntry>>.idle())
    LoadState<List<AuditEntry>> entries,
  }) = _AuditState;

  List<AuditEntry> get items => entries.dataOrNull ?? const [];

  List<AuditEntry> get visible {
    if (query.isEmpty) return items;
    final needle = query.toLowerCase();
    return [
      for (final entry in items)
        if (entry.action.toLowerCase().contains(needle) ||
            entry.targetType.toLowerCase().contains(needle) ||
            (entry.targetId?.toLowerCase().contains(needle) ?? false) ||
            (entry.actorId?.toLowerCase().contains(needle) ?? false) ||
            (entry.traceId?.toLowerCase().contains(needle) ?? false))
          entry,
    ];
  }
}
