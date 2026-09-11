import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sanathan_nepal_mobile_app/app/di/profile_booking_contact_source.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/core/utils/result.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/entities/user_profile.dart';
import 'package:sanathan_nepal_mobile_app/features/profile/domain/usecases/get_user_profile.dart';

class _MockGetProfile extends Mock implements GetUserProfile {}

void main() {
  late _MockGetProfile getProfile;

  UserProfile profile({String? dobAd, String? birthTime}) => UserProfile(
    id: 'u1',
    name: 'Yashwanth H K',
    email: 'yash@example.com',
    phone: '9686912639',
    birthPlace: 'Hassan',
    dobAd: dobAd,
    birthTime: birthTime,
  );

  setUp(() => getProfile = _MockGetProfile());

  test('the profile fills the booking form', () async {
    when(getProfile.call).thenAnswer(
      (_) async =>
          Result.success(profile(dobAd: '1995/01/01', birthTime: '4:12:20 PM')),
    );

    final contact = await ProfileBookingContactSource(getProfile).current();

    expect(contact?.name, 'Yashwanth H K');
    expect(contact?.phone, '9686912639');
    expect(contact?.birthPlace, 'Hassan');
    expect(contact?.birthDate, DateTime(1995));
    // The profile keeps a display time; the form wants 24-hour "HH:mm".
    expect(contact?.birthTime, '16:12');
  });

  test('a 12-hour midnight and noon convert the way clocks do', () async {
    for (final (raw, expected) in [
      ('12:05 AM', '00:05'),
      ('12:05 PM', '12:05'),
      ('09:30', '09:30'),
    ]) {
      when(
        getProfile.call,
      ).thenAnswer((_) async => Result.success(profile(birthTime: raw)));
      final contact = await ProfileBookingContactSource(getProfile).current();
      expect(contact?.birthTime, expected, reason: raw);
    }
  });

  test('unparsable birth details are left out rather than guessed', () async {
    when(getProfile.call).thenAnswer(
      (_) async =>
          Result.success(profile(dobAd: 'sometime', birthTime: 'morning')),
    );

    final contact = await ProfileBookingContactSource(getProfile).current();

    expect(contact?.birthDate, isNull);
    expect(contact?.birthTime, isNull);
  });

  test('no profile means no prefill, not a crash', () async {
    when(
      getProfile.call,
    ).thenAnswer((_) async => const Result.failure(NetworkFailure()));

    expect(await ProfileBookingContactSource(getProfile).current(), isNull);
  });
}
