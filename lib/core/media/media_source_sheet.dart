import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';
import 'media_bucket.dart';
import 'media_picker.dart';

/// "Take a photo / Choose from gallery / Choose a file" sheet.
///
/// One sheet for every upload point in the app: the same two choices in the
/// same order everywhere is what makes uploading feel like one feature rather
/// than six.
///
/// Camera and gallery only. A document is photographed rather than attached as
/// a PDF — the file-browser plugin cannot be added without downgrading
/// `flutter_secure_storage`, which is where the refresh token lives, and that
/// is not a trade worth making for a second way to attach a licence.
class MediaSourceSheet extends StatelessWidget {
  const MediaSourceSheet({required this.bucket, super.key, this.title});

  final MediaBucket bucket;
  final String? title;

  /// Returns the chosen source, or null if the sheet was dismissed.
  static Future<MediaSource?> show(
    BuildContext context, {
    required MediaBucket bucket,
    String? title,
  }) => showModalBottomSheet<MediaSource>(
    context: context,
    useSafeArea: true,
    builder: (_) => MediaSourceSheet(bucket: bucket, title: title),
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title ?? l10n.addAPhoto,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                Text(
                  l10n.maxFileSize(bucket.maxSizeLabel),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.photo_camera_outlined, color: colors.icon),
            title: Text(l10n.takeAPhoto),
            onTap: () => Navigator.of(context).pop(MediaSource.camera),
          ),
          ListTile(
            leading: Icon(Icons.photo_library_outlined, color: colors.icon),
            title: Text(l10n.chooseFromGallery),
            onTap: () => Navigator.of(context).pop(MediaSource.gallery),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}
