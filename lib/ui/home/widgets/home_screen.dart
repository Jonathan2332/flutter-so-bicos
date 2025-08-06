import 'package:flutter/material.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';
import 'package:so_bicos/ui/home/viewmodels/home_viewmodel.dart';
import 'package:so_bicos/ui/home/widgets/drawer_header_user.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeaderUser(viewModel: viewModel),
            ListTile(
              title: TextButton.icon(
                onPressed: () {
                  viewModel.signout();
                },
                label: Text(appLocalizations.logout),
                icon: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Container(),
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: MediaQuery.viewPaddingOf(context).top,
          ),
          child: SearchAnchor.bar(
            barLeading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                );
              },
            ),
            barHintText: appLocalizations.search,
            suggestionsBuilder: (context, controller) => [],
          ),
        ),
      ),
      body: Center(),
    );
  }
}
