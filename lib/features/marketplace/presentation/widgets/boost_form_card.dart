import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/boost_request.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import 'payment_details_card.dart';
import 'step_header.dart';

/// Values collected by [BoostFormCard].
class BoostFormValues {
  const BoostFormValues({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.productLink,
    this.receiptPath,
  });
  final String firstName;
  final String lastName;
  final String phone;
  final String productLink;
  final String? receiptPath;
}

/// Step 2 of Boost: "N Products Selected!", hours dropdown, contact fields,
/// payment instructions, receipt upload and Submit.
class BoostFormCard extends StatefulWidget {
  const BoostFormCard({
    required this.selectedCount,
    required this.plans,
    required this.plan,
    required this.onPlanChanged,
    required this.onSubmit,
    required this.onBack,
    super.key,
    this.submitting = false,
  });

  final int selectedCount;
  final List<BoostPlan> plans;
  final BoostPlan? plan;
  final ValueChanged<BoostPlan> onPlanChanged;
  final ValueChanged<BoostFormValues> onSubmit;
  final VoidCallback onBack;
  final bool submitting;

  @override
  State<BoostFormCard> createState() => _BoostFormCardState();
}

class _BoostFormCardState extends State<BoostFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _phone = TextEditingController();
  final _link = TextEditingController();
  String? _receipt;
  bool _phonePrefilled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Default phone prefix from the region (+977 / +91), once.
    if (!_phonePrefilled) {
      _phonePrefilled = true;
      _phone.text = '${context.regionConfig.phonePrefix}-';
    }
  }

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _phone.dispose();
    _link.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSubmit(
      BoostFormValues(
        firstName: _first.text.trim(),
        lastName: _last.text.trim(),
        phone: _phone.text.trim(),
        productLink: _link.text.trim(),
        receiptPath: _receipt,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = MarketplaceStrings.of(context);
    final t = context.textTheme;
    final total = (widget.plan?.pricePerProduct ?? 0) * widget.selectedCount;
    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? s.requiredField : null;
    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceVariant.withValues(
          alpha: context.isDark ? 0.6 : 1,
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StepHeader(
            steps: [
              StepItem(
                label: s.shoppingCart,
                icon: Icons.shopping_bag_outlined,
              ),
              StepItem(
                label: s.boostYourListing,
                icon: Icons.account_balance_wallet_outlined,
              ),
            ],
            activeIndex: 1,
            onStepTap: (i) {
              if (i == 0) widget.onBack();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    s.productsSelected(widget.selectedCount),
                    style: t.titleMedium?.copyWith(
                      color: colors.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _RequiredLabel(s.selectNumberOfHours),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<BoostPlan>(
                          key: const Key('boost_plan_dropdown'),
                          initialValue: widget.plan,
                          isDense: true,
                          style: t.bodySmall?.copyWith(
                            color: colors.textPrimary,
                          ),
                          decoration: const InputDecoration(isDense: true),
                          items: [
                            for (final p in widget.plans)
                              DropdownMenuItem(
                                value: p,
                                child: Text(
                                  s.hoursPlan(
                                    MarketplaceFormat.digits(context, p.hours),
                                    MarketplaceFormat.priceOf(
                                      context,
                                      p.pricePerProduct,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                          onChanged: (p) {
                            if (p != null) widget.onPlanChanged(p);
                          },
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '= ${MarketplaceFormat.priceOf(context, total)}',
                          style: t.titleSmall?.copyWith(
                            color: colors.accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _first,
                          label: s.firstName,
                          hint: s.firstName,
                          required: true,
                          validator: required,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AppTextField(
                          controller: _last,
                          label: s.lastName,
                          hint: s.lastName,
                          required: true,
                          validator: required,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _phone,
                    label: s.phoneNumber,
                    hint: '${context.regionConfig.phonePrefix}-9999999999',
                    required: true,
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      final digits = (v ?? '').replaceAll(RegExp(r'\D'), '');
                      return digits.length < 10 ? s.invalidPhone : null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _link,
                    label: s.productServiceLink,
                    hint: s.linkToYourAd,
                    required: true,
                    keyboardType: TextInputType.url,
                    validator: required,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PaymentDetailsCard(
                    total: total,
                    receiptName: _receipt,
                    onPickReceipt: () =>
                        setState(() => _receipt = 'payment_receipt.jpg'),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '*Note: ',
                          style: t.labelSmall?.copyWith(
                            color: colors.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: s.boostNote,
                          style: t.labelSmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  PrimaryButton(
                    label: s.submit,
                    height: 40,
                    radius: AppRadius.sm,
                    isLoading: widget.submitting,
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequiredLabel extends StatelessWidget {
  const _RequiredLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      text: text,
      style: context.textTheme.titleSmall,
      children: [
        TextSpan(
          text: ' *',
          style: TextStyle(color: context.colors.error),
        ),
      ],
    ),
  );
}
