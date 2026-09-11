import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../domain/entities/order.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/payment_rails.dart';

/// Radio group of the payment methods offered in the active region
/// (`RegionConfig.paymentRails`): eSewa / Khalti / Bank transfer / COD for
/// Nepal, UPI / Card / Net banking / COD for India.
class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final PaymentMethod value;
  final ValueChanged<PaymentMethod> onChanged;

  static String label(MarketplaceStrings s, PaymentMethod m) => m.label(s);

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final methods = PaymentMethod.forRegion(context.regionConfig);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.paymentMethod, style: context.textTheme.titleSmall),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.md,
          children: [
            for (final m in methods)
              AppRadioOption<PaymentMethod>(
                value: m,
                groupValue: value,
                label: label(s, m),
                onChanged: onChanged,
                textStyle: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
