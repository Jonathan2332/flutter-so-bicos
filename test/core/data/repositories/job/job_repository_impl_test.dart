import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/datasources/job/job_category_datasource.dart';
import 'package:so_bicos/core/data/datasources/job/job_datasource.dart';
import 'package:so_bicos/core/data/repositories/job/job_repository_impl.dart';
import 'package:so_bicos/core/domain/models/job/job.dart';
import 'package:so_bicos/core/external/models/job/job_api_model.dart';
import 'package:so_bicos/core/external/models/job/job_category_api_model.dart';
import 'package:so_bicos/core/external/models/job/job_errors.dart';

import '../../../../fakes/core/external/models/job/job_api_model_fake.dart';
import '../../../../fakes/core/external/models/job/job_category_api_model_fake.dart';
@GenerateNiceMocks([
  MockSpec<JobDataSource>(),
  MockSpec<JobCategoryDataSource>(),
])
import 'job_repository_impl_test.mocks.dart';

void main() {
  final dataSource = MockJobDataSource();
  final categoryDataSource = MockJobCategoryDataSource();
  final repository = JobRepositoryImpl(
    dataSource: dataSource,
    categoryDataSource: categoryDataSource,
  );

  setUpAll(() {
    final Result<List<JobCategoryApiModel>> dummyCategories = Success(
      jobCategoryApiModelFakeList,
    );
    provideDummy(dummyCategories);
  });

  group("getAllJobs", () {
    test('getAllJobs should return a Success list of Job', () async {

      final Result<List<JobApiModel>> dummy = Success(jobApiModelFakeList);
      provideDummy(dummy);

      when(dataSource.getAllJobs()).thenAnswer((_) async => dummy);
      final result = await repository.getAllJobs();
      expect(result, isA<Result<List<Job>>>());
      expect(result.getOrNull()?.first.title, jobApiModelFakeList.first.title);
    });

    test(
      'getAllJobs should return a Failure with JobFetchAllException',
      () async {
        final Result<List<JobApiModel>> dummy = Failure(
          JobFetchAllException(message: ""),
        );
        provideDummy(dummy);

        when(dataSource.getAllJobs()).thenAnswer((_) async => dummy);
        final result = await repository.getAllJobs();
        expect(result, isA<Result<List<Job>>>());
        expect(result.exceptionOrNull(), isA<JobFetchAllException>());
        expect(result.isError(), true);
      },
    );
  });

  group("getJobsByAuthor", () {
    test('getJobsByAuthor should return a Success list of Job', () async {
      final Result<List<JobApiModel>> dummy = Success(jobApiModelFakeList);
      provideDummy(dummy);

      when(
        dataSource.getJobsByAuthor(jobApiModelFake.author),
      ).thenAnswer((_) async => dummy);
      final result = await repository.getJobsByAuthor(jobApiModelFake.author!);
      expect(result, isA<Result<List<Job>>>());
      expect(
        result.getOrNull()?.firstOrNull?.author,
        jobApiModelFakeList.first.author,
      );
    });

    test(
      'getJobsByAuthor should return a Failure with JobFetchByAuthorException',
      () async {

        final Result<List<JobApiModel>> dummy = Failure(
          JobFetchByAuthorException(message: ""),
        );
        provideDummy(dummy);

        when(
          dataSource.getJobsByAuthor(jobApiModelFake.author),
        ).thenAnswer((_) async => dummy);
        final result = await repository.getJobsByAuthor(
          jobApiModelFake.author!,
        );
        expect(result, isA<Result<List<Job>>>());
        expect(result.exceptionOrNull(), isA<JobFetchByAuthorException>());
        expect(result.isError(), true);
      },
    );
  });
}
