import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/astrologer.dart';
import '../../domain/entities/consult_channel.dart';
import '../l10n/astrologers_strings.dart';
import 'astrologer_presence.dart';

/// Listing row for one astrologer.
///
/// Leads with what a seeker actually decides on — presence, rating, price
/// and language — and puts the primary action on the right where the thumb
/// already is.
class AstrologerCard extends StatelessWidget {
  const AstrologerCard({
    required this.astrologer,
    required this.onTap,
    super.key,
    this.onConsult,
    this.onFollowToggle,
  });

  final Astrologer astrologer;
  final VoidCallback onTap;
  final ValueChanged<ConsultChannel>? onConsult;
  final VoidCallback? onFollowToggle;

  IconData _channelIcon(ConsultChannel c) => switch (c) {
    ConsultChannel.chat => Icons.chat_bubble_outline_rounded,
    ConsultChannel.voice => Icons.call_outlined,
    ConsultChannel.video => Icons.videocam_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = AstrologersStrings.of(context);
    final rate = RegionFormat.money(
      astrologer.lowestRate,
      config: context.regionConfig,
      languageCode: context.languageCode,
    );

    return AppCard(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                source: astrologer.avatarAsset,
                name: astrologer.name.en,
                size: 58,
                online: astrologer.isOnline,
                verified: astrologer.isVerified,
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
                            localized(context, astrologer.name),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.headlineSmall,
                          ),
                        ),
                        if (onFollowToggle != null)
                          _FollowButton(
                            following: astrologer.isFollowing,
                            onTap: onFollowToggle!,
                          ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Text(
                      localized(context, astrologer.headline),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs + 2),
                    Row(
                      children: [
                        RatingSummary(
                          rating: astrologer.rating,
                          reviewCount: astrologer.reviewCount,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.textMuted,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Flexible(
                          child: Text(
                            s.yearsLabel(
                              localizeCount(
                                context,
                                astrologer.experienceYears,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelMedium?.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs + 2,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AstrologerPresence(astrologer: astrologer),
              for (final specialty in astrologer.specialties.take(2))
                StatusChip(label: s.specialty(specialty), dense: true),
              Text(
                astrologer.languageCodes.map(s.languageName).join(' · '),
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.from,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          rate,
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: colors.accent,
                          ),
                        ),
                        Text(
                          s.perMinute,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: colors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              for (final channel in astrologer.channels) ...[
                _ChannelButton(
                  icon: _channelIcon(channel),
                  enabled: astrologer.isOnline && onConsult != null,
                  onTap: () => onConsult?.call(channel),
                  tooltip: s.channelName(channel),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              PrimaryButton(
                label: astrologer.isOnline ? s.consultNow : s.bookLater,
                expanded: false,
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                onPressed: onConsult == null
                    ? null
                    : () => onConsult!(
                        astrologer.channels.isEmpty
                            ? ConsultChannel.chat
                            : astrologer.channels.first,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChannelButton extends StatelessWidget {
  const _ChannelButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.surfaceVariant,
            border: Border.all(color: colors.border.withValues(alpha: 0.6)),
          ),
          child: Icon(
            icon,
            size: 16,
            color: enabled ? colors.accent : colors.iconMuted,
          ),
        ),
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({required this.following, required this.onTap});

  final bool following;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = AstrologersStrings.of(context);
    return Semantics(
      button: true,
      label: following ? s.following : s.follow,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.sm),
          child: Icon(
            following ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            size: 20,
            color: following ? colors.accent : colors.iconMuted,
          ),
        ),
      ),
    );
  }
}
