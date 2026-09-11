import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/favourite_product.dart';
import '../../domain/entities/user_profile.dart';
import '../l10n/profile_strings.dart';
import 'favourite_product_card.dart';
import 'preferences_card.dart';
import 'profile_info_card.dart';

/// ABOUT tab: info card, preferences card and favourite products grid.
class ProfileAboutTab extends StatelessWidget {
  const ProfileAboutTab({
    required this.profile,
    required this.favourites,
    super.key,
  });

  final UserProfile profile;
  final List<FavouriteProduct> favourites;

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    return Column(
      children: [
        ProfileInfoCard(profile: profile),
        PreferencesCard(
          favouriteChild: favourites.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Text(
                    s.noFavourites,
                    style: context.textTheme.bodySmall,
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favourites.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.sm,
                    crossAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 155 / 205,
                  ),
                  itemBuilder: (_, i) => FavouriteProductCard(
                    product: favourites[i],
                    onTap: () => context.push(
                      AppRoutes.productDetailsPath(favourites[i].id),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
