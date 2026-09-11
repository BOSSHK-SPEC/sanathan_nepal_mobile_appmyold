import '../../../../core/media/media_bucket.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/media/media_upload_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/business_profile.dart';
import '../cubit/business_form_cubit.dart';
import '../l10n/profile_strings.dart';
import '../region/business_region_fields.dart';
import '../widgets/business_item_form_sheet.dart';
import '../widgets/business_items_step.dart';
import '../widgets/submitted_dialog.dart';
import '../widgets/upload_placeholder.dart';

/// Business details form (Figma "BUSINESS DETAILS FORM" 1117:4227 /
/// 1873:3263): "Business Details" + "Products / Services Details" sections.
/// Region-conditional hints/fields (phone prefix, address / PIN code, tax id
/// PAN-VAT vs GSTIN) come from [BusinessRegionFields].
class BusinessFormPage extends StatelessWidget {
  const BusinessFormPage({super.key, this.businessId, this.onSubmitted});

  /// Existing business to edit; defaults to the current user's business.
  final String? businessId;

  /// Called after the confirmation dialog; defaults to popping the page.
  final ValueChanged<BusinessProfile>? onSubmitted;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<BusinessFormCubit>(
      // Empty means "mine": the cubit loads the user's own business when
      // it exists, so opening the form is Edit rather than a second create.
      param1: businessId ?? '',
    )..load(),
    child: BusinessFormView(onSubmitted: onSubmitted),
  );
}

/// Widget-testable body of [BusinessFormPage].
class BusinessFormView extends StatefulWidget {
  const BusinessFormView({super.key, this.onSubmitted});

  /// Called after the "Submitted for approval" dialog is dismissed; when
  /// `null` the page pops with the saved business.
  final ValueChanged<BusinessProfile>? onSubmitted;

  @override
  State<BusinessFormView> createState() => _BusinessFormViewState();
}

class _BusinessFormViewState extends State<BusinessFormView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _type = TextEditingController();
  final _website = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _whatsapp = TextEditingController();
  final _address = TextEditingController();
  final _mapLink = TextEditingController();
  final _description = TextEditingController();
  final _hours = TextEditingController();
  final _taxId = TextEditingController();
  bool _seeded = false;

  List<TextEditingController> get _all => [
    _name,
    _type,
    _website,
    _phone,
    _email,
    _whatsapp,
    _address,
    _mapLink,
    _description,
    _hours,
    _taxId,
  ];

  @override
  void dispose() {
    for (final c in _all) {
      c.dispose();
    }
    super.dispose();
  }

  /// Confirms discarding an in-progress form.
  Future<bool> _confirmDiscard(BuildContext context) {
    final s = ProfileStrings.of(context);
    return AppConfirmSheet.show(
      context,
      title: s.discardChanges,
      message: s.discardChangesMessage,
      confirmLabel: s.discard,
      cancelLabel: s.keepEditing,
    );
  }

  void _seed(BusinessProfile b) {
    if (_seeded) return;
    _seeded = true;
    _name.text = b.name;
    _type.text = b.category;
    _website.text = b.website;
    _phone.text = b.phone;
    _email.text = b.email;
    _whatsapp.text = b.whatsapp;
    _address.text = b.address;
    _mapLink.text = b.mapLink;
    _description.text = b.description;
    _hours.text = b.workingHours;
    _taxId.text = b.taxId;
  }

  BusinessProfile _collect(BusinessProfile draft) => draft.copyWith(
    name: _name.text.trim(),
    category: _type.text.trim(),
    website: _website.text.trim(),
    phone: _phone.text.trim(),
    email: _email.text.trim(),
    whatsapp: _whatsapp.text.trim(),
    address: _address.text.trim(),
    mapLink: _mapLink.text.trim(),
    description: _description.text.trim(),
    tagline: _description.text.trim().split('.').first,
    workingHours: _hours.text.trim(),
    taxId: _taxId.text.trim(),
  );

  void _next(BusinessFormCubit cubit) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    cubit
      ..updateDraft(_collect(cubit.state.draft))
      ..goToStep(1);
  }

  Future<void> _submit(BusinessFormCubit cubit) async {
    cubit.updateDraft(_collect(cubit.state.draft));
    await cubit.submit();
  }

  Future<void> _onSubmitted(BuildContext context, BusinessProfile data) async {
    await SubmittedDialog.show(context);
    if (!context.mounted) return;
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(data);
    } else {
      Navigator.of(context).maybePop(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    return PopScope(
      // A long form with an upload in it is expensive to refill, and a stray
      // back gesture is cheap to make. Ask before throwing it away.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final navigator = Navigator.of(context);
        if (!await _confirmDiscard(context)) return;
        navigator.pop();
      },
      child: Scaffold(
        appBar: AppTopBar(title: s.businessForm, showBack: true),
        body: BlocConsumer<BusinessFormCubit, BusinessFormState>(
          listenWhen: (p, n) => p.submission != n.submission,
          listener: (context, state) {
            switch (state.submission) {
              case Loaded(:final data):
                _onSubmitted(context, data);
              case Failed(:final failure):
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(failure.message)));
              case Idle() || Loading():
                break;
            }
          },
          builder: (context, state) {
            if (!state.isReady) return const LoadingView();
            _seed(state.draft);
            final cubit = context.read<BusinessFormCubit>();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: PillTabs(
                    labels: [s.businessDetails, s.productsServicesDetails],
                    selectedIndex: state.step,
                    scrollable: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    onChanged: (i) => i == 0 ? cubit.goToStep(0) : _next(cubit),
                  ),
                ),
                Expanded(
                  child: state.step == 0
                      ? _DetailsStep(
                          formKey: _formKey,
                          controllers: this,
                          documents: state.draft.documents,
                          onAddDocument: cubit.addDocument,
                          onNext: () => _next(cubit),
                        )
                      : BusinessItemsStep(
                          state: state,
                          onAdd: () async {
                            final item = await BusinessItemFormSheet.show(
                              context,
                              categories: state.draft.items
                                  .map((i) => i.category)
                                  .toSet()
                                  .toList(),
                            );
                            if (item != null) cubit.addItem(item);
                          },
                          onRemove: cubit.removeItem,
                          onBack: () => cubit.goToStep(0),
                          onSubmit: () => _submit(cubit),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DetailsStep extends StatelessWidget {
  const _DetailsStep({
    required this.formKey,
    required this.controllers,
    required this.documents,
    required this.onAddDocument,
    required this.onNext,
  });
  final GlobalKey<FormState> formKey;
  final _BusinessFormViewState controllers;
  final List<String> documents;
  final ValueChanged<String> onAddDocument;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final c = controllers;
    final fields = BusinessRegionFields.of(context.regionConfig);
    String? req(String? v) =>
        (v == null || v.trim().isEmpty) ? s.required : null;

    /// The API rejects a name shorter than two characters, so the form does
    /// too — otherwise the seller fills the whole thing and is told "request
    /// validation failed" with no field to point at.
    String? businessName(String? v) =>
        req(v) ?? (v!.trim().length < 2 ? s.required : null);
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.xxl,
        ),
        children: [
          AppTextField(
            controller: c._name,
            label: s.businessName,
            required: true,
            hint: 'Official Business name',
            validator: businessName,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c._type,
            label: s.businessType,
            required: true,
            hint: 'eg: Digital Marketing Agency',
            validator: req,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c._website,
            label: s.websiteUrl,
            hint: 'www.company.com',
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  controller: c._phone,
                  label: s.phoneNumber,
                  required: true,
                  hint: fields.phoneHint,
                  keyboardType: TextInputType.phone,
                  validator: req,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  controller: c._email,
                  label: s.email,
                  required: true,
                  hint: 'name@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: req,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c._whatsapp,
            label: s.whatsappNumber,
            hint: fields.phoneHint,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c._address,
            label: s.officeLocation,
            hint: fields.addressHint,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c._mapLink,
            label: s.googleMapLink,
            hint: 'Google map link of your office address',
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c._description,
            label: s.businessDescription,
            required: true,
            hint: 'Short description about business (20 words)',
            maxLines: 3,
            validator: req,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c._hours,
            label: s.workingHours,
            hint: fields.workingHoursHint,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: c._taxId,
            label: fields.taxIdLabel(context.languageCode),
            hint: fields.taxIdHint,
          ),
          const SizedBox(height: AppSpacing.md),
          UploadPlaceholder(
            label: s.documents,
            hint: s.pngJpegHint,
            files: documents,
            onTap: () async {
              // Registration papers are private: they exist for a reviewer,
              // not for shoppers, so they are stored by id and never as a
              // public URL.
              final uploaded = await pickAndUploadMedia(
                context,
                bucket: MediaBucket.privateDocs,
                title: s.documents,
              );
              if (uploaded != null) onAddDocument(uploaded.mediaId);
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(label: s.next, height: 40, onPressed: onNext),
        ],
      ),
    );
  }
}
