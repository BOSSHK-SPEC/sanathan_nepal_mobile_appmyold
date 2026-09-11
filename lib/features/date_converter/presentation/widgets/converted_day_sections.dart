import 'package:flutter/material.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../events/presentation/widgets/events_for_date_section.dart';
import '../../../panchanga/presentation/cubit/panchanga_cubit.dart';
import '../../../panchanga/presentation/widgets/panchanga_section.dart';
import '../../../panchanga/presentation/widgets/suva_sait_section.dart';

/// Blocks under the conversion result for the CONVERTED day (Figma
/// "EVENTS" · "SUVA SAIT" · "PANCHANGA" groups): the events feature's
/// [EventsForDateSection] (festivals + my events + to-dos, "Add
/// Event/Reminder"), then the panchanga feature's [SuvaSaitSection] and
/// [PanchangaSection] sharing one [PanchangaCubit].
///
/// The cubit is owned here and re-pointed with `selectDate` whenever [date]
/// changes, so all three sections re-load with the converted date.
class ConvertedDaySections extends StatefulWidget {
  const ConvertedDaySections({required this.date, super.key});

  /// Converted Gregorian date (local midnight).
  final DateTime date;

  @override
  State<ConvertedDaySections> createState() => _ConvertedDaySectionsState();
}

class _ConvertedDaySectionsState extends State<ConvertedDaySections> {
  late final PanchangaCubit _panchanga;

  @override
  void initState() {
    super.initState();
    _panchanga = sl<PanchangaCubit>()..selectDate(widget.date);
  }

  @override
  void didUpdateWidget(covariant ConvertedDaySections oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameDay(oldWidget.date, widget.date)) {
      _panchanga.selectDate(widget.date);
    }
  }

  @override
  void dispose() {
    _panchanga.close();
    super.dispose();
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      EventsForDateSection(
        date: widget.date,
        showTodos: true,
        padding: EdgeInsets.zero,
      ),
      const SizedBox(height: AppSpacing.md),
      SuvaSaitSection(cubit: _panchanga, maxItems: 3, padding: EdgeInsets.zero),
      const SizedBox(height: AppSpacing.md),
      PanchangaSection(cubit: _panchanga, padding: EdgeInsets.zero),
    ],
  );
}
