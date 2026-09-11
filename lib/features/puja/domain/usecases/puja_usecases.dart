import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/puja_booking.dart';
import '../entities/puja_service.dart';
import '../repositories/puja_repository.dart';

class GetPujaCatalogue implements UseCase<List<PujaService>, PujaPurpose?> {
  const GetPujaCatalogue(this._repo);
  final PujaRepository _repo;

  @override
  Future<Result<List<PujaService>>> call(PujaPurpose? params) =>
      _repo.catalogue(purpose: params);
}

class GetPujaService implements UseCase<PujaService, String> {
  const GetPujaService(this._repo);
  final PujaRepository _repo;

  @override
  Future<Result<PujaService>> call(String params) => _repo.service(params);
}

/// A service and a day together — neither alone identifies a set of times.
class PujaTimesParams {
  const PujaTimesParams({required this.serviceId, required this.date});
  final String serviceId;
  final DateTime date;
}

class GetPujaTimes implements UseCase<List<DateTime>, PujaTimesParams> {
  const GetPujaTimes(this._repo);
  final PujaRepository _repo;

  @override
  Future<Result<List<DateTime>>> call(PujaTimesParams params) =>
      _repo.availableTimes(serviceId: params.serviceId, date: params.date);
}

class BookPuja implements UseCase<PujaBooking, PujaBookingRequest> {
  const BookPuja(this._repo);
  final PujaRepository _repo;

  @override
  Future<Result<PujaBooking>> call(PujaBookingRequest params) =>
      _repo.book(params);
}

class GetMyPujas implements NoParamsUseCase<List<PujaBooking>> {
  const GetMyPujas(this._repo);
  final PujaRepository _repo;

  @override
  Future<Result<List<PujaBooking>>> call() => _repo.myBookings();
}

class GetPujaBooking implements UseCase<PujaBooking, String> {
  const GetPujaBooking(this._repo);
  final PujaRepository _repo;

  @override
  Future<Result<PujaBooking>> call(String params) => _repo.booking(params);
}

class CancelPujaParams {
  const CancelPujaParams({required this.bookingId, required this.reason});
  final String bookingId;
  final String reason;
}

class CancelPuja implements UseCase<PujaBooking, CancelPujaParams> {
  const CancelPuja(this._repo);
  final PujaRepository _repo;

  @override
  Future<Result<PujaBooking>> call(CancelPujaParams params) =>
      _repo.cancel(params.bookingId, params.reason);
}
