import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';
import 'package:gym_claude/src/design_system/tokens/gc_radii.dart';

/// Estado de un segmento de [ProgressSegments].
enum SegmentState { done, current, pending }

/// Barra segmentada, un segmento por ejercicio: con series = acento, actual = acento suave,
/// pendiente = gris.
class ProgressSegments extends StatelessWidget {
  const ProgressSegments({required this.segments, super.key});

  final List<SegmentState> segments;

  static const double _height = 5;
  static const double _gap = 6;

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    return Row(
      children: [
        for (var i = 0; i < segments.length; i++) ...[
          if (i > 0) const SizedBox(width: _gap),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: _height,
              decoration: BoxDecoration(
                borderRadius: GcRadii.borderPill,
                color: switch (segments[i]) {
                  SegmentState.done => c.accent,
                  SegmentState.current => c.accentSoft,
                  SegmentState.pending => c.surfaceRaised,
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}
