import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gym_claude/src/design_system/theme/app_theme.dart';

/// Modo de [StreakFlame].
enum FlameMode {
  /// Apagada: contorno discontinuo.
  off,

  /// Encendida con parpadeo continuo.
  lit,

  /// Pasa de apagada a encendida con rebote y halo; después queda en [lit].
  ignite,
}

/// Llama de la racha (`10 - Design System` → Animaciones).
/// Con `MediaQuery.disableAnimations` se muestra directamente encendida, sin movimiento.
class StreakFlame extends StatefulWidget {
  const StreakFlame({required this.mode, super.key, this.size = 120});

  final FlameMode mode;
  final double size;

  @override
  State<StreakFlame> createState() => _StreakFlameState();
}

class _StreakFlameState extends State<StreakFlame>
    with TickerProviderStateMixin {
  late final AnimationController _ignite = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );
  late final AnimationController _flicker = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1700),
  );

  bool get _reduceMotion => MediaQuery.of(context).disableAnimations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync(restartIgnite: !_ignite.isAnimating && _ignite.value == 0);
  }

  @override
  void didUpdateWidget(StreakFlame oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode != widget.mode) {
      _sync(restartIgnite: widget.mode == FlameMode.ignite);
    }
  }

  void _sync({required bool restartIgnite}) {
    if (_reduceMotion || widget.mode == FlameMode.off) {
      _flicker.stop();
      _ignite.value = widget.mode == FlameMode.off ? 0 : 1;
      return;
    }
    if (widget.mode == FlameMode.lit) {
      _ignite.value = 1;
      _flicker.repeat();
      return;
    }
    if (restartIgnite) {
      _ignite.forward(from: 0).whenComplete(() {
        if (mounted) _flicker.repeat();
      });
    }
  }

  @override
  void dispose() {
    _ignite.dispose();
    _flicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.gcColors;
    return SizedBox.square(
      dimension: widget.size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_ignite, _flicker]),
        builder: (context, _) {
          final t = _ignite.value;
          final offOpacity = 1 - const Interval(0, 0.35).transform(t);
          final grow = Curves.elasticOut.transform(
            const Interval(0.25, 1).transform(t),
          );
          final halo = const Interval(0.45, 1).transform(t);
          final phase = _flicker.value * 2 * math.pi;
          final flickerScale = _flicker.isAnimating
              ? 1 + 0.03 * math.sin(phase)
              : 1.0;
          final tilt = _flicker.isAnimating ? 0.025 * math.sin(phase * 2) : 0.0;

          return CustomPaint(
            painter: _FlamePainter(
              outer: c.accent,
              inner: c.flameInner,
              offColor: c.textFaint,
              offOpacity: offOpacity,
              litScale: grow * flickerScale,
              tilt: tilt,
              haloOpacity: halo * (0.85 + 0.15 * math.sin(phase)),
            ),
          );
        },
      ),
    );
  }
}

class _FlamePainter extends CustomPainter {
  _FlamePainter({
    required this.outer,
    required this.inner,
    required this.offColor,
    required this.offOpacity,
    required this.litScale,
    required this.tilt,
    required this.haloOpacity,
  });

  final Color outer;
  final Color inner;
  final Color offColor;
  final double offOpacity;
  final double litScale;
  final double tilt;
  final double haloOpacity;

  /// Llama en una caja unitaria, con la base en (0.5, 1).
  static Path _flame(Size box) {
    final w = box.width;
    final h = box.height;
    return Path()
      ..moveTo(0.52 * w, 0)
      ..cubicTo(0.70 * w, 0.22 * h, 0.98 * w, 0.40 * h, 0.96 * w, 0.66 * h)
      ..cubicTo(0.94 * w, 0.88 * h, 0.74 * w, h, 0.50 * w, h)
      ..cubicTo(0.24 * w, h, 0.04 * w, 0.86 * h, 0.04 * w, 0.64 * h)
      ..cubicTo(0.04 * w, 0.48 * h, 0.14 * w, 0.38 * h, 0.26 * w, 0.32 * h)
      ..cubicTo(0.24 * w, 0.44 * h, 0.30 * w, 0.54 * h, 0.40 * w, 0.56 * h)
      ..cubicTo(0.36 * w, 0.36 * h, 0.40 * w, 0.16 * h, 0.52 * w, 0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final flameSize = Size(size.width * 0.5, size.height * 0.62);
    final origin = Offset(
      (size.width - flameSize.width) / 2,
      (size.height - flameSize.height) / 2,
    );
    final base = origin + Offset(flameSize.width / 2, flameSize.height);
    final path = _flame(flameSize).shift(origin);

    if (haloOpacity > 0) {
      final center = size.center(Offset.zero);
      canvas.drawCircle(
        center,
        size.width / 2,
        Paint()
          ..shader =
              RadialGradient(
                colors: [
                  outer.withValues(alpha: 0.28 * haloOpacity),
                  outer.withValues(alpha: 0),
                ],
              ).createShader(
                Rect.fromCircle(center: center, radius: size.width / 2),
              ),
      );
    }

    if (offOpacity > 0) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.035
        ..strokeCap = StrokeCap.round
        ..color = offColor.withValues(alpha: offOpacity);
      for (final metric in path.computeMetrics()) {
        final dash = size.width * 0.06;
        for (var d = 0.0; d < metric.length; d += dash * 1.9) {
          canvas.drawPath(metric.extractPath(d, d + dash), paint);
        }
      }
    }

    if (litScale > 0) {
      canvas
        ..save()
        ..translate(base.dx, base.dy)
        ..rotate(tilt)
        ..scale(litScale)
        ..translate(-base.dx, -base.dy);
      canvas.drawPath(path, Paint()..color = outer);

      final innerSize = Size(flameSize.width * 0.5, flameSize.height * 0.5);
      final innerOrigin = Offset(
        base.dx - innerSize.width / 2,
        base.dy - innerSize.height - flameSize.height * 0.04,
      );
      canvas.drawPath(
        _flame(innerSize).shift(innerOrigin),
        Paint()..color = inner,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_FlamePainter old) =>
      old.offOpacity != offOpacity ||
      old.litScale != litScale ||
      old.tilt != tilt ||
      old.haloOpacity != haloOpacity ||
      old.outer != outer ||
      old.inner != inner ||
      old.offColor != offColor;
}
