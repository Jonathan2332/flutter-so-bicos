import 'package:flutter/foundation.dart';
import 'package:so_bicos/core/data/repositories/auth/auth_repository.dart';
import 'package:so_bicos/core/data/repositories/job/job_category_repository.dart';
import 'package:so_bicos/ui/home/home_drawer_view_state.dart';

class HomeDrawerViewModel {
  final AuthRepository authRepository;
  final JobCategoryRepository jobCategoryRepository;

  HomeDrawerViewModel({required this.authRepository, required this.jobCategoryRepository});

  ValueNotifier<HomeDrawerViewState> userViewState = ValueNotifier(HomeDrawerIdleState());
  ValueNotifier<HomeDrawerViewState> categoriesViewState = ValueNotifier(HomeDrawerIdleState());

  Future<void> loadUser() async {
    userViewState.value = HomeDrawerLoadingState();
    final result = await authRepository.getLoggedUser();
    result.fold((user) {
      userViewState.value = HomeUserSuccessState(user: user);
    }, (error) {
        userViewState.value = HomeDrawerErrorState(error: error.toString());
    });
  }

  Future<void> loadCategories() async {
    categoriesViewState.value = HomeDrawerLoadingState();
    final result = await jobCategoryRepository.getAllCategories();
    result.fold((categories) {
      categoriesViewState.value = HomeJobCategorySuccessState(categories: categories);
    }, (error) {
        categoriesViewState.value = HomeDrawerErrorState(error: error.toString());
    });
  }

  Future<void> signout() async => await authRepository.logout();
}
