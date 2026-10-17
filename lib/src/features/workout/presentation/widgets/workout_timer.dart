import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/core/time/clock_provider.dart';
import 'package:gym_claude/src/design_system/design_system.dart';

/// Cronómetro derivado de `ahora − startedAt`: no se guarda y sobrevive a cierres de la app.
/// Es lo único que se reconstruye cada segundo.
class WorkoutTimer extends ConsumerWidget {
  const WorkoutTimer({required this.startedAt, super.key});

  final DateTime startedAt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now =
        ref.watch(tickerProvider).value ?? ref.read(clockProvider).now();
    final elapsed = now.difference(startedAt);
    return GcTimerPill(elapsed: elapsed.isNegative ? Duration.zero : elapsed);
  }
}
