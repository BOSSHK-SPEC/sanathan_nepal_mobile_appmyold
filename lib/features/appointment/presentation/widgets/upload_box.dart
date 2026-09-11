import 'package:flutter/material.dart';

import '../../../../core/media/media_bucket.dart';
import '../../../../core/media/media_upload_action.dart';
import '../../../../core/widgets/app_upload_field.dart';
import '../l10n/appointment_strings.dart';

/// One attachment on the booking form — the customer's existing birth chart,
/// or the receipt for a transfer they have already made (Figma `766:2531`).
///
/// Both files are private: they are stored by media id and read back through a
/// short-lived signed link, so the filled state says the file is attached
/// rather than drawing a preview of something that has no public URL.
///
/// The widget owns nothing. It reports the uploaded media id and the removal,
/// and the booking cubit keeps them, so what is on screen and what is
/// submitted cannot drift apart.
class UploadBox extends StatelessWidget {
  const UploadBox({
    required this.label,
    required this.mediaId,
    required this.onChanged,
    super.key,
  });

  final String label;

  /// Media id of the attached file, or null while nothing is attached.
  final String? mediaId;

  /// Called with the new media id, or null when the file is removed.
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    final attached = mediaId != null;

    return AppUploadField(
      variant: UploadVariant.row,
      label: label,
      helper: attached
          ? null
          : strings.uploadHint(MediaBucket.privateDocs.maxSizeLabel),
      source: mediaId,
      filledLabel: strings.fileAttached,
      icon: attached
          ? Icons.check_circle_outline_rounded
          : Icons.cloud_upload_outlined,
      onRemove: attached ? () => onChanged(null) : null,
      onTap: () async {
        final uploaded = await pickAndUploadMedia(
          context,
          bucket: MediaBucket.privateDocs,
          title: label,
        );
        if (uploaded == null) return;
        onChanged(uploaded.mediaId);
      },
    );
  }
}
