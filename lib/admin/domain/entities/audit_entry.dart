import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_entry.freezed.dart';

/// One staff action, as recorded server-side.
///
/// The audit log is append-only and the console never offers a way to edit it —
/// a log a reviewer can rewrite is not evidence of anything.
@freezed
abstract class AuditEntry with _$AuditEntry {
  const factory AuditEntry({
    required String id,

    /// Null for actions the system took on its own (expiries, webhooks).
    String? actorId,
    required String action,
    required String targetType,
    String? targetId,

    /// Correlates with `X-Trace-Id` in the API logs, so a line here can be
    /// followed to the exact request that produced it.
    String? traceId,
    required DateTime createdAt,
  }) = _AuditEntry;
}
