import '../../../../core/utils/repository_guard.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/account_entities.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/account_data_source.dart';

class AccountRepositoryImpl implements AccountRepository {
  const AccountRepositoryImpl(this._source);

  final AccountDataSource _source;

  @override
  Future<Result<List<SavedAddress>>> addresses() => guard(_source.addresses);

  @override
  Future<Result<SavedAddress>> saveAddress(SavedAddress address) =>
      guard(() => _source.saveAddress(address));

  @override
  Future<Result<void>> deleteAddress(String addressId) =>
      guard(() => _source.deleteAddress(addressId));

  @override
  Future<Result<void>> setDefaultAddress(String addressId) =>
      guard(() => _source.setDefaultAddress(addressId));

  @override
  Future<Result<SecuritySettings>> security() => guard(_source.security);

  @override
  Future<Result<SecuritySettings>> updateSecurity(SecuritySettings settings) =>
      guard(() => _source.updateSecurity(settings));

  @override
  Future<Result<List<DeviceSession>>> devices() => guard(_source.devices);

  @override
  Future<Result<void>> revokeDevice(String deviceId) =>
      guard(() => _source.revokeDevice(deviceId));

  @override
  Future<Result<void>> revokeAllOtherDevices() =>
      guard(_source.revokeAllOtherDevices);

  @override
  Future<Result<List<DataRequest>>> dataRequests() =>
      guard(_source.dataRequests);

  @override
  Future<Result<DataRequest>> requestData(DataRequestKind kind) =>
      guard(() => _source.requestData(kind));

  @override
  Future<Result<List<SupportTicket>>> tickets() => guard(_source.tickets);

  @override
  Future<Result<SupportTicket>> ticket(String ticketId) =>
      guard(() => _source.ticket(ticketId));

  @override
  Future<Result<SupportTicket>> createTicket({
    required String subject,
    required TicketTopic topic,
    required String body,
  }) => guard(
    () => _source.createTicket(subject: subject, topic: topic, body: body),
  );

  @override
  Future<Result<SupportTicket>> replyToTicket({
    required String ticketId,
    required String body,
  }) => guard(() => _source.replyToTicket(ticketId: ticketId, body: body));

  @override
  Future<Result<List<Offer>>> offers() => guard(_source.offers);

  @override
  Future<Result<ReferralSummary>> referral() => guard(_source.referral);
}
