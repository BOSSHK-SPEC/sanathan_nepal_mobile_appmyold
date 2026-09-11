import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_all.dart';
import '../../../../core/theme/app_spacing.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import '../utils/payment_rails.dart';
import 'upload_dropzone.dart';

/// Total + payment instructions + receipt upload for the boost flow
/// (Figma "payment for nepali user").
///
/// The instruction blocks follow `RegionConfig.paymentRails` and
/// [PaymentAccounts.forRegion]: Nepal shows eSewa / Khalti IDs and the Nabil
/// bank details; India shows the UPI ID with a QR placeholder plus an
/// Indian bank block (bank, A/C holder, A/C number, IFSC).
class PaymentDetailsCard extends StatelessWidget {
  const PaymentDetailsCard({
    required this.total,
    required this.receiptName,
    required this.onPickReceipt,
    super.key,
  });

  final double total;
  final String? receiptName;
  final VoidCallback onPickReceipt;

  // Nepal defaults kept as constants for callers / tests.
  static const String esewaId = '9866952669';
  static const String khaltiId = '9866952669';
  static const String bankName = 'Nabil Bank';
  static const String accountHolder = 'Hari Lochan Neupane';
  static const String accountNumber = '3110017514066';

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final t = context.textTheme;
    final config = context.regionConfig;
    final accounts = PaymentAccounts.forRegion(config);
    final rails = config.paymentRails;
    final labelStyle = t.bodySmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: colors.textPrimary,
    );
    final valueStyle = t.bodySmall?.copyWith(color: colors.textPrimary);
    final hasWallets =
        rails.contains(PaymentRail.esewa) || rails.contains(PaymentRail.khalti);
    final hasUpi = rails.contains(PaymentRail.upi) && accounts.upiId != null;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.total,
                style: t.bodyMedium?.copyWith(color: colors.textSecondary),
              ),
              Text(
                '${MarketplaceFormat.priceOf(context, total)}/-',
                style: t.titleSmall?.copyWith(
                  color: colors.accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Divider(height: AppSpacing.lg, color: colors.divider),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final rail in rails)
                if (rail != PaymentRail.cashOnDelivery &&
                    rail != PaymentRail.bankTransfer &&
                    rail != PaymentRail.netBanking) ...[
                  _RailBadge(rail: rail),
                  _VerticalRule(color: colors.divider),
                ],
              if (accounts.bankBadge != null)
                Text(
                  accounts.bankBadge!,
                  style: t.labelMedium?.copyWith(
                    color: colors.success,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (hasWallets)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (rails.contains(PaymentRail.esewa) &&
                    accounts.esewaId != null)
                  _LabelValue(
                    label: '${s.esewaId}: ',
                    value: MarketplaceFormat.digits(context, accounts.esewaId!),
                    labelStyle: labelStyle,
                    valueStyle: valueStyle,
                  ),
                if (rails.contains(PaymentRail.khalti) &&
                    accounts.khaltiId != null)
                  _LabelValue(
                    label: '${s.khaltiId}: ',
                    value: MarketplaceFormat.digits(
                      context,
                      accounts.khaltiId!,
                    ),
                    labelStyle: labelStyle,
                    valueStyle: valueStyle,
                  ),
              ],
            ),
          if (hasUpi)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LabelValue(
                        label: '${s.upiId}: ',
                        value: accounts.upiId!,
                        labelStyle: labelStyle,
                        valueStyle: valueStyle,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        s.scanQrToPay,
                        style: t.labelSmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                _QrPlaceholder(upiId: accounts.upiId!),
              ],
            ),
          Divider(height: AppSpacing.lg, color: colors.divider),
          Text(
            s.bankDetails,
            textAlign: TextAlign.center,
            style: labelStyle?.copyWith(decoration: TextDecoration.underline),
          ),
          _LabelValue(
            label: '${s.bankName}: ',
            value: accounts.bankName,
            labelStyle: labelStyle,
            valueStyle: valueStyle,
            center: true,
          ),
          _LabelValue(
            label: '${s.accountHolder}: ',
            value: accounts.accountHolder,
            labelStyle: labelStyle,
            valueStyle: valueStyle,
            center: true,
          ),
          _LabelValue(
            label: '${s.accountNumber}: ',
            value: MarketplaceFormat.digits(context, accounts.accountNumber),
            labelStyle: labelStyle,
            valueStyle: valueStyle,
            center: true,
          ),
          if (accounts.ifscCode != null)
            _LabelValue(
              label: '${s.ifscCode}: ',
              value: accounts.ifscCode!,
              labelStyle: labelStyle,
              valueStyle: valueStyle,
              center: true,
            ),
          Divider(height: AppSpacing.lg, color: colors.divider),
          Text(
            s.attachPaymentScreenshot,
            style: t.labelSmall?.copyWith(color: colors.textSecondary),
          ),
          Text(
            s.nonRefundable,
            style: t.labelSmall?.copyWith(color: colors.accent, fontSize: 9),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            s.uploadReceipt,
            style: t.bodySmall?.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          UploadDropzone(fileName: receiptName, onPick: onPickReceipt),
        ],
      ),
    );
  }
}

/// Round wallet / rail badge: "e" (eSewa), "K" (Khalti), QR icon (UPI),
/// card icon.
class _RailBadge extends StatelessWidget {
  const _RailBadge({required this.rail});
  final PaymentRail rail;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (label, color) = switch (rail) {
      PaymentRail.esewa => ('e', colors.success),
      PaymentRail.khalti => ('K', colors.primary),
      PaymentRail.upi => (null, colors.info),
      PaymentRail.card => (null, colors.primary),
      _ => (null, colors.textMuted),
    };
    return Container(
      width: 25,
      height: 25,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: label == null
          ? Icon(rail.icon, size: 15, color: colors.onPrimary)
          : Text(
              label,
              style: context.textTheme.labelMedium?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
    );
  }
}

/// Placeholder QR tile (a real QR is generated once the UPI ID is final).
class _QrPlaceholder extends StatelessWidget {
  const _QrPlaceholder({required this.upiId});
  final String upiId;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      label: 'UPI QR $upiId',
      child: Container(
        key: const Key('upi_qr_placeholder'),
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
        child: Icon(Icons.qr_code_2, size: 48, color: colors.textPrimary),
      ),
    );
  }
}

class _VerticalRule extends StatelessWidget {
  const _VerticalRule({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    height: 20,
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    color: color,
  );
}

class _LabelValue extends StatelessWidget {
  const _LabelValue({
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
    this.center = false,
  });
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final bool center;

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      children: [
        TextSpan(text: label, style: labelStyle),
        TextSpan(text: value, style: valueStyle),
      ],
    ),
    textAlign: center ? TextAlign.center : TextAlign.start,
  );
}
