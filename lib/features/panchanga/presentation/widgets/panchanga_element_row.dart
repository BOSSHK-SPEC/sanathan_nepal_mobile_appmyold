import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/panchanga_element.dart';
import '../l10n/panchanga_strings.dart';
import 'panchanga_format.dart';
import 'panchanga_table_widgets.dart';

/// One limb row: `तिथि | तृतीया, ०५:३७:४७ बजे सम्म उप्रान्त चतुर्थी  [थप जानकारी ⌄]`
/// with the expandable घ:प:वि:प्र / बजे सम्म / भुक्त / भोग्य / स्पष्ट sub-table
/// (Figma "TITHI" / "NAKSHATRA" / "KARAN" / "YOG").
class PanchangaElementRow extends StatelessWidget {
  const PanchangaElementRow({
    required this.label,
    required this.element,
    required this.expanded,
    required this.onToggle,
    super.key,
  });

  final String label;
  final PanchangaElement element;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final devanagari = context.usesDevanagariDigits;
    final s = PanchangaStrings.of(context);
    final e = element;
    final endTime = PanchangaFormat.time(e.endsAt, devanagari: devanagari);
    // Devanagari UIs (ne/hi): "तृतीया, ०५:३७:४७ बजे सम्म उप्रान्त चतुर्थी".
    final summary = devanagari
        ? '${e.nameNe}, $endTime ${s.until} ${s.thenAfter} ${e.nextNe}'
        : '${e.nameEn}, ${s.until} $endTime, ${s.thenAfter} ${e.nextEn}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PanchangaHairline(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 3,
          ),
          child: Row(
            children: [
              PanchangaRowLabel(label: label),
              Expanded(
                child: Text(
                  summary,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              MoreInfoButton(
                expanded: expanded,
                onTap: onToggle,
                compact: true,
              ),
            ],
          ),
        ),
        PanchangaExpandable(
          expanded: expanded,
          child: PanchangaSubTable(
            title: e.name(nepali: devanagari),
            rows: [
              (
                s.ghatiPala,
                PanchangaFormat.digits(e.ghatiPala, devanagari: devanagari),
              ),
              (s.until, endTime),
              (
                s.bhukta,
                PanchangaFormat.number(e.bhukta, devanagari: devanagari),
              ),
              (
                s.bhogya,
                PanchangaFormat.number(e.bhogya, devanagari: devanagari),
              ),
              (
                s.spashta(label),
                PanchangaFormat.number(e.spashta, devanagari: devanagari),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
