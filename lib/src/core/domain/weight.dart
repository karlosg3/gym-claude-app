import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

/// Representación inmutable de un peso.
/// El valor subyacente SIEMPRE se almacena en kilogramos con precisión completa.
@immutable
class Weight implements Comparable<Weight> {
  /// Construye un peso expresado en kilogramos.
  const Weight(this.value);

  /// Constructor con nombre equivalente al predeterminado.
  const Weight.kg(this.value);

  /// Valor subyacente en kilogramos.
  final double value;

  /// Valor de peso cero (0.0 kg).
  static const Weight zero = Weight(0.0);

  /// Factor de conversión estándar: 1 kg = 2.20462 lb.
  static const double lbPerKg = 2.20462;

  /// Crea un [Weight] a partir de una entrada en la unidad especificada.
  factory Weight.fromInput(double value, WeightUnit unit) {
    if (value < 0) {
      throw ArgumentError.value(
        value,
        'value',
        'El peso no puede ser negativo',
      );
    }
    return switch (unit) {
      WeightUnit.kg => Weight(value),
      WeightUnit.lb => Weight(value / lbPerKg),
    };
  }

  /// Retorna el valor exacto sin redondear en la unidad solicitada.
  double inUnit(WeightUnit unit) {
    return switch (unit) {
      WeightUnit.kg => value,
      WeightUnit.lb => value * lbPerKg,
    };
  }

  /// Retorna el valor formateado para visualización según las reglas del diseño:
  /// - kg: múltiplos de 0,5
  /// - lb: entero más cercano
  double displayValue(WeightUnit unit) {
    final v = inUnit(unit);
    return switch (unit) {
      WeightUnit.kg => (v * 2).roundToDouble() / 2,
      WeightUnit.lb => v.roundToDouble(),
    };
  }

  bool get isZero => value == 0.0;

  @override
  int compareTo(Weight other) => value.compareTo(other.value);

  bool operator <(Weight other) => value < other.value;
  bool operator <=(Weight other) => value <= other.value;
  bool operator >(Weight other) => value > other.value;
  bool operator >=(Weight other) => value >= other.value;

  Weight operator +(Weight other) => Weight(value + other.value);
  Weight operator -(Weight other) {
    final res = value - other.value;
    if (res < 0) {
      throw StateError(
        'La resta de pesos no puede resultar en un valor negativo',
      );
    }
    return Weight(res);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Weight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Weight(${value.toStringAsFixed(2)} kg)';
}
