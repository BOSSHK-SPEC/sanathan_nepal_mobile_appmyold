import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_contact_source.freezed.dart';

/// The signed-in person's own details, as far as the booking form cares.
@freezed
abstract class BookingContact with _$BookingContact {
  const factory BookingContact({
    @Default('') String name,
    @Default('') String phone,
    @Default('') String email,
    String? birthPlace,
    DateTime? birthDate,

    /// "HH:mm" 24h.
    String? birthTime,
  }) = _BookingContact;
}

/// Where the booking form gets its starting values.
///
/// A port rather than a direct call into the profile feature: the appointment
/// feature must not import another feature, and tests want to hand the wizard
/// a fixed contact without standing up a profile repository. The composition
/// root supplies the adapter.
abstract interface class BookingContactSource {
  /// The current user's details, or null when nobody is signed in or the
  /// profile cannot be read — the form then simply starts empty.
  Future<BookingContact?> current();
}
