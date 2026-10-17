import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

/// Formateador de pesos según `07 - Reglas de Negocio.md` y `10 - Design System.md`.
/// Usa coma decimal para español (`72,5 kg`, `159 lb`).
abstract final class WeightFormatter {
  static const String noData = '—';
  static const String bodyweightLong = 'Peso corporal';
  static const String bodyweightShort = 'PC';
  static const String bodyweightMarkdown = 'BW';

  /// Formatea un número con coma decimal y sin `.0` superfluo.
  static String formatNumber(double value, {int maxDecimals = 1}) {
    if ((value - value.roundToDouble()).abs() < 0.001) {
      return value.round().toString();
    }
    return value.toStringAsFixed(maxDecimals).replaceAll('.', ',');
  }

  /// Formatea un [Weight] en la unidad del ejercicio.
  /// - Si `weight == null` => `—`
  /// - Si `isBodyweight` y `weight.isZero` => `Peso corporal` (o `PC` si `short: true`)
  /// - Si `isBodyweight` y `weight > 0` => `+10 kg`
  /// - Estándar => `72,5 kg` / `159 lb`
  static String format(
    Weight? weight,
    WeightUnit unit, {
    bool isBodyweight = false,
    bool short = false,
    bool includeUnit = true,
  }) {
    if (weight == null) return noData;

    if (isBodyweight && weight.isZero) {
      return short ? bodyweightShort : bodyweightLong;
    }

    final displayVal = weight.displayValue(unit);
    final numStr = formatNumber(displayVal);
    final prefix = isBodyweight ? '+' : '';
    final unitSuffix = includeUnit ? ' ${unit.name}' : '';
    return '$prefix$numStr$unitSuffix';
  }

  /// Formatea equivalencia en la unidad opuesta (`≈ 159 lb` o `≈ 72,5 kg`).
  static String formatEquivalence(Weight? weight, WeightUnit currentUnit) {
    if (weight == null || weight.isZero) return '';
    final otherUnit = currentUnit == WeightUnit.kg
        ? WeightUnit.lb
        : WeightUnit.kg;
    final displayVal = weight.displayValue(otherUnit);
    final numStr = formatNumber(displayVal);
    return '≈ $numStr ${otherUnit.name}';
  }

  /// Formatea volumen total en miles (`12,3k kg`).
  static String formatVolume(Weight totalVolume, WeightUnit unit) {
    final val = totalVolume.inUnit(unit);
    if (val >= 1000) {
      final thousands = val / 1000.0;
      final str = thousands.toStringAsFixed(1).replaceAll('.', ',');
      return '${str}k ${unit.name}';
    }
    return '${formatNumber(val.roundToDouble())} ${unit.name}';
  }
}
