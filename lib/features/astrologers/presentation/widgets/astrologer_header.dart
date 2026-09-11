import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/astrologer.dart';
import '../l10n/astrologers_strings.dart';
import 'astrologer_presence.dart';

/// Gradient profile header: avatar, name, presence, and the three numbers a
/// seeker weighs before paying — rating, experience and volume.
class AstrologerHeader extends StatelessWidget {
  const AstrologerHeader({
    required this.astrologer,
    required this.onFollowToggle,
    super.key,
  });

  final Astrologer astrologer;
  final VoidCallback onFollowToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = AstrologersStrings.of(context);
    final onGradient = colors.onPrimary;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: colors.headerGradient),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.md,
        AppSpacing.pageGutter,
        AppSpacing.xl,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                source: astrologer.avatarAsset,
                name: astrologer.name.en,
                size: 78,
                verified: astrologer.isVerified,
                borderColor: onGradient.withValues(alpha: 0.7),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localized(context, astrologer.name),
                      style: context.textTheme.displaySmall?.copyWith(
                        color: onGradient,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      localized(context, astrologer.headline),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: onGradient.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        AstrologerPresence(astrologer: astrologer),
                        const SizedBox(width: AppSpacing.sm),
                        _FollowPill(
                          following: astrologer.isFollowing,
                          onTap: onFollowToggle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.surface.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              children: [
                _HeaderStat(
                  value: astrologer.rating.toStringAsFixed(1),
                  label:
                      '${localizeCount(context, astrologer.reviewCount)} '
                      '${s.reviews.toLowerCase()}',
                  color: onGradient,
                ),
                _HeaderDivider(color: onGradient),
                _HeaderStat(
                  value: localizeCount(context, astrologer.experienceYears),
                  label: s.yearsExperience,
                  color: onGradient,
                ),
                _HeaderDivider(color: onGradient),
                _HeaderStat(
                  value: _compact(context, astrologer.consultationCount),
                  label: s.consultations,
                  color: onGradient,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 9 800 → "9.8k". Keeps the stat row from wrapping on narrow phones.
  String _compact(BuildContext context, int value) {
    final text = value >= 1000
        ? '${(value / 1000).toStringAsFixed(value >= 10000 ? 0 : 1)}k'
        : '$value';
    return context.usesDevanagariDigits ? text.toDevanagariDigits() : text;
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: context.textTheme.headlineMedium?.copyWith(color: color),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelSmall?.copyWith(
            color: color.withValues(alpha: 0.85),
          ),
        ),
      ],
    ),
  );
}

class _HeaderDivider extends StatelessWidget {
  const _HeaderDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 26, color: color.withValues(alpha: 0.3));
}

class _FollowPill extends StatelessWidget {
  const _FollowPill({required this.following, required this.onTap});

  final bool following;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = AstrologersStrings.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: following
              ? colors.onPrimary.withValues(alpha: 0.22)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: colors.onPrimary.withValues(alpha: 0.7)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              following
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              size: 12,
              color: colors.onPrimary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              following ? s.following : s.follow,
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
