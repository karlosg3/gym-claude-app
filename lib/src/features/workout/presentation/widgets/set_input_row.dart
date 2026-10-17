import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/l10n/l10n.dart';

/// Bloque "Nueva serie": peso (teclado decimal, unidad del ejercicio), reps y botón de añadir.
/// Tras añadir conserva los valores (repetir peso es lo habitual) y devuelve el foco a Reps.
class SetInputRow extends StatefulWidget {
  const SetInputRow({
    required this.unitLabel,
    required this.onSubmit,
    super.key,
    this.initialWeight = '',
    this.initialReps = '',
    this.errorText,
  });

  final String unitLabel;
  final String initialWeight;
  final String initialReps;
  final String? errorText;

  /// Devuelve `true` si la serie se registró.
  final Future<bool> Function(String weight, String reps) onSubmit;

  @override
  State<SetInputRow> createState() => _SetInputRowState();
}

class _SetInputRowState extends State<SetInputRow> {
  late final _weight = TextEditingController(text: widget.initialWeight);
  late final _reps = TextEditingController(text: widget.initialReps);
  final _repsFocus = FocusNode();
  bool _submitting = false;

  @override
  void dispose() {
    _weight.dispose();
    _reps.dispose();
    _repsFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting) return;
    setState(() => _submitting = true);
    final ok = await widget.onSubmit(_weight.text, _reps.text);
    if (!mounted) return;
    setState(() => _submitting = false);
    if (ok) {
      _repsFocus.requestFocus();
      _reps.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _reps.text.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.gcColors;
    final t = context.gcText;
    final hasError = widget.errorText != null;

    return GcCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.workoutNewSet.toUpperCase(),
            style: t.overline.copyWith(color: c.textMuted),
          ),
          const SizedBox(height: GcSpacing.md),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _field(
                  context,
                  key: const Key('set-input-weight'),
                  controller: _weight,
                  hint: l10n.workoutWeightHint(widget.unitLabel),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  formatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  action: TextInputAction.next,
                  onSubmitted: (_) => _repsFocus.requestFocus(),
                  hasError: false,
                ),
              ),
              const SizedBox(width: GcSpacing.md),
              Expanded(
                flex: 2,
                child: _field(
                  context,
                  key: const Key('set-input-reps'),
                  controller: _reps,
                  focusNode: _repsFocus,
                  hint: l10n.workoutRepsHint,
                  keyboardType: TextInputType.number,
                  formatters: [FilteringTextInputFormatter.digitsOnly],
                  action: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                  hasError: hasError,
                ),
              ),
              const SizedBox(width: GcSpacing.md),
              Semantics(
                button: true,
                label: l10n.workoutAddSet,
                child: Material(
                  color: c.accent,
                  borderRadius: GcRadii.borderLg,
                  child: InkWell(
                    key: const Key('set-input-submit'),
                    onTap: _submitting ? null : _submit,
                    borderRadius: GcRadii.borderLg,
                    child: SizedBox(
                      width: 56,
                      height: 52,
                      child: Icon(
                        GcIcons.check,
                        color: c.textPrimary,
                        size: GcIcons.sizeLg,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (hasError) ...[
            const SizedBox(height: GcSpacing.sm + 2),
            Text(widget.errorText!, style: t.label.copyWith(color: c.accent)),
          ],
        ],
      ),
    );
  }

  Widget _field(
    BuildContext context, {
    required Key key,
    required TextEditingController controller,
    required String hint,
    required TextInputType keyboardType,
    required List<TextInputFormatter> formatters,
    required TextInputAction action,
    required ValueChanged<String> onSubmitted,
    required bool hasError,
    FocusNode? focusNode,
  }) {
    final c = context.gcColors;
    final t = context.gcText;
    final border = OutlineInputBorder(
      borderRadius: GcRadii.borderLg,
      borderSide: BorderSide(color: hasError ? c.accent : c.border),
    );
    return TextField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      textInputAction: action,
      onSubmitted: onSubmitted,
      textAlign: TextAlign.center,
      style: t.subtitle.copyWith(color: c.textPrimary),
      cursorColor: c.accent,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: t.subtitle.copyWith(color: c.textFaint),
        filled: true,
        fillColor: c.background,
        contentPadding: const EdgeInsets.symmetric(vertical: GcSpacing.lg),
        enabledBorder: border,
        border: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: c.accent, width: 1.4),
        ),
      ),
    );
  }
}
