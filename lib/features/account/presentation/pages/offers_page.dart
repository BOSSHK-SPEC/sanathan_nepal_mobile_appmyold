import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/account_entities.dart';
import '../cubit/account_cubits.dart';
import '../l10n/account_strings.dart';

/// Coupons and offers.
class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<OffersCubit>()..load(),
    child: const _OffersView(),
  );
}

class _OffersView extends StatelessWidget {
  const _OffersView();

  @override
  Widget build(BuildContext context) {
    final s = AccountStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.offers, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<OffersCubit, OffersState>(
          builder: (context, state) {
            final cubit = context.read<OffersCubit>();

            return switch (state.offers) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 3),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ when state.isEmpty => EmptyViewWithBody(
                title: s.noOffers,
                body: s.noOffersBody,
                icon: Icons.local_offer_outlined,
              ),
              _ => ListView(
                padding: const EdgeInsets.all(AppSpacing.pageGutter),
                children: [
                  if (state.available.isNotEmpty) ...[
                    Text(
                      s.availableOffers,
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (final offer in state.available)
                      _OfferCard(offer: offer, strings: s),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  if (state.spent.isNotEmpty) ...[
                    Text(s.usedOffers, style: context.textTheme.titleSmall),
                    const SizedBox(height: AppSpacing.sm),
                    for (final offer in state.spent)
                      _OfferCard(offer: offer, strings: s),
                  ],
                ],
              ),
            };
          },
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.offer, required this.strings});

  final Offer offer;
  final AccountStrings strings;

  IconData get _icon => switch (offer.kind) {
    OfferKind.firstConsultation => Icons.forum_outlined,
    OfferKind.walletBonus => Icons.account_balance_wallet_outlined,
    OfferKind.freeMinutes => Icons.timer_outlined,
    OfferKind.productDiscount => Icons.local_mall_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final usable = offer.isUsable;

    return Opacity(
      opacity: usable ? 1 : 0.55,
      child: AppCard(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        border: offer.isExpiringSoon ? Border.all(color: colors.warning) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.accent.withValues(alpha: 0.12),
                  ),
                  child: Icon(_icon, size: 18, color: colors.accent),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(offer.title, style: context.textTheme.titleSmall),
                      Text(
                        offer.description,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (offer.minimumSpend > 0) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Text(
                    '${strings.minimumSpend}: ',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                  MoneyText(
                    offer.minimumSpend,
                    style: context.textTheme.labelSmall,
                    color: colors.textSecondary,
                  ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                // A dashed coupon-code slab, which is the shape people
                // recognise and expect to be able to copy.
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: colors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: colors.border,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text(
                      offer.code,
                      style: context.textTheme.titleSmall?.copyWith(
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                if (usable)
                  SecondaryButton(
                    label: strings.copyCode,
                    expanded: false,
                    height: 36,
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: offer.code));
                      if (context.mounted) {
                        AppSnack.success(context, strings.codeCopied);
                      }
                    },
                  )
                else
                  StatusChip(
                    label: offer.used
                        ? strings.usedLabel
                        : strings.expiredLabel,
                    dense: true,
                  ),
              ],
            ),
            if (usable) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 12,
                    color: offer.isExpiringSoon
                        ? colors.warning
                        : colors.textMuted,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    offer.isExpiringSoon
                        ? strings.expiringSoon
                        : '${strings.expiresIn} '
                              '${strings.daysLabel(_digits(context, offer.daysLeft))}',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: offer.isExpiringSoon
                          ? colors.warning
                          : colors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Referral programme.
class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<OffersCubit>()..load(),
    child: const _ReferralView(),
  );
}

class _ReferralView extends StatelessWidget {
  const _ReferralView();

  @override
  Widget build(BuildContext context) {
    final s = AccountStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.referral, showBack: true),
      body: SafeArea(
        top: false,
        child: BlocBuilder<OffersCubit, OffersState>(
          builder: (context, state) {
            final referral = state.referralSummary;
            if (referral == null) return const LoadingView();

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    gradient: colors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.card_giftcard_rounded,
                        size: 32,
                        color: colors.onPrimary,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          MoneyText(
                            referral.rewardPerReferral,
                            style: context.textTheme.displayLarge?.copyWith(
                              fontSize: 30,
                            ),
                            color: colors.onPrimary,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            s.perReferral,
                            style: context.textTheme.labelMedium?.copyWith(
                              color: colors.onPrimary.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        s.referralBody,
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.onPrimary.withValues(alpha: 0.92),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.yourCode,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              referral.code,
                              style: context.textTheme.displaySmall?.copyWith(
                                fontSize: 20,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          SecondaryButton(
                            label: s.shareCode,
                            expanded: false,
                            height: 36,
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(text: referral.code),
                              );
                              if (context.mounted) {
                                AppSnack.success(context, s.codeCopied);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        label: s.invited,
                        icon: Icons.send_outlined,
                        value: _digits(context, referral.invited),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: StatTile(
                        label: s.joined,
                        icon: Icons.how_to_reg_outlined,
                        value: _digits(context, referral.joined),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: StatTile(
                        label: s.earnedLabel,
                        icon: Icons.savings_outlined,
                        accentColor: colors.success,
                        valueWidget: MoneyText(
                          referral.earned,
                          style: context.textTheme.headlineMedium,
                          color: colors.success,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

String _digits(BuildContext context, Object value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}
