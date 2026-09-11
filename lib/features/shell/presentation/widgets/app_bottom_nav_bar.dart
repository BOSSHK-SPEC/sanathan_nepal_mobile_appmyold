import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';

/// Bottom navigation bar from Figma "Bottom Bar":
/// Home · Marketplace · (gradient centre menu) · Horoscope · Profile.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.onMenuTap,
    super.key,
  });

  /// 0=Home, 1=Marketplace, 2=Horoscope, 3=Profile
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final items = <_NavItem>[
      _NavItem(Icons.home_outlined, Icons.home_rounded, l10n.navHome),
      _NavItem(
        Icons.shopping_cart_outlined,
        Icons.shopping_cart_rounded,
        l10n.navMarketplace,
      ),
      _NavItem(
        Icons.brightness_7_outlined,
        Icons.brightness_7,
        l10n.navHoroscope,
      ),
      _NavItem(
        Icons.account_circle_outlined,
        Icons.account_circle,
        l10n.navProfile,
      ),
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
              _tab(context, items[0], 0),
              _tab(context, items[1], 1),
              Expanded(
                child: Center(
                  child: Semantics(
                    button: true,
                    label: l10n.navMenu,
                    child: GestureDetector(
                      onTap: onMenuTap,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: colors.primaryGradient,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colors.accent.withValues(alpha: 0.35),
                              blurRadius: 7,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.grid_view_rounded,
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

  Widget _tab(BuildContext context, _NavItem item, int index) {
    final colors = context.colors;
    final selected = index == currentIndex;
    final color = selected ? colors.navSelected : colors.navUnselected;
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(selected ? item.active : item.icon, color: color, size: 24),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              item.label,
              style: context.textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
