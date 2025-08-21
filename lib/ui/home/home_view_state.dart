// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class HomeViewState {}

class HomeLoadingState implements HomeViewState {}

class HomeSuccessState implements HomeViewState {}

class HomeErrorState implements HomeViewState {
  String msg;
  HomeErrorState({required this.msg});
}
