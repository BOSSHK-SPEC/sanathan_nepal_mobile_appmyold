import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../l10n/profile_strings.dart';
import '../region/support_contacts.dart';
import '../widgets/profile_section_card.dart';

/// Help & Support page (`AppRoutes.support`): contact options (per region via
/// [SupportContacts]) + FAQ accordion.
class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    final contacts = SupportContacts.of(context.regionConfig);
    return Scaffold(
      appBar: AppTopBar(title: s.helpSupport, showBack: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        children: [
          Padding(
            padding: AppSpacing.page,
            child: Text(s.supportIntro, style: context.textTheme.bodyMedium),
          ),
          const SizedBox(height: AppSpacing.lg),
          ProfileSectionCard(
            title: s.contactUs,
            child: Column(
              children: [
                _ContactRow(
                  icon: Icons.call_outlined,
                  label: s.callUs,
                  value: localizeDigits(context, contacts.phone),
                ),
                Divider(color: colors.divider),
                _ContactRow(
                  icon: Icons.mail_outline_rounded,
                  label: s.emailUs,
                  value: contacts.email,
                ),
                Divider(color: colors.divider),
                _ContactRow(
                  icon: Icons.chat_outlined,
                  label: s.whatsapp,
                  value: localizeDigits(context, contacts.whatsapp),
                ),
              ],
            ),
          ),
          ProfileSectionCard(
            title: s.faq,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Column(
              children: [
                for (final item in s.faqItems)
                  Material(
                    color: Colors.transparent,
                    child: ExpansionTile(
                      shape: const Border(),
                      collapsedShape: const Border(),
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: const EdgeInsets.only(
                        bottom: AppSpacing.md,
                      ),
                      iconColor: colors.accent,
                      collapsedIconColor: colors.iconMuted,
                      title: Text(item.q, style: context.textTheme.titleSmall),
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.a,
                            style: context.textTheme.bodySmall,
                          ),
                        ),
                      ],
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

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.chipBackground,
            ),
            child: Icon(icon, size: 18, color: colors.accent),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: context.textTheme.titleSmall),
                Text(
                  value,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: colors.iconMuted),
        ],
      ),
    );
  }
}
