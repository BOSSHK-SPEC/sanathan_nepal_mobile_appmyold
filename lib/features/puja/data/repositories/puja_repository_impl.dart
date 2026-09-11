import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/puja_booking.dart';
import '../../domain/entities/puja_service.dart';
import '../../domain/repositories/puja_repository.dart';
import '../datasources/puja_data_source.dart';

class PujaRepositoryImpl implements PujaRepository {
  const PujaRepositoryImpl(this._source);

  final PujaDataSource _source;

  @override
  Future<Result<List<PujaService>>> catalogue({PujaPurpose? purpose}) =>
      guard(() => _source.catalogue(purpose: purpose));

  @override
  Future<Result<PujaService>> service(String serviceId) =>
      guard(() => _source.service(serviceId));

  @override
  Future<Result<List<DateTime>>> availableTimes({
    required String serviceId,
    required DateTime date,
  }) => guard(() => _source.availableTimes(serviceId: serviceId, date: date));

  @override
  Future<Result<PujaBooking>> book(PujaBookingRequest request) =>
      guard(() => _source.book(request));

  @override
  Future<Result<List<PujaBooking>>> myBookings() => guard(_source.myBookings);

  @override
  Future<Result<PujaBooking>> booking(String bookingId) =>
      guard(() => _source.booking(bookingId));

  @override
  Future<Result<PujaBooking>> cancel(String bookingId, String reason) =>
      guard(() => _source.cancel(bookingId, reason));
}
