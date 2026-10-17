import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_icons.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';

/// Campo de búsqueda estilizado según el diseño (fondo `surface`, borde `border`,
/// radio 14 dp, icono de búsqueda y botón para borrar texto).
class GcSearchField extends StatefulWidget {
  const GcSearchField({
    required this.hintText,
    this.initialValue = '',
    this.onChanged,
    this.focusNode,
    super.key,
  });

  final String hintText;
  final String initialValue;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  @override
  State<GcSearchField> createState() => _GcSearchFieldState();
}

class _GcSearchFieldState extends State<GcSearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant GcSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final textStyles = context.gcText;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(GcRadii.md),
      ),
      padding: const EdgeInsets.symmetric(horizontal: GcSpacing.md),
      child: Row(
        children: [
          Icon(
            GcIcons.search,
            size: GcIcons.sizeSm + 2,
            color: colors.textFaint,
          ),
          const SizedBox(width: GcSpacing.sm + 2),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: widget.focusNode,
              onChanged: (val) {
                widget.onChanged?.call(val);
                setState(() {});
              },
              style: textStyles.body.copyWith(
                fontWeight: FontWeight.w500,
                color: colors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: textStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.textMuted,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: GcSpacing.md,
                ),
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: _clear,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(GcSpacing.xs),
                child: Icon(
                  GcIcons.close,
                  size: GcIcons.sizeSm,
                  color: colors.textSecondary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
