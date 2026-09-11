import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/app_notification.dart';
import '../cubit/notifications_cubit.dart';
import '../l10n/notifications_strings.dart';
import 'notification_card.dart';

/// Body of the "Notifications" tab – reusable by the Profile feature.
///
/// ```dart
/// const NotificationListView()            // creates its own cubit from sl
/// NotificationListView(shrinkWrap: true)  // when embedded in another scroll view
/// ```
/// Provide a [NotificationsCubit] above it to share state; otherwise one is
/// created from `sl` and loaded automatically. Tapping a card marks it read
/// and follows its deep-link route (if any) unless [onTap] is given.
class NotificationListView extends StatelessWidget {
  const NotificationListView({
    super.key,
    this.shrinkWrap = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: AppSpacing.sm),
  });

  final bool shrinkWrap;
  final ValueChanged<AppNotification>? onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final existing = _maybeCubit(context);
    if (existing != null) {
      return _Body(shrinkWrap: shrinkWrap, onTap: onTap, padding: padding);
    }
    return BlocProvider(
      create: (_) => sl<NotificationsCubit>()..load(),
      child: _Body(shrinkWrap: shrinkWrap, onTap: onTap, padding: padding),
    );
  }

  static NotificationsCubit? _maybeCubit(BuildContext context) {
    try {
      return context.read<NotificationsCubit>();
    } on ProviderNotFoundException {
      return null;
    }
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.shrinkWrap,
    required this.onTap,
    required this.padding,
  });
  final bool shrinkWrap;
  final ValueChanged<AppNotification>? onTap;
  final EdgeInsets padding;

  void _handleTap(BuildContext context, AppNotification n) {
    context.read<NotificationsCubit>().markRead(n.id);
    if (onTap != null) return onTap!(n);
    final route = n.route;
    if (route != null && route.isNotEmpty) context.push(route);
  }

  @override
  Widget build(BuildContext context) {
    final s = NotificationsStrings.of(context);
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final items = state.notifications.dataOrNull;
        if (items == null) {
          return switch (state.notifications) {
            Failed(:final failure) => ErrorView(
              message: failure.message,
              onRetry: context.read<NotificationsCubit>().load,
            ),
            _ => const LoadingView(height: 120),
          };
        }
        if (items.isEmpty) {
          return EmptyView(message: s.empty, icon: Icons.notifications_none);
        }
        return ListView.builder(
          shrinkWrap: shrinkWrap,
          physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
          padding: padding,
          itemCount: items.length + 1,
          itemBuilder: (context, i) {
            if (i == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: state.unreadCount == 0
                      ? null
                      : context.read<NotificationsCubit>().markAllRead,
                  child: Text(
                    s.markAllRead,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: state.unreadCount == 0
                          ? context.colors.textMuted
                          : context.colors.accent,
                    ),
                  ),
                ),
              );
            }
            final n = items[i - 1];
            return NotificationCard(
              notification: n,
              onTap: () => _handleTap(context, n),
            );
          },
        );
      },
    );
  }
}
