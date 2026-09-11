import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/profile_strings.dart';

/// Dashed "upload" box used for business documents.
///
/// Presentation only: the page owns picking and uploading, because it is the
/// page that knows which bucket the file belongs in.
class UploadPlaceholder extends StatelessWidget {
  const UploadPlaceholder({
    required this.label,
    required this.onTap,
    super.key,
    this.hint,
    this.files = const [],
    this.labelFor,
  });

  final String label;
  final String? hint;

  /// Stored references — media ids, not names.
  final List<String> files;

  /// Opens the picker.
  final VoidCallback onTap;

  /// How each stored reference is described. Defaults to "Document N",
  /// because a media id is a 26-character string that tells the user nothing.
  final String Function(BuildContext context, int index)? labelFor;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  color: colors.accent,
                  size: 28,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  files.isEmpty
                      ? s.noFileChosen
                      : [
                          for (var i = 0; i < files.length; i++)
                            labelFor?.call(context, i) ??
                                s.documentNumber(i + 1),
                        ].join(', '),
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: files.isEmpty
                        ? colors.textMuted
                        : colors.textPrimary,
                  ),
                ),
                if (hint != null)
                  Text(
                    hint!,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
