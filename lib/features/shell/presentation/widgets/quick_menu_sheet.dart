import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/session/app_role.dart';
import '../../../../core/session/permission.dart';
import '../../../../core/session/session_scope.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/ad_banner.dart';
import '../../../app_settings/domain/entities/app_preferences.dart';
import '../../../app_settings/presentation/cubit/app_settings_cubit.dart';
import '../../../session/presentation/cubit/session_cubit.dart';
import 'paged_tile_grid.dart';
import 'patro_quick_card.dart';

/// Quick-access menu opened from the centre button of the bottom bar
/// (Figma "Home Bottom Bar Menu"). Opens on the Patro card: the calendar is
/// the app's everyday screen, and the centre button is how people reach it.
class QuickMenuSheet extends StatelessWidget {
  const QuickMenuSheet({super.key, this.today});

  /// Injectable "today" for the Patro card (tests); defaults to now.
  final DateTime? today;

  static Future<void> show(BuildContext context, {DateTime? today}) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        builder: (_) => QuickMenuSheet(today: today),
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final prefs = context.watch<AppSettingsCubit>().state;

    void go(String route) {
      Navigator.of(context).pop();
      context.push(route);
    }

    final primaryTiles = <_MenuTile>[
      // Patro has its own card at the top of the menu. Its tile here wore a
      // house icon and read as "Home"; Panchanga takes the slot instead.
      _MenuTile(
        Icons.auto_awesome_outlined,
        l10n.menuPanchanga,
        () => go(AppRoutes.panchanga),
      ),
      _MenuTile(
        Icons.shopping_cart_outlined,
        l10n.menuBazar,
        () => go(AppRoutes.marketplace),
      ),
      _MenuTile(
        Icons.access_time,
        l10n.menuNotification,
        () => go(AppRoutes.notifications),
      ),
      _MenuTile(
        Icons.help_outline,
        l10n.menuSupport,
        () => go(AppRoutes.support),
      ),
    ];
    final secondaryTiles = <_MenuTile>[
      _MenuTile(
        Icons.local_fire_department_outlined,
        l10n.menuSuvaSaits,
        () => go(AppRoutes.panchanga),
      ),
      _MenuTile(
        Icons.event_repeat_outlined,
        l10n.menuDateConverter,
        () => go(AppRoutes.dateConverter),
      ),
      _MenuTile(
        Icons.brightness_7_outlined,
        l10n.menuHoroscope,
        () => go(AppRoutes.horoscope),
      ),
      // Not a calendar icon: that one belongs to Patro.
      _MenuTile(
        Icons.event_note_outlined,
        l10n.menuEvents,
        () => go(AppRoutes.events),
      ),
      _MenuTile(
        Icons.currency_exchange,
        l10n.menuForex,
        () => go(AppRoutes.forex),
      ),
      _MenuTile(
        Icons.wb_sunny_outlined,
        l10n.menuWeather,
        () => go(AppRoutes.weather),
      ),
      _MenuTile(
        Icons.auto_awesome_motion_outlined,
        l10n.menuAstrologers,
        () => go(AppRoutes.astrologers),
      ),
      _MenuTile(
        Icons.account_balance_wallet_outlined,
        l10n.menuWallet,
        () => go(AppRoutes.wallet),
      ),
      _MenuTile(
        Icons.bookmark_outline_rounded,
        l10n.menuSaved,
        () => go(AppRoutes.savedProducts),
      ),
      _MenuTile(
        Icons.receipt_long_outlined,
        l10n.menuOrders,
        () => go(AppRoutes.myOrders),
      ),
      _MenuTile(
        Icons.local_offer_outlined,
        l10n.menuOffers,
        () => go(AppRoutes.offers),
      ),
      _MenuTile(
        Icons.grid_on_outlined,
        l10n.menuKundli,
        () => go(AppRoutes.kundli),
      ),
      _MenuTile(
        Icons.picture_as_pdf_outlined,
        l10n.menuReports,
        () => go(AppRoutes.reports),
      ),
      _MenuTile(
        Icons.temple_hindu_outlined,
        l10n.menuPuja,
        () => go(AppRoutes.pujas),
      ),
      _MenuTile(
        Icons.forum_outlined,
        l10n.menuConsultations,
        () => go(AppRoutes.consultHistory),
      ),
      _MenuTile(
        Icons.event_available_outlined,
        l10n.menuAppointment,
        () => go(AppRoutes.appointments),
      ),
      _MenuTile(
        Icons.add_box_outlined,
        l10n.menuAddProducts,
        () => go(AppRoutes.productCreate),
      ),
      _MenuTile(
        Icons.article_outlined,
        l10n.menuBlogs,
        () => go(AppRoutes.blogs),
      ),
      _MenuTile(
        Icons.newspaper_outlined,
        l10n.menuNews,
        () => go(AppRoutes.news),
      ),
      _MenuTile(
        Icons.storefront_outlined,
        l10n.menuSellerProfile,
        () => go(AppRoutes.myBusiness),
      ),
      // An approved astrologer is not a candidate: the same slot takes them
      // to their console instead of inviting them to apply again.
      if (context.can(Permission.viewAstrologerConsole))
        _MenuTile(Icons.auto_awesome_outlined, l10n.menuAstrologerConsole, () {
          // Switch first, so the console opens knowing which role is active.
          context.read<SessionCubit>().switchRole(AppRole.astrologer);
          go(AppRoutes.astrologerHome);
        })
      else
        _MenuTile(
          Icons.auto_awesome_outlined,
          l10n.menuBecomeAstrologer,
          () => go(AppRoutes.astrologerApply),
        ),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: context.isDark
              ? [const Color(0xFF3B2A5E), const Color(0xFF2A2350)]
              : [colors.surface, colors.surface],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PatroQuickCard(
                today: today ?? DateTime.now(),
                onTap: () => go(AppRoutes.patro),
              ),
              const SizedBox(height: AppSpacing.md),
              AdBanner(
                label: l10n.settingTabAds,
                margin: EdgeInsets.zero,
                height: 110,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    l10n.silentMode,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      value: prefs.silentMode,
                      onChanged: context.read<AppSettingsCubit>().setSilentMode,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.expand_more, color: colors.iconMuted),
                  ),
                  const Spacer(),
                  _LanguagePill(
                    language: prefs.language,
                    onChanged: context.read<AppSettingsCubit>().setLanguage,
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _IconLabel(
                    icon: Icons.favorite_border,
                    label: l10n.menuWishlist,
                    onTap: () => go(AppRoutes.profile),
                  ),
                  _IconLabel(
                    icon: Icons.access_time,
                    label: l10n.menuNotification,
                    onTap: () => go(AppRoutes.notifications),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: colors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => go(AppRoutes.eventCreate),
                      icon: Icon(Icons.add, color: colors.onPrimary, size: 18),
                    ),
                  ),
                  _IconLabel(
                    icon: Icons.settings_outlined,
                    label: l10n.menuSettings,
                    onTap: () => go(AppRoutes.notificationSettings),
                    highlighted: true,
                  ),
                  _IconLabel(
                    icon: Icons.account_circle_outlined,
                    label: l10n.menuProfile,
                    onTap: () => go(AppRoutes.profile),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.sm,
                  horizontal: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: colors.textPrimary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var i = 0; i < primaryTiles.length; i++)
                      _BigTile(tile: primaryTiles[i], selected: i == 0),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              // Two rows per page; remaining tiles live on the next swipeable
              // page with pill indicators (Figma quick-menu).
              PagedTileGrid<_MenuTile>(
                items: secondaryTiles,
                tileBuilder: (_, t) => _SmallTile(tile: t),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuTile {
  const _MenuTile(this.icon, this.label, this.onTap);
  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

class _BigTile extends StatelessWidget {
  const _BigTile({required this.tile, this.selected = false});
  final _MenuTile tile;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: tile.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: selected ? colors.accent : colors.chipBackground,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Icon(
              tile.icon,
              color: selected ? colors.onPrimary : colors.icon,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            tile.label,
            style: context.textTheme.labelLarge?.copyWith(
              color: selected ? colors.accent : colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallTile extends StatelessWidget {
  const _SmallTile({required this.tile});
  final _MenuTile tile;
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: tile.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.chipBackground,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Icon(tile.icon, color: colors.icon, size: 22),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            tile.label,
            style: context.textTheme.labelMedium?.copyWith(
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({
    required this.icon,
    required this.label,
    required this.onTap,
    this.highlighted = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool highlighted;
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = highlighted ? colors.accent : colors.textMuted;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 2),
          Text(
            label,
            style: context.textTheme.labelMedium?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _LanguagePill extends StatelessWidget {
  const _LanguagePill({required this.language, required this.onChanged});
  final AppLanguage language;
  final ValueChanged<AppLanguage> onChanged;
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return PopupMenuButton<AppLanguage>(
      onSelected: onChanged,
      itemBuilder: (_) => [
        for (final lang in AppLanguage.forRegion(context.region))
          PopupMenuItem(
            value: lang,
            child: Text(switch (lang) {
              AppLanguage.nepali => context.l10n.nepali,
              AppLanguage.english => context.l10n.english,
              AppLanguage.hindi => context.l10n.hindi,
            }),
          ),
      ],
      child: Container(
        height: 22,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          color: colors.textPrimary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.language,
              style: context.textTheme.labelMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              language == AppLanguage.english
                  ? '🇺🇸'
                  : context.regionConfig.flagEmoji,
            ),
            Icon(Icons.expand_more, size: 14, color: colors.textSecondary),
          ],
        ),
      ),
    );
  }
}
