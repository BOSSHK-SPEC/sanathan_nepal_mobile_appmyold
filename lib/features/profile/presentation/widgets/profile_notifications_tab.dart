import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../notifications/presentation/widgets/notification_list_view.dart';
import '../../../notifications/presentation/widgets/notification_settings_view.dart';
import '../l10n/profile_strings.dart';
import 'sub_tab_bar.dart';

/// NOTIFICATIONS tab: "Notifications | Notification Settings".
///
/// Thin composition over the `notifications` feature's reusable views so the
/// profile page and the standalone notifications page share one source of
/// truth (DRY – no duplicate mock list / settings form here).
class ProfileNotificationsTab extends StatefulWidget {
  const ProfileNotificationsTab({super.key, this.initialSection = 0});

  /// 0 = notifications list, 1 = notification settings.
  final int initialSection;

  @override
  State<ProfileNotificationsTab> createState() =>
      _ProfileNotificationsTabState();
}

class _ProfileNotificationsTabState extends State<ProfileNotificationsTab> {
  late int _section = widget.initialSection;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    return Column(
      children: [
        SubTabBar(
          labels: [s.notifications.capitalizedWords, s.notificationSettings],
          selectedIndex: _section,
          onChanged: (i) => setState(() => _section = i),
        ),
        const SizedBox(height: AppSpacing.md),
        if (_section == 0)
          const NotificationListView(shrinkWrap: true)
        else
          const NotificationSettingsView(shrinkWrap: true),
      ],
    );
  }
}

extension on String {
  /// "NOTIFICATIONS" → "Notifications" (Devanagari strings are unaffected).
  String get capitalizedWords => split(' ')
      .map(
        (w) => w.isEmpty
            ? w
            : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}',
      )
      .join(' ');
}
