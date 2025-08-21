import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/repositories/job/job_repository.dart';
import 'package:so_bicos/core/domain/models/job/job.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';
import 'package:so_bicos/core/external/models/job/job_errors.dart';
import 'package:so_bicos/ui/home/home_view_state.dart';
import 'package:so_bicos/ui/home/viewmodels/home_viewmodel.dart';

@GenerateNiceMocks([MockSpec<JobRepository>(as: #JobRepositoryMock)])
import 'home_viewmodel_test.mocks.dart';

void main() {
  late final JobRepositoryMock jobRepository;
  late final HomeViewModel viewModel;

  final job = Job(
    id: 1,
    title: "Especialista",
    description: "Procuro",
    category: JobCategory(id: "desenvolvedor", name: "Desenvolvedor"),
    author: "teste@gmail.com",
    date: DateTime.now(),
  );

  setUpAll(() {
    jobRepository = JobRepositoryMock();
    viewModel = HomeViewModel(jobRepository: jobRepository);
  });

  group('loadJobs', () {
    test(
      'jobViewState should be stated as HomeSuccessState when category is null',
      () async {
        final Result<List<Job>> dummy = Success([job]);
        provideDummy(dummy);

        when(jobRepository.getAllJobs()).thenAnswer((_) async => dummy);

        await viewModel.loadJobs(null);

        expect(viewModel.jobViewState.value, isA<HomeSuccessState>());
      },
    );

    test(
      'jobViewState should be stated as HomeSuccessState when category is not null',
      () async {
        final Result<List<Job>> dummy = Success([job]);
        provideDummy(dummy);

        when(
          jobRepository.getJobsByCategory("desenvolvedor"),
        ).thenAnswer((_) async => dummy);

        await viewModel.loadJobs(job.category);

        expect(viewModel.jobViewState.value, isA<HomeSuccessState>());
      },
    );

    test(
      'jobViewState should be stated as HomeErrorState when category is unknown',
      () async {
        final Result<List<Job>> dummy = Failure(
          JobFetchByCategoryException(message: "empty"),
        );
        provideDummy(dummy);

        when(
          jobRepository.getJobsByCategory("unknown"),
        ).thenAnswer((_) async => dummy);

        await viewModel.loadJobs(JobCategory(id: "unknown", name: "unkonwn"));

        expect(viewModel.jobViewState.value, isA<HomeErrorState>());
      },
    );
  });
}
