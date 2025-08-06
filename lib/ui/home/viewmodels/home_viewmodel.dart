import 'package:flutter/foundation.dart';
import 'package:so_bicos/core/data/repositories/auth/auth_repository.dart';
import 'package:so_bicos/ui/home/home_view_state.dart';

class HomeViewModel {
  final AuthRepository authRepository;

  HomeViewModel({required this.authRepository});

  ValueNotifier<HomeViewState> viewState = ValueNotifier(HomeIdleState());

  Future<void> load() async {
    viewState.value = HomeLoadingState();
    final userResult = await authRepository.getLoggedUser();
    userResult.fold((user) {
      viewState.value = HomeSuccessState(user: user);
    }, (error) {
        viewState.value = HomeErrorState(error: error.toString());
    });
  }

  Future<void> signout() async => await authRepository.logout();
}
