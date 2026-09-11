import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/account_entities.dart';
import '../cubit/account_cubits.dart';
import '../l10n/account_strings.dart';

/// Saved delivery addresses.
class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => GetIt.I<AddressesCubit>()..load(),
    child: const _AddressesView(),
  );
}

class _AddressesView extends StatelessWidget {
  const _AddressesView();

  @override
  Widget build(BuildContext context) {
    final s = AccountStrings.of(context);
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppTopBar(title: s.addresses, showBack: true),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton.extended(
          backgroundColor: colors.accent,
          foregroundColor: colors.onPrimary,
          onPressed: () => _edit(context, null),
          icon: const Icon(Icons.add_rounded),
          label: Text(s.addAddress),
        ),
      ),
      body: SafeArea(
        top: false,
        child: BlocBuilder<AddressesCubit, AddressesState>(
          builder: (context, state) {
            final cubit = context.read<AddressesCubit>();

            return switch (state.addresses) {
              Idle() ||
              Loading(previous: null) => const AppSkeletonList.tiles(count: 3),
              Failed(:final failure, previous: null) => ErrorView(
                message: failure.message,
                onRetry: cubit.load,
              ),
              _ when state.isEmpty => EmptyViewWithBody(
                title: s.noAddresses,
                body: s.noAddressesBody,
                icon: Icons.location_on_outlined,
                actionLabel: s.addAddress,
                onAction: () => _edit(context, null),
              ),
              _ => ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pageGutter,
                  AppSpacing.md,
                  AppSpacing.pageGutter,
                  AppSpacing.xxxl * 2,
                ),
                children: [
                  for (final address in state.all)
                    _AddressCard(
                      address: address,
                      strings: s,
                      onEdit: () => _edit(context, address),
                      onMakeDefault: () => cubit.makeDefault(address.id),
                      onDelete: () async {
                        final confirmed = await AppConfirmSheet.show(
                          context,
                          title: s.deleteAddress,
                          message: s.deleteAddressBody,
                          confirmLabel: s.delete,
                          cancelLabel: s.cancel,
                        );
                        if (confirmed) await cubit.delete(address.id);
                      },
                    ),
                ],
              ),
            };
          },
        ),
      ),
    );
  }

  Future<void> _edit(BuildContext context, SavedAddress? existing) async {
    final cubit = context.read<AddressesCubit>();
    await AppBottomSheet.show<void>(
      context,
      builder: (_) => BlocProvider<AddressesCubit>.value(
        value: cubit,
        child: AddressFormSheet(existing: existing),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.address,
    required this.strings,
    required this.onEdit,
    required this.onMakeDefault,
    required this.onDelete,
  });

  final SavedAddress address;
  final AccountStrings strings;
  final VoidCallback onEdit;
  final VoidCallback onMakeDefault;
  final VoidCallback onDelete;

  IconData get _icon => switch (address.label) {
    AddressLabel.home => Icons.home_outlined,
    AddressLabel.work => Icons.work_outline_rounded,
    AddressLabel.other => Icons.place_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      border: address.isDefault ? Border.all(color: colors.accent) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_icon, size: 18, color: colors.accent),
              const SizedBox(width: AppSpacing.sm),
              Text(
                strings.labelName(address.label),
                style: context.textTheme.titleSmall,
              ),
              const SizedBox(width: AppSpacing.sm),
              if (address.isDefault)
                StatusChip(
                  label: strings.defaultLabel,
                  tone: StatusTone.accent,
                  dense: true,
                ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: colors.iconMuted,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: onEdit,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 18,
                  color: colors.iconMuted,
                ),
                visualDensity: VisualDensity.compact,
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(address.fullName, style: context.textTheme.bodyMedium),
          Text(
            address.summary,
            style: context.textTheme.bodySmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
          Text(
            address.phone,
            style: context.textTheme.bodySmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
          if (!address.isDefault) ...[
            const SizedBox(height: AppSpacing.sm),
            SecondaryButton(
              label: strings.setDefault,
              expanded: false,
              height: 32,
              onPressed: onMakeDefault,
            ),
          ],
        ],
      ),
    );
  }
}

/// Address form. The regional field is labelled district in Nepal and state
/// in India, since it is the same slot with a different name.
class AddressFormSheet extends StatefulWidget {
  const AddressFormSheet({super.key, this.existing});

  final SavedAddress? existing;

  @override
  State<AddressFormSheet> createState() => _AddressFormSheetState();
}

class _AddressFormSheetState extends State<AddressFormSheet> {
  late final _name = TextEditingController(
    text: widget.existing?.fullName ?? '',
  );
  late final _phone = TextEditingController(text: widget.existing?.phone ?? '');
  late final _line1 = TextEditingController(text: widget.existing?.line1 ?? '');
  late final _line2 = TextEditingController(text: widget.existing?.line2 ?? '');
  late final _city = TextEditingController(text: widget.existing?.city ?? '');
  late final _region = TextEditingController(
    text: widget.existing?.region ?? '',
  );
  late final _postal = TextEditingController(
    text: widget.existing?.postalCode ?? '',
  );
  late AddressLabel _label = widget.existing?.label ?? AddressLabel.home;
  late bool _isDefault = widget.existing?.isDefault ?? false;

  @override
  void dispose() {
    for (final c in [_name, _phone, _line1, _line2, _city, _region, _postal]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AccountStrings.of(context);
    final cubit = context.read<AddressesCubit>();
    final saving = context.watch<AddressesCubit>().state.saving.isLoading;
    final error = context.watch<AddressesCubit>().state.saveError;

    return AppBottomSheet(
      title: widget.existing == null ? s.addAddress : s.editAddress,
      actions: PrimaryButton(
        label: s.saveAddress,
        height: 46,
        isLoading: saving,
        onPressed: () async {
          final ok = await cubit.save(
            SavedAddress(
              id: widget.existing?.id ?? '',
              fullName: _name.text,
              phone: _phone.text,
              line1: _line1.text,
              line2: _line2.text,
              city: _city.text,
              region: _region.text,
              postalCode: _postal.text,
              label: _label,
              isDefault: _isDefault,
            ),
          );
          if (ok && context.mounted) Navigator.of(context).pop();
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final label in AddressLabel.values)
                ChoiceChip(
                  label: Text(s.labelName(label)),
                  selected: _label == label,
                  onSelected: (_) => setState(() => _label = label),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(controller: _name, label: s.fullName, required: true),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _phone,
            label: s.phone,
            required: true,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _line1,
            label: s.addressLine1,
            required: true,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(controller: _line2, label: s.addressLine2),
          const SizedBox(height: AppSpacing.md),
          AppTextField(controller: _city, label: s.city, required: true),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _region,
            label: context.region == Region.nepal ? s.district : s.state,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _postal,
            label: s.postalCode,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.md),
          LabeledToggle(
            label: s.setDefault,
            value: _isDefault,
            onChanged: (v) => setState(() => _isDefault = v),
          ),
          if (error != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              error,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colors.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
