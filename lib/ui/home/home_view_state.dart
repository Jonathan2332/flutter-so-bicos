// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:so_bicos/core/domain/models/auth/user.dart';

abstract class HomeViewState {}

class HomeIdleState implements HomeViewState {}

class HomeLoadingState implements HomeViewState {}

class HomeErrorState implements HomeViewState {
  String error;
  HomeErrorState({
    required this.error,
  });
}

class HomeSuccessState implements HomeViewState {
  User user;
  HomeSuccessState({
    required this.user,
  });
}
