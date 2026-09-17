import 'package:flutter/material.dart';

import '../../../core/extensions/context_extensions.dart';

/// What a reviewer decided, and why.
@immutable
class Decision {
  const Decision({required this.approve, required this.note, this.reference});

  final bool approve;
  final String note;

  /// Bank or gateway reference, for a payout that was actually sent.
  final String? reference;
}

/// Collects a decision and the note that justifies it.
///
/// The note is mandatory on a rejection and optional on an approval, which
/// matches what the record is for: an approval explains itself, a refusal is
/// the thing someone will later ask about — and "why was I rejected" with an
/// empty audit note is a support ticket nobody can answer.
Future<Decision?> showDecisionDialog(
  BuildContext context, {
  required String title,
  required String subject,
  required bool approve,
  bool askForReference = false,
}) {
  return showDialog<Decision>(
    context: context,
    builder: (context) => _DecisionDialog(
      title: title,
      subject: subject,
      approve: approve,
      askForReference: askForReference,
    ),
  );
}

class _DecisionDialog extends StatefulWidget {
  const _DecisionDialog({
    required this.title,
    required this.subject,
    required this.approve,
    required this.askForReference,
  });

  final String title;
  final String subject;
  final bool approve;
  final bool askForReference;

  @override
  State<_DecisionDialog> createState() => _DecisionDialogState();
}

class _DecisionDialogState extends State<_DecisionDialog> {
  final TextEditingController _note = TextEditingController();
  final TextEditingController _reference = TextEditingController();
  bool _showNoteError = false;

  @override
  void dispose() {
    _note.dispose();
    _reference.dispose();
    super.dispose();
  }

  void _submit() {
    final note = _note.text.trim();
    if (!widget.approve && note.isEmpty) {
      setState(() => _showNoteError = true);
      return;
    }
    Navigator.of(context).pop(
      Decision(
        approve: widget.approve,
        note: note,
        reference: _reference.text.trim().isEmpty
            ? null
            : _reference.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AlertDialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Text(widget.title),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.subject,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _note,
              maxLines: 3,
              maxLength: 1000,
              autofocus: true,
              decoration: InputDecoration(
                labelText: widget.approve ? 'Note (optional)' : 'Reason',
                hintText: widget.approve
                    ? 'Anything the next reviewer should know'
                    : 'What has to change before this can be approved',
                errorText: _showNoteError ? 'A rejection needs a reason' : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) {
                if (_showNoteError) setState(() => _showNoteError = false);
              },
            ),
            if (widget.askForReference && widget.approve) ...[
              const SizedBox(height: 8),
              TextField(
                controller: _reference,
                maxLength: 120,
                decoration: const InputDecoration(
                  labelText: 'Bank / gateway reference',
                  hintText: 'So this payment can be traced later',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submit,
          style: FilledButton.styleFrom(
            backgroundColor: widget.approve ? colors.success : colors.error,
          ),
          child: Text(widget.approve ? 'Approve' : 'Reject'),
        ),
      ],
    );
  }
}
