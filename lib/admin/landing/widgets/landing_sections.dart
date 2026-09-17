import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';
import '../../motion/motion.dart';

/// One capability of the app, as shown on the landing page.
@immutable
class AppFeature {
  const AppFeature({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  /// What the product actually does, in the order it matters to a new visitor.
  ///
  /// Written from the shipped feature set — calendar, panchanga, horoscope,
  /// kundli, astrologers, marketplace, puja, wallet — rather than invented
  /// marketing, so the page never promises something the app does not do.
  static const List<AppFeature> all = [
    AppFeature(
      icon: Icons.calendar_month_rounded,
      title: 'Bikram Sambat calendar',
      body:
          'The full BS calendar with tithi, festivals and holidays, and the '
          'Saka calendar for India — each region sees its own.',
    ),
    AppFeature(
      icon: Icons.auto_awesome_rounded,
      title: 'Panchanga and horoscope',
      body:
          'Daily panchanga, and horoscopes by day, week, month and year for '
          'every rashi, in Nepali, English and Hindi.',
    ),
    AppFeature(
      icon: Icons.blur_circular_rounded,
      title: 'Kundli and matching',
      body:
          'Birth charts, dashas, doshas and gun milan, computed server-side '
          'from a real ephemeris rather than a lookup table.',
    ),
    AppFeature(
      icon: Icons.forum_rounded,
      title: 'Talk to an astrologer',
      body:
          'Chat, voice and video with verified astrologers, billed by the '
          'minute from a wallet balance — never a surprise invoice.',
    ),
    AppFeature(
      icon: Icons.storefront_rounded,
      title: 'Marketplace',
      body:
          'Puja items, rudraksha and ritual supplies from approved local '
          'sellers, with orders, returns and reviews.',
    ),
    AppFeature(
      icon: Icons.temple_hindu_rounded,
      title: 'Book a puja',
      body:
          'Find a priest, pick a muhurta and book a ceremony at home or at '
          'the temple.',
    ),
    AppFeature(
      icon: Icons.account_balance_wallet_rounded,
      title: 'One wallet',
      body:
          'Top up with eSewa, Khalti or UPI and spend across consultations, '
          'reports and orders. Every paisa is double-entry booked.',
    ),
    AppFeature(
      icon: Icons.public_rounded,
      title: 'Nepal and India',
      body:
          'Currency, calendar, language and payment rails all follow the '
          'region — not a translation layer bolted on afterwards.',
    ),
  ];
}

/// The hero: the one screen that has to say what this is.
class LandingHero extends StatelessWidget {
  const LandingHero({required this.onSignIn, super.key});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final wide = MediaQuery.sizeOf(context).width >= 900;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, wide ? 80 : 48, 24, wide ? 96 : 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Reveal(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: colors.chipBackground,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: colors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.brightness_7_rounded,
                    size: 14,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sanatan Nepal',
                    style: context.textTheme.labelSmall?.copyWith(
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          Reveal(
            delay: const Duration(milliseconds: 90),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Text(
                'The Hindu calendar, astrology and marketplace — in one app.',
                textAlign: TextAlign.center,
                style:
                    (wide
                            ? context.textTheme.displaySmall
                            : context.textTheme.headlineMedium)
                        ?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.12,
                          letterSpacing: -1,
                        ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Reveal(
            delay: const Duration(milliseconds: 160),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Text(
                'Bikram Sambat dates, daily panchanga, verified astrologers, '
                'kundli and a marketplace of local sellers — built for Nepal '
                'and India, in Nepali, English and Hindi.',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: colors.textSecondary,
                  height: 1.6,
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Reveal(
            delay: const Duration(milliseconds: 230),
            child: Wrap(
              spacing: 14,
              runSpacing: 14,
              alignment: WrapAlignment.center,
              children: [
                MagneticButton(
                  label: 'Staff sign in',
                  icon: Icons.lock_open_rounded,
                  onPressed: onSignIn,
                ),
                MagneticButton(
                  label: 'What is inside',
                  icon: Icons.arrow_downward_rounded,
                  filled: false,
                  onPressed: () => Scrollable.ensureVisible(
                    context,
                    alignment: 0.1,
                    duration: Motion.slow,
                    curve: Motion.settle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The feature grid, on tilting cards.
class LandingFeatures extends StatelessWidget {
  const LandingFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          Reveal(
            child: Text(
              'What the app does',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Reveal(
            delay: const Duration(milliseconds: 80),
            child: Text(
              'Eight things, each built properly rather than eighty half-built.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 36),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 18.0;
              final columns = switch (constraints.maxWidth) {
                >= 1180 => 4,
                >= 860 => 3,
                >= 560 => 2,
                _ => 1,
              };
              final tile =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (final (index, feature) in AppFeature.all.indexed)
                    SizedBox(
                      width: tile,
                      child: Reveal(
                        delay: Motion.stagger(index),
                        child: TiltCard(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: colors.primaryGradient,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  feature.icon,
                                  color: colors.onPrimary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                feature.title,
                                style: context.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                feature.body,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: colors.textSecondary,
                                  height: 1.55,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// What the console itself is for — shown to a visitor who wonders why this
/// page has a sign-in button at all.
class LandingConsoleSection extends StatelessWidget {
  const LandingConsoleSection({required this.onSignIn, super.key});

  final VoidCallback onSignIn;

  static const List<(IconData, String, String)> _duties = [
    (
      Icons.verified_user_rounded,
      'Verify astrologers',
      'Review documents and experience before anyone can charge for a reading.',
    ),
    (
      Icons.storefront_rounded,
      'Approve sellers',
      'A business is checked by a human before its listings reach the app.',
    ),
    (
      Icons.account_balance_rounded,
      'Release payouts',
      'Earnings leave the platform only after a named reviewer approves them.',
    ),
    (
      Icons.receipt_long_rounded,
      'Answer for it',
      'Every staff action is written to an append-only log with its trace id.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Reveal(
          child: Container(
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              gradient: colors.cardGradient,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The staff console',
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Nothing reaches users unreviewed. This is where that review '
                  'happens — and where it is recorded.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 780 ? 2 : 1;
                    const spacing = 20.0;
                    final tile =
                        (constraints.maxWidth - spacing * (columns - 1)) /
                        columns;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: [
                        for (final (icon, title, body) in _duties)
                          SizedBox(
                            width: tile,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(icon, size: 20, color: colors.primary),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: context.textTheme.titleSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        body,
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                              color: colors.textSecondary,
                                              height: 1.5,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),
                MagneticButton(
                  label: 'Sign in to the console',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: onSignIn,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Closing strip.
class LandingFooter extends StatelessWidget {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.divider)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 12,
        children: [
          Text(
            '© Sanatan Nepal',
            style: context.textTheme.labelMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
          Text(
            'Nepal 🇳🇵 · India 🇮🇳',
            style: context.textTheme.labelMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
