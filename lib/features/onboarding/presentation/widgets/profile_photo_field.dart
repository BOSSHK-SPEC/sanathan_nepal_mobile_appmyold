import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/media/media_upload_action.dart';
import '../../../../core/media/media_bucket.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../l10n/onboarding_strings.dart';

/// Optional profile photo on the registration form.
///
/// Shows the photo itself rather than a file name, so the person can see what
/// others will see. Optional by design: nobody should be stopped at the door
/// of the app for not having a photo to hand — it can be added from the
/// profile any time.
///
/// Uploads to the public bucket, as the profile editor does: avatars appear
/// beside reviews, chats and bookings, so they need a durable URL.
class ProfilePhotoField extends StatefulWidget {
  const ProfilePhotoField({
    required this.url,
    required this.name,
    required this.onChanged,
    super.key,
  });

  /// Uploaded photo URL, or null when none has been picked.
  final String? url;

  /// For the initials shown until there is a photo.
  final String name;

  /// Receives the new URL, or null when the photo is removed.
  final ValueChanged<String?> onChanged;

  @override
  State<ProfilePhotoField> createState() => _ProfilePhotoFieldState();
}

class _ProfilePhotoFieldState extends State<ProfilePhotoField> {
  bool _busy = false;

  Future<void> _pick() async {
    final title = OnboardingStrings.of(context).profilePhoto;
    setState(() => _busy = true);
    try {
      final uploaded = await pickAndUploadMedia(
        context,
        bucket: MediaBucket.publicCatalog,
        title: title,
      );
      if (uploaded != null && mounted) widget.onChanged(uploaded.url);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    final colors = context.colors;
    final url = widget.url;
    final hasPhoto = url != null && url.isNotEmpty;

    return Row(
      children: [
        SizedBox(
          width: 72,
          height: 72,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AppAvatar(
                source: hasPhoto ? url : null,
                name: widget.name,
                size: 72,
                onTap: _busy ? null : _pick,
              ),
              if (_busy)
                const SizedBox(
                  width: 72,
                  height: 72,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: AppSpacing.xs,
                children: [
                  Text(s.profilePhoto, style: context.textTheme.titleSmall),
                  Text(
                    '(${s.optionalField})',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: AppSpacing.xs,
                children: [
                  TextButton.icon(
                    onPressed: _busy ? null : _pick,
                    icon: const Icon(Icons.photo_camera_outlined, size: 18),
                    label: Text(hasPhoto ? s.changePhoto : s.addPhoto),
                  ),
                  if (hasPhoto)
                    TextButton(
                      onPressed: _busy ? null : () => widget.onChanged(null),
                      child: Text(context.l10n.removePhoto),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
