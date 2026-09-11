import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/utils/localized_text.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../domain/entities/astrologer.dart';
import '../l10n/astrologers_strings.dart';

/// Presence pill: available / busy with a wait / offline.
///
/// Three states rather than a boolean, because "online with twelve people
/// ahead" is a materially different offer from "online and free right now"
/// and the card must not present them the same way.
class AstrologerPresence extends StatelessWidget {
  const AstrologerPresence({
    required this.astrologer,
    super.key,
    this.dense = true,
  });

  final Astrologer astrologer;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);

    if (!astrologer.isOnline) {
      return StatusChip(
        label: s.offline,
        dense: dense,
        icon: Icons.circle_outlined,
      );
    }
    if (astrologer.isBusy) {
      return StatusChip(
        label: s.waitingCount(
          localizeCount(context, astrologer.queueLength),
          localizeCount(context, astrologer.estimatedWaitMinutes),
        ),
        tone: StatusTone.warning,
        dense: dense,
        icon: Icons.hourglass_bottom_rounded,
      );
    }
    return StatusChip(
      label: s.free,
      tone: StatusTone.success,
      dense: dense,
      icon: Icons.circle,
    );
  }
}

/// Digits in the active script — Devanagari for Nepali and Hindi.
String localizeCount(BuildContext context, num value) {
  final raw = value.toString();
  return context.usesDevanagariDigits ? raw.toDevanagariDigits() : raw;
}

/// Picks the right language out of a [LocalizedText] for the active locale.
String localized(BuildContext context, LocalizedText text) =>
    text.forLanguage(context.languageCode);
