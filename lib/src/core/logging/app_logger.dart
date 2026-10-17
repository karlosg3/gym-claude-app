import 'dart:async';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

enum LogLevel { debug, info, warning, error }

/// Logger local rotativo que guarda errores y eventos relevantes exclusivamente
/// en el almacenamiento local del dispositivo. Nunca envía datos al exterior.
class AppLogger {
  AppLogger._();
  static final AppLogger instance = AppLogger._();

  File? _logFile;
  final List<String> _memoryLogs = [];
  static const int _maxMemoryLogs = 200;
  static const int _maxFileSizeBytes = 1024 * 1024; // 1 MB

  Future<void> init() async {
    try {
      final dir = await getApplicationSupportDirectory();
      _logFile = File('${dir.path}/gymclaude_app.log');
      await _rotateIfNeeded();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error al inicializar AppLogger: $e');
      }
    }
  }

  void debug(String message) => _log(LogLevel.debug, message);
  void info(String message) => _log(LogLevel.info, message);
  void warning(String message, [Object? error, StackTrace? stackTrace]) =>
      _log(LogLevel.warning, message, error, stackTrace);
  void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _log(LogLevel.error, message, error, stackTrace);

  void _log(
    LogLevel level,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    final now = clock.now().toIso8601String();
    final levelStr = level.name.toUpperCase().padRight(7);
    var entry = '[$now] $levelStr: $message';
    if (error != null) {
      entry += '\n  Error: $error';
    }
    if (stackTrace != null) {
      entry += '\n  StackTrace: $stackTrace';
    }

    if (kDebugMode) {
      debugPrint(entry);
    }

    _memoryLogs.add(entry);
    if (_memoryLogs.length > _maxMemoryLogs) {
      _memoryLogs.removeAt(0);
    }

    _writeEntryToFile(entry);
  }

  void _writeEntryToFile(String entry) {
    if (_logFile == null) return;
    try {
      _logFile!.writeAsStringSync(
        '$entry\n',
        mode: FileMode.append,
        flush: false,
      );
    } catch (_) {
      // Ignorar fallos de escritura de logs
    }
  }

  Future<void> _rotateIfNeeded() async {
    if (_logFile == null || !await _logFile!.exists()) return;
    try {
      final length = await _logFile!.length();
      if (length > _maxFileSizeBytes) {
        final backupFile = File('${_logFile!.path}.old');
        if (await backupFile.exists()) {
          await backupFile.delete();
        }
        await _logFile!.rename(backupFile.path);
        _logFile = File(_logFile!.path);
      }
    } catch (_) {}
  }

  List<String> get recentLogs => List.unmodifiable(_memoryLogs);

  Future<String> readFullLog() async {
    if (_logFile != null && await _logFile!.exists()) {
      try {
        return await _logFile!.readAsString();
      } catch (_) {}
    }
    return _memoryLogs.join('\n');
  }
}
