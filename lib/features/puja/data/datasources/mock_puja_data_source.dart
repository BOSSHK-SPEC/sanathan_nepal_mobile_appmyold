import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/puja_booking.dart';
import '../../domain/entities/puja_service.dart';
import '../../domain/repositories/puja_repository.dart';
import 'puja_data_source.dart';
import 'puja_seed.dart';

/// In-memory puja bookings.
///
/// The rules live here rather than in the screens: an at-home booking needs
/// an address, a booking cannot be made for a time that is not offered, a
/// sankalp needs a name, and the 24-hour cancellation window is enforced on
/// the record rather than by hiding a button.
class MockPujaDataSource implements PujaDataSource {
  MockPujaDataSource(this._store, this._regions);

  final KeyValueStore _store;
  final RegionResolver _regions;

  static const _bookingsKey = 'puja.bookings';
  static const Duration _latency = Duration(milliseconds: 200);

  /// Muhurta-aligned start times. Real muhurtas come from the panchanga;
  /// these are fixed brahma/abhijit-style windows so the flow is walkable
  /// until that calculation is wired in.
  static const List<int> _startHours = [6, 8, 11, 16, 18];

  @override
  Future<List<PujaService>> catalogue({PujaPurpose? purpose}) async {
    await Future<void>.delayed(_latency);
    final all = PujaSeed.forRegion(_regions.region);
    if (purpose == null) return all;
    return all.where((s) => s.purpose == purpose).toList();
  }

  @override
  Future<PujaService> service(String serviceId) async {
    await Future<void>.delayed(_latency);
    return PujaSeed.forRegion(_regions.region).firstWhere(
      (s) => s.id == serviceId,
      orElse: () => throw NotFoundException('No puja "$serviceId"'),
    );
  }

  @override
  Future<List<DateTime>> availableTimes({
    required String serviceId,
    required DateTime date,
  }) async {
    await Future<void>.delayed(_latency);
    final now = DateTime.now();
    final booked = _read()
        .where((b) => b.isUpcoming && _sameDay(b.scheduledAt, date))
        .map((b) => b.scheduledAt.hour)
        .toSet();

    return [
          for (final hour in _startHours)
            if (!booked.contains(hour))
              DateTime(date.year, date.month, date.day, hour),
        ]
        // A slot that has already started today is not bookable, and a puja
        // needs at least two hours of notice for the priest to prepare.
        .where((t) => t.isAfter(now.add(const Duration(hours: 2))))
        .toList();
  }

  @override
  Future<PujaBooking> book(PujaBookingRequest request) async {
    final puja = await service(request.serviceId);

    if (!puja.modes.contains(request.mode)) {
      throw const ValidationException('This puja is not offered in that form.');
    }
    if (!request.sankalp.isValid) {
      throw const ValidationException(
        'The sankalp needs the name it is performed for.',
      );
    }
    if (request.mode == PujaMode.atHome &&
        (request.address == null || request.address!.trim().isEmpty)) {
      throw const ValidationException(
        'An at-home puja needs the address the priest should come to.',
      );
    }

    final offered = await availableTimes(
      serviceId: request.serviceId,
      date: request.scheduledAt,
    );
    if (!offered.any((t) => t.isAtSameMomentAs(request.scheduledAt))) {
      throw const ValidationException(
        'That time is no longer available. Please pick another.',
      );
    }

    final booking = PujaBooking(
      id: 'puja-${DateTime.now().millisecondsSinceEpoch}',
      serviceId: puja.id,
      serviceName: puja.name.en,
      mode: request.mode,
      scheduledAt: request.scheduledAt,
      amount: puja.priceFor(
        mode: request.mode,
        withSamagri: request.withSamagri,
      ),
      sankalp: request.sankalp,
      bookedAt: DateTime.now(),
      // Cash on delivery is the one rail that is not settled up front; every
      // other rail is treated as paid the moment the booking is made.
      status: request.paymentRail == PaymentRail.cashOnDelivery
          ? PujaBookingStatus.pendingPayment
          : PujaBookingStatus.confirmed,
      withSamagri: request.withSamagri,
      paymentRail: request.paymentRail,
      address: request.address,
      priestName: _priestFor(puja),
      streamUrl: request.mode == PujaMode.templeOnline
          ? 'https://stream.sanatan.example/${puja.id}'
          : null,
    );
    await _write([booking, ..._read()]);
    return booking;
  }

  @override
  Future<List<PujaBooking>> myBookings() async {
    await Future<void>.delayed(_latency);
    return [for (final b in _read()) _advance(b)]
      ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
  }

  @override
  Future<PujaBooking> booking(String bookingId) async {
    await Future<void>.delayed(_latency);
    return _advance(
      _read().firstWhere(
        (b) => b.id == bookingId,
        orElse: () => throw NotFoundException('No booking "$bookingId"'),
      ),
    );
  }

  @override
  Future<PujaBooking> cancel(String bookingId, String reason) async {
    await Future<void>.delayed(_latency);
    final all = _read();
    final index = all.indexWhere((b) => b.id == bookingId);
    if (index < 0) throw NotFoundException('No booking "$bookingId"');

    final current = _advance(all[index]);
    if (!current.canCancel) {
      throw const ValidationException(
        'This puja is too close to its start time to cancel.',
      );
    }
    final cancelled = current.copyWith(
      status: PujaBookingStatus.cancelled,
      cancellationReason: reason,
    );
    all[index] = cancelled;
    await _write(all);
    return cancelled;
  }

  /// Moves a booking through its lifecycle on the clock, so a puja that has
  /// happened does not still read as upcoming after the app was closed.
  PujaBooking _advance(PujaBooking booking) {
    if (booking.status != PujaBookingStatus.confirmed) return booking;
    final now = DateTime.now();
    final end = booking.scheduledAt.add(const Duration(minutes: 90));
    if (now.isBefore(booking.scheduledAt)) return booking;
    if (now.isBefore(end)) {
      return booking.copyWith(status: PujaBookingStatus.inProgress);
    }
    return booking.copyWith(
      status: PujaBookingStatus.completed,
      recordingUrl: 'local://puja/${booking.id}.mp4',
      prasadPhotos: [
        'local://puja/${booking.id}-1.jpg',
        'local://puja/${booking.id}-2.jpg',
      ],
    );
  }

  String _priestFor(PujaService puja) => _regions.region == Region.india
      ? 'Pandit Ramesh Shastri'
      : 'Pandit Hari Prasad Sharma';

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<PujaBooking> _read() {
    final raw = _store.getString(_bookingsKey);
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        _fromJson(e as Map<String, dynamic>),
    ];
  }

  Future<void> _write(List<PujaBooking> bookings) => _store.setString(
    _bookingsKey,
    jsonEncode([for (final b in bookings) _toJson(b)]),
  );

  PujaBooking _fromJson(Map<String, dynamic> e) => PujaBooking(
    id: e['id'] as String,
    serviceId: e['serviceId'] as String,
    serviceName: e['serviceName'] as String,
    mode: PujaMode.values.firstWhere(
      (m) => m.name == e['mode'],
      orElse: () => PujaMode.templeOnline,
    ),
    scheduledAt: DateTime.parse(e['scheduledAt'] as String),
    amount: (e['amount'] as num).toDouble(),
    sankalp: SankalpDetails(
      fullName: e['sankalpName'] as String? ?? '',
      gotra: e['gotra'] as String? ?? '',
      rashiOrNakshatra: e['rashi'] as String? ?? '',
      familyMembers: [
        for (final m in (e['familyMembers'] as List<dynamic>? ?? []))
          m as String,
      ],
    ),
    bookedAt: DateTime.parse(e['bookedAt'] as String),
    status: PujaBookingStatus.values.firstWhere(
      (s) => s.name == e['status'],
      orElse: () => PujaBookingStatus.confirmed,
    ),
    withSamagri: e['withSamagri'] as bool? ?? false,
    paymentRail: e['paymentRail'] == null
        ? null
        : PaymentRail.values.firstWhere(
            (r) => r.name == e['paymentRail'],
            orElse: () => PaymentRail.cashOnDelivery,
          ),
    address: e['address'] as String?,
    streamUrl: e['streamUrl'] as String?,
    recordingUrl: e['recordingUrl'] as String?,
    priestName: e['priestName'] as String?,
    cancellationReason: e['cancellationReason'] as String?,
    prasadPhotos: [
      for (final p in (e['prasadPhotos'] as List<dynamic>? ?? [])) p as String,
    ],
  );

  Map<String, dynamic> _toJson(PujaBooking b) => {
    'id': b.id,
    'serviceId': b.serviceId,
    'serviceName': b.serviceName,
    'mode': b.mode.name,
    'scheduledAt': b.scheduledAt.toIso8601String(),
    'amount': b.amount,
    'sankalpName': b.sankalp.fullName,
    'gotra': b.sankalp.gotra,
    'rashi': b.sankalp.rashiOrNakshatra,
    'familyMembers': b.sankalp.familyMembers,
    'bookedAt': b.bookedAt.toIso8601String(),
    'status': b.status.name,
    'withSamagri': b.withSamagri,
    'paymentRail': b.paymentRail?.name,
    'address': b.address,
    'streamUrl': b.streamUrl,
    'recordingUrl': b.recordingUrl,
    'priestName': b.priestName,
    'cancellationReason': b.cancellationReason,
    'prasadPhotos': b.prasadPhotos,
  };
}
