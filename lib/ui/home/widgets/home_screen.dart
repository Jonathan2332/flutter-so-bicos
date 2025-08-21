import 'package:flutter/material.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';
import 'package:so_bicos/ui/home/viewmodels/home_drawer_viewmodel.dart';
import 'package:so_bicos/ui/home/viewmodels/home_viewmodel.dart';
import 'package:so_bicos/ui/home/widgets/drawer_body_categories.dart';
import 'package:so_bicos/ui/home/widgets/drawer_header_user.dart';

class HomeScreen extends StatelessWidget {
  final HomeDrawerViewModel drawerViewModel;
  final HomeViewModel viewModel;
  const HomeScreen({
    super.key,
    required this.viewModel,
    required this.drawerViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeaderUser(viewModel: drawerViewModel),
            DrawerBodyCategories(
              viewModel: drawerViewModel,
              onSelectedCategory: viewModel.loadJobs,
            ),
            ListTile(
              title: TextButton.icon(
                onPressed: () {
                  drawerViewModel.signout();
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
