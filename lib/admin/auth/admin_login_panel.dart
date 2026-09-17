import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/extensions/context_extensions.dart';
import '../motion/motion.dart';
import 'cubit/admin_auth_cubit.dart';

/// Staff sign-in form.
///
/// Shown [embedded] on the console's `/sign-in` page — the public front door
/// is the static landing site (`landing/`), which links there — and still
/// usable as a drawer where a page wants it to slide in over its content.
/// Brute-forcing is the server's problem either way: codes are rate-limited
/// and only allow-listed numbers can sign in.
///
/// Phone OTP only. Google and Apple are refused by the server in this
/// deployment, and offering a button that always fails is worse than not
/// offering it.
class AdminLoginPanel extends StatefulWidget {
  const AdminLoginPanel({super.key, this.embedded = false});

  /// Renders the bare form (no drawer chrome, no close button) for a page to
  /// place itself.
  final bool embedded;

  @override
  State<AdminLoginPanel> createState() => _AdminLoginPanelState();
}

class _AdminLoginPanelState extends State<AdminLoginPanel> {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _code = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final form = BlocBuilder<AdminAuthCubit, AdminAuthState>(
      builder: (context, state) {
        final cubit = context.read<AdminAuthCubit>();

        return ListView(
          shrinkWrap: widget.embedded,
          // Embedded, the page around it scrolls.
          physics: widget.embedded
              ? const NeverScrollableScrollPhysics()
              : null,
          padding: const EdgeInsets.fromLTRB(28, 32, 28, 32),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Staff sign in',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                if (!widget.embedded)
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Close',
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'For moderators, finance and support. Everyone else uses the app.',
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),

            if (state.isSignedInWithoutAccess)
              _Notice(
                icon: Icons.lock_person_rounded,
                tone: colors.warning,
                title: 'This account is not staff',
                body:
                    'You are signed in, but this number holds no staff role. '
                    'Ask a superAdmin to grant one, then sign in again.',
                action: TextButton(
                  onPressed: cubit.signOut,
                  child: const Text('Use a different number'),
                ),
              )
            else ...[
              _PhoneField(
                controller: _phone,
                enabled: !state.awaitingCode && !state.busy,
                onChanged: cubit.setPhone,
                onSubmit: cubit.requestCode,
              ),
              const SizedBox(height: 16),

              if (state.awaitingCode) ...[
                _CodeField(
                  controller: _code,
                  enabled: !state.busy,
                  onSubmit: () => cubit.verify(_code.text),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: state.busy
                        ? null
                        : () {
                            _code.clear();
                            cubit.changeNumber();
                          },
                    child: Text('Change number (${state.phone})'),
                  ),
                ),
              ] else
                _RegionPicker(region: state.region, onChanged: cubit.setRegion),

              if (state.errorMessage != null) ...[
                const SizedBox(height: 16),
                _Notice(
                  icon: Icons.error_outline_rounded,
                  tone: colors.error,
                  title: 'Could not sign in',
                  body: state.errorMessage!,
                ),
              ],

              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: state.busy
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: MagneticButton(
                          label: state.awaitingCode
                              ? 'Verify and continue'
                              : 'Send me a code',
                          icon: state.awaitingCode
                              ? Icons.login_rounded
                              : Icons.sms_rounded,
                          onPressed: state.awaitingCode
                              ? () => cubit.verify(_code.text)
                              : cubit.requestCode,
                        ),
                      ),
              ),
            ],

            const SizedBox(height: 40),
            Divider(color: colors.divider),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.shield_outlined, size: 16, color: colors.textMuted),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Sign-in is limited to numbers an administrator has enabled. '
                    'Every action you take in the console is recorded against '
                    'your account in the audit log.',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textMuted,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (widget.embedded) return form;
    return Drawer(
      width: 420,
      backgroundColor: colors.surface,
      child: SafeArea(child: form),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({
    required this.controller,
    required this.enabled,
    required this.onChanged,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      autofocus: true,
      keyboardType: TextInputType.phone,
      // The server only accepts E.164, so the field only accepts its alphabet
      // — catching it here beats a round trip to be told about a space.
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))],
      onChanged: onChanged,
      onSubmitted: (_) => onSubmit(),
      decoration: const InputDecoration(
        labelText: 'Phone number',
        hintText: '+9779812345678',
        helperText: 'With the country code',
        prefixIcon: Icon(Icons.phone_rounded),
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _CodeField extends StatelessWidget {
  const _CodeField({
    required this.controller,
    required this.enabled,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool enabled;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      autofocus: true,
      keyboardType: TextInputType.number,
      maxLength: 8,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onSubmitted: (_) => onSubmit(),
      style: const TextStyle(letterSpacing: 8, fontWeight: FontWeight.w700),
      decoration: const InputDecoration(
        labelText: 'Verification code',
        counterText: '',
        prefixIcon: Icon(Icons.password_rounded),
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _RegionPicker extends StatelessWidget {
  const _RegionPicker({required this.region, required this.onChanged});

  final String region;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Region',
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        const SizedBox(width: 12),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'NP', label: Text('Nepal')),
            ButtonSegment(value: 'IN', label: Text('India')),
          ],
          selected: {region},
          showSelectedIcon: false,
          onSelectionChanged: (selection) => onChanged(selection.first),
        ),
      ],
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({
    required this.icon,
    required this.tone,
    required this.title,
    required this.body,
    this.action,
  });

  final IconData icon;
  final Color tone;
  final String title;
  final String body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.10),
        border: Border.all(color: tone.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: tone),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: tone,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(body, style: context.textTheme.bodySmall?.copyWith(height: 1.5)),
          ?action,
        ],
      ),
    );
  }
}
