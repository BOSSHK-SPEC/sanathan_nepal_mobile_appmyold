import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_constants.dart';
import '../core/region/region_scope.dart';
import '../core/session/app_session.dart';
import '../core/session/session_scope.dart';
import '../core/theme/app_theme.dart';
import '../features/app_settings/domain/entities/app_preferences.dart';
import '../features/app_settings/presentation/cubit/app_settings_cubit.dart';
import '../features/session/presentation/cubit/session_cubit.dart';
import '../features/system/presentation/cubit/system_cubit.dart';
import '../features/system/presentation/widgets/system_gate.dart';
import '../l10n/generated/app_localizations.dart';
import 'di/injection.dart';
import 'router/app_router.dart';

class SanatanNepalApp extends StatefulWidget {
  const SanatanNepalApp({super.key, this.router});

  /// Optional router override (tests / previews).
  final GoRouter? router;

  @override
  State<SanatanNepalApp> createState() => _SanatanNepalAppState();
}

class _SanatanNepalAppState extends State<SanatanNepalApp> {
  late final GoRouter _router = widget.router ?? AppRouter.create();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppSettingsCubit>.value(value: sl<AppSettingsCubit>()),
        BlocProvider<SessionCubit>.value(value: sl<SessionCubit>()),
        BlocProvider<SystemCubit>.value(value: sl<SystemCubit>()),
      ],
      child: BlocBuilder<AppSettingsCubit, AppPreferences>(
        buildWhen: (p, n) =>
            p.themeMode != n.themeMode ||
            p.language != n.language ||
            p.region != n.region,
        builder: (context, prefs) {
          return RegionScope(
            region: prefs.region,
            // Region drives calendars, currencies and data sources – rebuild
            // the whole tree (cubits reload) when it changes; the router keeps
            // the current location.
            child: KeyedSubtree(
              key: ValueKey(prefs.region),
              // Sits above MaterialApp.router so route guards can read the
              // session from the navigator's context.
              child: BlocBuilder<SessionCubit, AppSession>(
                builder: (context, session) => SessionScope(
                  session: session,
                  child: MaterialApp.router(
                    title: AppConstants.appName,
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.light(),
                    darkTheme: AppTheme.dark(),
                    themeMode: prefs.themeMode,
                    locale: prefs.language.locale,
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    routerConfig: _router,
                    // Above every route: a forced upgrade or maintenance
                    // window must stop screens that know nothing about it,
                    // and the offline banner must show over all of them.
                    builder: (context, child) =>
                        BlocBuilder<SystemCubit, SystemState>(
                          builder: (context, system) => SystemGate(
                            status: system.status,
                            child: Column(
                              children: [
                                OfflineBanner(online: system.online),
                                Expanded(child: child ?? const SizedBox()),
                              ],
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
