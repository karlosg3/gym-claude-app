import 'package:flutter/widgets.dart';
import 'package:gym_claude/src/l10n/generated/app_localizations.dart';

export 'generated/app_localizations.dart';

/// Extensión de conveniencia para acceder a `AppLocalizations` mediante `context.l10n`.
extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
