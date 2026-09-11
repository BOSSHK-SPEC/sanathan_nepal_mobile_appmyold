import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/region/region_format.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/astrologer_filter.dart';
import '../../domain/entities/consult_channel.dart';
import '../../domain/entities/specialty.dart';
import '../cubit/astrologer_list_cubit.dart';
import '../l10n/astrologers_strings.dart';
import 'astrologer_presence.dart';

/// Narrowing filters for the discovery list.
///
/// Edits go to the cubit's *draft* filter; only "Show N astrologers" promotes
/// them, so swiping the sheet away discards the changes.
class AstrologerFilterSheet extends StatelessWidget {
  const AstrologerFilterSheet({super.key});

  static Future<void> show(BuildContext context) {
    final cubit = context.read<AstrologerListCubit>()..beginFilterEdit();
    return AppBottomSheet.show<void>(
      context,
      builder: (_) => BlocProvider<AstrologerListCubit>.value(
        value: cubit,
        child: const AstrologerFilterSheet(),
      ),
    );
  }

  /// Ceiling for the price slider, in the region's currency per minute.
  static const double _maxRate = 100;

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);

    return BlocBuilder<AstrologerListCubit, AstrologerListState>(
      builder: (context, state) {
        final cubit = context.read<AstrologerListCubit>();
        final draft = state.draftFilter;
        final languages = state.languages.dataOrNull ?? const ['ne', 'en'];

        return AppFilterSheet(
          title: s.filters,
          resetLabel: s.reset,
          canReset: draft.hasFilters,
          onReset: cubit.resetDraft,
          applyLabel: s.showResults(
            localizeCount(context, state.results.length),
          ),
          onApply: () {
            cubit.applyFilter();
            Navigator.of(context).pop();
          },
          children: [
            FilterSection(
              title: s.onlyOnline,
              trailing: Switch.adaptive(
                value: draft.onlineOnly,
                onChanged: (v) =>
                    cubit.updateDraft(draft.copyWith(onlineOnly: v)),
              ),
              child: Text(
                s.onlineNow,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.textMuted,
                ),
              ),
            ),
            FilterSection(
              title: s.speciality,
              child: FilterChipGroup<Specialty>(
                options: Specialty.values,
                labelOf: s.specialty,
                selected: draft.specialties,
                onChanged: (next) =>
                    cubit.updateDraft(draft.copyWith(specialties: next)),
              ),
            ),
            FilterSection(
              title: s.language,
              child: FilterChipGroup<String>(
                options: languages,
                labelOf: s.languageName,
                selected: draft.languageCodes,
                onChanged: (next) =>
                    cubit.updateDraft(draft.copyWith(languageCodes: next)),
              ),
            ),
            FilterSection(
              title: s.channel,
              child: FilterChipGroup<ConsultChannel>(
                options: ConsultChannel.values,
                labelOf: s.channelName,
                iconOf: (c) => switch (c) {
                  ConsultChannel.chat => Icons.chat_bubble_outline_rounded,
                  ConsultChannel.voice => Icons.call_outlined,
                  ConsultChannel.video => Icons.videocam_outlined,
                },
                selected: draft.channels,
                onChanged: (next) =>
                    cubit.updateDraft(draft.copyWith(channels: next)),
              ),
            ),
            FilterSection(
              title: s.maxPricePerMinute,
              child: _PriceFilter(
                value: draft.maxRate,
                onChanged: (v) => cubit.updateDraft(
                  v == null
                      ? AstrologerFilter(
                          query: draft.query,
                          sort: draft.sort,
                          specialties: draft.specialties,
                          languageCodes: draft.languageCodes,
                          channels: draft.channels,
                          minRating: draft.minRating,
                          minExperience: draft.minExperience,
                          onlineOnly: draft.onlineOnly,
                        )
                      : draft.copyWith(maxRate: v),
                ),
              ),
            ),
            FilterSection(
              title: s.minimumRating,
              child: _RatingFilter(
                value: draft.minRating,
                onChanged: (v) =>
                    cubit.updateDraft(draft.copyWith(minRating: v)),
              ),
            ),
            FilterSection(
              title: s.minimumExperience,
              child: _ExperienceFilter(
                value: draft.minExperience,
                onChanged: (v) =>
                    cubit.updateDraft(draft.copyWith(minExperience: v)),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PriceFilter extends StatelessWidget {
  const _PriceFilter({required this.value, required this.onChanged});

  final double? value;
  final ValueChanged<double?> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = AstrologersStrings.of(context);
    final current = value ?? AstrologerFilterSheet._maxRate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value == null
              ? s.anyPrice
              : '${RegionFormat.money(current, config: context.regionConfig, languageCode: context.languageCode)}${s.perMinute}',
          style: context.textTheme.titleSmall?.copyWith(color: colors.accent),
        ),
        Slider(
          min: 5,
          max: AstrologerFilterSheet._maxRate,
          divisions: 19,
          value: current,
          activeColor: colors.accent,
          inactiveColor: colors.divider,
          onChanged: (v) =>
              onChanged(v >= AstrologerFilterSheet._maxRate ? null : v),
        ),
      ],
    );
  }
}

class _RatingFilter extends StatelessWidget {
  const _RatingFilter({required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  static const List<double> _options = [0, 3, 3.5, 4, 4.5];

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    return FilterChipGroup<double>(
      options: _options,
      multiSelect: false,
      labelOf: (v) => v == 0 ? s.any : '${localizeCount(context, v)}+',
      iconOf: (v) => v == 0 ? null : Icons.star_rounded,
      selected: {value},
      onChanged: (next) => onChanged(next.isEmpty ? 0 : next.first),
    );
  }
}

class _ExperienceFilter extends StatelessWidget {
  const _ExperienceFilter({required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  static const List<int> _options = [0, 5, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    final s = AstrologersStrings.of(context);
    return FilterChipGroup<int>(
      options: _options,
      multiSelect: false,
      labelOf: (v) =>
          v == 0 ? s.any : '${s.yearsLabel(localizeCount(context, v))}+',
      selected: {value},
      onChanged: (next) => onChanged(next.isEmpty ? 0 : next.first),
    );
  }
}
