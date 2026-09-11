import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// Numbered progress header for multi-step wizards — KYC, booking,
/// checkout, product form. Replaces the two feature-local step headers.
///
/// Steps before [currentIndex] render as complete and are tappable when
/// [onStepTapped] is given (so a user can go back but not skip ahead).
class AppStepper extends StatelessWidget {
  const AppStepper({
    required this.steps,
    required this.currentIndex,
    super.key,
    this.onStepTapped,
    this.showLabels = true,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.pageGutter,
      vertical: AppSpacing.lg,
    ),
  });

  final List<String> steps;
  final int currentIndex;
  final ValueChanged<int>? onStepTapped;
  final bool showLabels;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: padding,
      child: Column(
        children: [
          Row(
            children: List.generate(steps.length * 2 - 1, (slot) {
              if (slot.isOdd) {
                final leftIndex = slot ~/ 2;
                return Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                    ),
                    color: leftIndex < currentIndex
                        ? colors.accent
                        : colors.divider,
                  ),
                );
              }
              final i = slot ~/ 2;
              final done = i < currentIndex;
              final active = i == currentIndex;
              final reachable = i <= currentIndex && onStepTapped != null;

              final marker = Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: active ? colors.primaryGradient : null,
                  color: done
                      ? colors.accent
                      : active
                      ? null
                      : colors.surfaceVariant,
                  border: done || active
                      ? null
                      : Border.all(color: colors.border),
                ),
                alignment: Alignment.center,
                child: done
                    ? Icon(
                        Icons.check_rounded,
                        size: 15,
                        color: colors.onPrimary,
                      )
                    : Text(
                        '${i + 1}',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: active ? colors.onPrimary : colors.textMuted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              );

              return Semantics(
                label: steps[i],
                selected: active,
                child: reachable
                    ? GestureDetector(
                        onTap: () => onStepTapped!(i),
                        child: marker,
                      )
                    : marker,
              );
            }),
          ),
          if (showLabels) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: List.generate(steps.length, (i) {
                final active = i == currentIndex;
                return Expanded(
                  child: Text(
                    steps[i],
                    textAlign: i == 0
                        ? TextAlign.start
                        : i == steps.length - 1
                        ? TextAlign.end
                        : TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: active ? colors.accent : colors.textMuted,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }
}

/// "Step 2 of 5" line plus a title — the compact variant for sheets and
/// screens too narrow for the dotted stepper.
class StepHeading extends StatelessWidget {
  const StepHeading({
    required this.stepLabel,
    required this.title,
    super.key,
    this.subtitle,
  });

  final String stepLabel;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepLabel.toUpperCase(),
          style: context.textTheme.labelSmall?.copyWith(
            color: colors.accent,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(title, style: context.textTheme.headlineMedium),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle!,
            style: context.textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}
