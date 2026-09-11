import '../../../../core/utils/result.dart';
import '../entities/account_entities.dart';

/// Addresses, security, privacy, support and offers.
///
/// One repository because these are all "my account" concerns backed by the
/// same user record; splitting them would spread a single screen's data
/// across four dependencies without buying isolation.
abstract interface class AccountRepository {
  Future<Result<List<SavedAddress>>> addresses();
  Future<Result<SavedAddress>> saveAddress(SavedAddress address);
  Future<Result<void>> deleteAddress(String addressId);
  Future<Result<void>> setDefaultAddress(String addressId);

  Future<Result<SecuritySettings>> security();
  Future<Result<SecuritySettings>> updateSecurity(SecuritySettings settings);
  Future<Result<List<DeviceSession>>> devices();
  Future<Result<void>> revokeDevice(String deviceId);
  Future<Result<void>> revokeAllOtherDevices();

  Future<Result<List<DataRequest>>> dataRequests();
  Future<Result<DataRequest>> requestData(DataRequestKind kind);

  Future<Result<List<SupportTicket>>> tickets();
  Future<Result<SupportTicket>> ticket(String ticketId);
  Future<Result<SupportTicket>> createTicket({
    required String subject,
    required TicketTopic topic,
    required String body,
  });
  Future<Result<SupportTicket>> replyToTicket({
    required String ticketId,
    required String body,
  });

  Future<Result<List<Offer>>> offers();
  Future<Result<ReferralSummary>> referral();
}
