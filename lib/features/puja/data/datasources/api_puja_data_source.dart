import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_localized.dart';
import '../../../../core/network/api_money.dart';
import '../../../../core/utils/localized_text.dart';
import '../../domain/entities/puja_booking.dart';
import '../../domain/entities/puja_service.dart';
import '../../domain/repositories/puja_repository.dart';
import 'puja_data_source.dart';

/// The puja catalogue and the devotee's bookings, from the backend.
///
/// Prices are never sent up: the server totals base + samagri + at-home
/// surcharge from its own service record, so a tampered client cannot book a
/// three-priest ritual for the price of a one-priest one.
class ApiPujaDataSource implements PujaDataSource {
  const ApiPujaDataSource(this._client, this._languageCode);

  final ApiClient _client;

  /// The booking list renders the service name as a plain string, so one
  /// translation has to be chosen; read per call because the user can switch
  /// language with the list on screen.
  final String Function() _languageCode;

  @override
  Future<List<PujaService>> catalogue({PujaPurpose? purpose}) =>
      guardApi(() async {
        final response = await _client.get<dynamic>(
          ApiEndpoints.pujaServices,
          query: {if (purpose != null) 'purpose': purpose.name},
        );
        return asJsonList(response).map(_toService).toList(growable: false);
      });

  @override
  Future<PujaService> service(String serviceId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.pujaService(serviceId),
    );
    return _toService(asJsonMap(response));
  });

  @override
  Future<List<DateTime>> availableTimes({
    required String serviceId,
    required DateTime date,
  }) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.pujaServiceTimes(serviceId),
      query: {'date': _isoDate(date)},
    );
    final body = response.data;
    if (body is! List) {
      throw const ServerException('Expected a list of times from the server');
    }
    return body
        .whereType<String>()
        .map(ApiTime.instant)
        .whereType<DateTime>()
        .toList(growable: false);
  });

  @override
  Future<PujaBooking> book(PujaBookingRequest request) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.pujaBookings,
      data: {
        'serviceId': request.serviceId,
        'mode': request.mode.name,
        'scheduledAt': request.scheduledAt.toUtc().toIso8601String(),
        'sankalp': {
          'name': request.sankalp.fullName,
          'gotra': request.sankalp.gotra,
          'rashi': request.sankalp.rashiOrNakshatra,
          'familyMembers': request.sankalp.familyMembers,
        },
        'withSamagri': request.withSamagri,
        if (request.address != null) 'address': request.address,
      },
    );
    // The chosen rail is not sent here: a booking starts unpaid and the rail
    // is decided by the payment intent that follows, so recording an intent
    // on the booking would claim a payment that has not happened.
    return _toBooking(asJsonMap(response));
  });

  @override
  Future<List<PujaBooking>> myBookings() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.pujaBookings);
    return asJsonList(response).map(_toBooking).toList(growable: false);
  });

  @override
  Future<PujaBooking> booking(String bookingId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.pujaBooking(bookingId),
    );
    return _toBooking(asJsonMap(response));
  });

  @override
  Future<PujaBooking> cancel(String bookingId, String reason) =>
      guardApi(() async {
        final response = await _client.post<dynamic>(
          ApiEndpoints.pujaBookingCancel(bookingId),
          data: {'reason': reason},
        );
        return _toBooking(asJsonMap(response));
      });

  // ---------------------------------------------------------------- mapping --

  PujaService _toService(Map<String, dynamic> json) {
    final procedure = json['procedure'];
    return PujaService(
      id: json['id'] as String? ?? '',
      name: asLocalizedText(json['name']),
      summary: asLocalizedText(json['summary']),
      purpose: PujaPurpose.values.firstWhere(
        (p) => p.name == json['purpose'],
        orElse: () => PujaPurpose.prosperity,
      ),
      basePrice: ApiMoney.toMajor(json['basePriceMinor']),
      duration: Duration(
        minutes: (json['durationMinutes'] as num?)?.toInt() ?? 60,
      ),
      modes: _modes(json['modes']),
      templeName: json['templeName'] == null
          ? null
          : asLocalizedText(json['templeName']),
      procedure: procedure is List
          ? procedure.map(asLocalizedText).toList(growable: false)
          : const <LocalizedText>[],
      samagriPrice: ApiMoney.toMajor(json['samagriPriceMinor']),
      atHomeSurcharge: ApiMoney.toMajor(json['atHomeSurchargeMinor']),
      priestCount: (json['priestCount'] as num?)?.toInt() ?? 1,
      bookingsThisMonth: (json['bookingsThisMonth'] as num?)?.toInt() ?? 0,
      isPopular: json['isPopular'] as bool? ?? false,
    );
  }

  /// A service with no usable mode cannot be booked at all, so an unreadable
  /// list falls back to the one every temple offers rather than to nothing.
  static List<PujaMode> _modes(Object? raw) {
    if (raw is! List) return const [PujaMode.templeOnline];
    final modes = raw
        .whereType<String>()
        .map((m) => PujaMode.values.where((mode) => mode.name == m).firstOrNull)
        .whereType<PujaMode>()
        .toList(growable: false);
    return modes.isEmpty ? const [PujaMode.templeOnline] : modes;
  }

  PujaBooking _toBooking(Map<String, dynamic> json) {
    final sankalp = json['sankalp'];
    final sankalpMap = sankalp is Map
        ? Map<String, dynamic>.from(sankalp)
        : const <String, dynamic>{};
    final media = json['mediaKeys'];
    final mediaKeys = media is List
        ? media.whereType<String>().toList(growable: false)
        : const <String>[];

    return PujaBooking(
      id: json['id'] as String? ?? '',
      serviceId: json['serviceId'] as String? ?? '',
      serviceName: localizedFor(json['serviceName'], _languageCode()),
      mode: json['mode'] == 'atHome' ? PujaMode.atHome : PujaMode.templeOnline,
      scheduledAt: ApiTime.instantOr(json['scheduledAt'], DateTime.now()),
      amount: ApiMoney.toMajor(json['totalMinor']),
      sankalp: SankalpDetails(
        fullName: sankalpMap['name'] as String? ?? '',
        gotra: sankalpMap['gotra'] as String? ?? '',
        rashiOrNakshatra: sankalpMap['rashi'] as String? ?? '',
        familyMembers:
            (sankalpMap['familyMembers'] as List?)?.whereType<String>().toList(
              growable: false,
            ) ??
            const [],
      ),
      bookedAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
      status: PujaBookingStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => PujaBookingStatus.pendingPayment,
      ),
      withSamagri: json['withSamagri'] as bool? ?? false,
      address: json['address'] as String?,
      // Delivered media arrives as one list; the recording is the video and
      // everything else is a prasad photo.
      prasadPhotos: mediaKeys
          .where((key) => !_isVideo(key))
          .toList(growable: false),
      recordingUrl: mediaKeys.where(_isVideo).firstOrNull,
      cancellationReason: json['cancelReason'] as String?,
    );
  }

  static bool _isVideo(String key) =>
      key.endsWith('.mp4') || key.endsWith('.mov') || key.endsWith('.m3u8');

  static String _isoDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
