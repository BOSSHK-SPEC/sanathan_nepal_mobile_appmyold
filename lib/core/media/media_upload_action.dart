import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../error/exceptions.dart';
import '../extensions/context_extensions.dart';
import '../theme/app_spacing.dart';
import 'media_bucket.dart';
import 'media_service.dart';
import 'media_source_sheet.dart';
import 'picked_media.dart';
import 'media_uploader.dart';

/// Pick a file and upload it, with the progress and error handling every
/// caller would otherwise write again.
///
/// Uploading is slow enough to need feedback and fallible enough to need a
/// message, so doing it "inline" in a form ends up as the same forty lines in
/// six places. This is that code, once:
///
///  * a source sheet (camera / gallery / files),
///  * a blocking progress dialog, shown only once a file has actually been
///    chosen — the file is going into the thing being edited, so letting the
///    form be submitted mid-upload would save a half-uploaded reference,
///  * one snackbar for every failure mode, in the user's language.
///
/// Returns null when the user cancelled or the upload failed; the caller only
/// has to handle success.
Future<UploadedMedia?> pickAndUploadMedia(
  BuildContext context, {
  required MediaBucket bucket,
  String? title,
  MediaService? service,
}) async {
  final source = await MediaSourceSheet.show(
    context,
    bucket: bucket,
    title: title,
  );
  if (source == null || !context.mounted) return null;

  final media = service ?? GetIt.I<MediaService>();

  // Pick first, with nothing on top of the picker.
  final PickedMedia? file;
  try {
    file = await media.pick(source: source, bucket: bucket);
  } on Object catch (error) {
    if (context.mounted) _showError(context, error);
    return null;
  }
  if (file == null || !context.mounted) return null;

  // Only now is there something slow to report.
  final progress = ValueNotifier<double>(0);
  var dialogOpen = true;
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _UploadProgressDialog(progress: progress),
    ).then((_) => dialogOpen = false),
  );

  try {
    return await media.upload(
      file: file,
      bucket: bucket,
      onProgress: (value) => progress.value = value,
    );
  } on Object catch (error) {
    if (context.mounted) _showError(context, error);
    return null;
  } finally {
    if (dialogOpen && context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
    progress.dispose();
  }
}

void _showError(BuildContext context, Object error) {
  final message = switch (error) {
    ValidationException(:final message) => message,
    PermissionException(:final message) => message,
    NetworkException() => context.l10n.uploadFailed,
    ServerException(:final message) => message,
    _ => context.l10n.uploadFailed,
  };

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

class _UploadProgressDialog extends StatelessWidget {
  const _UploadProgressDialog({required this.progress});

  final ValueNotifier<double> progress;

  @override
  Widget build(BuildContext context) => AlertDialog(
    content: Row(
      children: [
        ValueListenableBuilder<double>(
          valueListenable: progress,
          builder: (context, value, _) => SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              // Indeterminate until the first byte report, so the ring does
              // not sit frozen at zero while the slot is being created.
              value: value <= 0 ? null : value,
              strokeWidth: 3,
              color: context.colors.accent,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(child: Text(context.l10n.uploading)),
      ],
    ),
  );
}
