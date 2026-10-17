import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/app.dart';
import 'package:gym_claude/src/core/logging/app_logger.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/l10n/l10n.dart';

/// Inicializa el entorno de ejecución de GymClaude, instala los manejadores
/// locales de error y lanza la aplicación dentro de [ProviderScope].
Future<void> bootstrapApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  final logger = AppLogger.instance;
  await logger.init();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logger.error(
      'FlutterError capturado en el framework',
      details.exception,
      details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logger.error(
      'Error asíncrono no controlado en PlatformDispatcher',
      error,
      stackTrace,
    );
    return true;
  };

  ErrorWidget.builder = (details) {
    logger.error(
      'Error al construir un widget',
      details.exception,
      details.stack,
    );
    return _BootstrapErrorView(details: details);
  };

  runApp(const ProviderScope(child: GymClaudeApp()));
}

class _BootstrapErrorView extends StatelessWidget {
  const _BootstrapErrorView({required this.details});

  final FlutterErrorDetails details;

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    final title =
        l10n?.errorUnexpectedTitle ?? 'Ha ocurrido un problema inesperado';
    const colors = GcColors();
    final text = GcTextStyles.fromColors(colors);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: ColoredBox(
        color: colors.background,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(GcSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(GcIcons.alert, size: GcIcons.sizeLg, color: colors.danger),
                const SizedBox(height: GcSpacing.md),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: text.bodyStrong,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
