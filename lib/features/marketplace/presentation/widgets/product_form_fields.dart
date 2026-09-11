import '../../../../core/media/media_bucket.dart';
import '../../../../core/media/media_upload_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/labeled_toggle.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/product.dart';
import '../cubit/product_form_cubit.dart';
import '../l10n/marketplace_strings.dart';
import '../utils/marketplace_format.dart';
import 'category_picker_field.dart';
import 'form_choice_row.dart';
import 'marketplace_dialogs.dart';
import 'product_image_picker.dart';

/// All input fields of the seller form + Save / Update / Delete buttons.
class ProductFormFields extends StatelessWidget {
  const ProductFormFields({
    required this.state,
    required this.title,
    required this.titleLocal,
    required this.description,
    required this.descriptionLocal,
    required this.price,
    required this.location,
    required this.phone,
    required this.website,
    required this.expiryChoices,
    super.key,
  });

  final ProductFormState state;
  final TextEditingController title;
  final TextEditingController titleLocal;
  final TextEditingController description;
  final TextEditingController descriptionLocal;
  final TextEditingController price;
  final TextEditingController location;
  final TextEditingController phone;
  final TextEditingController website;
  final List<int> expiryChoices;

  String? _error(MarketplaceStrings s, ProductFormField field) =>
      switch (state.errors[field]) {
        null => null,
        ProductFormError.required => s.requiredField,
        ProductFormError.invalidPrice => s.invalidPrice,
        ProductFormError.invalidCategory => s.invalidCategory,
        ProductFormError.invalidPhone => s.invalidPhone,
      };

  @override
  Widget build(BuildContext context) {
    final s = MarketplaceStrings.of(context);
    final colors = context.colors;
    final cubit = context.read<ProductFormCubit>();
    final d = state.draft;
    final config = context.regionConfig;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.lg,
        AppSpacing.pageGutter,
        AppSpacing.xxl,
      ),
      children: [
        ProductImagePicker(
          images: d.images,
          onAdd: () async {
            // Product photos are shown to every shopper, so they go to the
            // public bucket and are stored as durable URLs.
            final uploaded = await pickAndUploadMedia(
              context,
              bucket: MediaBucket.publicCatalog,
              title: s.photos,
            );
            if (uploaded != null) cubit.addImage(uploaded.url);
          },
          onRemove: cubit.removeImage,
          onRemoveAll: () {
            cubit.clearImages();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(s.photosRemoved)));
          },
          maxImages: ProductFormCubit.maxImages,
        ),
        if (_error(s, ProductFormField.photos) case final message?)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Text(
              message,
              style: context.textTheme.bodySmall?.copyWith(color: colors.error),
            ),
          ),
        const SizedBox(height: AppSpacing.lg),
        _Field(
          error: _error(s, ProductFormField.title),
          child: AppTextField(
            controller: title,
            label: s.productTitle,
            required: true,
            textInputAction: TextInputAction.next,
            onChanged: (v) => cubit.patch((d) => d.copyWith(title: v)),
          ),
        ),
        AppTextField(
          controller: titleLocal,
          label: s.productTitleLocal,
          textInputAction: TextInputAction.next,
          onChanged: (v) => cubit.patch((d) => d.copyWith(titleLocal: v)),
        ),
        const SizedBox(height: AppSpacing.md),
        CategoryPickerField(
          categories: state.categories.dataOrNull ?? const [],
          selectedId: d.categoryId.isEmpty ? null : d.categoryId,
          names: state.categoryNames,
          errorText: _error(s, ProductFormField.category),
          onSelected: (id) => cubit.patch((d) => d.copyWith(categoryId: id)),
          onRenamed: cubit.renameCategory,
        ),
        const SizedBox(height: AppSpacing.md),
        _Field(
          error: _error(s, ProductFormField.description),
          child: AppTextField(
            controller: description,
            label: s.description,
            required: true,
            maxLines: 4,
            minLines: 3,
            onChanged: (v) => cubit.patch((d) => d.copyWith(description: v)),
          ),
        ),
        AppTextField(
          controller: descriptionLocal,
          label: '${s.description} (${s.productTitleLocal.split('(').last}',
          maxLines: 4,
          minLines: 2,
          onChanged: (v) => cubit.patch((d) => d.copyWith(descriptionLocal: v)),
        ),
        const SizedBox(height: AppSpacing.md),
        _Field(
          error: _error(s, ProductFormField.price),
          child: AppTextField(
            controller: price,
            label: '${s.price} (${config.currencyCode})',
            required: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            prefix: Padding(
              padding: const EdgeInsets.only(left: AppSpacing.md, right: 4),
              child: Text(
                config.symbolFor(context.languageCode),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colors.accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onChanged: (v) => cubit.patch(
              (d) => d.copyWith(price: double.tryParse(v.trim()) ?? 0),
            ),
          ),
        ),
        FormChoiceRow<ProductCondition>(
          label: s.condition,
          value: d.condition,
          choices: [
            FormChoice(ProductCondition.brandNew, s.brandNew),
            FormChoice(ProductCondition.used, s.used),
          ],
          onChanged: (v) => cubit.patch((d) => d.copyWith(condition: v)),
        ),
        const SizedBox(height: AppSpacing.md),
        FormChoiceRow<bool>(
          label: s.listingType,
          value: d.isService,
          choices: [FormChoice(false, s.product), FormChoice(true, s.service)],
          onChanged: (v) => cubit.patch((d) => d.copyWith(isService: v)),
        ),
        const SizedBox(height: AppSpacing.sm),
        LabeledToggle(
          label: s.negotiable,
          value: d.negotiable,
          onChanged: (v) => cubit.patch((d) => d.copyWith(negotiable: v)),
        ),
        const SizedBox(height: AppSpacing.sm),
        _Field(
          error: _error(s, ProductFormField.location),
          child: AppTextField(
            controller: location,
            label: s.location.replaceAll(':', ''),
            required: true,
            prefix: Icon(Icons.location_on_outlined, color: colors.iconMuted),
            textInputAction: TextInputAction.next,
            onChanged: (v) => cubit.patch((d) => d.copyWith(location: v)),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _Field(
          error: _error(s, ProductFormField.phone),
          child: AppTextField(
            controller: phone,
            label: s.contactPhone,
            required: true,
            hint: '${config.phonePrefix}-9800000000',
            keyboardType: TextInputType.phone,
            prefix: Icon(Icons.call_outlined, color: colors.iconMuted),
            onChanged: (v) => cubit.patch((d) => d.copyWith(phone: v)),
          ),
        ),
        AppTextField(
          controller: website,
          label: s.website,
          hint: 'www.websitedomain.com',
          keyboardType: TextInputType.url,
          prefix: Icon(Icons.language_outlined, color: colors.iconMuted),
          onChanged: (v) => cubit.patch((d) => d.copyWith(websiteLink: v)),
        ),
        const SizedBox(height: AppSpacing.md),
        FormChoiceRow<int>(
          label: s.expiryDays,
          value: d.expiryDays,
          choices: [
            for (final n in {...expiryChoices, d.expiryDays}.toList()..sort())
              FormChoice(n, MarketplaceFormat.digits(context, n)),
          ],
          onChanged: (v) => cubit.patch((d) => d.copyWith(expiryDays: v)),
        ),
        const SizedBox(height: AppSpacing.xxl),
        PrimaryButton(
          label: state.isEdit ? s.update : s.save,
          isLoading: state.submission.isLoading,
          onPressed: state.isBusy ? null : cubit.submit,
        ),
        if (state.isEdit) ...[
          const SizedBox(height: AppSpacing.md),
          SecondaryButton(
            label: s.delete,
            icon: Icon(
              Icons.delete_outline_rounded,
              size: 16,
              color: colors.error,
            ),
            onPressed: state.isBusy
                ? null
                : () async {
                    if (await showDeleteProductDialog(context)) {
                      await cubit.delete();
                    }
                  },
          ),
        ],
      ],
    );
  }
}

/// Field + optional validation message underneath.
class _Field extends StatelessWidget {
  const _Field({required this.child, this.error});
  final Widget child;
  final String? error;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      child,
      if (error != null)
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xs),
          child: Text(
            error!,
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colors.error,
            ),
          ),
        ),
      const SizedBox(height: AppSpacing.md),
    ],
  );
}
