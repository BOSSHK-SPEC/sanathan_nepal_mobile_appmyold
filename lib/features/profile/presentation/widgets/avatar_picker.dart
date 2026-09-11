import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/profile_strings.dart';

/// "Profile photo *" row: a name box and a camera button.
///
/// The widget owns the presentation only. Picking and uploading belong to the
/// page, which knows which bucket the file goes to and what to do with the id
/// that comes back — a shared field widget that also uploaded would have to
/// know both, for every screen that uses it.
class AvatarPicker extends StatelessWidget {
  const AvatarPicker({
    required this.fileName,
    required this.onTap,
    super.key,
    this.label,
    this.required = true,
  });

  final String? fileName;

  /// Opens the picker. Async work is the page's business.
  final VoidCallback onTap;
  final String? label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label ?? s.profilePhoto,
            style: context.textTheme.titleSmall,
            children: [
              if (required)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: colors.error),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border.all(color: colors.border),
                  borderRadius: AppRadius.input,
                  color: colors.surface,
                ),
                child: Text(
                  fileName ?? s.noFileChosen,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: fileName == null
                        ? colors.textMuted
                        : colors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Material(
              color: colors.chipBackground,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onTap,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.photo_camera_outlined,
                    size: 20,
                    color: colors.accent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
