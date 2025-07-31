import 'package:flutter/material.dart';
import 'package:so_bicos/ui/home/home_drawer_view_state.dart';
import 'package:so_bicos/ui/home/viewmodels/home_drawer_viewmodel.dart';

class DrawerBodyCategories extends StatefulWidget {
  final HomeDrawerViewModel viewModel;
  const DrawerBodyCategories({super.key, required this.viewModel});

  @override
  State<DrawerBodyCategories> createState() => _DrawerBodyCategoriesState();
}

class _DrawerBodyCategoriesState extends State<DrawerBodyCategories> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.viewModel.categoriesViewState,
      builder: (_, viewState, child) {
        if (viewState is HomeJobCategorySuccessState) {
          final categories = viewState.categories;
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: categories.length,
              itemBuilder: (context, index) =>
              TextButton(onPressed: () {
                //TODO: change filter on home
              }, child: ListTile(title: Text(categories[index].name))),
            ),
          );
        }

        return const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            spacing: 32,
            children: [
              LinearProgressIndicator(),
              LinearProgressIndicator(),
              LinearProgressIndicator(),
              LinearProgressIndicator(),
              LinearProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
