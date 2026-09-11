import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';
import 'app_image.dart';

/// How an upload target renders. One widget replaces the three feature-local
/// upload widgets (marketplace dropzone, appointment box, profile placeholder).
enum UploadVariant {
  /// Large dashed drop area — product images, KYC documents.
  dropzone,

  /// Compact square tile, used in a grid of already-picked images.
  tile,

  /// Wide row with an icon and helper text — single-file pickers.
  row,
}

/// Empty-or-filled upload target.
///
/// Purely presentational: it reports taps and removals, and the calling
/// cubit owns the picked files. That keeps the picker implementation
/// swappable without touching any screen.
class AppUploadField extends StatelessWidget {
  const AppUploadField({
    required this.onTap,
    super.key,
    this.variant = UploadVariant.dropzone,
    this.label,
    this.helper,
    this.source,
    this.onRemove,
    this.height,
    this.icon = Icons.cloud_upload_outlined,
    this.error,
    this.enabled = true,
    this.busy = false,
    this.filledLabel,
  });

  final VoidCallback onTap;
  final UploadVariant variant;

  /// Shown above the field.
  final String? label;

  /// Instruction text inside the empty state (e.g. "PNG or JPG, max 5 MB").
  final String? helper;

  /// Asset path or URL of the already-picked file; switches to the filled
  /// state when non-null.
  final String? source;
  final VoidCallback? onRemove;
  final double? height;
  final IconData icon;
  final String? error;

  /// Shown in place of a preview once a file is attached.
  ///
  /// Set it whenever [source] is not something that can be drawn — a private
  /// document is stored by id and fetched through a signed link, so rendering
  /// it as an image gives the user a broken picture box, and printing the id
  /// gives them a 26-character string that means nothing.
  final String? filledLabel;
  final bool enabled;

  /// Work is in flight against this field — an upload finishing, or a removal
  /// waiting on the server.
  ///
  /// Distinct from `enabled: false`: that says the field is not the user's to
  /// touch, this says it is theirs and is busy. Without the distinction a
  /// removal that takes a second looks like a tap that did nothing, and the
  /// second tap is the one that causes trouble.
  final bool busy;

  bool get _filled => source != null;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final resolvedHeight =
        height ??
        switch (variant) {
          UploadVariant.dropzone => 140.0,
          UploadVariant.tile => 84.0,
          UploadVariant.row => 64.0,
        };

    final field = Opacity(
      opacity: enabled ? 1 : 0.5,
      child: GestureDetector(
        onTap: enabled && !busy ? onTap : null,
        child: Container(
          height: resolvedHeight,
          width: variant == UploadVariant.tile
              ? resolvedHeight
              : double.infinity,
          decoration: BoxDecoration(
            color: colors.surfaceVariant.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: error != null
                  ? colors.error
                  : colors.border.withValues(alpha: 0.9),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (_filled)
                _Filled(
                  source: source!,
                  label: filledLabel,
                  // The × goes while work is in flight: leaving it tappable
                  // invites a second removal of something already gone.
                  onRemove: busy ? null : onRemove,
                )
              else
                _Empty(variant: variant, icon: icon, helper: helper),
              if (busy)
                ColoredBox(
                  color: colors.surface.withValues(alpha: 0.7),
                  child: const Center(
                    child: SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    if (label == null && error == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: context.textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
        ],
        field,
        if (error != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            error!,
            style: context.textTheme.labelSmall?.copyWith(color: colors.error),
          ),
        ],
      ],
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.variant, required this.icon, this.helper});

  final UploadVariant variant;
  final IconData icon;
  final String? helper;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    if (variant == UploadVariant.row) {
      return Row(
        children: [
          const SizedBox(width: AppSpacing.lg),
          Icon(icon, color: colors.accent, size: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              helper ?? '',
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: colors.iconMuted),
          const SizedBox(width: AppSpacing.sm),
        ],
      );
    }

    final compact = variant == UploadVariant.tile;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: colors.accent, size: compact ? 22 : 30),
        if (helper != null && !compact) ...[
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              helper!,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.textMuted,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Filled extends StatelessWidget {
  const _Filled({required this.source, this.label, this.onRemove});

  final String source;
  final String? label;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (label case final text?)
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 18,
                  color: colors.success,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(text, style: context.textTheme.bodyMedium),
              ],
            ),
          )
        else
          AppImage(source),
        if (onRemove != null)
          Positioned(
            top: AppSpacing.xs,
            right: AppSpacing.xs,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 14,
                  color: colors.onPrimary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
