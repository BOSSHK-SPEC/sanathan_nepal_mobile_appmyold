import '../../domain/entities/horoscope_media.dart';
import '../../domain/entities/sign_profile.dart';
import '../../domain/entities/zodiac_sign.dart';
import 'horoscope_profile_seed_en.dart';
import 'horoscope_profile_seed_hi.dart';
import 'horoscope_profile_seed_ne.dart';

/// Builds the "about the sign" [SignProfile] of [sign] from the trilingual
/// seed tables (about, man, personality, career, money, health, career
/// point, relationships).
SignProfile horoscopeProfileFor(ZodiacSign sign) {
  final en = horoscopeProfileSeedEn[sign]!;
  final ne = horoscopeProfileSeedNe[sign]!;
  final hi = horoscopeProfileSeedHi[sign]!;
  final points = [
    SignProfilePoint(
      labelNe: 'पैसा',
      labelEn: 'Money',
      labelHi: 'धन',
      textNe: ne[4],
      textEn: en[4],
      textHi: hi[4],
    ),
    SignProfilePoint(
      labelNe: 'स्वास्थ्य',
      labelEn: 'Health',
      labelHi: 'स्वास्थ्य',
      textNe: ne[5],
      textEn: en[5],
      textHi: hi[5],
    ),
    SignProfilePoint(
      labelNe: 'पेशा',
      labelEn: 'Career',
      labelHi: 'करियर',
      textNe: ne[6],
      textEn: en[6],
      textHi: hi[6],
    ),
    SignProfilePoint(
      labelNe: 'सम्बन्ध',
      labelEn: 'Relationships',
      labelHi: 'संबंध',
      textNe: ne[7],
      textEn: en[7],
      textHi: hi[7],
    ),
  ];
  return SignProfile(
    aboutNe: ne[0],
    aboutEn: en[0],
    aboutHi: hi[0],
    tabs: [
      SignProfileTab(
        titleNe: '${sign.nameNe} राशि को पुरुष',
        titleEn: '${sign.nameEn} Man',
        titleHi: '${sign.nameHi} राशि का पुरुष',
        introNe: ne[1],
        introEn: en[1],
        introHi: hi[1],
        points: points,
      ),
      SignProfileTab(
        titleNe: '${sign.nameNe} राशि को व्यक्तित्व',
        titleEn: '${sign.nameEn} Personality',
        titleHi: '${sign.nameHi} राशि का व्यक्तित्व',
        introNe: ne[2],
        introEn: en[2],
        introHi: hi[2],
      ),
      SignProfileTab(
        titleNe: '${sign.nameNe} राशि को पेशा',
        titleEn: '${sign.nameEn} Career Horoscope',
        titleHi: '${sign.nameHi} करियर राशिफल',
        introNe: ne[3],
        introEn: en[3],
        introHi: hi[3],
        points: [points[2]],
      ),
    ],
    luckyMedia: HoroscopeMedia(
      titleNe: '${sign.nameNe} राशिको शुभ रङ, अंक र रत्न',
      titleEn: 'Lucky Color, Number and Stone for ${sign.nameEn} Sign',
      titleHi: '${sign.nameHi} राशि के शुभ रंग, अंक और रत्न',
      duration: Duration(seconds: 600 + sign.index * 23),
    ),
  );
}
