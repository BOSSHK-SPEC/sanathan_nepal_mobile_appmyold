import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../../marketplace/presentation/cubit/business_listings_cubit.dart';
import '../cubit/business_profile_cubit.dart';
import '../l10n/profile_strings.dart';
import 'business_form_page.dart';
import 'business_profile_page.dart';

/// "My Business / Become a Seller" entry (`/business/mine`).
///
/// Loads the current user's business: when it exists the owner view of
/// [BusinessProfileView] is shown (Edit → form, add products/services,
/// status chip); when there is none yet the [BusinessFormPage] is embedded
/// and, once submitted, the page switches to the owner view.
class MyBusinessPage extends StatelessWidget {
  const MyBusinessPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    // Asked for by identity, never by a guessed id.
    create: (_) => sl<BusinessProfileCubit>()..loadMine(),
    child: const MyBusinessView(),
  );
}

/// Widget-testable body of [MyBusinessPage].
///
/// Expects a [BusinessProfileCubit] above it, and provides the
/// [BusinessListingsCubit] that [BusinessProfileView] needs for its
/// Products and Services tabs — see the `Loaded` branch below.
class MyBusinessView extends StatelessWidget {
  const MyBusinessView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = ProfileStrings.of(context);
    return BlocBuilder<BusinessProfileCubit, BusinessProfileState>(
      buildWhen: (p, n) =>
          p.business.dataOrNull == null || n.business.dataOrNull == null,
      builder: (context, state) {
        final cubit = context.read<BusinessProfileCubit>();
        return switch (state.business) {
          Idle() || Loading() => Scaffold(
            appBar: AppTopBar(title: s.myBusiness, showBack: true),
            body: const LoadingView(),
          ),
          // No business yet → become a seller: embed the form.
          // No business yet → become a seller: embed the create form.
          Failed(failure: NotFoundFailure()) => BusinessFormPage(
            onSubmitted: (_) => cubit.loadMine(),
          ),
          Failed(:final failure) => Scaffold(
            appBar: AppTopBar(title: s.myBusiness, showBack: true),
            body: ErrorView(message: failure.message, onRetry: cubit.loadMine),
          ),
          // BusinessProfileView needs BOTH cubits: its own, and the listings
          // one behind the Products and Services tabs. Only the profile cubit
          // was provided here, so those two tabs threw
          // ProviderNotFoundException the moment an owner opened them —
          // invisible until then, because the About tab needs neither.
          //
          // The id is only known once the business has loaded (it is fetched
          // by identity, never by a guessed id), which is why the provider
          // sits in this branch rather than at the top of the page.
          Loaded(:final data) => BlocProvider(
            key: ValueKey(data.id),
            create: (_) => sl<BusinessListingsCubit>(param1: data.id)..load(),
            child: const BusinessProfileView(mode: BusinessProfileMode.owner),
          ),
        };
      },
    );
  }
}
