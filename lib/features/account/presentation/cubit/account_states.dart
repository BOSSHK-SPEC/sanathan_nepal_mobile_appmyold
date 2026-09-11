part of 'account_cubits.dart';

@freezed
abstract class AddressesState with _$AddressesState {
  const AddressesState._();

  const factory AddressesState({
    @Default(LoadState.idle()) LoadState<List<SavedAddress>> addresses,
    @Default(LoadState.idle()) LoadState<SavedAddress> saving,
    String? saveError,
  }) = _AddressesState;

  List<SavedAddress> get all => addresses.dataOrNull ?? const [];

  bool get isEmpty => addresses.isLoaded && all.isEmpty;

  SavedAddress? get defaultAddress => all.where((a) => a.isDefault).firstOrNull;
}

@freezed
abstract class SecurityState with _$SecurityState {
  const SecurityState._();

  const factory SecurityState({
    @Default(LoadState.idle()) LoadState<SecuritySettings> settings,
    @Default(LoadState.idle()) LoadState<List<DeviceSession>> devices,
  }) = _SecurityState;

  SecuritySettings get current =>
      settings.dataOrNull ?? const SecuritySettings();

  List<DeviceSession> get sessions => devices.dataOrNull ?? const [];

  /// Other devices, which are the ones that can actually be revoked.
  List<DeviceSession> get otherSessions =>
      sessions.where((d) => !d.isCurrent).toList();

  bool get hasStaleSessions => otherSessions.any((d) => d.isStale);
}

@freezed
abstract class PrivacyState with _$PrivacyState {
  const PrivacyState._();

  const factory PrivacyState({
    @Default(LoadState.idle()) LoadState<List<DataRequest>> requests,
    @Default(LoadState.idle()) LoadState<DataRequest> submitting,
  }) = _PrivacyState;

  List<DataRequest> get all => requests.dataOrNull ?? const [];

  DataRequest requestFor(DataRequestKind kind) => all.firstWhere(
    (r) => r.kind == kind,
    orElse: () => DataRequest(kind: kind, status: DataRequestStatus.none),
  );
}

@freezed
abstract class SupportTicketsState with _$SupportTicketsState {
  const SupportTicketsState._();

  const factory SupportTicketsState({
    @Default(LoadState.idle()) LoadState<List<SupportTicket>> tickets,
    @Default(LoadState.idle()) LoadState<SupportTicket> submitting,
  }) = _SupportTicketsState;

  List<SupportTicket> get all => tickets.dataOrNull ?? const [];

  List<SupportTicket> get open => all.where((t) => t.isOpen).toList();

  bool get isEmpty => tickets.isLoaded && all.isEmpty;

  /// Tickets the support team is waiting on the user for — the ones that
  /// stall unless surfaced.
  int get awaitingYouCount =>
      all.where((t) => t.status == TicketStatus.waitingOnYou).length;

  SupportTicket? byId(String id) => all.where((t) => t.id == id).firstOrNull;
}

@freezed
abstract class OffersState with _$OffersState {
  const OffersState._();

  const factory OffersState({
    @Default(LoadState.idle()) LoadState<List<Offer>> offers,
    @Default(LoadState.idle()) LoadState<ReferralSummary> referral,
  }) = _OffersState;

  List<Offer> get all => offers.dataOrNull ?? const [];

  List<Offer> get available => all.where((o) => o.isUsable).toList();

  List<Offer> get spent => all.where((o) => !o.isUsable).toList();

  ReferralSummary? get referralSummary => referral.dataOrNull;

  bool get isEmpty => offers.isLoaded && all.isEmpty;
}
