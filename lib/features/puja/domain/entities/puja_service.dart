import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/localized_text.dart';

part 'puja_service.freezed.dart';

/// How the ritual is performed for the devotee.
///
/// The distinction is not cosmetic: an at-home puja needs an address and a
/// travelling priest, a temple puja needs neither, and an online one needs a
/// stream. They price differently for the same reason.
enum PujaMode {
  /// Performed at a temple on the devotee's behalf, streamed live.
  templeOnline,

  /// A priest visits the devotee's home.
  atHome,
}

/// What the devotee is asking the puja for. Used to group the catalogue —
/// people arrive with a problem, not a ritual name.
enum PujaPurpose {
  prosperity,
  health,
  marriage,
  career,
  protection,
  ancestors,
  education,
}

/// A ritual that can be booked.
@freezed
abstract class PujaService with _$PujaService {
  const PujaService._();

  const factory PujaService({
    required String id,
    required LocalizedText name,
    required LocalizedText summary,
    required PujaPurpose purpose,
    required double basePrice,

    /// How long the ritual itself takes, so a devotee attending live knows
    /// what they are setting aside.
    required Duration duration,

    /// Modes actually offered. A ritual needing a fire pit may be at-home
    /// only; one needing a specific temple may be online only.
    @Default(<PujaMode>[PujaMode.templeOnline]) List<PujaMode> modes,

    /// Where a temple puja is performed.
    LocalizedText? templeName,

    /// Steps of the ritual, shown before booking.
    @Default(<LocalizedText>[]) List<LocalizedText> procedure,

    /// Materials the priest brings, as an optional add-on.
    @Default(0) double samagriPrice,

    /// Surcharge for a priest travelling to the devotee.
    @Default(0) double atHomeSurcharge,

    /// Number of priests performing it — a real price driver in listings.
    @Default(1) int priestCount,
    @Default(0) int bookingsThisMonth,
    @Default(false) bool isPopular,
  }) = _PujaService;

  bool get supportsAtHome => modes.contains(PujaMode.atHome);

  bool get supportsOnline => modes.contains(PujaMode.templeOnline);

  bool get includesSamagriOption => samagriPrice > 0;

  /// Total for a chosen configuration. Kept on the entity so the booking
  /// screen, the summary and the receipt cannot compute it differently.
  double priceFor({required PujaMode mode, required bool withSamagri}) =>
      basePrice +
      (mode == PujaMode.atHome ? atHomeSurcharge : 0) +
      (withSamagri ? samagriPrice : 0);
}
