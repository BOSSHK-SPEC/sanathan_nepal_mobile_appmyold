import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/appointment.dart';
import '../l10n/appointment_strings.dart';

/// Static payee details per region (wallet ids, UPI handle, bank account).
/// Purely a config-driven data map – widgets look values up by
/// `context.regionConfig` and never branch on the region themselves.
class PayeeAccount {
  const PayeeAccount({
    required this.walletId,
    required this.bankName,
    required this.accountHolder,
    required this.accountNumber,
    this.bankCode,
  });

  /// eSewa / Khalti id (Nepal) or UPI VPA (India).
  final String walletId;
  final String bankName;
  final String accountHolder;
  final String accountNumber;

  /// IFSC / branch code when the bank requires one (India).
  final String? bankCode;
}

/// Payment details from the design (eSewa / Khalti IDs, bank) plus the
/// Indian equivalents (UPI handle, SBI account).
abstract final class PaymentInfo {
  static const Map<Region, PayeeAccount> _accounts = {
    Region.nepal: PayeeAccount(
      walletId: '9866952669',
      bankName: 'Nabil Bank',
      accountHolder: 'Hari Lochan Neupane',
      accountNumber: '3110017514066',
    ),
    Region.india: PayeeAccount(
      walletId: 'sanathan@upi',
      bankName: 'State Bank of India',
      accountHolder: 'Sanathan Jyotish Seva',
      accountNumber: '30412345678',
      bankCode: 'SBIN0000123',
    ),
  };

  static PayeeAccount account(RegionConfig config) =>
      _accounts[config.region] ?? _accounts[Region.nepal]!;

  /// Radio / summary label, e.g. "eSewa ID: 98…", "UPI: sanathan@upi",
  /// "Bank transfer".
  static String label(
    PaymentMethod m,
    AppointmentStrings s,
    RegionConfig config,
  ) {
    final base = s.rail(m.rail);
    return switch (m.rail) {
      PaymentRail.esewa ||
      PaymentRail.khalti ||
      PaymentRail.upi => '$base: ${account(config).walletId}',
      _ => base,
    };
  }
}

/// "Label ........ value" line used in payment summaries.
class PaymentSummaryRow extends StatelessWidget {
  const PaymentSummaryRow({
    required this.label,
    required this.value,
    super.key,
    this.bold = false,
  });

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style =
        (bold ? context.textTheme.titleSmall : context.textTheme.bodyMedium)
            ?.copyWith(fontWeight: bold ? FontWeight.w700 : null);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}

/// Bank instructions for the selected [PaymentMethod] (bank transfer only).
class PaymentInstructions extends StatelessWidget {
  const PaymentInstructions({required this.method, super.key});

  final PaymentMethod method;

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    final colors = context.colors;
    final textTheme = context.textTheme;
    if (!method.needsBankDetails) return const SizedBox.shrink();
    final account = PaymentInfo.account(context.regionConfig);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.bankDetails,
            style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${strings.bankName}: ${account.bankName}',
            style: textTheme.bodySmall,
          ),
          Text(
            '${strings.accountHolder}: ${account.accountHolder}',
            style: textTheme.bodySmall,
          ),
          Text(
            '${strings.accountNumber}: ${account.accountNumber}',
            style: textTheme.bodySmall,
          ),
          if (account.bankCode != null)
            Text(
              '${strings.bankCode}: ${account.bankCode}',
              style: textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
