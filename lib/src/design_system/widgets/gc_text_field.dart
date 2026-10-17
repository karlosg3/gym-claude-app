import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

/// Campo de texto del Design System con etiqueta superior y mensaje de error inline debajo.
class GcTextField extends StatelessWidget {
  const GcTextField({
    super.key,
    this.label,
    this.hintText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.maxLines = 1,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.suffix,
  });

  final String? label;
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!.toUpperCase(),
            style: t.overline.copyWith(color: c.textSecondary),
          ),
          const SizedBox(height: GcSpacing.sm),
        ],
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          autofocus: autofocus,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: t.body.copyWith(color: c.textPrimary),
          cursorColor: c.accent,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: t.body.copyWith(color: c.textFaint),
            filled: true,
            fillColor: c.surfaceSunken,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: GcSpacing.lg,
              vertical: GcSpacing.md + 2,
            ),
            suffixIcon: suffix,
            enabledBorder: OutlineInputBorder(
              borderRadius: GcRadii.borderLg,
              borderSide: BorderSide(color: hasError ? c.error : c.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: GcRadii.borderLg,
              borderSide: BorderSide(
                color: hasError ? c.error : c.accent,
                width: 1.4,
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: GcSpacing.xs + 2),
          Text(
            errorText!,
            style: t.caption.copyWith(color: c.error),
          ),
        ],
      ],
    );
  }
}
