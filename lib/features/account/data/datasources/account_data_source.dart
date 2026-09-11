import '../../domain/entities/account_entities.dart';

abstract interface class AccountDataSource {
  Future<List<SavedAddress>> addresses();
  Future<SavedAddress> saveAddress(SavedAddress address);
  Future<void> deleteAddress(String addressId);
  Future<void> setDefaultAddress(String addressId);
  Future<SecuritySettings> security();
  Future<SecuritySettings> updateSecurity(SecuritySettings settings);
  Future<List<DeviceSession>> devices();
  Future<void> revokeDevice(String deviceId);
  Future<void> revokeAllOtherDevices();
  Future<List<DataRequest>> dataRequests();
  Future<DataRequest> requestData(DataRequestKind kind);
  Future<List<SupportTicket>> tickets();
  Future<SupportTicket> ticket(String ticketId);
  Future<SupportTicket> createTicket({
    required String subject,
    required TicketTopic topic,
    required String body,
  });
  Future<SupportTicket> replyToTicket({
    required String ticketId,
    required String body,
  });
  Future<List<Offer>> offers();
  Future<ReferralSummary> referral();
}
