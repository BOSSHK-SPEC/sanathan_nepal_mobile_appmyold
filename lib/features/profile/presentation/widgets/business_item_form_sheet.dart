import '../../../../core/media/media_bucket.dart';
import '../../../../core/media/media_upload_action.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_radio_option.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/business_profile.dart';
import '../l10n/profile_strings.dart';
import '../region/business_region_fields.dart';
import 'upload_placeholder.dart';

/// Bottom sheet to add a product/service (Figma "Products / Services
/// Details" section of the BUSINESS DETAILS FORM): title, photos,
/// description, price (fixed / variable, negotiable), category dropdown with
/// "+ Add new Category", purchase link and TikTok / YouTube video links.
class BusinessItemFormSheet extends StatefulWidget {
  const BusinessItemFormSheet({
    super.key,
    this.isService = false,
    this.categories = const [],
    this.initialItem,
  });

  /// Preselects the "service" toggle.
  final bool isService;

  /// Existing categories offered in the dropdown.
  final List<String> categories;

  /// Initial item to edit (if null, creates a new item).
  final BusinessItem? initialItem;

  static Future<BusinessItem?> show(
    BuildContext context, {
    bool isService = false,
    List<String>? categories,
    BusinessItem? initialItem,
  }) => showModalBottomSheet<BusinessItem>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: context.colors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
    ),
    builder: (_) => BusinessItemFormSheet(
      isService: isService,
      categories: categories ?? const [],
      initialItem: initialItem,
    ),
  );

  @override
  State<BusinessItemFormSheet> createState() => _BusinessItemFormSheetState();
}

class _BusinessItemFormSheetState extends State<BusinessItemFormSheet> {
  static const String _newCategory = '__new__';

  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();
  final _price = TextEditingController();
  final _purchaseLink = TextEditingController();
  final _tiktok = TextEditingController();
  final _youtube = TextEditingController();
  late bool _isService = widget.initialItem?.isService ?? widget.isService;
  bool _fixed = true;
  late bool _negotiable = widget.initialItem?.negotiable ?? false;
  String? _selectedCategory;
  final List<String> _photos = [];

  @override
  void initState() {
    super.initState();
    final init = widget.initialItem;
    if (init != null) {
      _title.text = init.title;
      _description.text = init.description;
      _price.text = init.priceLabel;
      _category.text = init.category;
      _purchaseLink.text = init.purchaseLink;
      _tiktok.text = init.tiktokLink;
      _youtube.text = init.youtubeLink;
      if (init.imageUrl != null && init.imageUrl!.isNotEmpty) {
        _photos.add(init.imageUrl!);
      }
      if (widget.categories.contains(init.category)) {
        _selectedCategory = init.category;
      }
    }
  }

  List<TextEditingController> get _all => [
    _title,
    _description,
    _category,
    _price,
    _purchaseLink,
    _tiktok,
    _youtube,
  ];

  @override
  void dispose() {
    for (final c in _all) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _hasCategories => widget.categories.isNotEmpty;

  bool get _typingCategory =>
      !_hasCategories || _selectedCategory == _newCategory;

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final category = _typingCategory
        ? _category.text.trim()
        : (_selectedCategory ?? '');
    final itemId =
        widget.initialItem?.id ??
        'item-${DateTime.now().millisecondsSinceEpoch}';
    Navigator.of(context).pop(
      BusinessItem(
        id: itemId,
        title: _title.text.trim(),
        description: _description.text.trim(),
        priceLabel: _price.text.trim().isEmpty
            ? '${context.regionConfig.currencySymbol} ???'
            : _price.text.trim(),
        category: category.isEmpty ? 'General' : category,
        isService: _isService,
        negotiable: _negotiable,
        purchaseLink: _purchaseLink.text.trim(),
        tiktokLink: _tiktok.text.trim(),
        youtubeLink: _youtube.text.trim(),
        imageUrl: _photos.isEmpty ? null : _photos.first,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    final config = context.regionConfig;
    final fields = BusinessRegionFields.of(config);
    String money(num amount) =>
        RegionFormat.money(amount, config: config, languageCode: 'en');
    String? req(String? v) =>
        (v == null || v.trim().isEmpty) ? s.required : null;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              s.productsServicesDetails,
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              controller: _title,
              label: s.itemTitle,
              required: true,
              hint: 'eg: Web Design',
              validator: req,
            ),
            const SizedBox(height: AppSpacing.md),
            UploadPlaceholder(
              label: s.addProductPhotos,
              hint: s.pngJpegHint,
              files: _photos,
              onTap: () async {
                final uploaded = await pickAndUploadMedia(
                  context,
                  bucket: MediaBucket.publicCatalog,
                  title: s.addProductPhotos,
                );
                if (uploaded == null || !mounted) return;
                setState(() => _photos.add(uploaded.url));
              },
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _description,
              label: s.itemDescription,
              required: true,
              maxLines: 2,
              validator: req,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _price,
              label: s.itemPrice,
              required: true,
              hint: _fixed
                  ? fields.priceHint(money)
                  : fields.priceRangeHint(money),
              validator: req,
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.md,
              children: [
                AppRadioOption<bool>(
                  value: true,
                  groupValue: _fixed,
                  label: s.fixed,
                  onChanged: (v) => setState(() => _fixed = v),
                ),
                AppRadioOption<bool>(
                  value: false,
                  groupValue: _fixed,
                  label: s.variable,
                  onChanged: (v) => setState(() => _fixed = v),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(s.negotiable, style: context.textTheme.titleSmall),
            Wrap(
              spacing: AppSpacing.md,
              children: [
                AppRadioOption<bool>(
                  value: true,
                  groupValue: _negotiable,
                  label: s.yes,
                  onChanged: (v) => setState(() => _negotiable = v),
                ),
                AppRadioOption<bool>(
                  value: false,
                  groupValue: _negotiable,
                  label: s.no,
                  onChanged: (v) => setState(() => _negotiable = v),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(s.isService, style: context.textTheme.bodyMedium),
              value: _isService,
              onChanged: (v) => setState(() => _isService = v),
            ),
            if (_hasCategories) ...[
              Text(s.itemCategory, style: context.textTheme.titleSmall),
              const SizedBox(height: AppSpacing.xs),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                isExpanded: true,
                hint: Text(s.itemCategory),
                items: [
                  for (final c in widget.categories)
                    DropdownMenuItem(value: c, child: Text(c)),
                  DropdownMenuItem(
                    value: _newCategory,
                    child: Text(
                      s.addNewCategory,
                      style: TextStyle(color: context.colors.accent),
                    ),
                  ),
                ],
                onChanged: (v) => setState(() => _selectedCategory = v),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (_typingCategory) ...[
              AppTextField(
                controller: _category,
                label: _hasCategories ? s.newCategoryName : s.itemCategory,
                hint: 'eg: Gemstones',
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            AppTextField(
              controller: _purchaseLink,
              label: s.purchaseLink,
              hint: 'eg: website.com/productname (if any)',
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _tiktok,
              label: s.tiktokLink,
              hint: 'Embed your tiktok video link',
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: _youtube,
              label: s.youtubeLink,
              hint: 'Embed your youtube video link',
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(label: s.addItem, height: 40, onPressed: _submit),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
