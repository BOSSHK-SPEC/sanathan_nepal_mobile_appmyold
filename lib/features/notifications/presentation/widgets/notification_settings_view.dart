import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../cubit/notification_settings_cubit.dart';
import '../l10n/notifications_strings.dart';
import 'settings_fields.dart';
import 'settings_section_card.dart';

/// Body of the "Notification Settings" tab – reusable by the Profile feature.
///
/// ```dart
/// const NotificationSettingsView()            // own cubit from sl
/// NotificationSettingsView(shrinkWrap: true)  // inside another scroll view
/// ```
/// Sections: Horoscope (toggle, Daily/Monthly/Yearly, time), Festivals
/// (three toggles + remind-before row) and Birthday (toggle + remind-before).
/// Every change is persisted immediately via `sl<KeyValueStore>()`.
class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({
    super.key,
    this.shrinkWrap = false,
    this.padding = const EdgeInsets.symmetric(vertical: AppSpacing.sm),
  });

  final bool shrinkWrap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final existing = _maybeCubit(context);
    if (existing != null) {
      return _Body(shrinkWrap: shrinkWrap, padding: padding);
    }
    return BlocProvider(
      create: (_) => sl<NotificationSettingsCubit>()..load(),
      child: _Body(shrinkWrap: shrinkWrap, padding: padding),
    );
  }

  static NotificationSettingsCubit? _maybeCubit(BuildContext context) {
    try {
      return context.read<NotificationSettingsCubit>();
    } on ProviderNotFoundException {
      return null;
    }
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.shrinkWrap, required this.padding});
  final bool shrinkWrap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final s = NotificationsStrings.of(context);
    final colors = context.colors;
    return BlocConsumer<NotificationSettingsCubit, NotificationSettingsState>(
      listenWhen: (p, c) =>
          (c.save.isFailed && p.save != c.save) ||
          (c.settings.isFailed && p.settings != c.settings),
      listener: (context, state) {
        final message = state.save.errorMessage ?? state.settings.errorMessage;
        if (message == null) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      },
      builder: (context, state) {
        if (state.settings.dataOrNull == null && !state.settings.isFailed) {
          return const LoadingView(height: 120);
        }
        final cubit = context.read<NotificationSettingsCubit>();
        final st = state.current;
        return ListView(
          shrinkWrap: shrinkWrap,
          physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
          padding: padding,
          children: [
            SettingsSectionCard(
              title: s.horoscopeSection,
              enabled: st.horoscopeEnabled,
              onEnabledChanged: cubit.setHoroscopeEnabled,
              children: [
                Wrap(
                  spacing: AppSpacing.lg,
                  children: [
                    SettingsCheckOption(
                      label: s.daily,
                      value: st.horoscopeDaily,
                      onChanged: cubit.setHoroscopeDaily,
                    ),
                    SettingsCheckOption(
                      label: s.monthly,
                      value: st.horoscopeMonthly,
                      onChanged: cubit.setHoroscopeMonthly,
                    ),
                    SettingsCheckOption(
                      label: s.yearly,
                      value: st.horoscopeYearly,
                      onChanged: cubit.setHoroscopeYearly,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Text(
                      s.notificationTime,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.accent,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: SettingsTimeBox(
                        time: st.horoscopeTime,
                        width: double.infinity,
                        onChanged: cubit.setHoroscopeTime,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SettingsSectionCard(
              title: s.festivalsSection,
              children: [
                SettingsToggleRow(
                  label: s.importantHinduFestivals,
                  value: st.importantHinduFestivals,
                  onChanged: cubit.setImportantHinduFestivals,
                ),
                SettingsToggleRow(
                  label: s.commonFestivals,
                  value: st.commonFestivals,
                  onChanged: cubit.setCommonFestivals,
                ),
                SettingsToggleRow(
                  label: s.publicHolidays,
                  value: st.publicHolidays,
                  onChanged: cubit.setPublicHolidays,
                ),
                const SizedBox(height: AppSpacing.sm),
                RemindBeforeRow(
                  days: st.festivalRemindDays,
                  time: st.festivalRemindTime,
                  onDaysChanged: cubit.setFestivalRemindDays,
                  onTimeChanged: cubit.setFestivalRemindTime,
                ),
              ],
            ),
            SettingsSectionCard(
              title: s.birthdaySection,
              enabled: st.birthdayEnabled,
              onEnabledChanged: cubit.setBirthdayEnabled,
              children: [
                RemindBeforeRow(
                  days: st.birthdayRemindDays,
                  time: st.birthdayRemindTime,
                  onDaysChanged: cubit.setBirthdayRemindDays,
                  onTimeChanged: cubit.setBirthdayRemindTime,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
