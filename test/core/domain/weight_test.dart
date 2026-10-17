import 'package:flutter_test/flutter_test.dart';
import 'package:gym_claude/src/core/domain/weight.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';

void main() {
  group('Weight', () {
    test('almacena siempre el valor en kg con precisión completa', () {
      const w = Weight.kg(72.3456);
      expect(w.value, 72.3456);
    });

    test('Weight.fromInput convierte correctamente libras a kilogramos', () {
      final wKg = Weight.fromInput(80.0, WeightUnit.kg);
      expect(wKg.value, 80.0);

      // 100 lb / 2.20462 = 45.35929... kg
      final wLb = Weight.fromInput(100.0, WeightUnit.lb);
      expect(wLb.value, closeTo(45.35929, 0.0001));
    });

    test('Weight.fromInput rechaza pesos negativos', () {
      expect(() => Weight.fromInput(-5.0, WeightUnit.kg), throwsArgumentError);
    });

    test('inUnit devuelve valor exacto sin redondear', () {
      const w = Weight.kg(50.0);
      expect(w.inUnit(WeightUnit.kg), 50.0);
      expect(w.inUnit(WeightUnit.lb), closeTo(110.231, 0.001));
    });

    test('displayValue redondea kg a múltiplos de 0.5', () {
      expect(const Weight.kg(72.1).displayValue(WeightUnit.kg), 72.0);
      expect(const Weight.kg(72.24).displayValue(WeightUnit.kg), 72.0);
      expect(const Weight.kg(72.26).displayValue(WeightUnit.kg), 72.5);
      expect(const Weight.kg(72.74).displayValue(WeightUnit.kg), 72.5);
      expect(const Weight.kg(72.76).displayValue(WeightUnit.kg), 73.0);
    });

    test('displayValue redondea lb al entero más cercano', () {
      // 72 kg ≈ 158.73 lb -> 159 lb
      expect(const Weight.kg(72.0).displayValue(WeightUnit.lb), 159.0);
      // 45.359 kg (100 lb) -> 100 lb
      final w = Weight.fromInput(100.0, WeightUnit.lb);
      expect(w.displayValue(WeightUnit.lb), 100.0);
    });

    test('comparaciones y operadores de orden', () {
      const w1 = Weight.kg(50.0);
      const w2 = Weight.kg(75.0);
      const w3 = Weight.kg(75.0);

      expect(w1 < w2, isTrue);
      expect(w1 <= w2, isTrue);
      expect(w2 > w1, isTrue);
      expect(w2 >= w1, isTrue);
      expect(w2 == w3, isTrue);
      expect(w1.compareTo(w2), isNegative);
    });

    test('operaciones aritméticas suma y resta', () {
      const w1 = Weight.kg(50.0);
      const w2 = Weight.kg(25.0);

      expect(w1 + w2, const Weight.kg(75.0));
      expect(w1 - w2, const Weight.kg(25.0));

      expect(() => w2 - w1, throwsStateError);
    });

    test('cero y isZero', () {
      expect(Weight.zero.value, 0.0);
      expect(Weight.zero.isZero, isTrue);
      expect(const Weight.kg(0.0).isZero, isTrue);
      expect(const Weight.kg(0.5).isZero, isFalse);
    });
  });
}
