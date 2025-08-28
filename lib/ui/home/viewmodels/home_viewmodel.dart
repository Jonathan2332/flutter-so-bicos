import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:so_bicos/core/data/repositories/job/job_repository.dart';
import 'package:so_bicos/core/domain/models/job/job.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';
import 'package:so_bicos/ui/home/home_view_state.dart';

class HomeViewModel {
  final JobRepository jobRepository;

  HomeViewModel({required this.jobRepository});

  ValueNotifier<HomeViewState> jobViewState = ValueNotifier(HomeLoadingState());

  Future<void> loadJobs(
    JobCategory? category, {
    bool refreshing = false,
  }) async {
    if (!refreshing) {
      jobViewState.value = HomeLoadingState();
    }
    if (category != null) {
      (await jobRepository.getJobsByCategory(category.id)).fold(
        (jobs) {
          jobViewState.value = HomeSuccessState(jobs: jobs);
        },
        (e) {
          jobViewState.value = HomeErrorState(msg: e.toString());
        },
      );
    } else {
      (await jobRepository.getAllJobs()).fold(
        (jobs) {
          jobViewState.value = HomeSuccessState(jobs: jobs);
        },
        (e) {
          jobViewState.value = HomeErrorState(msg: e.toString());
        },
      );
    }
  }

  String formatJobDate(Job job) => DateFormat.yMMMMEEEEd().format(job.date);
}
