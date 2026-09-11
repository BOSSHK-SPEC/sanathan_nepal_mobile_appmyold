import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../app/di/injection.dart';
import '../core/region/region.dart';
import '../core/region/region_scope.dart';
import '../core/theme/app_theme.dart';
import '../l10n/generated/app_localizations.dart';
import 'auth/cubit/admin_auth_cubit.dart';
import 'router/admin_router.dart';

/// The staff console as its own application.
///
/// Shares the app's theme, region scope and localisations, so a console button
/// is the same button the app ships — but it is a separate `MaterialApp` with
/// its own router, and it is built from `lib/main_admin.dart`. That separation
/// is the point: the moderation queue must not be compiled into the APK that
/// goes to users, and the console must not carry a bottom navigation bar.
class SanatanAdminApp extends StatefulWidget {
  const SanatanAdminApp({super.key});

  @override
  State<SanatanAdminApp> createState() => _SanatanAdminAppState();
}

class _SanatanAdminAppState extends State<SanatanAdminApp> {
  late final AdminAuthCubit _auth = sl<AdminAuthCubit>();
  late final GoRouter _router = AdminRouter.create(_auth);

  @override
  void initState() {
    super.initState();
    // Restores a stored session before the first frame settles, so a browser
    // refresh inside the console does not bounce staff back to the landing
    // page and make them sign in again.
    _auth.restore();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminAuthCubit>.value(
      value: _auth,
      child: RegionScope(
        // The console is staff-facing and reports in one place: Nepal is the
        // platform's home region, and finance figures are not re-denominated
        // per reviewer. Region-specific *data* still comes from the server.
        region: Region.nepal,
        child: MaterialApp.router(
          title: 'Sanatan Console',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          // Follows the operating system. A console is looked at for hours, and
          // forcing either mode on someone is the fastest way to be disliked.
          themeMode: ThemeMode.system,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: _router,
        ),
      ),
    );
  }
}
