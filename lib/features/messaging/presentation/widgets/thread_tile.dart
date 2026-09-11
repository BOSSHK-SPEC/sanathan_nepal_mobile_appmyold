import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../domain/entities/message_thread.dart';
import '../l10n/messaging_strings.dart';

/// One conversation in the inbox.
class ThreadTile extends StatelessWidget {
  const ThreadTile({
    required this.thread,
    required this.onTap,
    super.key,
    this.onArchiveToggle,
  });

  final MessageThread thread;
  final VoidCallback onTap;
  final VoidCallback? onArchiveToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MessagingStrings.of(context);
    final unread = thread.hasUnread;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pageGutter,
          vertical: AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppAvatar(
              source: thread.isOwnerSide ? null : thread.businessLogoUrl,
              name: thread.counterpartName,
              size: 44,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          thread.counterpartName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: unread
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        _time(context, thread.lastMessageAt),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: unread ? colors.accent : colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  if (thread.subject.isNotEmpty) ...[
                    const SizedBox(height: 1),
                    Text(
                      thread.subject,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          thread.lastMessagePreview,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: unread
                                ? colors.textPrimary
                                : colors.textMuted,
                          ),
                        ),
                      ),
                      if (unread) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Semantics(
                          label: s.unreadCount(thread.unreadCount),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: colors.accent,
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                            ),
                            child: Text(
                              context.usesDevanagariDigits
                                  ? '${thread.unreadCount}'.toDevanagariDigits()
                                  : '${thread.unreadCount}',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: colors.onPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (onArchiveToggle != null)
              IconButton(
                tooltip: thread.archived ? s.unarchive : s.archive,
                onPressed: onArchiveToggle,
                icon: Icon(
                  thread.archived
                      ? Icons.unarchive_outlined
                      : Icons.archive_outlined,
                  size: 18,
                  color: colors.iconMuted,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Time for today, weekday inside the last week, date beyond that — the
  /// same ladder every mail client uses, because an absolute timestamp on a
  /// message from ten minutes ago is unreadable at a glance.
  String _time(BuildContext context, DateTime at) {
    final now = DateTime.now();
    final diff = now.difference(at);
    final String raw;
    if (diff.inDays == 0 && now.day == at.day) {
      raw = DateFormat.Hm().format(at);
    } else if (diff.inDays < 7) {
      raw = DateFormat.E().format(at);
    } else {
      raw = DateFormat.yMd().format(at);
    }
    return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
  }
}
