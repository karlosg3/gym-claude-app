import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/settings/presentation/settings_providers.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/app_router.dart';

/// Widget raíz de GymClaude configurado con [MaterialApp.router],
/// tema oscuro cálido ([AppTheme.dark]) con color de acento personalizable
/// y localización en español.
class GymClaudeApp extends ConsumerWidget {
  const GymClaudeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeColor = ref.watch(themeColorProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(accentColor: themeColor),
      darkTheme: AppTheme.dark(accentColor: themeColor),
      themeMode: ThemeMode.dark,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('es'),
    );
  }
}
