import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../cubit/compliance_cubit.dart';
import '../l10n/console_strings.dart';

/// Dashboard strip shown only when notices are open.
///
/// Carries its own cubit so the dashboard is not coupled to compliance
/// loading, and renders nothing at all — not an empty box — when there is
/// nothing outstanding.
class ComplianceBanner extends StatelessWidget {
  const ComplianceBanner({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ComplianceCubit>()..load(),
    child: const _BannerBody(),
  );
}

class _BannerBody extends StatelessWidget {
  const _BannerBody();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<ComplianceCubit, ComplianceState>(
      buildWhen: (p, c) => p.open.length != c.open.length,
      builder: (context, state) {
        if (state.open.isEmpty) return const SizedBox.shrink();
        final tone = state.hasCritical ? colors.error : colors.warning;
        final headline = state.open.first;

        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.lg),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.md),
            onTap: () => context.push(AppRoutes.astrologerCompliance),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: tone.withValues(alpha: 0.35)),
              ),
              child: Row(
                children: [
                  Icon(Icons.gavel_rounded, size: 18, color: tone),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.complianceNeedsAction,
                          style: context.textTheme.labelLarge?.copyWith(
                            color: tone,
                          ),
                        ),
                        // Naming the first notice beats a bare count: the
                        // astrologer can tell at a glance whether it is a
                        // policy note or money being held back.
                        Text(
                          state.open.length == 1
                              ? headline.title
                              : '${headline.title} +${state.open.length - 1}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: colors.textMuted,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
