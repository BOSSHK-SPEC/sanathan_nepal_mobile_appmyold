import '../../features/appointment/domain/repositories/booking_contact_source.dart';
import '../../features/profile/domain/usecases/get_user_profile.dart';

/// Fills the booking form from the signed-in user's profile.
///
/// This adapter lives in the composition root rather than in either feature:
/// the appointment feature owns the port, the profile feature owns the data,
/// and neither has to import the other.
class ProfileBookingContactSource implements BookingContactSource {
  const ProfileBookingContactSource(this._getProfile);

  final GetUserProfile _getProfile;

  @override
  Future<BookingContact?> current() async {
    final result = await _getProfile();
    final profile = result.valueOrNull;
    if (profile == null) return null;

    return BookingContact(
      name: profile.name,
      phone: profile.phone,
      email: profile.email,
      birthPlace: profile.birthPlace,
      // The profile stores the Gregorian date as `YYYY/MM/DD`.
      birthDate: _date(profile.dobAd),
      birthTime: _time(profile.birthTime),
    );
  }

  static DateTime? _date(String? raw) {
    if (raw == null) return null;
    return DateTime.tryParse(raw.replaceAll('/', '-'));
  }

  /// The profile keeps a display time ("4:12:20 PM"); the booking form wants
  /// 24-hour "HH:mm", so anything that does not parse is left out rather than
  /// prefilled wrongly.
  static String? _time(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    final match = RegExp(
      r'^(\d{1,2}):(\d{2})(?::\d{2})?\s*([AaPp][Mm])?$',
    ).firstMatch(raw.trim());
    if (match == null) return null;

    var hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final meridiem = match.group(3)?.toUpperCase();
    if (meridiem == 'PM' && hour < 12) hour += 12;
    if (meridiem == 'AM' && hour == 12) hour = 0;
    if (hour > 23 || minute > 59) return null;

    return '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}';
  }
}
