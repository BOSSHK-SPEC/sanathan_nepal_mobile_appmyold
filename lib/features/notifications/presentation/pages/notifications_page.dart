import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../l10n/notifications_strings.dart';
import '../widgets/notification_list_view.dart';
import '../widgets/notification_settings_view.dart';

/// Which tab of [NotificationsPage] is shown first.
enum NotificationsTab { list, settings }

/// Notifications page: tabs "Notifications | Notification Settings"
/// (Figma profile page 1873:3487 sections; push layouts 1337:3042).
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key, this.initialTab = NotificationsTab.list});

  final NotificationsTab initialTab;

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late int _tab = widget.initialTab.index;

  @override
  Widget build(BuildContext context) {
    final s = NotificationsStrings.of(context);
    return Scaffold(
      appBar: AppTopBar(title: s.pageTitle, showBack: true),
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.sm),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: PillTabs(
              labels: [s.tabNotifications, s.tabSettings],
              filled: false,
              selectedIndex: _tab,
              onChanged: (i) => setState(() => _tab = i),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Expanded(
            child: IndexedStack(
              index: _tab,
              children: const [
                NotificationListView(),
                NotificationSettingsView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// `/notifications/settings` – the same page opened on the settings tab.
class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) =>
      const NotificationsPage(initialTab: NotificationsTab.settings);
}
