import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';

/// State of a single [AppTimeline] step.
enum TimelineStepState { done, current, pending, failed }

/// One node on a vertical progress timeline.
class TimelineStep {
  const TimelineStep({
    required this.title,
    required this.state,
    this.subtitle,
    this.timestamp,
    this.trailing,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final String? timestamp;
  final TimelineStepState state;
  final Widget? trailing;
  final IconData? icon;
}

/// Vertical status timeline — order tracking, payout progress, KYC review,
/// appointment lifecycle.
///
/// Connector segments are coloured by the state of the step *above* them, so
/// the completed portion of the line reads as one continuous run.
class AppTimeline extends StatelessWidget {
  const AppTimeline({
    required this.steps,
    super.key,
    this.padding = EdgeInsets.zero,
  });

  final List<TimelineStep> steps;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    Color colorFor(TimelineStepState s) => switch (s) {
      TimelineStepState.done => colors.success,
      TimelineStepState.current => colors.accent,
      TimelineStepState.pending => colors.textMuted.withValues(alpha: 0.5),
      TimelineStepState.failed => colors.error,
    };

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(steps.length, (i) {
          final step = steps[i];
          final isLast = i == steps.length - 1;
          final color = colorFor(step.state);
          final done = step.state == TimelineStepState.done;
          final current = step.state == TimelineStepState.current;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done || current ? color : Colors.transparent,
                        border: Border.all(color: color, width: 2),
                      ),
                      child: done
                          ? Icon(
                              Icons.check_rounded,
                              size: 14,
                              color: colors.onPrimary,
                            )
                          : step.state == TimelineStepState.failed
                          ? Icon(Icons.close_rounded, size: 14, color: color)
                          : null,
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          color: done ? colors.success : colors.divider,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: isLast ? 0 : AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                step.title,
                                style: context.textTheme.titleSmall?.copyWith(
                                  color: step.state == TimelineStepState.pending
                                      ? colors.textMuted
                                      : colors.textPrimary,
                                  fontWeight: current
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            if (step.timestamp != null)
                              Text(
                                step.timestamp!,
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: colors.textMuted,
                                ),
                              ),
                            if (step.trailing != null) ...[
                              const SizedBox(width: AppSpacing.sm),
                              step.trailing!,
                            ],
                          ],
                        ),
                        if (step.subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            step.subtitle!,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
