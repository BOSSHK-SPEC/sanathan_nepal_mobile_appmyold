import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/result.dart';
import '../entities/account_entities.dart';
import '../repositories/account_repository.dart';

class GetAddresses implements NoParamsUseCase<List<SavedAddress>> {
  const GetAddresses(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<List<SavedAddress>>> call() => _repo.addresses();
}

class SaveAddress implements UseCase<SavedAddress, SavedAddress> {
  const SaveAddress(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<SavedAddress>> call(SavedAddress params) =>
      _repo.saveAddress(params);
}

class DeleteAddress implements UseCase<void, String> {
  const DeleteAddress(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<void>> call(String params) => _repo.deleteAddress(params);
}

class SetDefaultAddress implements UseCase<void, String> {
  const SetDefaultAddress(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<void>> call(String params) => _repo.setDefaultAddress(params);
}

class GetSecuritySettings implements NoParamsUseCase<SecuritySettings> {
  const GetSecuritySettings(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<SecuritySettings>> call() => _repo.security();
}

class UpdateSecuritySettings
    implements UseCase<SecuritySettings, SecuritySettings> {
  const UpdateSecuritySettings(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<SecuritySettings>> call(SecuritySettings params) =>
      _repo.updateSecurity(params);
}

class GetDevices implements NoParamsUseCase<List<DeviceSession>> {
  const GetDevices(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<List<DeviceSession>>> call() => _repo.devices();
}

class RevokeDevice implements UseCase<void, String> {
  const RevokeDevice(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<void>> call(String params) => _repo.revokeDevice(params);
}

class RevokeAllOtherDevices implements NoParamsUseCase<void> {
  const RevokeAllOtherDevices(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<void>> call() => _repo.revokeAllOtherDevices();
}

class GetDataRequests implements NoParamsUseCase<List<DataRequest>> {
  const GetDataRequests(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<List<DataRequest>>> call() => _repo.dataRequests();
}

class RequestData implements UseCase<DataRequest, DataRequestKind> {
  const RequestData(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<DataRequest>> call(DataRequestKind params) =>
      _repo.requestData(params);
}

class GetTickets implements NoParamsUseCase<List<SupportTicket>> {
  const GetTickets(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<List<SupportTicket>>> call() => _repo.tickets();
}

class GetTicket implements UseCase<SupportTicket, String> {
  const GetTicket(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<SupportTicket>> call(String params) => _repo.ticket(params);
}

class CreateTicketParams {
  const CreateTicketParams({
    required this.subject,
    required this.topic,
    required this.body,
  });
  final String subject;
  final TicketTopic topic;
  final String body;
}

class CreateTicket implements UseCase<SupportTicket, CreateTicketParams> {
  const CreateTicket(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<SupportTicket>> call(CreateTicketParams params) =>
      _repo.createTicket(
        subject: params.subject,
        topic: params.topic,
        body: params.body,
      );
}

class ReplyToTicketParams {
  const ReplyToTicketParams({required this.ticketId, required this.body});
  final String ticketId;
  final String body;
}

class ReplyToTicket implements UseCase<SupportTicket, ReplyToTicketParams> {
  const ReplyToTicket(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<SupportTicket>> call(ReplyToTicketParams params) =>
      _repo.replyToTicket(ticketId: params.ticketId, body: params.body);
}

class GetOffers implements NoParamsUseCase<List<Offer>> {
  const GetOffers(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<List<Offer>>> call() => _repo.offers();
}

class GetReferral implements NoParamsUseCase<ReferralSummary> {
  const GetReferral(this._repo);
  final AccountRepository _repo;
  @override
  Future<Result<ReferralSummary>> call() => _repo.referral();
}
