// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:so_bicos/core/domain/models/job/job.dart';

abstract class HomeViewState {}

class HomeLoadingState implements HomeViewState {}

class HomeSuccessState implements HomeViewState {
  List<Job> jobs;
  HomeSuccessState({
    required this.jobs,
  });
}

class HomeErrorState implements HomeViewState {
  String msg;
  HomeErrorState({required this.msg});
}
