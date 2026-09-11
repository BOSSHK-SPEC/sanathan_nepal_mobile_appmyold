import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/astrologer_slot.dart';
import '../../domain/entities/booking_request.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../../domain/entities/time_slot.dart';
import '../models/appointment_model.dart';
import '../models/time_slot_model.dart';
import 'astrologer_seed.dart';

/// I/O contract for astrologers, slots and appointments.
abstract interface class AppointmentDataSource {
  Future<List<BookableAstrologer>> fetchAstrologers();
  Future<BookableAstrologer> fetchAstrologer(String id);

  /// Slots of [astrologerId] on [date]; scoped to [serviceId] when the caller
  /// knows which service is being booked.
  /// An astrologer's own bookable slots, for the next two weeks.
  ///
  /// Its own call rather than a flag on [fetchTimeSlots]: a astrologer's slots
  /// are asked for one date at a time, while an astrologer publishes a rolling
  /// calendar the seeker scrolls — different question, different shape.
  Future<List<AstrologerSlot>> fetchAstrologerSlots(String astrologerId);

  Future<List<TimeSlotModel>> fetchTimeSlots(
    String astrologerId,
    DateTime date, {
    String? serviceId,
  });
  Future<List<AppointmentModel>> fetchAppointments();
  Future<AppointmentModel> fetchAppointment(String id);
  Future<AppointmentModel> book(BookingRequest request);
  Future<AppointmentModel> cancel(String id);
  Future<AppointmentModel> reschedule(String id, DateTime date, String slotId);

}

/// Deterministic in-memory implementation. Seed appointments are created
/// relative to [now] so the list always has upcoming + past entries; the
/// store holds domain entities and hands out models at the boundary.
///
/// Astrologers and the appointment list are region-aware: the active
/// [RegionResolver] is read on every call (never cached), so switching
/// Nepal ⇄ India at runtime swaps the seeded astrologers (NPR vs INR
/// prices, +977 vs +91 phones) and the appointments booked with them.
class MockAppointmentDataSource implements AppointmentDataSource {
  MockAppointmentDataSource({DateTime Function()? now, RegionResolver? region})
    : _now = now ?? DateTime.now,
      _region = region ?? const FixedRegionResolver(Region.nepal) {
    _appointments
      ..addAll(_seedNepal())
      ..addAll(_seedIndia());
  }

  final DateTime Function() _now;
  final RegionResolver _region;
  final List<Appointment> _appointments = [];
  int _counter = 0;

  RegionConfig get _config => _region.config;

  static TimeSlot slotAt(int hour, int minute, {bool available = true}) =>
      TimeSlot(
        id: 'slot-$hour-$minute',
        hour: hour,
        minute: minute,
        available: available,
      );

  DateTime _day(int offsetDays) {
    final n = _now();
    return DateTime(n.year, n.month, n.day).add(Duration(days: offsetDays));
  }

  List<Appointment> _seedNepal() => [
    Appointment(
      id: 'apt-1001',
      astrologerId: featuredAstrologerId,
      astrologerName: featuredAstrologer.name,
      service: chatSitting,
      quantity: 1,
      date: _day(3),
      slot: slotAt(20, 30),
      status: AppointmentStatus.booked,
      customerName: 'Sita Sharma',
      phone: '9841000000',
      email: 'sita@example.com',
      country: 'Nepal',
      paymentMethod: PaymentMethod.esewa,
      createdAt: _day(-2),
      birthPlace: 'Hetauda',
      birthDate: DateTime(1998, 4, 2),
      birthTime: '16:12',
    ),
    Appointment(
      id: 'apt-1002',
      astrologerId: featuredAstrologerId,
      astrologerName: featuredAstrologer.name,
      service: featuredAstrologer.services[1],
      quantity: 1,
      date: _day(10),
      slot: slotAt(11, 0),
      status: AppointmentStatus.booked,
      customerName: 'Sita Sharma',
      phone: '9841000000',
      email: 'sita@example.com',
      country: 'Nepal',
      paymentMethod: PaymentMethod.khalti,
      createdAt: _day(-1),
    ),
    Appointment(
      id: 'apt-0998',
      astrologerId: featuredAstrologerId,
      astrologerName: featuredAstrologer.name,
      service: featuredAstrologer.services[2],
      quantity: 1,
      date: _day(-20),
      slot: slotAt(14, 0),
      status: AppointmentStatus.completed,
      customerName: 'Sita Sharma',
      phone: '9841000000',
      email: 'sita@example.com',
      country: 'Nepal',
      paymentMethod: PaymentMethod.bank,
      createdAt: _day(-30),
    ),
    Appointment(
      id: 'apt-0990',
      astrologerId: featuredAstrologerId,
      astrologerName: featuredAstrologer.name,
      service: chatSitting,
      quantity: 1,
      date: _day(-40),
      slot: slotAt(9, 0),
      status: AppointmentStatus.cancelled,
      customerName: 'Sita Sharma',
      phone: '9841000000',
      email: 'sita@example.com',
      country: 'Nepal',
      paymentMethod: PaymentMethod.esewa,
      createdAt: _day(-45),
    ),
  ];

  List<Appointment> _seedIndia() => [
    Appointment(
      id: 'apt-in-1001',
      astrologerId: indiaFeaturedAstrologerId,
      astrologerName: indiaFeaturedAstrologer.name,
      service: indiaChatSitting,
      quantity: 1,
      date: _day(4),
      slot: slotAt(11, 0),
      status: AppointmentStatus.booked,
      customerName: 'Priya Verma',
      phone: '9876500000',
      email: 'priya@example.com',
      country: 'India',
      paymentMethod: PaymentMethod.upi,
      createdAt: _day(-2),
      birthPlace: 'Lucknow',
      birthDate: DateTime(1996, 7, 14),
      birthTime: '05:40',
    ),
    Appointment(
      id: 'apt-in-1002',
      astrologerId: indiaSecondAstrologerId,
      astrologerName: indiaSecondAstrologer.name,
      service: indiaSecondAstrologer.services[1],
      quantity: 1,
      date: _day(12),
      slot: slotAt(15, 0),
      status: AppointmentStatus.booked,
      customerName: 'Priya Verma',
      phone: '9876500000',
      email: 'priya@example.com',
      country: 'India',
      paymentMethod: PaymentMethod.card,
      createdAt: _day(-1),
    ),
    Appointment(
      id: 'apt-in-0998',
      astrologerId: indiaFeaturedAstrologerId,
      astrologerName: indiaFeaturedAstrologer.name,
      service: indiaFeaturedAstrologer.services[1],
      quantity: 1,
      date: _day(-18),
      slot: slotAt(10, 0),
      status: AppointmentStatus.completed,
      customerName: 'Priya Verma',
      phone: '9876500000',
      email: 'priya@example.com',
      country: 'India',
      paymentMethod: PaymentMethod.netBanking,
      createdAt: _day(-25),
    ),
  ];

  @override
  Future<List<BookableAstrologer>> fetchAstrologers() async => astrologersFor(_config);

  @override
  Future<BookableAstrologer> fetchAstrologer(String id) async {
    // Prefer the active region's astrologers, but resolve any seeded id so
    // appointments booked before a region switch still open.
    final match = [
      ...astrologersFor(_config),
      ...allAstrologers,
    ].where((p) => p.id == id);
    if (match.isEmpty) throw const NotFoundException('Astrologer not found');
    return match.first;
  }

  @override
  Future<List<AstrologerSlot>> fetchAstrologerSlots(String astrologerId) async {
    // A fortnight of half hours on weekday mornings — enough shape for the
    // calendar to be worth scrolling with no server running. It reads the
    // injected clock, not the wall clock, so a test with a fixed `now` sees
    // the same fortnight the rest of the source does.
    final now = _now();
    final start = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
    return [
      for (var day = 0; day < 14; day += 1)
        if (start.add(Duration(days: day)).weekday <= 5)
          for (var slot = 0; slot < 6; slot += 1)
            AstrologerSlot(
              id: 'mock-slot-$astrologerId-$day-$slot',
              startsAt: start.add(Duration(days: day, hours: 9, minutes: 35 * slot)),
              endsAt: start.add(
                Duration(days: day, hours: 9, minutes: 35 * slot + 30),
              ),
              // One taken slot per day, so the greyed-out state is visible in
              // a demo rather than only in production.
              available: slot != 2,
            ),
    ];
  }

  @override
  Future<List<TimeSlotModel>> fetchTimeSlots(
    String astrologerId,
    DateTime date, {
    // Slots are the astrologer's own half hours, not a per-channel grid: the
    // same half hour cannot be sold once as chat and again as video. The live
    // source ignores this for the same reason.
    String? serviceId,
  }) async {
    final day = DateTime(date.year, date.month, date.day);
    final booked = _appointments
        .where(
          (a) =>
              a.astrologerId == astrologerId &&
              a.status == AppointmentStatus.booked &&
              DateTime(a.date.year, a.date.month, a.date.day) == day,
        )
        .map((a) => a.slot.id)
        .toSet();
    final now = _now();
    final calendar = await fetchAstrologerSlots(astrologerId);
    return [
      for (final slot in calendar.where((s) => s.day == day))
        TimeSlotModel(
          id: slot.id,
          hour: slot.startsAt.hour,
          minute: slot.startsAt.minute,
          available:
              slot.available &&
              !booked.contains(slot.id) &&
              slot.startsAt.isAfter(now),
        ),
    ];
  }

  @override
  Future<List<AppointmentModel>> fetchAppointments() async {
    final ids = astrologersFor(_config).map((p) => p.id).toSet();
    return List.unmodifiable(
      _appointments
          .where((a) => ids.contains(a.astrologerId))
          .map(AppointmentModel.fromEntity),
    );
  }

  @override
  Future<AppointmentModel> fetchAppointment(String id) async {
    final match = _appointments.where((a) => a.id == id);
    if (match.isEmpty) throw const NotFoundException('Appointment not found');
    return AppointmentModel.fromEntity(match.first);
  }

  @override
  Future<AppointmentModel> book(BookingRequest request) async {
    final astrologer = await fetchAstrologer(request.astrologerId);
    final service = astrologer.services.where((s) => s.id == request.serviceId);
    if (service.isEmpty) throw const NotFoundException('Service not found');
    final slots = await fetchTimeSlots(request.astrologerId, request.date);
    final slot = slots.where((s) => s.id == request.slotId);
    if (slot.isEmpty || !slot.first.available) {
      throw const ServerException('Selected time slot is no longer available');
    }
    _counter++;
    final appointment = Appointment(
      id: 'apt-${2000 + _counter}',
      astrologerId: astrologer.id,
      astrologerName: astrologer.name,
      service: service.first,
      quantity: request.quantity,
      date: DateTime(request.date.year, request.date.month, request.date.day),
      slot: slot.first.toEntity(),
      status: AppointmentStatus.booked,
      customerName: request.customerName,
      phone: request.phone,
      email: request.email,
      country: request.country,
      paymentMethod: request.paymentMethod,
      createdAt: _now(),
      birthPlace: request.birthPlace,
      birthDate: request.birthDate,
      birthTime: request.birthTime,
      notes: request.notes,
      cheenaMediaId: request.cheenaMediaId,
      receiptMediaId: request.receiptMediaId,
    );
    _appointments.insert(0, appointment);
    return AppointmentModel.fromEntity(appointment);
  }

  @override
  Future<AppointmentModel> cancel(String id) async {
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index < 0) throw const NotFoundException('Appointment not found');
    final current = _appointments[index];
    if (current.status != AppointmentStatus.booked) {
      throw const ServerException('Only booked appointments can be cancelled');
    }
    final updated = current.copyWith(status: AppointmentStatus.cancelled);
    _appointments[index] = updated;
    return AppointmentModel.fromEntity(updated);
  }

  @override
  Future<AppointmentModel> reschedule(
    String id,
    DateTime date,
    String slotId,
  ) async {
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index < 0) throw const NotFoundException('Appointment not found');
    final current = _appointments[index];
    if (current.status != AppointmentStatus.booked) {
      throw const ServerException('Only booked appointments can be moved');
    }
    final slots = await fetchTimeSlots(current.astrologerId, date);
    final slot = slots.where((s) => s.id == slotId);
    if (slot.isEmpty || !slot.first.available) {
      throw const ServerException('Selected time slot is not available');
    }
    final updated = current.copyWith(
      date: DateTime(date.year, date.month, date.day),
      slot: slot.first.toEntity(),
    );
    _appointments[index] = updated;
    return AppointmentModel.fromEntity(updated);
  }

}
