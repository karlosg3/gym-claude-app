import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_icons.dart';
import 'package:gym_claude/src/design_system/tokens/gc_spacing.dart';
import 'package:gym_claude/src/design_system/widgets/gc_buttons.dart';
import 'package:gym_claude/src/design_system/widgets/gc_card.dart';

/// Renderizador declarativo para `AsyncValue<T>` que garantiza que toda pantalla
/// cubra los estados de carga, error (con reintento) y datos/vacío.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    required this.value,
    required this.data,
    super.key,
    this.loading,
    this.errorTitle,
    this.retryLabel,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget? loading;
  final String? errorTitle;
  final String? retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    final t = context.gcText;

    return value.when(
      data: data,
      loading: () =>
          loading ??
          Center(
            child: Padding(
              padding: const EdgeInsets.all(GcSpacing.xxl),
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(c.accent),
              ),
            ),
          ),
      error: (err, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(GcSpacing.xl),
          child: GcCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(GcIcons.alert, size: 28, color: c.error),
                const SizedBox(height: GcSpacing.md),
                if (errorTitle != null) ...[
                  Text(
                    errorTitle!,
                    textAlign: TextAlign.center,
                    style: t.bodyStrong,
                  ),
                  const SizedBox(height: GcSpacing.xs),
                ],
                Text(
                  err.toString(),
                  textAlign: TextAlign.center,
                  style: t.caption.copyWith(color: c.textSecondary),
                ),
                if (onRetry != null && retryLabel != null) ...[
                  const SizedBox(height: GcSpacing.lg),
                  SecondaryButton(
                    label: retryLabel!,
                    icon: GcIcons.refresh,
                    onPressed: onRetry,
                    expand: false,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
