import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/application.dart';
import '../cubit/application_cubit.dart';
import '../l10n/console_strings.dart';

/// The pitch, then the application.
///
/// Routes straight past itself once an application exists: someone returning
/// mid-wizard wants their draft, not the sales page again.
class ApplyIntroPage extends StatelessWidget {
  const ApplyIntroPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<ApplicationCubit>()..load(),
    child: const _ApplyIntroView(),
  );
}

class _ApplyIntroView extends StatelessWidget {
  const _ApplyIntroView();

  @override
  Widget build(BuildContext context) {
    final s = ConsoleStrings.of(context);
    final colors = context.colors;

    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        final application = state.form;
        final started = application.status != ApplicationStatus.notStarted;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppTopBar(title: s.becomeAstrologer, showBack: true),
          body: SafeArea(
            top: false,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.pageGutter),
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    gradient: colors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        size: 30,
                        color: colors.onPrimary,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        s.applyIntroTitle,
                        style: context.textTheme.displaySmall?.copyWith(
                          color: colors.onPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        s.applyIntroBody,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: colors.onPrimary.withValues(alpha: 0.92),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text(s.requirements, style: context.textTheme.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                for (final (icon, label) in [
                  (Icons.badge_outlined, s.requirementId),
                  (Icons.school_outlined, s.requirementExperience),
                  (Icons.payments_outlined, s.requirementPricing),
                  (Icons.schedule_outlined, s.requirementTime),
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: Row(
                      children: [
                        Icon(icon, size: 19, color: colors.accent),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            label,
                            style: context.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (state.application.isLoaded && application.status.isTerminal)
                  const SizedBox.shrink(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(top: BorderSide(color: colors.divider)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: PrimaryButton(
                  label: started ? s.continueApplication : s.startApplication,
                  height: 46,
                  onPressed: () => context.push(
                    application.status.isEditable
                        ? AppRoutes.astrologerKyc
                        : AppRoutes.astrologerApplication,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
