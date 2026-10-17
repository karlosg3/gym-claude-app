import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final libSrcDir = Directory('lib/src');

  List<File> dartFilesIn(Directory dir) {
    if (!dir.existsSync()) return const [];
    return dir
        .listSync(recursive: true)
        .whereType<File>()
        .where(
          (f) =>
              f.path.endsWith('.dart') &&
              !f.path.endsWith('.g.dart') &&
              !f.path.endsWith('.freezed.dart') &&
              !f.path.endsWith('.drift.dart') &&
              !f.path.contains('/l10n/generated/'),
        )
        .toList();
  }

  List<String> extractImports(File file) {
    final lines = file.readAsLinesSync();
    final importRegex = RegExp("^\\s*import\\s+['\"]([^'\"]+)['\"]");
    final imports = <String>[];
    for (final line in lines) {
      final match = importRegex.firstMatch(line);
      if (match != null) {
        imports.add(match.group(1)!);
      }
    }
    return imports;
  }

  String normalizePath(String path) => path.replaceAll('\\', '/');

  group('Fronteras de arquitectura (12 - Testing y Calidad)', () {
    test('domain/ nunca importa flutter, drift ni riverpod', () {
      final violations = <String>[];
      for (final file in dartFilesIn(libSrcDir)) {
        final path = normalizePath(file.path);
        if (!path.contains('/domain/')) continue;

        for (final imp in extractImports(file)) {
          if (imp.startsWith('package:flutter/') ||
              imp.startsWith('package:flutter_') ||
              imp.startsWith('package:drift') ||
              imp.startsWith('package:riverpod') ||
              imp.contains('/data/') ||
              imp.contains('/application/') ||
              imp.contains('/presentation/')) {
            violations.add('$path -> $imp');
          }
        }
      }
      expect(violations, isEmpty, reason: violations.join('\n'));
    });

    test('presentation/ nunca importa drift ni data/', () {
      final violations = <String>[];
      for (final file in dartFilesIn(libSrcDir)) {
        final path = normalizePath(file.path);
        if (!path.contains('/presentation/')) continue;

        for (final imp in extractImports(file)) {
          if (imp.startsWith('package:drift') || imp.contains('/data/')) {
            violations.add('$path -> $imp');
          }
        }
      }
      expect(violations, isEmpty, reason: violations.join('\n'));
    });

    test('un feature nunca importa presentation/ ni data/ de otro feature', () {
      final featureRegex = RegExp(r'lib/src/features/([^/]+)/');
      final importFeatureRegex = RegExp(
        r'package:gym_claude/src/features/([^/]+)/(data|presentation)/',
      );
      final violations = <String>[];

      for (final file in dartFilesIn(libSrcDir)) {
        final path = normalizePath(file.path);
        final ownerMatch = featureRegex.firstMatch(path);
        if (ownerMatch == null) continue;
        final ownerFeature = ownerMatch.group(1)!;

        for (final imp in extractImports(file)) {
          final targetMatch = importFeatureRegex.firstMatch(imp);
          if (targetMatch != null) {
            final targetFeature = targetMatch.group(1)!;
            if (targetFeature != ownerFeature) {
              violations.add('$path ($ownerFeature) -> $imp');
            }
          }
        }
      }
      expect(violations, isEmpty, reason: violations.join('\n'));
    });

    test('application/, domain/ y data/ nunca importan integrations/', () {
      final violations = <String>[];
      for (final file in dartFilesIn(libSrcDir)) {
        final path = normalizePath(file.path);
        final isRestrictedLayer =
            path.contains('/domain/') ||
            path.contains('/data/') ||
            path.contains('/application/');
        if (!isRestrictedLayer) continue;

        for (final imp in extractImports(file)) {
          if (imp.contains('/integrations/')) {
            violations.add('$path -> $imp');
          }
        }
      }
      expect(violations, isEmpty, reason: violations.join('\n'));
    });

    test('archivos *_calculator|_detector|_planner|_builder|_renderer.dart solo importan Dart puro o domain', () {
      final pureFileRegex = RegExp(
        r'_(calculator|detector|planner|builder|renderer)\.dart$',
      );
      final violations = <String>[];

      for (final file in dartFilesIn(libSrcDir)) {
        final path = normalizePath(file.path);
        if (!pureFileRegex.hasMatch(path)) continue;

        for (final imp in extractImports(file)) {
          final allowed =
              imp.startsWith('dart:') ||
              imp.startsWith('package:clock/') ||
              imp.startsWith('package:collection/') ||
              imp.startsWith('package:meta/') ||
              imp.startsWith('package:freezed_annotation/') ||
              imp.contains('/domain/');
          if (!allowed) {
            violations.add('$path -> $imp');
          }
        }
      }
      expect(violations, isEmpty, reason: violations.join('\n'));
    });

    test('ningún archivo fuera de gc_icons.dart importa lucide_icons_flutter directamente', () {
      final violations = <String>[];
      for (final file in dartFilesIn(libSrcDir)) {
        final path = normalizePath(file.path);
        if (path.endsWith('/gc_icons.dart')) continue;

        for (final imp in extractImports(file)) {
          if (imp.startsWith('package:lucide_icons_flutter/')) {
            violations.add('$path -> $imp');
          }
        }
      }
      expect(violations, isEmpty, reason: violations.join('\n'));
    });
  });
}
