import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/pill_tabs.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/appointment.dart';
import '../l10n/appointment_strings.dart';
import 'appointment_summary_card.dart';

/// "My Appointments" tab: Upcoming / Past switch + list of
/// [AppointmentSummaryCard]s (empty state mirrors the profile design).
class MyAppointmentsTab extends StatefulWidget {
  const MyAppointmentsTab({
    required this.upcoming,
    required this.past,
    required this.onOpen,
    required this.onBook,
    super.key,
  });

  final List<Appointment> upcoming;
  final List<Appointment> past;
  final ValueChanged<Appointment> onOpen;
  final VoidCallback onBook;

  @override
  State<MyAppointmentsTab> createState() => _MyAppointmentsTabState();
}

class _MyAppointmentsTabState extends State<MyAppointmentsTab> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final strings = AppointmentStrings.of(context);
    final list = _tab == 0 ? widget.upcoming : widget.past;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PillTabs(
            labels: [strings.upcoming, strings.past],
            selectedIndex: _tab,
            filled: false,
            onChanged: (i) => setState(() => _tab = i),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (list.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Text(
                    strings.noAppointments,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.textMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  PrimaryButton(
                    label: strings.bookNow,
                    expanded: false,
                    height: 32,
                    onPressed: widget.onBook,
                  ),
                ],
              ),
            )
          else
            for (var i = 0; i < list.length; i++)
              AppointmentSummaryCard(
                appointment: list[i],
                showDivider: i > 0,
                onTap: () => widget.onOpen(list[i]),
              ),
        ],
      ),
    );
  }
}
