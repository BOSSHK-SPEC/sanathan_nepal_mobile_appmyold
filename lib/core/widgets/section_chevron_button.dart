import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';

/// The `>` at the end of a [SectionHeader] row that opens the section's full
/// page (Panchanga, Events, Suva Sait / Shubh Muhurat…).
///
/// One widget so every section says "there is more behind this" the same
/// way. The accent rule some headers ended with reads as decoration, so the
/// pages behind them went undiscovered. Carries a tooltip — announced by
/// screen readers, shown on long-press — and the compact 40 dp tap target.
class SectionChevronButton extends StatelessWidget {
  const SectionChevronButton({
    required this.onPressed,
    super.key,
    this.tooltip,
  });

  final VoidCallback onPressed;

  /// Defaults to the shared "See All" string.
  final String? tooltip;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    tooltip: tooltip ?? context.l10n.seeAll,
    icon: const Icon(Icons.chevron_right),
    visualDensity: VisualDensity.compact,
  );
}
