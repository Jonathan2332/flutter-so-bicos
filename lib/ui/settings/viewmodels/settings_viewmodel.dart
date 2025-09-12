import 'package:flutter/material.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';

class SettingsViewmodel {
  String themeDisplayName(AppLocalizations appLocalizations, ThemeMode themeMode) {
    return switch (themeMode) {
      ThemeMode.light => appLocalizations.light_theme,
      ThemeMode.dark => appLocalizations.dark_theme,
      ThemeMode.system => appLocalizations.system_theme,
    };
  }
}