import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/localized_text.dart';
import 'sitting_option.dart';

part 'bookable_astrologer.freezed.dart';

/// An astrologer as the *booking* flow sees them: enough to pick who to book
/// and what a sitting costs, and nothing more.
///
/// Their bio, credentials and reviews are deliberately absent. Those belong to
/// the astrologer profile in the astrologers feature — the one screen in the
/// app that shows a person — and duplicating them here is what produced two
/// near-identical profiles that then drifted apart.
@freezed
abstract class BookableAstrologer with _$BookableAstrologer {
  const BookableAstrologer._();

  const factory BookableAstrologer({
    required String id,
    required LocalizedText name,

    /// Headline, e.g. "Vedic astrologer, 15 years".
    required LocalizedText title,
    required double rating,
    required int reviewCount,

    /// The sittings on offer, cheapest first.
    required List<SittingOption> services,

    /// Live right now. Offline astrologers are still bookable — that is the
    /// whole point of the slot calendar — so this only changes the wording.
    @Default(false) bool isOnline,
    @Default(false) bool isVerified,
    String? avatarAsset,
  }) = _BookableAstrologer;

  /// Cheapest sitting, for the "from Rs. X" line on the picker card.
  SittingOption? get cheapestSitting => services.isEmpty
      ? null
      : services.reduce((a, b) => a.price <= b.price ? a : b);

  /// Whether anything can actually be booked. An astrologer who has priced
  /// nothing is listed but cannot be opened onto an empty wizard.
  bool get isBookable => services.isNotEmpty;
}
