import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/injection.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/status_chip.dart';
import '../../domain/entities/feature_flag.dart';
import '../../motion/motion.dart';
import '../../shell/widgets/console_page.dart';
import '../../shell/widgets/console_panel.dart';
import 'cubit/flags_cubit.dart';

/// Feature flags and staged rollouts.
class FlagsPage extends StatelessWidget {
  const FlagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FlagsCubit>()..load(),
      child: const _FlagsView(),
    );
  }
}

class _FlagsView extends StatelessWidget {
  const _FlagsView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FlagsCubit>();

    return BlocBuilder<FlagsCubit, FlagsState>(
      builder: (context, state) {
        return ConsolePage(
          title: 'Feature flags',
          subtitle:
              'Changes here reach every app within seconds. There is no staging step.',
          onRefresh: cubit.load,
          banner: state.actionError,
          child: LoadStateView<List<FeatureFlag>>(
            state: state.flags,
            onRetry: cubit.load,
            isEmpty: (items) => items.isEmpty,
            emptyMessage: 'No flags are defined',
            emptyIcon: Icons.toggle_off_outlined,
            builder: (context, items) => Column(
              children: [
                for (final (index, flag) in items.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Reveal(
                      delay: Motion.stagger(index),
                      child: _FlagRow(
                        flag: flag,
                        busy: state.isSaving(flag.key),
                        onToggle: () => cubit.toggle(flag),
                        onRollout: (pct) => cubit.setRollout(flag, pct),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FlagRow extends StatefulWidget {
  const _FlagRow({
    required this.flag,
    required this.busy,
    required this.onToggle,
    required this.onRollout,
  });

  final FeatureFlag flag;
  final bool busy;
  final VoidCallback onToggle;
  final ValueChanged<int> onRollout;

  @override
  State<_FlagRow> createState() => _FlagRowState();
}

class _FlagRowState extends State<_FlagRow> {
  /// Local while a drag is in progress, so the slider tracks the thumb rather
  /// than snapping back to the server's value on every frame.
  double? _dragging;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final flag = widget.flag;
    final rollout = _dragging ?? flag.rolloutPct.toDouble();

    return ConsolePanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: SelectableText(
                            flag.key,
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        if (flag.region != null) ...[
                          const SizedBox(width: 8),
                          StatusChip(
                            label: flag.region!,
                            dense: true,
                            tone: StatusTone.info,
                          ),
                        ],
                      ],
                    ),
                    if (flag.description.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        flag.description,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (widget.busy)
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else
                Switch(value: flag.enabled, onChanged: (_) => widget.onToggle()),
            ],
          ),
          if (flag.enabled) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Rollout',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: rollout,
                    max: 100,
                    divisions: 20,
                    label: '${rollout.round()}%',
                    onChanged: widget.busy
                        ? null
                        : (value) => setState(() => _dragging = value),
                    // Committed on release, not on every tick: a slider that
                    // fires a write per frame would hammer the API and race
                    // its own responses.
                    onChangeEnd: (value) {
                      setState(() => _dragging = null);
                      widget.onRollout(value.round());
                    },
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: Text(
                    '${rollout.round()}%',
                    textAlign: TextAlign.end,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (flag.rolloutPct == 0)
              Text(
                // Enabled at 0% is a real and confusing state: the flag is on,
                // and nobody has it. Saying so prevents a bug report.
                'On, but nobody is in the rollout yet',
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.warning,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
