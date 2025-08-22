import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';
import 'package:so_bicos/ui/home/home_view_state.dart';
import 'package:so_bicos/ui/home/viewmodels/home_drawer_viewmodel.dart';
import 'package:so_bicos/ui/home/viewmodels/home_viewmodel.dart';
import 'package:so_bicos/ui/home/widgets/drawer_body_categories.dart';
import 'package:so_bicos/ui/home/widgets/drawer_header_user.dart';

class HomeScreen extends StatefulWidget {
  final HomeDrawerViewModel drawerViewModel;
  final HomeViewModel viewModel;
  const HomeScreen({
    super.key,
    required this.viewModel,
    required this.drawerViewModel,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadJobs(null);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeaderUser(viewModel: widget.drawerViewModel),
            DrawerBodyCategories(
              viewModel: widget.drawerViewModel,
              onSelectedCategory: (category) {
                Navigator.of(context).pop(context);
                widget.viewModel.loadJobs(category);
              },
            ),
            ListTile(
              title: TextButton.icon(
                onPressed: () {
                  widget.drawerViewModel.signout();
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
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: widget.viewModel.jobViewState,
          builder: (context, viewState, child) {
            if (viewState is HomeSuccessState) {
              return RefreshIndicator.adaptive(
                child: ListView.builder(
                  itemCount: viewState.jobs.length,
                  itemBuilder: (context, index) {
                    final job = viewState.jobs[index];
                    return ListBody(
                      children: [
                        Card(   
                          margin: EdgeInsetsGeometry.only(top: 8, bottom: 8, left: 16, right: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat("yyyy-MM-dd HH:mm:ss").format(job.date),
                                  style: GoogleFonts.rubik(
                                    textStyle: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  job.title,
                                  style: GoogleFonts.rubik(
                                    textStyle: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  job.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                onRefresh: () async {
                  widget.viewModel.loadJobs(null);
                },
              );
            } else if (viewState is HomeErrorState) {
              return Center(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Text(viewState.msg),
                ),
              );
            }

            return const Center(
              child: Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: LinearProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
