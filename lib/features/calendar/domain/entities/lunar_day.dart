import 'package:freezed_annotation/freezed_annotation.dart';

part 'lunar_day.freezed.dart';

/// Lunar fortnight.
enum Paksha { shukla, krishna }

const List<String> _tithiNe = [
  'प्रतिपदा',
  'द्वितीया',
  'तृतीया',
  'चतुर्थी',
  'पञ्चमी',
  'षष्ठी',
  'सप्तमी',
  'अष्टमी',
  'नवमी',
  'दशमी',
  'एकादशी',
  'द्वादशी',
  'त्रयोदशी',
  'चतुर्दशी',
];
const List<String> _tithiEn = [
  'Pratipada',
  'Dwitiya',
  'Tritiya',
  'Chaturthi',
  'Panchami',
  'Shashthi',
  'Saptami',
  'Ashtami',
  'Navami',
  'Dashami',
  'Ekadashi',
  'Dwadashi',
  'Trayodashi',
  'Chaturdashi',
];

/// Approximate lunar day (tithi) information for a solar date.
@freezed
abstract class LunarDay with _$LunarDay {
  const LunarDay._();

  const factory LunarDay({
    /// 1..15 within the [paksha] (15 = पूर्णिमा for shukla, औंसी for krishna).
    required int tithiIndex,
    required Paksha paksha,
  }) = _LunarDay;

  String tithiName({required bool nepali}) {
    if (tithiIndex == 15) {
      if (paksha == Paksha.shukla) return nepali ? 'पूर्णिमा' : 'Purnima';
      return nepali ? 'औंसी' : 'Aunsi';
    }
    return (nepali ? _tithiNe : _tithiEn)[tithiIndex - 1];
  }

  String pakshaName({required bool nepali}) => paksha == Paksha.shukla
      ? (nepali ? 'शुक्लपक्ष' : 'Shukla Paksha')
      : (nepali ? 'कृष्णपक्ष' : 'Krishna Paksha');
}
