import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/localized_text.dart';

part 'sitting_option.freezed.dart';

/// How a sitting is held.
///
/// An astrologer prices each channel separately in the console, so the channel
/// is what the seeker is really choosing when they pick a "service" — the same
/// half hour costs more on video than in chat.
enum SittingChannel {
  chat,
  voice,
  video;

  static SittingChannel? tryParse(String raw) => switch (raw) {
    'chat' => SittingChannel.chat,
    'voice' || 'call' => SittingChannel.voice,
    'video' => SittingChannel.video,
    _ => null,
  };

  /// The value the API names this channel by.
  String get wireName => name;

  /// What a seeker calls this channel.
  ///
  /// It lives here rather than in the presentation strings because the name
  /// travels with the booking: it is stored on the appointment, rendered in
  /// the wizard, on the summary card and on the details page. One definition
  /// means those cannot drift into calling the same sitting three things.
  LocalizedText get displayName => switch (this) {
    SittingChannel.chat => const LocalizedText(
      en: 'Chat',
      ne: 'च्याट',
      hi: 'चैट',
    ),
    SittingChannel.voice => const LocalizedText(
      en: 'Voice call',
      ne: 'फोन कल',
      hi: 'वॉइस कॉल',
    ),
    SittingChannel.video => const LocalizedText(
      en: 'Video call',
      ne: 'भिडियो कल',
      hi: 'वीडियो कॉल',
    ),
  };
}

/// One bookable sitting with an astrologer — a channel, a length and a price.
///
/// Replaces the old astrologer "service": a centre published a menu of named
/// services, whereas an astrologer sells their own time, so the menu is
/// generated from the per-minute rates they set rather than typed by hand.
@freezed
abstract class SittingOption with _$SittingOption {
  const factory SittingOption({
    required String id,
    required SittingChannel channel,
    required LocalizedText name,

    /// Whole-sitting price in the astrologer's currency (NPR / INR), i.e.
    /// [ratePerMinute] × [durationMinutes] — formatted in presentation via
    /// `RegionFormat.money`. The server re-computes this at booking time, so
    /// it is a quote, never the authority.
    required int price,

    /// What the astrologer charges per minute, in the same currency.
    ///
    /// Carried beside [price] so the UI can show where the total came from.
    /// A bare "₹30,000" beside a profile advertising "from ₹1,000/min" reads
    /// as a bug even when it is arithmetic — the two numbers are the same
    /// fact, and the screen has to say so.
    @Default(0) double ratePerMinute,
    required LocalizedText description,
    @Default(30) int durationMinutes,
  }) = _SittingOption;
}
