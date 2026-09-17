import 'package:flutter_test/flutter_test.dart';
import 'package:sanathan_nepal_mobile_app/core/error/failures.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/appointment_data_source.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/datasources/astrologer_seed.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/models/appointment_model.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/data/repositories/appointment_repository_impl.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/appointment.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/entities/booking_request.dart';
import 'package:sanathan_nepal_mobile_app/features/appointment/domain/usecases/book_appointment.dart';

void main() {
  final now = DateTime(2026, 8, 17, 10);
  late AppointmentRepositoryImpl repo;

  setUp(
    () => repo = AppointmentRepositoryImpl(
      MockAppointmentDataSource(now: () => now),
    ),
  );

  test('lists astrologer and seeded appointments', () async {
    final astrologers = (await repo.getAstrologers()).valueOrNull!;
    expect(astrologers.single.id, featuredAstrologerId);
    final list = (await repo.getAppointments()).valueOrNull!;
    expect(list.length, 4);
    expect(list.where((a) => a.status == AppointmentStatus.booked).length, 2);
  });

  test('slots come from the hours the astrologer keeps', () async {
    final slots = (await repo.getTimeSlots(
      SlotQuery(astrologerId: featuredAstrologerId, date: _workingDay(now, 1)),
    )).valueOrNull!;
    expect(slots, isNotEmpty);
    // The seed takes one slot a day, so the greyed-out state is visible in a
    // demo rather than only once somebody has really booked.
    expect(slots.where((s) => s.available), isNotEmpty);
    expect(slots.where((s) => !s.available), hasLength(1));

    // A day the astrologer does not work has no slots at all — an empty
    // calendar day, not a grid of greyed-out times that were never offered.
    final weekend = _nextWeekend(now);
    final none = (await repo.getTimeSlots(
      SlotQuery(astrologerId: featuredAstrologerId, date: weekend),
    )).valueOrNull!;
    expect(none, isEmpty);

    // Today is already past the calendar's start, so nothing is bookable in
    // the hours that have gone.
    final today = (await repo.getTimeSlots(
      SlotQuery(astrologerId: featuredAstrologerId, date: now),
    )).valueOrNull!;
    expect(
      today.where((s) => s.hour <= now.hour).every((s) => !s.available),
      isTrue,
    );
  });

  test('book → cancel round trip via use case validation', () async {
    final day = _workingDay(now, 5);
    final slots = (await repo.getTimeSlots(
      SlotQuery(astrologerId: featuredAstrologerId, date: day),
    )).valueOrNull!;
    final free = slots.firstWhere((s) => s.available);
    final book = BookAppointment(repo);
    final invalid = await book(
      BookingRequest(
        astrologerId: featuredAstrologerId,
        serviceId: 'chat',
        quantity: 1,
        date: day,
        slotId: free.id,
        customerName: '',
        phone: '9800000000',
        email: '',
        country: 'Nepal',
        paymentMethod: PaymentMethod.esewa,
      ),
    );
    expect(invalid.failureOrNull, isA<ValidationFailure>());

    final booked = (await book(
      BookingRequest(
        astrologerId: featuredAstrologerId,
        serviceId: 'chat',
        quantity: 2,
        date: day,
        slotId: free.id,
        customerName: 'Ram',
        phone: '9800000000',
        email: 'ram@example.com',
        country: 'Nepal',
        paymentMethod: PaymentMethod.khalti,
      ),
    )).valueOrNull!;
    expect(booked.totalAmount, 1200);
    expect(booked.status, AppointmentStatus.booked);

    // The slot is now taken.
    final after = (await repo.getTimeSlots(
      SlotQuery(astrologerId: featuredAstrologerId, date: day),
    )).valueOrNull!;
    expect(after.firstWhere((s) => s.id == free.id).available, isFalse);

    final cancelled = (await repo.cancel(booked.id)).valueOrNull!;
    expect(cancelled.status, AppointmentStatus.cancelled);
    // Cancelling twice fails.
    expect((await repo.cancel(booked.id)).failureOrNull, isA<ServerFailure>());
  });

  test('reschedule moves date & slot', () async {
    final day = _workingDay(now, 8);
    final slots = (await repo.getTimeSlots(
      SlotQuery(astrologerId: featuredAstrologerId, date: day),
    )).valueOrNull!;
    final free = slots.firstWhere((s) => s.available);
    final moved = (await repo.reschedule(
      RescheduleRequest(appointmentId: 'apt-1001', date: day, slotId: free.id),
    )).valueOrNull!;
    expect(moved.date, DateTime(day.year, day.month, day.day));
    expect(moved.slot.id, free.id);
  });

  test(
    'unknown appointment → NotFoundFailure; model json round trip',
    () async {
      expect(
        (await repo.getAppointment('nope')).failureOrNull,
        isA<NotFoundFailure>(),
      );
      final a = (await repo.getAppointment('apt-1001')).valueOrNull!;
      final model = AppointmentModel.fromEntity(a);
      expect(AppointmentModel.fromJson(model.toJson()), equals(model));
    },
  );
}

/// The next day at or after [offset] on which the seeded astrologer keeps
/// hours. Picking a fixed offset made the test depend on which weekday the
/// hard-coded `now` happened to be.
DateTime _workingDay(DateTime now, int offset) {
  var day = DateTime(now.year, now.month, now.day).add(Duration(days: offset));
  while (day.weekday > DateTime.friday) {
    day = day.add(const Duration(days: 1));
  }
  return day;
}

DateTime _nextWeekend(DateTime now) {
  var day = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
  while (day.weekday <= DateTime.friday) {
    day = day.add(const Duration(days: 1));
  }
  return day;
}
