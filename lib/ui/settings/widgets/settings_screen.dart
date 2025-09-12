import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locale_names/locale_names.dart';
import 'package:so_bicos/ui/designsystem/components/scaffold.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';
import 'package:so_bicos/ui/settings/viewmodels/settings_viewmodel.dart';
import 'package:so_bicos/ui/settings/widgets/settings_sections.dart';
import 'package:so_bicos/ui/settings/widgets/settings_sticker.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsViewmodel viewModel;
  const SettingsScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final List<Locale> supportedLocales = context
        .findAncestorWidgetOfExactType<MaterialApp>()
        ?.supportedLocales
        .toList() ?? [];

    final formKey = GlobalKey<FormState>();

    return SbScaffold(
      appBar: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings),
            Text(
              appLocalizations.settings,
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final section = SettingsSections.values[index];
          return Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: switch (section) {
                SettingsSections.app => {
                  SettingsSticker(
                    header: Text(
                      appLocalizations.app,
                      style: GoogleFonts.rubik(
                        textStyle: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    headerDivider: Divider(
                      height: 1,
                      color: theme.colorScheme.primary,
                    ),
                    content: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            spacing: 16,
                            children: [
                              DropdownButtonFormField<Locale>(
                                decoration: InputDecoration(
                                  labelText: appLocalizations.language,
                                  labelStyle: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                value: Localizations.localeOf(context),
                                items: supportedLocales
                                    .map(
                                      (locale) => DropdownMenuItem(
                                        value: locale,
                                        child: Text(locale.nativeDisplayLanguage),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {},
                              ),
                              DropdownButtonFormField<ThemeMode>(
                                decoration: InputDecoration(
                                  labelText: appLocalizations.theme,
                                  labelStyle: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                value: ThemeMode.system,
                                items: ThemeMode.values
                                    .map(
                                      (themeMode) => DropdownMenuItem(
                                        value: themeMode,
                                        child: Text(viewModel.themeDisplayName(appLocalizations, themeMode)),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                },
              }.first,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsetsGeometry.all(8));
        },
        itemCount: SettingsSections.values.length,
      ),
    );
  }
}
