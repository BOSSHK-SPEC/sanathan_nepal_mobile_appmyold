import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/appointment_strings.dart';

/// Step indicator of the booking flow (Figma `759:2419`): three
/// icon + label buttons "Basic Info · Details · Payment", active one filled.
class BookingStepHeader extends StatelessWidget {
  const BookingStepHeader({
    required this.currentStep,
    super.key,
    this.onStepTap,
    this.completedThrough = -1,
  });

  final int currentStep;

  /// Steps up to this index may be tapped (already visited).
  final int completedThrough;
  final ValueChanged<int>? onStepTap;

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    final colors = context.colors;
    final steps = [
      (Icons.access_time, strings.stepBasicInfo),
      (Icons.info_outline, strings.stepDetails),
      (Icons.check_circle_outline, strings.stepPayment),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: List.generate(steps.length, (i) {
          final active = i == currentStep;
          final enabled = onStepTap != null && i <= completedThrough;
          final (icon, label) = steps[i];
          return Expanded(
            child: InkWell(
              onTap: enabled ? () => onStepTap!(i) : null,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: active ? colors.primaryGradient : null,
                      color: active ? null : colors.chipBackground,
                    ),
                    child: Icon(
                      icon,
                      size: 14,
                      color: active ? colors.onPrimary : colors.iconMuted,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelMedium?.copyWith(
                        fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                        color: active ? colors.textPrimary : colors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
