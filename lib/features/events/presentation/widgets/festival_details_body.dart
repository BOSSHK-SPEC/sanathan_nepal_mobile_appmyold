import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_category.dart';
import '../l10n/events_strings.dart';
import '../utils/event_date_format.dart';
import 'event_tag.dart';
import 'events_tab_strip.dart';

/// Body of the details page for festivals / holidays.
class FestivalDetailsBody extends StatefulWidget {
  const FestivalDetailsBody({
    required this.event,
    super.key,
    this.onPanchanga,
    this.onAddReminder,
  });

  final Event event;
  final VoidCallback? onPanchanga;
  final VoidCallback? onAddReminder;

  @override
  State<FestivalDetailsBody> createState() => _FestivalDetailsBodyState();
}

class _FestivalDetailsBodyState extends State<FestivalDetailsBody> {
  int _tab = 1;

  @override
  Widget build(BuildContext context) {
    final s = EventsStrings.of(context);
    final colors = context.colors;
    final lang = context.languageCode;
    final e = widget.event;
    final tabs = [
      s.tabVideo,
      s.tabDescription,
      s.tabHowToCelebrate,
      s.tabPlaces,
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.xxxl,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      EventDateFormat.detailsLine(
                        e.date,
                        config: context.regionConfig,
                        languageCode: lang,
                        weekdays: s.weekdays,
                        tithi: e.tithi.resolveFor(lang),
                      ),
                      style: context.textTheme.labelSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (e.isHoliday)
                          EventTag(
                            label: s.publicHoliday,
                            color: colors.holiday,
                          ),
                        if (e.category != EventCategory.publicHoliday)
                          EventTag(label: s.category_(e.category)),
                        if (e.isVrat)
                          EventTag(label: s.vrat, color: colors.today),
                        if (e.isImportant)
                          EventTag(label: s.filterImportant, filled: true),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: widget.onPanchanga,
                    child: Text(
                      '${s.panchangaLinkFor(context.regionConfig)} >',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  GestureDetector(
                    onTap: widget.onAddReminder,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: colors.accent),
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            s.addEventReminder,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colors.accent,
                              fontSize: 9,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.event_available_outlined,
                            size: 12,
                            color: colors.accent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Figma "Rectangle 2217": tinted 30px strip with the four
              // tab labels and an underline below the active one.
              EventsTabStrip(
                labels: tabs,
                selectedIndex: _tab,
                onChanged: (i) => setState(() => _tab = i),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: _TabContent(event: e, tab: _tab),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({required this.event, required this.tab});
  final Event event;
  final int tab;

  @override
  Widget build(BuildContext context) {
    final lang = context.languageCode;
    final body = context.textTheme.bodySmall?.copyWith(height: 1.5);
    // Companion images follow the naming `<base>_video/_celebrate/_place.png`
    // (AppImage falls back to a themed placeholder when a file is missing).
    final image = event.imagePath ?? 'assets/images/events/${event.id}.png';
    final base = image.replaceAll(RegExp(r'\.png$'), '');
    switch (tab) {
      case 0:
        return _VideoPlaceholder(image: '${base}_video.png');
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              '${base}_celebrate.png',
              height: 140,
              width: double.infinity,
              radius: AppRadius.sm,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              _or(event.howToCelebrate, event.description, lang),
              style: body,
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppImage(image, height: 120, radius: AppRadius.sm),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppImage(
                    '${base}_place.png',
                    height: 120,
                    radius: AppRadius.sm,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              _or(event.attractionPlaces, event.description, lang),
              style: body,
            ),
          ],
        );
      default:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(image, width: 110, height: 110, radius: AppRadius.sm),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(event.description.resolveFor(lang), style: body),
            ),
          ],
        );
    }
  }

  static String _or(
    LocalizedText primary,
    LocalizedText fallback,
    String languageCode,
  ) => primary.isEmpty
      ? fallback.resolveFor(languageCode)
      : primary.resolveFor(languageCode);
}

class _VideoPlaceholder extends StatelessWidget {
  const _VideoPlaceholder({required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: SizedBox(
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppImage(image),
            ColoredBox(color: Colors.black.withValues(alpha: 0.35)),
            Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: colors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: colors.onPrimary,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
