import 'package:flutter/material.dart';
import 'package:so_bicos/core/data/repositories/auth/auth_repository.dart';
import 'package:so_bicos/core/data/repositories/job/job_repository.dart';
import 'package:so_bicos/ui/home/home_view_state.dart';

class HomeViewModel {
  final AuthRepository authRepository;
  final JobRepository jobRepository;

  HomeViewModel({required this.authRepository, required this.jobRepository});

  ValueNotifier<HomeViewState> jobViewState = ValueNotifier(HomeLoadingState());
  String? selectedCategory;

  Future<void> loadJobs() async {
    jobViewState.value = HomeLoadingState();
    final currentCategory = selectedCategory;
    if (currentCategory != null) {
      (await jobRepository.getJobsByCategory(currentCategory)).fold(
        (jobs) {
          jobViewState.value = HomeSuccessState();
        },
        (e) {
          jobViewState.value = HomeErrorState(msg: e.toString());
        },
      );
    } else {
      (await jobRepository.getAllJobs()).fold(
        (jobs) {
          jobViewState.value = HomeSuccessState();
        },
        (e) {
          jobViewState.value = HomeErrorState(msg: e.toString());
        },
      );
    }
  }
}
