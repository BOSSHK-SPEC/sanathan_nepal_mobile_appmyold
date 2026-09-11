import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_bar_title.dart';
import '../../../../core/widgets/labeled_toggle.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/notification_prefs_cubit.dart';
import '../l10n/onboarding_strings.dart';
import '../widgets/auth_flow_navigation.dart';
import '../widgets/notification_setting_rows.dart';
import '../widgets/page_dots.dart';
import '../widgets/post_sign_in_scope.dart';

/// Notification Settings onboarding step (Figma 206:130): horoscope,
/// festival and birthday reminder toggles. Finish → home.
class NotificationSettingsOnboardingPage extends StatelessWidget {
  const NotificationSettingsOnboardingPage({super.key, this.cubit});

  /// Optional cubit override (tests); defaults to
  /// `sl<NotificationPrefsCubit>()..load()`.
  final NotificationPrefsCubit? cubit;

  @override
  Widget build(BuildContext context) => BlocProvider<NotificationPrefsCubit>(
    create: (_) => (cubit ?? sl<NotificationPrefsCubit>())..load(),
    // The details are already saved on the server; Back must not reopen them.
    child: const PostSignInScope(child: _NotificationSettingsView()),
  );
}

class _NotificationSettingsView extends StatelessWidget {
  const _NotificationSettingsView();

  @override
  Widget build(BuildContext context) {
    final s = OnboardingStrings.of(context);
    final colors = context.colors;
    return BlocConsumer<NotificationPrefsCubit, NotificationPrefsState>(
      listenWhen: (p, n) => p.save != n.save || p.prefs != n.prefs,
      listener: (context, state) {
        if (state.save.isLoaded) {
          AuthFlowNavigation.finishOnboarding(context);
          return;
        }
        final message = state.save.errorMessage ?? state.prefs.errorMessage;
        if (message != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<NotificationPrefsCubit>();
        final p = state.current;
        if (state.prefs.dataOrNull == null && !state.prefs.isFailed) {
          return Scaffold(
            appBar: AppTopBar(title: s.notificationTitle),
            body: const LoadingView(),
          );
        }
        return Scaffold(
          appBar: AppTopBar(title: s.notificationTitle),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                AppSpacing.lg,
                AppSpacing.pageGutter,
                AppSpacing.xxl,
              ),
              children: [
                Text(
                  s.notificationSubtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textMuted,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                NotificationSection(
                  title: s.horoscopeSection,
                  children: [
                    LabeledToggle(
                      label: s.daily,
                      value: p.horoscopeDaily,
                      onChanged: (v) =>
                          cubit.update((x) => x.copyWith(horoscopeDaily: v)),
                    ),
                    LabeledToggle(
                      label: s.monthly,
                      value: p.horoscopeMonthly,
                      onChanged: (v) =>
                          cubit.update((x) => x.copyWith(horoscopeMonthly: v)),
                    ),
                    LabeledToggle(
                      label: s.yearly,
                      value: p.horoscopeYearly,
                      onChanged: (v) =>
                          cubit.update((x) => x.copyWith(horoscopeYearly: v)),
                    ),
                    TimeRow(
                      label: s.notificationTime,
                      minutes: p.horoscopeTimeMinutes,
                      onChanged: (m) => cubit.update(
                        (x) => x.copyWith(horoscopeTimeMinutes: m),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                NotificationSection(
                  title: s.festivalSection,
                  children: [
                    LabeledToggle(
                      label: s.importantFestivals,
                      value: p.importantFestivals,
                      onChanged: (v) => cubit.update(
                        (x) => x.copyWith(importantFestivals: v),
                      ),
                    ),
                    LabeledToggle(
                      label: s.commonFestivals,
                      value: p.commonFestivals,
                      onChanged: (v) =>
                          cubit.update((x) => x.copyWith(commonFestivals: v)),
                    ),
                    LabeledToggle(
                      label: s.publicHolidays,
                      value: p.publicHolidays,
                      onChanged: (v) =>
                          cubit.update((x) => x.copyWith(publicHolidays: v)),
                    ),
                    RemindBeforeRow(
                      remindLabel: s.remindBefore,
                      daysAtLabel: s.daysAt,
                      days: p.festivalRemindDaysBefore,
                      minutes: p.festivalTimeMinutes,
                      onDaysChanged: (d) => cubit.update(
                        (x) => x.copyWith(festivalRemindDaysBefore: d),
                      ),
                      onMinutesChanged: (m) => cubit.update(
                        (x) => x.copyWith(festivalTimeMinutes: m),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                NotificationSection(
                  title: s.birthdaySection,
                  children: [
                    LabeledToggle(
                      label: s.birthdayReminders,
                      value: p.birthdays,
                      onChanged: (v) =>
                          cubit.update((x) => x.copyWith(birthdays: v)),
                    ),
                    RemindBeforeRow(
                      remindLabel: s.remindBefore,
                      daysAtLabel: s.daysAt,
                      days: p.birthdayRemindDaysBefore,
                      minutes: p.birthdayTimeMinutes,
                      onDaysChanged: (d) => cubit.update(
                        (x) => x.copyWith(birthdayRemindDaysBefore: d),
                      ),
                      onMinutesChanged: (m) => cubit.update(
                        (x) => x.copyWith(birthdayTimeMinutes: m),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxxl),
                const Center(child: PageDots(count: 4, activeIndex: 3)),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: s.finish,
                  isLoading: state.isSaving,
                  onPressed: cubit.save,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
