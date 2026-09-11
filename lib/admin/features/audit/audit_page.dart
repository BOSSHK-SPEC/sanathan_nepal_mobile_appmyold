import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/injection.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/relative_time.dart';
import '../../domain/entities/audit_entry.dart';
import '../../shell/widgets/console_page.dart';
import '../../shell/widgets/console_panel.dart';
import 'cubit/audit_cubit.dart';

/// Who did what, and which request it came from.
class AuditPage extends StatelessWidget {
  const AuditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuditCubit>()..load(),
      child: const _AuditView(),
    );
  }
}

class _AuditView extends StatelessWidget {
  const _AuditView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuditCubit>();

    return BlocBuilder<AuditCubit, AuditState>(
      builder: (context, state) {
        return ConsolePage(
          title: 'Audit log',
          subtitle:
              'Append-only. Each line carries the trace id that finds the request in the server logs.',
          onRefresh: cubit.load,
          actions: [
            SizedBox(
              width: 240,
              child: TextField(
                onChanged: cubit.setQuery,
                decoration: const InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(Icons.search_rounded, size: 18),
                  hintText: 'Filter by action, id or trace',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            DropdownButton<int>(
              value: state.limit,
              underline: const SizedBox.shrink(),
              items: [
                for (final limit in AuditCubit.limits)
                  DropdownMenuItem(value: limit, child: Text('$limit')),
              ],
              onChanged: (limit) {
                if (limit != null) cubit.setLimit(limit);
              },
            ),
          ],
          child: LoadStateView<List<AuditEntry>>(
            state: state.entries,
            onRetry: cubit.load,
            isEmpty: (_) => state.visible.isEmpty,
            emptyMessage: state.query.isEmpty
                ? 'Nothing has been recorded yet'
                : 'No entries match "${state.query}"',
            emptyIcon: Icons.receipt_long_outlined,
            builder: (context, _) => ConsolePanel(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  for (final (index, entry) in state.visible.indexed) ...[
                    if (index > 0) const Divider(height: 1),
                    _AuditRow(entry: entry),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AuditRow extends StatelessWidget {
  const _AuditRow({required this.entry});

  final AuditEntry entry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: colors.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              // The system acts too — expiries, webhooks, scheduled jobs — and
              // it matters whether a person or a timer did this.
              entry.actorId == null
                  ? Icons.settings_suggest_rounded
                  : Icons.person_rounded,
              size: 15,
              color: colors.iconMuted,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.action,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                SelectableText(
                  '${entry.targetType}${entry.targetId == null ? '' : ' · ${entry.targetId}'}'
                  '${entry.actorId == null ? ' · system' : ' · by ${entry.actorId}'}',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.textMuted,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                relativeTime(context, entry.createdAt),
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              if (entry.traceId != null) ...[
                const SizedBox(height: 4),
                Tooltip(
                  message: 'Search the server logs for this id',
                  child: SelectableText(
                    entry.traceId!,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
