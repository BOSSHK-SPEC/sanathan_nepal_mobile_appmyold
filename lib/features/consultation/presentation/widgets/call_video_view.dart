import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../l10n/consultation_strings.dart';

/// The video half of a call: the other person, full-bleed, with your own
/// camera inset.
///
/// This is the one widget in the app that knows a media SDK exists. The room
/// arrives untyped from the cubit and is checked here — so a build with calls
/// switched off, or a session that has not connected yet, renders the
/// placeholder instead of crashing.
///
/// It listens to the room itself rather than going through cubit state: tracks
/// appear, mute and disappear several times in a normal call, and routing each
/// of those through a state emission would put a rebuild of the whole call
/// screen behind every camera toggle.
class CallVideoView extends StatelessWidget {
  const CallVideoView({
    required this.room,
    required this.placeholderName,
    this.avatarUrl,
    super.key,
  });

  /// The LiveKit `Room`, or null when there is no call. Untyped because `core`
  /// hands it through without depending on the SDK.
  final Object? room;

  /// Shown while there is no picture — the person you are talking to.
  final String placeholderName;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final room = this.room;
    if (room is! Room) {
      return _Placeholder(
        name: placeholderName,
        avatarUrl: avatarUrl,
        label: ConsultationStrings.of(context).waitingForOther,
      );
    }

    return ListenableBuilder(
      listenable: room,
      builder: (context, _) {
        final s = ConsultationStrings.of(context);
        final remote = _liveVideo(
          room.remoteParticipants.values.expand((p) => p.videoTrackPublications),
        );
        final local = _liveVideo(room.localParticipant?.videoTrackPublications ?? const []);

        return Stack(
          fit: StackFit.expand,
          children: [
            if (remote != null)
              ClipRRect(
                borderRadius: AppRadius.card,
                // Cover, not contain: a letterboxed face on a phone screen
                // wastes the half of the display the call is about.
                child: VideoTrackRenderer(remote, fit: VideoViewFit.cover),
              )
            else
              _Placeholder(
                name: placeholderName,
                avatarUrl: avatarUrl,
                // Two different situations, and the difference matters: nobody
                // has joined yet, or they are here with the camera off.
                label: room.remoteParticipants.isEmpty
                    ? s.waitingForOther
                    : s.cameraOff,
              ),
            if (local != null)
              Positioned(
                right: AppSpacing.md,
                top: AppSpacing.md,
                width: 96,
                height: 128,
                child: ClipRRect(
                  borderRadius: AppRadius.input,
                  child: VideoTrackRenderer(
                    local,
                    fit: VideoViewFit.cover,
                    // Mirrored, because a self-view that is not mirrored feels
                    // wrong to everyone who has ever used a mirror.
                    mirrorMode: VideoViewMirrorMode.mirror,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  /// The first track that is both subscribed and not muted.
  ///
  /// A muted publication still has a track attached; rendering it shows a
  /// frozen last frame, which reads as a broken call rather than a closed
  /// camera.
  static VideoTrack? _liveVideo(
    Iterable<TrackPublication<VideoTrack>> publications,
  ) {
    for (final publication in publications) {
      final track = publication.track;
      if (track != null && !publication.muted) return track;
    }
    return null;
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.name, required this.label, this.avatarUrl});

  final String name;
  final String label;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceVariant,
        borderRadius: AppRadius.card,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAvatar(source: avatarUrl, name: name, size: 96),
          const SizedBox(height: AppSpacing.lg),
          Text(name, style: context.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
