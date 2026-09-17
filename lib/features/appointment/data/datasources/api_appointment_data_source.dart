import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_localized.dart';
import '../../../../core/network/api_money.dart';
import '../../../../core/utils/localized_text.dart';
import '../../../../core/utils/localized_text_model.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/entities/astrologer_slot.dart';
import '../../domain/entities/booking_request.dart';
import '../../domain/entities/sitting_option.dart';
import '../../domain/entities/bookable_astrologer.dart';
import '../models/appointment_model.dart';
import '../models/sitting_option_model.dart';
import '../models/time_slot_model.dart';
import 'appointment_data_source.dart';

/// Astrologers, slots and appointments from the backend.
///
/// Slots are never computed on the device: the server owns capacity, and it
/// claims a seat with a conditional update so two people tapping the same
/// 10:00 at the same moment cannot both get it. The app only renders what the
/// server says is still free.
class ApiAppointmentDataSource implements AppointmentDataSource {
  const ApiAppointmentDataSource(this._client);

  final ApiClient _client;

  @override
  Future<List<BookableAstrologer>> fetchAstrologers() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.astrologers,
      query: const {'limit': 40},
    );
    // A cursor page, not a bare array — the directory is long enough that the
    // server pages it.
    return asPageItems(response)
        .map(_toAstrologer)
        // Someone who has priced nothing cannot be booked, and a card that
        // opens onto an empty wizard is worse than one that is not there.
        .where((astrologer) => astrologer.isBookable)
        .toList(growable: false);
  });

  @override
  Future<BookableAstrologer> fetchAstrologer(String id) => guardApi(() async {
    // One call: reviews are the profile's business, not the wizard's.
    final response = await _client.get<dynamic>(ApiEndpoints.astrologer(id));
    return _toAstrologer(asJsonMap(response));
  });

  @override
  Future<List<AstrologerSlot>> fetchAstrologerSlots(String astrologerId) =>
      guardApi(() => _fetchSlots(astrologerId));

  Future<List<AstrologerSlot>> _fetchSlots(String astrologerId) async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.astrologerSlots(astrologerId),
    );
    return asJsonList(response)
        .map(
          (json) => AstrologerSlot(
            id: json['id'] as String? ?? '',
            startsAt: ApiTime.instantOr(json['startsAt'], DateTime.now()),
            endsAt: ApiTime.instantOr(json['endsAt'], DateTime.now()),
            available: json['available'] as bool? ?? false,
          ),
        )
        // A slot someone else has taken is still returned by the server so
        // the calendar shows a full day rather than a sparse one; the UI
        // greys it out.
        .toList(growable: false);
  }

  @override
  Future<List<TimeSlotModel>> fetchTimeSlots(
    String astrologerId,
    DateTime date, {
    String? serviceId,
  }) => guardApi(() async {
    // An astrologer publishes one rolling calendar rather than a day at a
    // time, so the wizard's per-date grid is a filter over it. The channel is
    // deliberately not part of the query: the same half hour is the same half
    // hour whether it is spent in chat or on video, and pretending otherwise
    // would let the same slot be sold three times.
    final slots = await _fetchSlots(astrologerId);
    final day = DateTime(date.year, date.month, date.day);
    return slots
        .where((slot) => slot.day == day)
        .map(
          (slot) => TimeSlotModel(
            id: slot.id,
            hour: slot.startsAt.hour,
            minute: slot.startsAt.minute,
            available: slot.available,
          ),
        )
        .toList(growable: false);
  });

  @override
  Future<List<AppointmentModel>> fetchAppointments() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.appointments);
    return asJsonList(response).map(_toAppointment).toList(growable: false);
  });

  @override
  Future<AppointmentModel> fetchAppointment(String id) => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.appointment(id));
    return _toAppointment(asJsonMap(response));
  });

  @override
  Future<AppointmentModel> book(BookingRequest request) => guardApi(() async {
    final birthDate = request.birthDate;
    final response = await _client.post<dynamic>(
      ApiEndpoints.appointments,
      data: {
        'astrologerId': request.astrologerId,
        // The channel, not a service id: an astrologer has no catalogue of
        // named services, they have a rate per minute per channel, and it is
        // the channel that decides what the half hour costs.
        if (request.serviceId.isNotEmpty) 'channel': request.serviceId,
        'slotId': request.slotId,
        'note': request.notes ?? '',
        'contactName': request.customerName,
        'contactPhone': request.phone,
        'contactEmail': request.email,
        'country': request.country,
        'quantity': request.quantity,
        'paymentMethod': _paymentMethod(request.paymentMethod),
        if (request.birthPlace != null ||
            birthDate != null ||
            request.birthTime != null)
          'intake': {
            if (request.birthPlace != null) 'birthPlace': request.birthPlace,
            if (birthDate != null) 'birthDate': _isoDate(birthDate),
            if (request.birthTime != null) 'birthTime': request.birthTime,
          },
        if (request.cheenaMediaId != null || request.receiptMediaId != null)
          'attachments': {
            if (request.cheenaMediaId != null)
              'cheenaMediaId': request.cheenaMediaId,
            if (request.receiptMediaId != null)
              'receiptMediaId': request.receiptMediaId,
          },
      },
    );
    return _toAppointment(asJsonMap(response));
  });

  @override
  Future<AppointmentModel> cancel(String id) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.appointmentCancel(id),
      data: {'reason': ''},
    );
    return _toAppointment(asJsonMap(response));
  });

  @override
  Future<AppointmentModel> reschedule(
    String id,
    DateTime date,
    String slotId,
  ) => guardApi(() async {
    // The slot id carries its own date, so the server needs nothing else —
    // [date] is what the UI already showed and is not re-sent, which keeps the
    // two from disagreeing.
    final response = await _client.post<dynamic>(
      ApiEndpoints.appointmentReschedule(id),
      data: {'newSlotId': slotId},
    );
    return _toAppointment(asJsonMap(response));
  });

  // ---------------------------------------------------------------- mapping --

  /// Half-hour sittings, matching the server's slot length. The two constants
  /// have to agree: the price quoted here is per slot, and the server prices
  /// the booking by the slot's own length.
  static const int sittingMinutes = 30;

  BookableAstrologer _toAstrologer(Map<String, dynamic> json) =>
      BookableAstrologer(
        id: json['id'] as String? ?? '',
        name: asLocalizedText(json['name']),
        title: asLocalizedText(json['headline']),
        rating: (json['ratingAvg'] as num?)?.toDouble() ?? 0,
        reviewCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
        services: _sittings(json['ratePerMinute']),
        isOnline: json['isOnline'] as bool? ?? false,
        isVerified: json['isVerified'] as bool? ?? false,
        avatarAsset: json['avatarKey'] as String?,
      );

  /// Turns `{"chat":"2000","voice":"3500"}` into the sittings the wizard
  /// offers, cheapest first.
  ///
  /// A channel the astrologer has not priced is left out rather than shown at
  /// zero — a free video sitting is not what an unpriced channel means, and
  /// offering one the server would refuse is worse than not offering it.
  static List<SittingOption> _sittings(Object? raw) {
    if (raw is! Map) return const [];
    final options = <SittingOption>[];
    for (final entry in raw.entries) {
      final channel = SittingChannel.tryParse('${entry.key}');
      if (channel == null) continue;
      final perMinute = ApiMoney.toMajor(entry.value);
      if (perMinute <= 0) continue;
      options.add(
        SittingOption(
          id: channel.wireName,
          channel: channel,
          name: channel.displayName,
          price: (perMinute * sittingMinutes).round(),
          ratePerMinute: perMinute,
          description: const LocalizedText(en: '', ne: ''),
          durationMinutes: sittingMinutes,
        ),
      );
    }
    options.sort((a, b) => a.price.compareTo(b.price));
    return List.unmodifiable(options);
  }

  AppointmentModel _toAppointment(Map<String, dynamic> json) {
    final startsAt = ApiTime.instantOr(json['startsAt'], DateTime.now());
    final intake = json['intake'];
    final intakeMap = intake is Map
        ? Map<String, dynamic>.from(intake)
        : const <String, dynamic>{};
    final attachments = json['attachments'];
    final attachmentMap = attachments is Map
        ? Map<String, dynamic>.from(attachments)
        : const <String, dynamic>{};

    return AppointmentModel(
      id: json['id'] as String? ?? '',
      astrologerId: json['astrologerId'] as String? ?? '',
      astrologerName: LocalizedTextModel.fromEntity(
        asLocalizedText(json['astrologerName']),
      ),
      service: SittingOptionModel(
        id: json['serviceId'] as String? ?? '',
        name: LocalizedTextModel.fromEntity(
          asLocalizedText(json['serviceName']),
        ),
        price: ApiMoney.toMajor(json['priceMinor']).round(),
        description: const LocalizedTextModel(en: '', ne: ''),
      ),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      date: DateTime(startsAt.year, startsAt.month, startsAt.day),
      slot: TimeSlotModel(
        id: json['slotId'] as String? ?? '',
        hour: startsAt.hour,
        minute: startsAt.minute,
        available: false,
      ),
      status: _status(json['status'] as String?),
      customerName: json['contactName'] as String? ?? '',
      phone: json['contactPhone'] as String? ?? '',
      email: json['contactEmail'] as String? ?? '',
      country: json['country'] as String? ?? '',
      paymentMethod: _paymentFrom(json['paymentMethod'] as String?),
      createdAt: ApiTime.instantOr(json['createdAt'], startsAt),
      birthPlace: intakeMap['birthPlace'] as String?,
      birthDate: ApiTime.date(intakeMap['birthDate']),
      birthTime: intakeMap['birthTime'] as String?,
      notes: json['note'] as String?,
      cheenaMediaId: attachmentMap['cheenaMediaId'] as String?,
      receiptMediaId: attachmentMap['receiptMediaId'] as String?,
    );
  }

  /// The server tracks six states; the app shows three. `pending` and
  /// `rescheduled` are both "you have a booking", which is what the list says.
  static AppointmentStatus _status(String? status) => switch (status) {
    'completed' => AppointmentStatus.completed,
    'cancelled' || 'noShow' => AppointmentStatus.cancelled,
    _ => AppointmentStatus.booked,
  };

  /// The app's rails and the server's enum agree except where the app is more
  /// specific (paypal is settled as a bank transfer, cash as cash on delivery).
  static String _paymentMethod(PaymentMethod method) => switch (method) {
    PaymentMethod.esewa => 'esewa',
    PaymentMethod.khalti => 'khalti',
    PaymentMethod.bank || PaymentMethod.paypal => 'bankTransfer',
    PaymentMethod.upi => 'upi',
    PaymentMethod.card => 'card',
    PaymentMethod.netBanking => 'netBanking',
    PaymentMethod.cash => 'cashOnDelivery',
  };

  static PaymentMethod _paymentFrom(String? code) => switch (code) {
    'khalti' => PaymentMethod.khalti,
    'bankTransfer' => PaymentMethod.bank,
    'upi' => PaymentMethod.upi,
    'card' => PaymentMethod.card,
    'netBanking' => PaymentMethod.netBanking,
    'cashOnDelivery' => PaymentMethod.cash,
    _ => PaymentMethod.esewa,
  };

  static String _isoDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
