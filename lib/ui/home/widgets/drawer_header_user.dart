import 'package:flutter/material.dart';
import 'package:so_bicos/ui/home/home_drawer_view_state.dart';
import 'package:so_bicos/ui/home/viewmodels/home_drawer_viewmodel.dart';

class DrawerHeaderUser extends StatefulWidget {
  final HomeDrawerViewModel viewModel;
  const DrawerHeaderUser({super.key, required this.viewModel});

  @override
  State<DrawerHeaderUser> createState() => _DrawerHeaderUserState();
}

class _DrawerHeaderUserState extends State<DrawerHeaderUser> {

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.viewModel.userViewState,
      builder: (_, viewState, child) {
        if (viewState is HomeUserSuccessState) {
          return DrawerHeader(
            child: Column(
              children: [Text(viewState.user.name), Text(viewState.user.email)],
            ),
          );
        }

        return const Center(child: LinearProgressIndicator());
      },
    );
  }
}
