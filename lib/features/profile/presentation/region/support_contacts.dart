import '../../../../core/region/region.dart';

/// Help & Support contact channels per [Region] (config-driven map, so the
/// support page never branches on the region itself).
class SupportContacts {
  const SupportContacts({
    required this.phone,
    required this.email,
    required this.whatsapp,
  });

  final String phone;
  final String email;
  final String whatsapp;

  static const Map<Region, SupportContacts> _byRegion = {
    Region.nepal: SupportContacts(
      phone: '+977-01-4444444',
      email: 'support@sanatannepal.com',
      whatsapp: '+977-9800000000',
    ),
    Region.india: SupportContacts(
      phone: '+91-11-40000000',
      email: 'support.in@sanatannepal.com',
      whatsapp: '+91-9800000000',
    ),
  };

  /// Contacts for [config]'s region.
  static SupportContacts of(RegionConfig config) =>
      _byRegion[config.region] ?? _byRegion[Region.nepal]!;
}
