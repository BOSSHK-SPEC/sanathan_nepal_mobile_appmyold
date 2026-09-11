import '../../../../core/constants/app_assets.dart';
import '../../../../core/region/region.dart';
import '../../../../core/utils/localized_text.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../../domain/entities/sitting_option.dart';

/// Astrologers the mock data source offers for booking.
///
/// These mirror what `/astrologers` returns, trimmed to what booking needs: a
/// name, a headline, a rating and a rate per channel. Bios, credentials and
/// reviews live with the astrologer profile, not here.

/// Featured Nepal astrologer from the Figma "Appointment" page.
const String featuredAstrologerId = 'dr-uttam-upadhyaya';

/// Featured India astrologers (Varanasi / Delhi) – INR rates.
const String indiaFeaturedAstrologerId = 'pandit-rajesh-sharma';
const String indiaSecondAstrologerId = 'acharya-meera-iyer';

/// Astrologers offered in a region. Prices are in the region's currency.
List<BookableAstrologer> astrologersFor(RegionConfig config) =>
    config.isIndia ? indiaAstrologers : nepalAstrologers;

/// Every seeded astrologer across regions (used to resolve ids from
/// appointments made before a region switch).
List<BookableAstrologer> get allAstrologers => [
  ...nepalAstrologers,
  ...indiaAstrologers,
];

List<BookableAstrologer> get nepalAstrologers => [featuredAstrologer];

List<BookableAstrologer> get indiaAstrologers => [
  indiaFeaturedAstrologer,
  indiaSecondAstrologer,
];

/// Builds the sittings from per-minute rates, exactly as the live source does
/// — so the mock cannot drift into offering a shape the server never sends.
List<SittingOption> sittingsFrom({
  required int chatPerMinute,
  int? voicePerMinute,
  int? videoPerMinute,
  int minutes = 30,
}) {
  SittingOption build(SittingChannel channel, int perMinute) => SittingOption(
    id: channel.wireName,
    channel: channel,
    name: channel.displayName,
    price: perMinute * minutes,
    ratePerMinute: perMinute.toDouble(),
    description: const LocalizedText(en: '', ne: ''),
    durationMinutes: minutes,
  );

  return List.unmodifiable([
    build(SittingChannel.chat, chatPerMinute),
    if (voicePerMinute != null) build(SittingChannel.voice, voicePerMinute),
    if (videoPerMinute != null) build(SittingChannel.video, videoPerMinute),
  ]);
}

final List<SittingOption> _nepalSittings = sittingsFrom(
  chatPerMinute: 20,
  voicePerMinute: 35,
  videoPerMinute: 50,
);

/// The cheapest sitting with the featured Nepal astrologer — the one seeded
/// appointments are made against.
final SittingOption chatSitting = _nepalSittings.first;

final BookableAstrologer featuredAstrologer = BookableAstrologer(
  id: featuredAstrologerId,
  name: const LocalizedText(
    ne: 'डा. उत्तम उपाध्याय न्यौपाने (ज्योतिष)',
    en: 'Dr. Uttam Upadhyaya (Astrologer)',
  ),
  title: const LocalizedText(
    ne: 'ज्योतिष तथा वास्तु विज्ञ',
    en: 'Astrology & Vaastu Expert',
  ),
  rating: 4.5,
  reviewCount: 42,
  avatarAsset: AppAssets.image('Ellipse 6.png'),
  services: _nepalSittings,
  isOnline: true,
  isVerified: true,
);

// ---------------------------------------------------------------------------
// India seeds (INR rates, IST).
// ---------------------------------------------------------------------------

final List<SittingOption> _indiaSittings = sittingsFrom(
  chatPerMinute: 25,
  voicePerMinute: 40,
  videoPerMinute: 60,
);

/// The cheapest sitting with the featured India astrologer.
final SittingOption indiaChatSitting = _indiaSittings.first;

final BookableAstrologer indiaFeaturedAstrologer = BookableAstrologer(
  id: indiaFeaturedAstrologerId,
  name: const LocalizedText(
    ne: 'पण्डित राजेश शर्मा',
    en: 'Pandit Rajesh Sharma',
    hi: 'पंडित राजेश शर्मा',
  ),
  title: const LocalizedText(
    ne: 'वैदिक ज्योतिष',
    en: 'Vedic Astrologer',
    hi: 'वैदिक ज्योतिषी',
  ),
  rating: 4.7,
  reviewCount: 128,
  services: _indiaSittings,
  isVerified: true,
);

final BookableAstrologer indiaSecondAstrologer = BookableAstrologer(
  id: indiaSecondAstrologerId,
  name: const LocalizedText(
    ne: 'आचार्य मीरा अय्यर',
    en: 'Acharya Meera Iyer',
    hi: 'आचार्य मीरा अय्यर',
  ),
  title: const LocalizedText(
    ne: 'ज्योतिष तथा वास्तु सल्लाहकार',
    en: 'Astrology & Vaastu Consultant',
    hi: 'ज्योतिष एवं वास्तु सलाहकार',
  ),
  rating: 4.4,
  reviewCount: 61,
  services: sittingsFrom(chatPerMinute: 18, videoPerMinute: 45),
  isOnline: true,
);
