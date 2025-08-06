// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:so_bicos/core/domain/models/auth/user.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';

abstract class HomeDrawerViewState {}

class HomeDrawerIdleState implements HomeDrawerViewState {}

class HomeDrawerLoadingState implements HomeDrawerViewState {}

class HomeDrawerErrorState implements HomeDrawerViewState {
  String error;
  HomeDrawerErrorState({
    required this.error,
  });
}

class HomeUserSuccessState implements HomeDrawerViewState {
  User user;
  HomeUserSuccessState({
    required this.user,
  });
}

class HomeJobCategorySuccessState implements HomeDrawerViewState {
  List<JobCategory> categories;
  HomeJobCategorySuccessState({
    required this.categories,
  });
}

