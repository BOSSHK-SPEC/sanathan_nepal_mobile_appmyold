import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/app_notification.dart';
import '../l10n/notifications_strings.dart';

/// Inbox row (Figma: "Notification Title  ·  1h ago / body").
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.notification,
    super.key,
    this.onTap,
    this.now,
  });

  final AppNotification notification;
  final VoidCallback? onTap;
  final DateTime? now;

  IconData get _icon => switch (notification.type) {
    NotificationType.horoscope => Icons.auto_awesome_outlined,
    NotificationType.event => Icons.event_outlined,
    NotificationType.festival => Icons.celebration_outlined,
    NotificationType.birthday => Icons.cake_outlined,
    NotificationType.order => Icons.shopping_bag_outlined,
    NotificationType.appointment => Icons.calendar_month_outlined,
    NotificationType.general => Icons.notifications_none,
  };

  @override
  Widget build(BuildContext context) {
    final s = NotificationsStrings.of(context);
    final colors = context.colors;
    final lang = context.languageCode;
    final n = notification;
    final elapsed = (now ?? DateTime.now()).difference(n.createdAt);
    return AppCard(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageGutter,
        vertical: AppSpacing.xs,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      gradient: context.isDark ? colors.cardGradient : null,
      color: n.isRead ? colors.surface : colors.surfaceVariant,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: colors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: Icon(_icon, size: 16, color: colors.onPrimary),
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
                        n.titleFor(lang),
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: n.isRead
                              ? FontWeight.w500
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      s.timeAgo(elapsed),
                      style: context.textTheme.labelSmall,
                    ),
                    if (!n.isRead) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: colors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(n.bodyFor(lang), style: context.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
