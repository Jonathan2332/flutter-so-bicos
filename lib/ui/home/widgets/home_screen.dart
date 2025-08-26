import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:so_bicos/routing/routes.dart';
import 'package:so_bicos/ui/designsystem/components/app_navigation_destination.dart';
import 'package:so_bicos/ui/designsystem/components/blur_filter.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';
import 'package:so_bicos/ui/designsystem/themes/dimens.dart';
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
    final navDestinations = [
      AppNavigationDestination(
        icon: Icon(Icons.home),
        label: appLocalizations.home,
        route: Routes.home,
      ),
      AppNavigationDestination(
        icon: Icon(Icons.account_circle_sharp),
        label: appLocalizations.profile,
        route: Routes.profile,
      ),
      AppNavigationDestination(
        icon: Icon(Icons.settings),
        label: appLocalizations.settings,
        route: Routes.settings,
      ),
    ];
    final barBorderRadius = const BorderRadius.all(Radius.circular(Dimens.barBorderRadius));
    final barAlphaBlur = 0.7;
    return Scaffold(
      drawer: Drawer(
        child: Builder(
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ), //Android 15
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
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).padding.top + kToolbarHeight,
        ),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.sizeOf(context).width, 56.0),
          ),
          child: BackdropFilter(
            filter: kBlurFilter,
            child: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary.withValues(alpha: barAlphaBlur),
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
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: barBorderRadius,
            child: BackdropFilter(
              filter: kBlurFilter,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: barBorderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Theme.of(
                    context,
                  ).colorScheme.inversePrimary.withValues(alpha: barAlphaBlur),
                ),
                child: SizedBox(
                  height: 56,
                  width: 250,
                  child: NavigationBar(
                    overlayColor: WidgetStateProperty.resolveWith<Color?>((
                      states,
                    ) {
                      return states.contains(WidgetState.focused)
                          ? null
                          : Colors.transparent;
                    }),
                    backgroundColor: Colors.transparent,
                    onDestinationSelected: (index) {
                      context.go(navDestinations[index].route);
                    },
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysHide,
                    destinations: navDestinations,
                    selectedIndex: navDestinations.indexWhere(
                      (dest) =>
                          dest.route ==
                          GoRouter.of(context).state.uri.toString(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: widget.viewModel.jobViewState,
          builder: (context, viewState, child) {
            if (viewState is HomeSuccessState) {
              return RefreshIndicator.adaptive(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    bottom:
                        kBottomNavigationBarHeight +
                        kFloatingActionButtonMargin +
                        56,
                  ),
                  itemCount: viewState.jobs.length,
                  itemBuilder: (context, index) {
                    final job = viewState.jobs[index];
                    return ListBody(
                      children: [
                        Card(
                          margin: EdgeInsetsGeometry.only(
                            top: 8,
                            bottom: 8,
                            left: 16,
                            right: 16,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.viewModel.formatJobDate(job),
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
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
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
                  return widget.viewModel.loadJobs(null, refreshing: true);
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
