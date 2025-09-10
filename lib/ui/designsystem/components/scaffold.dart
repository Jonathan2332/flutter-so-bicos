import 'package:flutter/material.dart';
import 'package:so_bicos/routing/routes.dart';
import 'package:so_bicos/ui/designsystem/components/app_bar.dart';
import 'package:so_bicos/ui/designsystem/components/navigation_bar.dart';
import 'package:so_bicos/ui/designsystem/components/navigation_destination.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';

class SbScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? drawer;
  final Widget? appBar;
  final Widget? floatingActionButton;
  const SbScaffold({super.key, this.body, this.drawer, this.appBar, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final navDestinations = [
      SbNavigationDestination(
        icon: Icon(Icons.home),
        label: appLocalizations.home,
        route: Routes.home,
      ),
      SbNavigationDestination(
        icon: Icon(Icons.account_circle_sharp),
        label: appLocalizations.profile,
        route: Routes.profile,
      ),
      SbNavigationDestination(
        icon: Icon(Icons.settings),
        label: appLocalizations.settings,
        route: Routes.settings,
      ),
    ];

    return Scaffold(
      drawer: drawer,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: SbAppBar(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top + kToolbarHeight,
        ),
        flexibleSpace: appBar,
      ),
      floatingActionButton: SbNavigationBar(navDestinations: navDestinations),
      body: body,
    );
  }
}
