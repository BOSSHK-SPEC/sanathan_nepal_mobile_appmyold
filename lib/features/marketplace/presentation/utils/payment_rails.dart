import 'package:flutter/material.dart';

import '../../../../core/region/region_all.dart';
import '../../domain/entities/order.dart';
import '../l10n/marketplace_strings.dart';

/// Single place that maps a region's [PaymentRail] to what the marketplace
/// UI shows for it: label, icon, secure-payment badge and the account
/// details rendered on the payment / boost cards.
extension PaymentRailX on PaymentRail {
  /// Localised label ("eSewa", "UPI", "Cash on Delivery" …).
  String label(MarketplaceStrings s) => switch (this) {
    PaymentRail.esewa => s.esewa,
    PaymentRail.khalti => s.khalti,
    PaymentRail.bankTransfer => s.bankTransfer,
    PaymentRail.cashOnDelivery => s.cashOnDelivery,
    PaymentRail.upi => s.upi,
    PaymentRail.card => s.card,
    PaymentRail.netBanking => s.netBanking,
  };

  IconData get icon => switch (this) {
    PaymentRail.esewa || PaymentRail.khalti => Icons.wallet_outlined,
    PaymentRail.upi => Icons.qr_code_2_outlined,
    PaymentRail.card => Icons.credit_card_outlined,
    PaymentRail.netBanking ||
    PaymentRail.bankTransfer => Icons.account_balance_outlined,
    PaymentRail.cashOnDelivery => Icons.payments_outlined,
  };

  /// Short badge text for the "secure payments provided by" footer; null
  /// for rails that have no badge (cash on delivery).
  String? get badge => switch (this) {
    PaymentRail.esewa => 'eSewa',
    PaymentRail.khalti => 'Khalti',
    PaymentRail.upi => 'UPI',
    PaymentRail.card => 'VISA',
    PaymentRail.netBanking => 'NetBanking',
    PaymentRail.bankTransfer => 'VISA',
    PaymentRail.cashOnDelivery => null,
  };
}

extension PaymentMethodX on PaymentMethod {
  String label(MarketplaceStrings s) => rail.label(s);
  IconData get icon => rail.icon;
}

/// Wallet / bank account details shown on the payment instruction cards.
///
/// TODO(ops): replace the India placeholders with the real UPI ID / bank
/// account once available.
class PaymentAccounts {
  const PaymentAccounts({
    required this.bankName,
    required this.accountHolder,
    required this.accountNumber,
    this.esewaId,
    this.khaltiId,
    this.upiId,
    this.ifscCode,
    this.bankBadge,
  });

  final String? esewaId;
  final String? khaltiId;
  final String? upiId;
  final String bankName;
  final String accountHolder;
  final String accountNumber;
  final String? ifscCode;

  /// Bank badge text shown next to the wallet badges ("NABIL BANK").
  final String? bankBadge;

  static const PaymentAccounts nepal = PaymentAccounts(
    esewaId: '9866952669',
    khaltiId: '9866952669',
    bankName: 'Nabil Bank',
    accountHolder: 'Hari Lochan Neupane',
    accountNumber: '3110017514066',
    bankBadge: 'NABIL BANK',
  );

  static const PaymentAccounts india = PaymentAccounts(
    upiId: 'sanatan@upi',
    bankName: 'State Bank of India',
    accountHolder: 'Sanatan Dharma Trust',
    accountNumber: '38012345678',
    ifscCode: 'SBIN0001234',
    bankBadge: 'SBI',
  );

  /// Accounts for the region of [config].
  static PaymentAccounts forRegion(RegionConfig config) =>
      switch (config.region) {
        Region.nepal => nepal,
        Region.india => india,
      };
}

/// Region-specific marketplace presentation data (administrative areas
/// offered in the checkout address form).
abstract final class MarketplaceRegion {
  /// Nepal's seven provinces.
  static const List<String> nepalProvinces = [
    'Koshi',
    'Madhesh',
    'Bagmati',
    'Gandaki',
    'Lumbini',
    'Karnali',
    'Sudurpashchim',
  ];

  /// Indian states / union territories (major ones + "Other").
  static const List<String> indiaStates = [
    'Delhi',
    'Maharashtra',
    'Karnataka',
    'Tamil Nadu',
    'Uttar Pradesh',
    'West Bengal',
    'Gujarat',
    'Rajasthan',
    'Telangana',
    'Kerala',
    'Bihar',
    'Madhya Pradesh',
    'Punjab',
    'Haryana',
    'Andhra Pradesh',
    'Odisha',
    'Assam',
    'Uttarakhand',
    'Jharkhand',
    'Chhattisgarh',
    'Goa',
    'Himachal Pradesh',
    'Other',
  ];

  /// Provinces (Nepal) / states (India) for the address form.
  static List<String> adminAreas(RegionConfig config) =>
      switch (config.region) {
        Region.nepal => nepalProvinces,
        Region.india => indiaStates,
      };

  /// Default admin area: Bagmati (Kathmandu) / Delhi.
  static String defaultAdminArea(RegionConfig config) =>
      switch (config.region) {
        Region.nepal => 'Bagmati',
        Region.india => 'Delhi',
      };

  /// "Province" (Nepal) / "State" (India).
  static String adminAreaLabel(MarketplaceStrings s, RegionConfig config) =>
      config.isIndia ? s.state : s.province;

  /// Countries offered in the checkout dropdown, region's own first.
  static List<String> countries(RegionConfig config) => [
    config.nameEn,
    for (final r in Region.values)
      if (r != config.region) r.config.nameEn,
    'Other',
  ];
}
