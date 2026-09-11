import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../../../core/session/permission.dart';
import '../../../../core/session/session_scope.dart';
import '../../../marketplace/domain/entities/product.dart';
import '../../../marketplace/presentation/cubit/business_listings_cubit.dart';
import '../../../marketplace/presentation/l10n/marketplace_strings.dart';
import '../../domain/entities/business_profile.dart';
import '../cubit/business_profile_cubit.dart';
import '../l10n/profile_strings.dart';
import '../widgets/business_about_section.dart';
import '../widgets/business_contact_section.dart';
import '../widgets/business_header.dart';
import '../widgets/business_items_section.dart';
import '../widgets/business_moderation_card.dart';
import '../widgets/business_reviews_section.dart';
import '../widgets/seller_approval_dialog.dart';

/// Who is looking at a business profile – controls the available actions.
enum BusinessProfileMode {
  /// Regular user: read-only (follow / message / contact form).
  viewer,

  /// The business owner: Edit → form, add/remove products & services,
  /// status card (pending / approved / rejected + admin note).
  owner,

  /// Admin: approve / reject with the "Seller Approval" dialog.
  admin;

  /// Parses the `?mode=` query value (`owner` / `admin`), default [viewer].
  static BusinessProfileMode fromQuery(String? value) => switch (value) {
    'owner' => owner,
    'admin' => admin,
    _ => viewer,
  };

  /// Query suffix appended to `AppRoutes.businessProfilePath`.
  String get query => this == viewer ? '' : '?mode=$name';
}

/// Seller / business profile (Figma "ADMIN VIEW – Business Profile Details"
/// 1117:3458): About | Products | Services | Reviews | Contact tabs plus
/// owner / admin actions depending on [mode].
class BusinessProfilePage extends StatelessWidget {
  const BusinessProfilePage({
    required this.businessId,
    super.key,
    this.mode = BusinessProfileMode.viewer,
  });
  final String businessId;
  final BusinessProfileMode mode;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<BusinessProfileCubit>()..load(businessId)),
      // The shop's Products and Services tabs are its marketplace listings,
      // so they are loaded by the feature that owns products.
      BlocProvider(
        create: (_) => sl<BusinessListingsCubit>(param1: businessId)..load(),
      ),
    ],
    child: BusinessProfileView(mode: mode),
  );
}

/// Widget-testable body of [BusinessProfilePage].
///
/// Requires **two** cubits above it:
///
///  * [BusinessProfileCubit] — the business itself, every tab;
///  * [BusinessListingsCubit] — the Products and Services tabs only.
///
/// Missing the second one is not a compile error and not visible on the
/// About tab, so it surfaces as a crash the first time somebody opens
/// Products. Both callers provide both: [BusinessProfilePage] from the route
/// id, and `MyBusinessView` once the owner's business has loaded.
class BusinessProfileView extends StatefulWidget {
  const BusinessProfileView({
    super.key,
    this.mode = BusinessProfileMode.viewer,
    this.showAppBar = true,
  });

  final BusinessProfileMode mode;

  /// Set to `false` when embedded in another scaffold (My Business page).
  final bool showAppBar;

  @override
  State<BusinessProfileView> createState() => _BusinessProfileViewState();
}

class _BusinessProfileViewState extends State<BusinessProfileView> {
  int _tab = 0;

  bool get _isOwner => widget.mode == BusinessProfileMode.owner;
  bool get _isAdmin => widget.mode == BusinessProfileMode.admin;

  Future<void> _moderate(BuildContext context, {required bool approve}) async {
    final cubit = context.read<BusinessProfileCubit>();
    final reason = await SellerApprovalDialog.show(context, approve: approve);
    if (reason == null) return;
    if (approve) {
      await cubit.approve();
    } else {
      await cubit.reject(reason: reason);
    }
  }

  Future<void> _edit(BuildContext context, BusinessProfile b) async {
    final cubit = context.read<BusinessProfileCubit>();
    await context.push('${AppRoutes.businessForm}?id=${b.id}');
    if (context.mounted) await cubit.refresh();
  }

  /// Publishing goes through the marketplace's own form, so a listing added
  /// from the shop page is the same row the marketplace serves — one form,
  /// one validation, one catalogue.
  Future<void> _addListing(BuildContext context) async {
    final listings = context.read<BusinessListingsCubit>();
    await context.push<Object?>(AppRoutes.productCreate);
    if (context.mounted) await listings.load();
  }

  Future<void> _editListing(BuildContext context, Product product) async {
    final listings = context.read<BusinessListingsCubit>();
    await context.push<Object?>(AppRoutes.productEditPath(product.id));
    if (context.mounted) await listings.load();
  }

  /// True once the seller role has been claimed for this screen, so an
  /// approval is not re-claimed on every rebuild.
  bool _sellerAccessClaimed = false;

  /// Brings this device's permissions in line with an approval that already
  /// happened server-side.
  ///
  /// Permissions come from the cached profile, and nothing was refreshing it
  /// after a business was approved — so an approved seller opened Products
  /// and was told their business was "still under review", indefinitely, until
  /// they reinstalled or signed out. Claiming here is the same move the
  /// astrologer flow makes when its application is approved.
  ///
  /// Owner only: a reviewer looking at somebody else's approved shop must not
  /// pick up a merchant role from it.
  void _claimSellerAccessIfDue(BuildContext context, BusinessProfileState state) {
    if (_sellerAccessClaimed || !_isOwner) return;

    final business = state.business.dataOrNull;
    if (business == null || business.status != BusinessStatus.approved) return;
    if (context.can(Permission.manageProducts)) return;

    _sellerAccessClaimed = true;
    unawaited(context.read<BusinessProfileCubit>().claimSellerAccess());
  }

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    return Scaffold(
      appBar: widget.showAppBar
          ? AppTopBar(title: s.businessProfile, showBack: true)
          : null,
      body: BlocConsumer<BusinessProfileCubit, BusinessProfileState>(
        listenWhen: (p, n) => p.business != n.business,
        listener: (context, state) {
          // Failed approve/reject/save: the listing is still shown, so surface
          // the error as a snackbar instead of replacing the page.
          if (state.business case Failed(:final failure, previous: != null)) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message)));
          }
          _claimSellerAccessIfDue(context, state);
        },
        builder: (context, state) {
          final b = state.business.dataOrNull;
          if (b == null) {
            return switch (state.business) {
              Failed(:final failure) => ErrorView(message: failure.message),
              _ => const LoadingView(),
            };
          }
          final cubit = context.read<BusinessProfileCubit>();
          final canEdit = _isOwner || _isAdmin;
          return SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: AppSpacing.lg,
              bottom: AppSpacing.xxl,
            ),
            child: Column(
              children: [
                BusinessHeader(
                  business: b,
                  isFollowing: state.isFollowing,
                  onFollow: cubit.toggleFollow,
                  showMessage: !canEdit,
                  // Opens the conversation itself. It used to scroll to the
                  // Contact tab, which looked like the button had done
                  // nothing on a screen already showing that tab.
                  onMessage: () =>
                      context.push(AppRoutes.businessMessageThreadPath(b.id)),
                  onEdit: canEdit ? () => _edit(context, b) : null,
                ),
                if (_isOwner) BusinessModerationCard.owner(business: b),
                if (_isAdmin)
                  BusinessModerationCard.admin(
                    business: b,
                    onApprove: () => _moderate(context, approve: true),
                    onReject: () => _moderate(context, approve: false),
                  ),
                const SizedBox(height: AppSpacing.md),
                PillTabs(
                  labels: [
                    s.aboutTab,
                    s.products,
                    s.services,
                    s.reviews,
                    s.contactTab,
                  ],
                  selectedIndex: _tab,
                  scrollable: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  onChanged: (i) => setState(() => _tab = i),
                ),
                const SizedBox(height: AppSpacing.md),
                switch (_tab) {
                  0 => BusinessAboutSection(business: b),
                  1 => _Listings(
                    business: b,
                    canEdit: canEdit,
                    onAdd: () => _addListing(context),
                    onEdit: (p) => _editListing(context, p),
                  ),
                  2 => _Listings(
                    business: b,
                    canEdit: canEdit,
                    services: true,
                    onAdd: () => _addListing(context),
                    onEdit: (p) => _editListing(context, p),
                  ),
                  3 => BusinessReviewsSection(key: ValueKey(b.id), business: b),
                  _ => BusinessContactSection(business: b),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}

/// The shop's Products or Services tab.
///
/// Owner actions are gated on `manageProducts` rather than on ownership
/// alone: publishing needs an approved shop, and an "Add" button that can
/// only ever return "Missing permission" is worse than a sentence saying the
/// listing is still under review.
class _Listings extends StatelessWidget {
  const _Listings({
    required this.business,
    required this.canEdit,
    required this.onAdd,
    required this.onEdit,
    this.services = false,
  });

  final BusinessProfile business;
  final bool canEdit;
  final VoidCallback onAdd;
  final ValueChanged<Product> onEdit;
  final bool services;

  @override
  Widget build(BuildContext context) {
    // Gated on `manageProducts`, not on ownership alone: publishing needs an
    // approved shop, and an "Add" button that can only ever come back with
    // "Missing permission" is worse than a sentence saying why.
    //
    // The two reasons it can be blocked are genuinely different, and saying
    // the wrong one is worse than saying nothing: a business still in review
    // has to wait for a human, while an approved one whose role has not
    // reached this device just needs a refresh. Telling an approved seller
    // they are "still under review" sends them to support over a cache.
    final isApproved = business.status == BusinessStatus.approved;
    final hasSellerRole = context.can(Permission.manageProducts);
    final canPublish = canEdit && isApproved && hasSellerRole;

    final blockedReason = !canEdit || canPublish
        ? null
        : isApproved
        ? MarketplaceStrings.of(context).sellerAccessSyncing
        : MarketplaceStrings.of(context).listingsNeedApproval;

    return BlocBuilder<BusinessListingsCubit, BusinessListingsState>(
      builder: (context, state) {
        final cubit = context.read<BusinessListingsCubit>();
        return BusinessItemsSection(
          items: services ? state.services : state.products,
          isServices: services,
          isLoading: state.listings.isLoading,
          errorMessage: state.listings.errorMessage,
          onAdd: canPublish ? onAdd : null,
          addDisabledReason: blockedReason,
          onRemove: canPublish ? (p) => cubit.remove(p.id) : null,
          // The owner edits; everyone else opens the listing as a buyer would.
          onItemTap: canPublish
              ? onEdit
              : (p) => context.push(AppRoutes.productDetailsPath(p.id)),
        );
      },
    );
  }
}
