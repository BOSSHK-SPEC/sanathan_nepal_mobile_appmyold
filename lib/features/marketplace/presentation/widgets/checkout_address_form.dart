import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_all.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entities/order.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/payment_rails.dart';

/// Holds the checkout form controllers so the page can build a
/// [ShippingAddress] on submit.
///
/// Country / province defaults are region-dependent and are filled in by
/// [CheckoutAddressForm] on first build (see [applyRegionDefaults]).
class CheckoutFormController {
  final formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final street = TextEditingController();
  final apartment = TextEditingController();
  final city = TextEditingController();
  final postcode = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final notes = TextEditingController();
  String country = '';
  String province = '';

  /// Nepal's provinces (kept for backwards compatibility – prefer
  /// [MarketplaceRegion.adminAreas]).
  static const List<String> provinces = MarketplaceRegion.nepalProvinces;

  /// Sets country / province to the region defaults when still unset.
  void applyRegionDefaults(RegionConfig config) {
    if (country.isEmpty) country = config.nameEn;
    if (province.isEmpty) province = MarketplaceRegion.defaultAdminArea(config);
  }

  bool validate() => formKey.currentState?.validate() ?? false;

  ShippingAddress toAddress() => ShippingAddress(
    firstName: firstName.text.trim(),
    lastName: lastName.text.trim(),
    country: country,
    street: street.text.trim(),
    apartment: apartment.text.trim(),
    city: city.text.trim(),
    province: province,
    postcode: postcode.text.trim(),
    phone: phone.text.trim(),
    email: email.text.trim(),
  );

  void dispose() {
    for (final c in [
      firstName,
      lastName,
      street,
      apartment,
      city,
      postcode,
      phone,
      email,
      notes,
    ]) {
      c.dispose();
    }
  }
}

/// Address / contact form of the checkout page (Figma "Form").
class CheckoutAddressForm extends StatefulWidget {
  const CheckoutAddressForm({
    required this.controller,
    required this.shipToDifferent,
    required this.onShipToDifferentChanged,
    super.key,
  });

  final CheckoutFormController controller;
  final bool shipToDifferent;
  final ValueChanged<bool> onShipToDifferentChanged;

  @override
  State<CheckoutAddressForm> createState() => _CheckoutAddressFormState();
}

class _CheckoutAddressFormState extends State<CheckoutAddressForm> {
  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final config = context.regionConfig;
    final c = widget.controller..applyRegionDefaults(config);
    final areas = MarketplaceRegion.adminAreas(config);
    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? s.requiredField : null;
    return Form(
      key: c.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  controller: c.firstName,
                  label: s.firstName,
                  required: true,
                  validator: required,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  controller: c.lastName,
                  label: s.lastName,
                  required: true,
                  validator: required,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _Dropdown(
            label: s.countryRegion,
            value: c.country,
            items: MarketplaceRegion.countries(config),
            onChanged: (v) => setState(() => c.country = v),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c.street,
            label: s.streetAddress,
            hint: s.houseNumberHint,
            required: true,
            validator: required,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(controller: c.apartment, hint: s.apartmentHint),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c.city,
            label: s.townCity,
            required: true,
            validator: required,
          ),
          const SizedBox(height: AppSpacing.md),
          _Dropdown(
            label: MarketplaceRegion.adminAreaLabel(s, config),
            value: areas.contains(c.province) ? c.province : areas.first,
            items: areas,
            onChanged: (v) => setState(() => c.province = v),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c.postcode,
            label: s.postcode,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  controller: c.phone,
                  label: s.phoneOptional,
                  hint: '${config.phonePrefix}-98XXXXXXXX',
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  controller: c.email,
                  label: s.emailAddress,
                  hint: 'johndoe@example.com',
                  required: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return s.requiredField;
                    return v.contains('@') ? null : s.requiredField;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _CheckboxRow(
            value: widget.shipToDifferent,
            label: s.shipToDifferentAddress,
            onChanged: widget.onShipToDifferentChanged,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: c.notes,
            label: s.orderNotes,
            hint: s.orderNotesHint,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text.rich(
        TextSpan(
          text: label,
          style: context.textTheme.titleSmall,
          children: [
            TextSpan(
              text: ' *',
              style: TextStyle(color: context.colors.error),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      DropdownButtonFormField<String>(
        initialValue: value,
        isDense: true,
        style: context.textTheme.bodyMedium,
        decoration: const InputDecoration(isDense: true),
        items: [
          for (final i in items) DropdownMenuItem(value: i, child: Text(i)),
        ],
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    ],
  );
}

class _CheckboxRow extends StatelessWidget {
  const _CheckboxRow({
    required this.value,
    required this.label,
    required this.onChanged,
  });
  final bool value;
  final String label;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => onChanged(!value),
    child: Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: (v) => onChanged(v ?? false),
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(label, style: context.textTheme.bodySmall)),
      ],
    ),
  );
}
