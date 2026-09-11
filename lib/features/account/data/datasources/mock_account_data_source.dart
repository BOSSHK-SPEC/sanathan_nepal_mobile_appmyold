import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/region/region_resolver.dart';
import '../../../../core/storage/key_value_store.dart';
import '../../domain/entities/account_entities.dart';
import 'account_data_source.dart';

/// In-memory account data.
///
/// The rules enforced here are the ones a real backend would own and the UI
/// must not duplicate: exactly one default address, the current device can
/// never be revoked, a deletion request cannot be raised twice, and a closed
/// ticket cannot be replied to.
class MockAccountDataSource implements AccountDataSource {
  MockAccountDataSource(this._store, this._regions);

  final KeyValueStore _store;
  final RegionResolver _regions;

  static const _addressesKey = 'account.addresses';
  static const _securityKey = 'account.security';
  static const _revokedKey = 'account.revokedDevices';
  static const _requestsKey = 'account.dataRequests';
  static const _ticketsKey = 'account.tickets';
  static const _seededKey = 'account.seeded';

  static const Duration _latency = Duration(milliseconds: 160);

  double get _scale => _regions.region == Region.nepal ? 1.0 : 0.6;

  bool get _isNepal => _regions.region == Region.nepal;

  // --- Addresses --------------------------------------------------------

  @override
  Future<List<SavedAddress>> addresses() async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    final all = _readAddresses();
    // Default first — it is the one that matters at checkout.
    all.sort((a, b) {
      if (a.isDefault == b.isDefault) return 0;
      return a.isDefault ? -1 : 1;
    });
    return all;
  }

  @override
  Future<SavedAddress> saveAddress(SavedAddress address) async {
    await Future<void>.delayed(_latency);
    if (!address.isValid) {
      throw const ValidationException(
        'Name, phone, address and city are required',
      );
    }

    final existing = _readAddresses();
    final saved = address.id.isEmpty
        ? address.copyWith(
            id: 'ad-${DateTime.now().microsecondsSinceEpoch}',
            // The first address saved becomes the default automatically.
            isDefault: existing.isEmpty || address.isDefault,
          )
        : address;

    final others = existing.where((a) => a.id != saved.id);
    await _writeAddresses([
      saved,
      // Exactly one default: saving a default demotes the rest.
      for (final a in others)
        saved.isDefault ? a.copyWith(isDefault: false) : a,
    ]);
    return saved;
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await Future<void>.delayed(_latency);
    final remaining = _readAddresses().where((a) => a.id != addressId).toList();
    // Deleting the default promotes the next one, so checkout is never left
    // without a destination.
    if (remaining.isNotEmpty && !remaining.any((a) => a.isDefault)) {
      remaining[0] = remaining[0].copyWith(isDefault: true);
    }
    await _writeAddresses(remaining);
  }

  @override
  Future<void> setDefaultAddress(String addressId) async {
    await Future<void>.delayed(_latency);
    await _writeAddresses([
      for (final a in _readAddresses())
        a.copyWith(isDefault: a.id == addressId),
    ]);
  }

  // --- Security ---------------------------------------------------------

  @override
  Future<SecuritySettings> security() async {
    await Future<void>.delayed(_latency);
    final raw = _store.getString(_securityKey);
    if (raw == null || raw.isEmpty) {
      return SecuritySettings(
        phone: _isNepal ? '+977 9841000000' : '+91 9810000000',
        email: 'you@example.com',
        loginAlertsEnabled: true,
        passwordChangedAt: DateTime.now().subtract(const Duration(days: 92)),
      );
    }
    final e = jsonDecode(raw) as Map<String, dynamic>;
    return SecuritySettings(
      phone: e['phone'] as String? ?? '',
      email: e['email'] as String? ?? '',
      twoFactorEnabled: e['twoFactorEnabled'] as bool? ?? false,
      loginAlertsEnabled: e['loginAlertsEnabled'] as bool? ?? true,
      passwordChangedAt: e['passwordChangedAt'] == null
          ? null
          : DateTime.parse(e['passwordChangedAt'] as String),
    );
  }

  @override
  Future<SecuritySettings> updateSecurity(SecuritySettings settings) async {
    await Future<void>.delayed(_latency);
    if (settings.email.isNotEmpty && !settings.email.contains('@')) {
      throw const ValidationException('Enter a valid email address');
    }
    await _store.setString(
      _securityKey,
      jsonEncode({
        'phone': settings.phone,
        'email': settings.email,
        'twoFactorEnabled': settings.twoFactorEnabled,
        'loginAlertsEnabled': settings.loginAlertsEnabled,
        'passwordChangedAt': settings.passwordChangedAt?.toIso8601String(),
      }),
    );
    return settings;
  }

  @override
  Future<List<DeviceSession>> devices() async {
    await Future<void>.delayed(_latency);
    final revoked = (_store.getStringList(_revokedKey) ?? const <String>[])
        .toSet();
    final now = DateTime.now();
    return [
      DeviceSession(
        id: 'd-1',
        deviceName: 'This device',
        platform: 'Android 15',
        location: _isNepal ? 'Kathmandu' : 'New Delhi',
        lastActiveAt: now,
        isCurrent: true,
      ),
      DeviceSession(
        id: 'd-2',
        deviceName: 'iPhone 14',
        platform: 'iOS 18',
        location: _isNepal ? 'Pokhara' : 'Mumbai',
        lastActiveAt: now.subtract(const Duration(days: 3)),
      ),
      DeviceSession(
        id: 'd-3',
        deviceName: 'Chrome on Windows',
        platform: 'Web',
        location: _isNepal ? 'Biratnagar' : 'Bengaluru',
        lastActiveAt: now.subtract(const Duration(days: 47)),
      ),
    ].where((d) => !revoked.contains(d.id)).toList();
  }

  @override
  Future<void> revokeDevice(String deviceId) async {
    await Future<void>.delayed(_latency);
    final all = await devices();
    final match = all.where((d) => d.id == deviceId);
    if (match.isEmpty) {
      throw NotFoundException('No device with id "$deviceId"');
    }
    if (match.first.isCurrent) {
      throw const ValidationException(
        'Sign out from settings to end this session',
      );
    }
    await _store.setStringList(_revokedKey, [
      ...(_store.getStringList(_revokedKey) ?? const <String>[]),
      deviceId,
    ]);
  }

  @override
  Future<void> revokeAllOtherDevices() async {
    await Future<void>.delayed(_latency);
    final others = (await devices()).where((d) => !d.isCurrent);
    await _store.setStringList(_revokedKey, [
      ...(_store.getStringList(_revokedKey) ?? const <String>[]),
      for (final d in others) d.id,
    ]);
  }

  // --- Privacy ----------------------------------------------------------

  @override
  Future<List<DataRequest>> dataRequests() async {
    await Future<void>.delayed(_latency);
    final raw = _store.getString(_requestsKey);
    if (raw == null || raw.isEmpty) {
      return [
        for (final kind in DataRequestKind.values)
          DataRequest(kind: kind, status: DataRequestStatus.none),
      ];
    }
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        DataRequest(
          kind: DataRequestKind.values.firstWhere(
            (k) => k.name == (e as Map<String, dynamic>)['kind'],
            orElse: () => DataRequestKind.export,
          ),
          status: DataRequestStatus.values.firstWhere(
            (s) => s.name == (e as Map<String, dynamic>)['status'],
            orElse: () => DataRequestStatus.none,
          ),
          requestedAt: (e as Map<String, dynamic>)['requestedAt'] == null
              ? null
              : DateTime.parse(e['requestedAt'] as String),
        ),
    ];
  }

  @override
  Future<DataRequest> requestData(DataRequestKind kind) async {
    await Future<void>.delayed(_latency);
    final all = await dataRequests();
    final existing = all.firstWhere((r) => r.kind == kind);
    if (existing.isOpen) {
      throw const ValidationException(
        'A request of this kind is already in progress',
      );
    }

    final updated = DataRequest(
      kind: kind,
      status: DataRequestStatus.pending,
      requestedAt: DateTime.now(),
    );
    final next = [for (final r in all) r.kind == kind ? updated : r];
    await _store.setString(
      _requestsKey,
      jsonEncode([
        for (final r in next)
          {
            'kind': r.kind.name,
            'status': r.status.name,
            'requestedAt': r.requestedAt?.toIso8601String(),
          },
      ]),
    );
    return updated;
  }

  // --- Support ----------------------------------------------------------

  @override
  Future<List<SupportTicket>> tickets() async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    return _readTickets()..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  @override
  Future<SupportTicket> ticket(String ticketId) async {
    await Future<void>.delayed(_latency);
    await _seedOnce();
    final matches = _readTickets().where((t) => t.id == ticketId);
    if (matches.isEmpty) {
      throw NotFoundException('No ticket with id "$ticketId"');
    }
    return matches.first;
  }

  @override
  Future<SupportTicket> createTicket({
    required String subject,
    required TicketTopic topic,
    required String body,
  }) async {
    await Future<void>.delayed(_latency);
    if (subject.trim().isEmpty) {
      throw const ValidationException('Add a subject');
    }
    if (body.trim().length < 10) {
      throw const ValidationException(
        'Describe the problem in a little more detail',
      );
    }

    final now = DateTime.now();
    final ticket = SupportTicket(
      id: 'tk-${now.microsecondsSinceEpoch}',
      reference: 'SUP-${now.millisecondsSinceEpoch % 100000}',
      subject: subject.trim(),
      topic: topic,
      status: TicketStatus.open,
      createdAt: now,
      updatedAt: now,
      messages: [
        TicketMessage(
          id: 'm-${now.microsecondsSinceEpoch}',
          body: body.trim(),
          sentAt: now,
        ),
      ],
    );
    await _writeTickets([ticket, ..._readTickets()]);
    return ticket;
  }

  @override
  Future<SupportTicket> replyToTicket({
    required String ticketId,
    required String body,
  }) async {
    await Future<void>.delayed(_latency);
    if (body.trim().isEmpty) {
      throw const ValidationException('Write a message first');
    }
    final ticket = await this.ticket(ticketId);
    if (!ticket.canReply) {
      throw const ValidationException(
        'This ticket is closed. Open a new one instead.',
      );
    }

    final now = DateTime.now();
    final updated = ticket.copyWith(
      updatedAt: now,
      // Replying moves it back to the support team.
      status: TicketStatus.open,
      messages: [
        ...ticket.messages,
        TicketMessage(
          id: 'm-${now.microsecondsSinceEpoch}',
          body: body.trim(),
          sentAt: now,
        ),
      ],
    );
    await _writeTickets([
      updated,
      ..._readTickets().where((t) => t.id != ticketId),
    ]);
    return updated;
  }

  // --- Offers & referral ------------------------------------------------

  @override
  Future<List<Offer>> offers() async {
    await Future<void>.delayed(_latency);
    final now = DateTime.now();
    return [
      Offer(
        id: 'of-1',
        code: 'FIRST50',
        title: '50% off your first consultation',
        description: 'Applies automatically to your first paid session.',
        kind: OfferKind.firstConsultation,
        expiresAt: now.add(const Duration(days: 2)),
      ),
      Offer(
        id: 'of-2',
        code: 'ADD1000',
        title: 'Add 1000, get 100 extra',
        description: 'Bonus credit lands with your top-up.',
        kind: OfferKind.walletBonus,
        minimumSpend: 1000 * _scale,
        expiresAt: now.add(const Duration(days: 21)),
      ),
      Offer(
        id: 'of-3',
        code: 'DASHAIN10',
        title: '10% off gemstones and rudraksha',
        description: 'Festival discount on the marketplace.',
        kind: OfferKind.productDiscount,
        expiresAt: now.add(const Duration(days: 9)),
      ),
      Offer(
        id: 'of-4',
        code: 'WELCOME5',
        title: '5 free chat minutes',
        description: 'Already used on your first session.',
        kind: OfferKind.freeMinutes,
        used: true,
        expiresAt: now.subtract(const Duration(days: 12)),
      ),
    ];
  }

  @override
  Future<ReferralSummary> referral() async {
    await Future<void>.delayed(_latency);
    return ReferralSummary(
      code: 'SANATAN-4K9P',
      invited: 7,
      joined: 3,
      earned: 450 * _scale,
      rewardPerReferral: 150 * _scale,
    );
  }

  // --- Persistence ------------------------------------------------------

  Future<void> _seedOnce() async {
    if (_store.getBool(_seededKey) ?? false) return;
    final now = DateTime.now();

    await _writeAddresses([
      SavedAddress(
        id: 'ad-seed-1',
        fullName: _isNepal ? 'Sita Sharma' : 'Priya Nair',
        phone: _isNepal ? '9841000000' : '9810000000',
        line1: _isNepal ? 'Baluwatar, Ward 4' : '12 MG Road',
        city: _isNepal ? 'Kathmandu' : 'New Delhi',
        region: _isNepal ? 'Bagmati' : 'Delhi',
        postalCode: _isNepal ? '44600' : '110001',
        isDefault: true,
      ),
    ]);

    await _writeTickets([
      SupportTicket(
        id: 'tk-seed-1',
        reference: 'SUP-40218',
        subject: 'Top-up not credited',
        topic: TicketTopic.payment,
        status: TicketStatus.waitingOnYou,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(hours: 6)),
        messages: [
          TicketMessage(
            id: 'm-1',
            body:
                'I paid through eSewa but the amount has not appeared in my '
                'wallet.',
            sentAt: now.subtract(const Duration(days: 2)),
          ),
          TicketMessage(
            id: 'm-2',
            body:
                'Thanks for writing in. Could you share the eSewa reference '
                'number so we can trace it?',
            sentAt: now.subtract(const Duration(hours: 6)),
            fromSupport: true,
          ),
        ],
      ),
      SupportTicket(
        id: 'tk-seed-2',
        reference: 'SUP-39880',
        subject: 'Astrologer did not join',
        topic: TicketTopic.consultation,
        status: TicketStatus.resolved,
        createdAt: now.subtract(const Duration(days: 16)),
        updatedAt: now.subtract(const Duration(days: 14)),
        messages: [
          TicketMessage(
            id: 'm-3',
            body: 'The session timed out and I was still charged.',
            sentAt: now.subtract(const Duration(days: 16)),
          ),
          TicketMessage(
            id: 'm-4',
            body: 'Refunded in full to your wallet. Sorry about that.',
            sentAt: now.subtract(const Duration(days: 14)),
            fromSupport: true,
          ),
        ],
      ),
    ]);

    await _store.setBool(_seededKey, true);
  }

  List<SavedAddress> _readAddresses() {
    final raw = _store.getString(_addressesKey);
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        SavedAddress(
          id: (e as Map<String, dynamic>)['id'] as String,
          fullName: e['fullName'] as String,
          phone: e['phone'] as String,
          line1: e['line1'] as String,
          line2: e['line2'] as String? ?? '',
          city: e['city'] as String,
          region: e['region'] as String? ?? '',
          postalCode: e['postalCode'] as String? ?? '',
          isDefault: e['isDefault'] as bool? ?? false,
          label: AddressLabel.values.firstWhere(
            (l) => l.name == e['label'],
            orElse: () => AddressLabel.home,
          ),
        ),
    ];
  }

  Future<void> _writeAddresses(List<SavedAddress> addresses) =>
      _store.setString(
        _addressesKey,
        jsonEncode([
          for (final a in addresses)
            {
              'id': a.id,
              'fullName': a.fullName,
              'phone': a.phone,
              'line1': a.line1,
              'line2': a.line2,
              'city': a.city,
              'region': a.region,
              'postalCode': a.postalCode,
              'isDefault': a.isDefault,
              'label': a.label.name,
            },
        ]),
      );

  List<SupportTicket> _readTickets() {
    final raw = _store.getString(_ticketsKey);
    if (raw == null || raw.isEmpty) return [];
    return [
      for (final e in jsonDecode(raw) as List<dynamic>)
        SupportTicket(
          id: (e as Map<String, dynamic>)['id'] as String,
          reference: e['reference'] as String,
          subject: e['subject'] as String,
          topic: TicketTopic.values.firstWhere(
            (t) => t.name == e['topic'],
            orElse: () => TicketTopic.other,
          ),
          status: TicketStatus.values.firstWhere(
            (s) => s.name == e['status'],
            orElse: () => TicketStatus.open,
          ),
          createdAt: DateTime.parse(e['createdAt'] as String),
          updatedAt: DateTime.parse(e['updatedAt'] as String),
          messages: [
            for (final m in (e['messages'] as List<dynamic>? ?? []))
              TicketMessage(
                id: (m as Map<String, dynamic>)['id'] as String,
                body: m['body'] as String,
                sentAt: DateTime.parse(m['sentAt'] as String),
                fromSupport: m['fromSupport'] as bool? ?? false,
              ),
          ],
        ),
    ];
  }

  Future<void> _writeTickets(List<SupportTicket> tickets) => _store.setString(
    _ticketsKey,
    jsonEncode([
      for (final t in tickets)
        {
          'id': t.id,
          'reference': t.reference,
          'subject': t.subject,
          'topic': t.topic.name,
          'status': t.status.name,
          'createdAt': t.createdAt.toIso8601String(),
          'updatedAt': t.updatedAt.toIso8601String(),
          'messages': [
            for (final m in t.messages)
              {
                'id': m.id,
                'body': m.body,
                'sentAt': m.sentAt.toIso8601String(),
                'fromSupport': m.fromSupport,
              },
          ],
        },
    ]),
  );
}
