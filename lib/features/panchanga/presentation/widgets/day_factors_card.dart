import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/services/day_factors.dart';
import '../../domain/services/panchanga_names.dart';
import '../cubit/day_periods_cubit.dart';
import '../l10n/panchanga_strings.dart';

/// Season, half-year, the direction not to travel in — and, once a birth star
/// is known, tara bala, chandra bala and whether today is chandrashtama.
///
/// The impersonal factors always show. The personal three appear only after
/// the reader names their birth star: counting them from an assumed star would
/// produce a confident answer for the wrong person.
class DayFactorsCard extends StatelessWidget {
  const DayFactorsCard({required this.state, super.key});

  final DayPeriodsState state;

  @override
  Widget build(BuildContext context) {
    final s = PanchangaStrings.of(context);
    final tara = state.tara;
    final chandraBala = state.chandraBala;
    final chandrashtama = state.isChandrashtama;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Row(label: s.ritu, value: s.rituLabel(state.ritu), tinted: true),
        _Row(label: s.ayana, value: s.ayanaLabel(state.ayana)),
        _Row(
          label: s.dishaShool,
          value: s.dishaLabel(state.dishaShool),
          quality: DayQuality.bad,
          tinted: true,
        ),
        if (tara != null && chandraBala != null && chandrashtama != null) ...[
          // The tara's name means nothing to a reader who is not an
          // astrologer, and the colour alone does not say it either. Both the
          // name and what it amounts to.
          _Row(
            label: s.taraBala,
            value: '${s.taraLabel(tara)} · ${s.dayQualityLabel(tara.quality)}',
            quality: tara.quality,
          ),
          _Row(
            label: s.chandraBala,
            value: '${s.houseLabel(state.moonHouse!)} · '
                '${s.dayQualityLabel(chandraBala)}',
            quality: chandraBala,
            tinted: true,
          ),
          _Row(
            label: s.chandrashtama,
            value: chandrashtama
                ? s.chandrashtamaToday
                : s.chandrashtamaNotToday,
            quality: chandrashtama ? DayQuality.bad : DayQuality.good,
          ),
        ],
        _BirthStarPrompt(state: state),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.quality,
    this.tinted = false,
  });

  final String label;
  final String value;
  final DayQuality? quality;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;
    final tint = switch (quality) {
      DayQuality.good => colors.success,
      DayQuality.bad => colors.holiday,
      DayQuality.mixed => colors.textMuted,
      null => colors.textPrimary,
    };
    return Container(
      color: tinted ? colors.chipBackground : Colors.transparent,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: text.labelMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: text.labelMedium?.copyWith(
                color: tint,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Asks for the one fact the personal factors need, and explains why.
///
/// Stateful on purpose. The two boxes are filled one after the other, and
/// nothing can be computed from the first alone — so the pending half has to
/// live somewhere until the second arrives. Holding it only in the stored
/// value meant neither box ever completed the pair, and picking a star did
/// nothing at all.
class _BirthStarPrompt extends StatefulWidget {
  const _BirthStarPrompt({required this.state});

  final DayPeriodsState state;

  @override
  State<_BirthStarPrompt> createState() => _BirthStarPromptState();
}

class _BirthStarPromptState extends State<_BirthStarPrompt> {
  int? _star;
  int? _pada;

  @override
  void initState() {
    super.initState();
    _star = widget.state.birthStar;
    _pada = widget.state.birthPada == null
        ? null
        : widget.state.birthPada! % 4 + 1;
  }

  @override
  void didUpdateWidget(_BirthStarPrompt old) {
    super.didUpdateWidget(old);
    // Follow a value saved elsewhere, but never wipe a half-made choice.
    final pada = widget.state.birthPada;
    if (pada != null && pada != old.state.birthPada) {
      _star = pada ~/ 4;
      _pada = pada % 4 + 1;
    }
  }

  InputDecoration _decoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(borderRadius: AppRadius.input),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
  );

  void _choose({int? star, int? pada}) {
    setState(() {
      _star = star ?? _star;
      _pada = pada ?? _pada;
    });
    final s = _star;
    final p = _pada;
    if (s == null || p == null) return;
    context.read<DayPeriodsCubit>().setBirthStar(nakshatra: s, pada: p);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final s = PanchangaStrings.of(context);
    final nepali = context.isNepali || context.isHindi;
    final names = nepali
        ? PanchangaNames.nakshatraNe
        : PanchangaNames.nakshatraEn;
    final incomplete = _star == null || _pada == null;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // Once it is answered the sentence becomes a reminder of what the
            // three rows above are counted from.
            incomplete ? s.birthStarWhy : s.birthStarSet,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: DropdownButtonFormField<int>(
                  initialValue: _star,
                  isExpanded: true,
                  decoration: _decoration(s.birthStar),
                  hint: Text(s.setBirthStar),
                  items: [
                    for (var i = 0; i < names.length; i++)
                      DropdownMenuItem(value: i, child: Text(names[i])),
                  ],
                  onChanged: (i) => _choose(star: i),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<int>(
                  initialValue: _pada,
                  isExpanded: true,
                  decoration: _decoration(s.pada),
                  items: [
                    for (var p = 1; p <= 4; p++)
                      DropdownMenuItem(value: p, child: Text('$p')),
                  ],
                  onChanged: (p) => _choose(pada: p),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
