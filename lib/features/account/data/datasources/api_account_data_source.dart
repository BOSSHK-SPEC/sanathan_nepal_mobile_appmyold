import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_time.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_guard.dart';
import '../../../../core/network/api_money.dart';
import '../../domain/entities/account_entities.dart';
import 'account_data_source.dart';

/// Addresses, security, devices, tickets, offers and referrals from the
/// backend.
///
/// Everything here is account state rather than device state, which is the
/// point: revoking a stolen phone, a support reply, or a redeemed offer has to
/// be true on every device the moment the server says so.
class ApiAccountDataSource implements AccountDataSource {
  const ApiAccountDataSource(this._client, this._languageCode);

  final ApiClient _client;

  /// Read per call, not captured once: the user can switch language while the
  /// offers page is open.
  final String Function() _languageCode;

  // ------------------------------------------------------------ addresses --

  @override
  Future<List<SavedAddress>> addresses() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.accountAddresses);
    return asJsonList(response).map(_toAddress).toList(growable: false);
  });

  @override
  Future<SavedAddress> saveAddress(SavedAddress address) => guardApi(() async {
    final names = _splitName(address.fullName);
    final response = await _client.put<dynamic>(
      ApiEndpoints.accountAddresses,
      data: {
        if (address.id.isNotEmpty) 'id': address.id,
        // The server keeps a free-text label and a kind; the app only models
        // the kind, so the label is derived rather than left blank.
        'label': _labelText(address.label),
        'kind': address.label.name,
        'firstName': names.$1,
        'lastName': names.$2,
        'country': address.region.isEmpty ? 'Nepal' : address.region,
        'street': address.line1,
        'apartment': address.line2,
        'city': address.city,
        'province': address.region.isEmpty ? address.city : address.region,
        'postcode': address.postalCode,
        'phone': address.phone,
        'isDefault': address.isDefault,
      },
    );
    return _toAddress(asJsonMap(response));
  });

  @override
  Future<void> deleteAddress(String addressId) => guardApi(
    () => _client.delete<dynamic>(ApiEndpoints.accountAddress(addressId)),
  );

  @override
  Future<void> setDefaultAddress(String addressId) => guardApi(
    () => _client.post<dynamic>(ApiEndpoints.accountAddressDefault(addressId)),
  );

  // ------------------------------------------------------------- security --

  @override
  Future<SecuritySettings> security() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.accountSecurity);
    return _toSecurity(asJsonMap(response));
  });

  @override
  Future<SecuritySettings> updateSecurity(SecuritySettings settings) =>
      guardApi(() async {
        // Phone and email are not editable here — they change through the
        // verified flows in identity, and PATCHing them from a settings toggle
        // would be a way to take over an account.
        final response = await _client.patch<dynamic>(
          ApiEndpoints.accountSecurity,
          data: {
            'twoFactorEnabled': settings.twoFactorEnabled,
            'loginAlerts': settings.loginAlertsEnabled,
          },
        );
        return _toSecurity(asJsonMap(response));
      });

  // -------------------------------------------------------------- devices --

  @override
  Future<List<DeviceSession>> devices() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.accountDevices);
    return asJsonList(response).map(_toDevice).toList(growable: false);
  });

  @override
  Future<void> revokeDevice(String deviceId) => guardApi(
    () => _client.delete<dynamic>(ApiEndpoints.accountDevice(deviceId)),
  );

  @override
  Future<void> revokeAllOtherDevices() => guardApi(
    () => _client.post<dynamic>(ApiEndpoints.accountRevokeOtherDevices),
  );

  // --------------------------------------------------------- data rights --

  @override
  Future<List<DataRequest>> dataRequests() => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.accountDataRequests,
    );
    return asJsonList(response).map(_toDataRequest).toList(growable: false);
  });

  @override
  Future<DataRequest> requestData(DataRequestKind kind) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.accountDataRequests,
      data: {'kind': kind.name},
    );
    return _toDataRequest(asJsonMap(response));
  });

  // -------------------------------------------------------------- support --

  @override
  Future<List<SupportTicket>> tickets() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.accountTickets);
    return asJsonList(response).map(_toTicket).toList(growable: false);
  });

  @override
  Future<SupportTicket> ticket(String ticketId) => guardApi(() async {
    final response = await _client.get<dynamic>(
      ApiEndpoints.accountTicket(ticketId),
    );
    return _toTicket(asJsonMap(response));
  });

  @override
  Future<SupportTicket> createTicket({
    required String subject,
    required TicketTopic topic,
    required String body,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.accountTickets,
      data: {'subject': subject, 'topic': topic.name, 'body': body},
    );
    return _toTicket(asJsonMap(response));
  });

  @override
  Future<SupportTicket> replyToTicket({
    required String ticketId,
    required String body,
  }) => guardApi(() async {
    final response = await _client.post<dynamic>(
      ApiEndpoints.accountTicketReply(ticketId),
      data: {'body': body},
    );
    return _toTicket(asJsonMap(response));
  });

  // --------------------------------------------------- offers & referrals --

  @override
  Future<List<Offer>> offers() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.accountOffers);
    return asJsonList(response).map(_toOffer).toList(growable: false);
  });

  @override
  Future<ReferralSummary> referral() => guardApi(() async {
    final response = await _client.get<dynamic>(ApiEndpoints.accountReferral);
    final json = asJsonMap(response);
    return ReferralSummary(
      code: json['code'] as String? ?? '',
      invited: (json['invitedCount'] as num?)?.toInt() ?? 0,
      joined: (json['joinedCount'] as num?)?.toInt() ?? 0,
      earned: ApiMoney.toMajor(json['earnedMinor']),
      rewardPerReferral: ApiMoney.toMajor(json['rewardPerReferralMinor']),
    );
  });

  // ---------------------------------------------------------------- mapping --

  SavedAddress _toAddress(Map<String, dynamic> json) {
    final first = json['firstName'] as String? ?? '';
    final last = json['lastName'] as String? ?? '';
    return SavedAddress(
      id: json['id'] as String? ?? '',
      fullName: [first, last].where((p) => p.isNotEmpty).join(' '),
      phone: json['phone'] as String? ?? '',
      line1: json['street'] as String? ?? '',
      city: json['city'] as String? ?? '',
      label: AddressLabel.values.firstWhere(
        (l) => l.name == json['kind'],
        orElse: () => AddressLabel.other,
      ),
      line2: json['apartment'] as String? ?? '',
      region: json['province'] as String? ?? '',
      postalCode: json['postcode'] as String? ?? '',
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  SecuritySettings _toSecurity(Map<String, dynamic> json) => SecuritySettings(
    phone: json['phone'] as String? ?? '',
    email: json['email'] as String? ?? '',
    twoFactorEnabled: json['twoFactorEnabled'] as bool? ?? false,
    loginAlertsEnabled: json['loginAlerts'] as bool? ?? false,
  );

  DeviceSession _toDevice(Map<String, dynamic> json) {
    final platform = json['platform'] as String? ?? '';
    final version = json['appVersion'] as String?;
    return DeviceSession(
      id: json['id'] as String? ?? '',
      // The server records what it can prove — platform and app version — and
      // not a name the device claims for itself.
      deviceName: version == null || version.isEmpty
          ? _platformLabel(platform)
          : '${_platformLabel(platform)} · $version',
      platform: platform,
      lastActiveAt: ApiTime.instantOr(json['lastSeenAt'], DateTime.now()),
      isCurrent: json['isCurrent'] as bool? ?? false,
    );
  }

  DataRequest _toDataRequest(Map<String, dynamic> json) => DataRequest(
    kind: json['kind'] == 'deletion'
        ? DataRequestKind.deletion
        : DataRequestKind.export,
    status: switch (json['status']) {
      'pending' || 'processing' => DataRequestStatus.pending,
      'ready' => DataRequestStatus.ready,
      'rejected' => DataRequestStatus.rejected,
      'completed' => DataRequestStatus.completed,
      _ => DataRequestStatus.none,
    },
    requestedAt: ApiTime.instant(json['requestedAt']),
    readyAt: ApiTime.instant(json['completedAt']),
    downloadRef: json['downloadUrl'] as String?,
  );

  SupportTicket _toTicket(Map<String, dynamic> json) {
    final id = json['id'] as String? ?? '';
    final messages = json['messages'];
    return SupportTicket(
      id: id,
      // ULIDs end in randomness, so the tail is the part that distinguishes
      // two tickets when a user reads a reference out over the phone.
      reference: id.length <= 6
          ? id.toUpperCase()
          : 'TK-${id.substring(id.length - 6).toUpperCase()}',
      subject: json['subject'] as String? ?? '',
      topic: TicketTopic.values.firstWhere(
        (t) => t.name == json['topic'],
        // The server also knows 'technical', which the app files under other.
        orElse: () => TicketTopic.other,
      ),
      status: switch (json['status']) {
        'awaitingUser' => TicketStatus.waitingOnYou,
        'resolved' => TicketStatus.resolved,
        'closed' => TicketStatus.closed,
        _ => TicketStatus.open,
      },
      createdAt: ApiTime.instantOr(json['createdAt'], DateTime.now()),
      updatedAt: ApiTime.instantOr(json['updatedAt'], DateTime.now()),
      messages: messages is List
          ? messages
                .whereType<Map>()
                .map(
                  (m) => TicketMessage(
                    id: m['id'] as String? ?? '',
                    body: m['body'] as String? ?? '',
                    sentAt: ApiTime.instantOr(m['createdAt'], DateTime.now()),
                    fromSupport: m['isStaff'] as bool? ?? false,
                  ),
                )
                .toList(growable: false)
          : const [],
    );
  }

  Offer _toOffer(Map<String, dynamic> json) {
    final language = _languageCode();
    return Offer(
      id: json['id'] as String? ?? '',
      code: json['code'] as String? ?? '',
      title: _localized(json['title'], language),
      description: _localized(json['description'], language),
      kind: OfferKind.values.firstWhere(
        (k) => k.name == json['kind'],
        orElse: () => OfferKind.productDiscount,
      ),
      expiresAt: ApiTime.instantOr(json['endsAt'], DateTime.now()),
      used: json['used'] as bool? ?? false,
      minimumSpend: ApiMoney.toMajor(json['minSpendMinor']),
    );
  }

  /// Offer copy is plain `String` on the entity (it is rendered as written by
  /// marketing), so the active language is resolved here rather than carried
  /// through the UI.
  static String _localized(Object? raw, String language) {
    if (raw is String) return raw;
    if (raw is! Map) return '';
    return (raw[language] ?? raw['en'] ?? raw.values.firstOrNull ?? '')
        .toString();
  }

  static String _platformLabel(String platform) => switch (platform) {
    'android' => 'Android',
    'ios' => 'iPhone',
    'web' => 'Web',
    _ => 'Device',
  };

  static String _labelText(AddressLabel label) => switch (label) {
    AddressLabel.home => 'Home',
    AddressLabel.work => 'Work',
    AddressLabel.other => 'Other',
  };

  /// Splits a single display name into the server's first/last pair, keeping
  /// everything after the first token together — many Nepali names have three
  /// parts and the surname is the last one.
  static (String, String) _splitName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length <= 1) return (fullName.trim(), '-');
    return (parts.first, parts.skip(1).join(' '));
  }
}
