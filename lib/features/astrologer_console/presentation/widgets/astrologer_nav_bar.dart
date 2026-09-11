import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/console_strings.dart';

/// Bottom navigation for the astrologer side of the app.
///
/// Deliberately a different bar from the seeker's, not the same one with
/// swapped labels: an astrologer's day is Queue → Schedule → Earnings →
/// Clients, and the seeker's centre "browse" button has no meaning here.
/// The centre action is the role switch, which is the one thing a
/// dual-role user needs constantly.
class AstrologerNavBar extends StatelessWidget {
  const AstrologerNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.onSwitchRole,
    super.key,
    this.queueCount = 0,
    this.isOnline = false,
  });

  /// 0 = Queue, 1 = Schedule, 2 = Earnings, 3 = Clients.
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onSwitchRole;

  /// Badge on the Queue tab — the number that decides where to look first.
  final int queueCount;

  /// Tints the centre switch so presence is visible from any tab.
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = ConsoleStrings.of(context);

    final items = <_NavItem>[
      _NavItem(Icons.people_outline_rounded, Icons.people_rounded, s.navQueue),
      _NavItem(
        Icons.calendar_month_outlined,
        Icons.calendar_month_rounded,
        s.navSchedule,
      ),
      _NavItem(Icons.payments_outlined, Icons.payments_rounded, s.navEarnings),
      _NavItem(Icons.contacts_outlined, Icons.contacts_rounded, s.navClients),
    ];

    return Container(
      decoration: BoxDecoration(
        color: colors.navBar,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.isDark ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _tab(context, items[0], 0, badge: queueCount),
              _tab(context, items[1], 1),
              Expanded(
                child: Center(
                  child: Semantics(
                    button: true,
                    label: s.switchToPersonal,
                    child: GestureDetector(
                      onTap: onSwitchRole,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: colors.primaryGradient,
                          border: Border.all(
                            color: isOnline
                                ? colors.success
                                : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colors.accent.withValues(alpha: 0.35),
                              blurRadius: 7,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.swap_horiz_rounded,
                          color: colors.onPrimary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _tab(context, items[2], 2),
              _tab(context, items[3], 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab(BuildContext context, _NavItem item, int index, {int badge = 0}) {
    final colors = context.colors;
    final selected = index == currentIndex;
    final color = selected ? colors.navSelected : colors.navUnselected;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  selected ? item.active : item.icon,
                  color: color,
                  size: 24,
                ),
                if (badge > 0)
                  Positioned(
                    right: -6,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      constraints: const BoxConstraints(minWidth: 16),
                      decoration: BoxDecoration(
                        color: colors.error,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        '$badge',
                        textAlign: TextAlign.center,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelMedium?.copyWith(
                color: color,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.active, this.label);
  final IconData icon;
  final IconData active;
  final String label;
}
