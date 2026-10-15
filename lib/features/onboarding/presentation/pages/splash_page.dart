import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/di/injection.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/app_boot.dart';
import '../../../../core/widgets/brand_mark.dart';
import '../../../app_settings/presentation/cubit/app_settings_cubit.dart';
import '../../domain/entities/onboarding_step.dart';
import '../../domain/repositories/auth_presence.dart';
import '../../domain/repositories/onboarding_progress_repository.dart';
import '../l10n/onboarding_strings.dart';
import '../widgets/auth_flow_navigation.dart';

/// Loading screen (Figma 205:2). Draws the brand yantra on the primary
/// gradient, then routes to the app — or back into onboarding at the step the
/// person had reached, if they closed the app part-way through.
///
/// It continues the Android launch screen rather than replacing it: the OS
/// paints `@drawable/launch_background` (the same mark, on the gradient's first
/// colour) while the process starts, and this page opens on that exact colour
/// before blooming the gradient in. There is no cut between the two.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.delay, this.progress, this.presence});

  /// How long to stay. Defaults to whatever is left of the launch budget
  /// ([AppBoot.splashRemainder]) so a slow start is absorbed here rather than
  /// added on top of it.
  final Duration? delay;

  /// Overrides for tests; default to the registered implementations.
  final OnboardingProgressRepository? progress;
  final AuthPresence? presence;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final Duration _delay = widget.delay ?? AppBoot.splashRemainder();

  /// Draw-in of the mark and the wordmark. Runs over [_delay] so the
  /// choreography always ends exactly when the screen does.
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: _delay,
  );

  /// Never-ending breath: the flame and the orbiting graha. Independent of
  /// [_intro] so the mark stays alive if the route is held (a slow first sync).
  late final AnimationController _idle = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2800),
  );

  Timer? _timer;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    // A screen reader or "remove animations" must not be made to sit through a
    // reveal: show the finished mark and move on.
    if (MediaQuery.disableAnimationsOf(context) ||
        MediaQuery.accessibleNavigationOf(context)) {
      _intro.value = 1;
    } else {
      _intro.forward();
      _idle.repeat();
    }
    _timer = Timer(_delay, _next);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _intro.dispose();
    _idle.dispose();
    super.dispose();
  }

  void _next() {
    if (!mounted) return;
    final prefs = context.read<AppSettingsCubit>().state;
    final progress = widget.progress ?? sl<OnboardingProgressRepository>();
    final presence = widget.presence ?? sl<AuthPresence>();
    final signedIn = presence.isSignedIn;
    if (prefs.onboardingCompleted) {
      // Finishing onboarding once does not mean signed in for good. After a
      // sign-out this flag is still set, and it used to open Home for nobody.
      // A returning user goes straight to sign-in; language and theme were
      // chosen already.
      context.go(signedIn ? AppRoutes.home : AppRoutes.login);
      return;
    }
    AuthFlowNavigation.openStep(
      context,
      OnboardingStep.resume(saved: progress.step, signedIn: signedIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = OnboardingStrings.of(context);
    final gradient = colors.primaryGradient;
    // The colour the OS splash is painted in — see launch_background.xml. It
    // is the same in dark mode, so a dark theme opens on it too and the bloom
    // below carries it into the night palette.
    final seed = AppColors.launchBackground;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: seed,
        body: Semantics(
          label: s.appName,
          container: true,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Bloom: the flat launch colour opens into the brand gradient.
              FadeTransition(
                opacity: CurvedAnimation(
                  parent: _intro,
                  curve: const Interval(0, 0.22, curve: Curves.easeOut),
                ),
                child: DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
              ),
              SafeArea(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ExcludeSemantics(
                        child: AnimatedBuilder(
                          animation: Listenable.merge([_intro, _idle]),
                          builder: (context, _) => BrandMark(
                            color: colors.onPrimary,
                            progress: _intro.value,
                            pulse: _idle.value,
                            size: _markSize(context),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      _Reveal(
                        animation: _intro,
                        start: 0.55,
                        child: _Wordmark(
                          text: s.appName,
                          animation: _idle,
                          style: context.textTheme.displayMedium?.copyWith(
                            color: colors.onPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _Reveal(
                        animation: _intro,
                        start: 0.68,
                        child: Text(
                          s.tagline,
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: colors.onPrimary.withValues(alpha: 0.85),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxxl),
                      _LoadingRail(
                        animation: _intro,
                        color: colors.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Large, but never taller than the space the wordmark leaves it.
  double _markSize(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return math.min(size.width * 0.52, math.min(size.height * 0.3, 220));
  }
}

/// Fades and lifts [child] into place over the tail of [animation].
class _Reveal extends StatelessWidget {
  const _Reveal({
    required this.animation,
    required this.start,
    required this.child,
  });

  final Animation<double> animation;
  final double start;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Interval(start, 1, curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.45),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}

/// The app name with a light sweeping across it, as on the public site.
class _Wordmark extends StatelessWidget {
  const _Wordmark({
    required this.text,
    required this.animation,
    required this.style,
  });

  final String text;
  final Animation<double> animation;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final label = Text(text, textAlign: TextAlign.center, style: style);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) {
          // A highlight travelling left to right, twice the width of the text
          // so it is off-screen at both ends of the loop.
          final x = animation.value * 2 - 0.5;
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [
              Colors.white,
              Colors.white,
              Color(0xFFFFF3D2),
              Colors.white,
              Colors.white,
            ],
            stops: [0, (x - 0.18).clamp(0.0, 1.0), x.clamp(0.0, 1.0), (x + 0.18).clamp(0.0, 1.0), 1],
          ).createShader(bounds);
        },
        child: child,
      ),
      child: label,
    );
  }
}

/// A hairline that fills while the app decides where to send you. Determinate
/// on purpose: the wait is a known length, so a spinner would be a lie.
class _LoadingRail extends StatelessWidget {
  const _LoadingRail({required this.animation, required this.color});

  final Animation<double> animation;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(1),
        ),
        child: ExcludeSemantics(
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, _) => FractionallySizedBox(
              alignment: AlignmentDirectional.centerStart,
              widthFactor: animation.value.clamp(0.0, 1.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
