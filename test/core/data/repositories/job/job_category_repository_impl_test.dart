import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/datasources/job/job_category_datasource.dart';
import 'package:so_bicos/core/data/repositories/job/job_category_repository_impl.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';
import 'package:so_bicos/core/external/models/job/job_category_api_model.dart';
import 'package:so_bicos/core/external/models/job/job_category_errors.dart';

import '../../../../fakes/core/external/models/job/job_category_api_model_fake.dart';
@GenerateNiceMocks([
  MockSpec<JobCategoryDataSource>(as: #JobCategoryDataSourceMock),
])

import 'job_category_repository_impl_test.mocks.dart';

void main() {
  late final JobCategoryDataSourceMock dataSource;
  late final JobCategoryRepositoryImpl repository;

  setUpAll(() {
    dataSource = JobCategoryDataSourceMock();
    repository = JobCategoryRepositoryImpl(dataSource: dataSource);
  });

  group("GetAllCategories", () {
    test(
      'getAllCategories should return a Success list of JobCategory',
      () async {
        final Result<List<JobCategoryApiModel>> dummy = Success(
          jobCategoryApiModelFakeList,
        );
        provideDummy(dummy);

        when(dataSource.getAllCategories()).thenAnswer((_) async => dummy);
        final result = await repository.getAllCategories();
        expect(result, isA<Result<List<JobCategory>>>());
        expect(
          result.getOrNull()?.first.name,
          jobCategoryApiModelFakeList.first.name,
        );
      },
    );

    test(
      'getAllCategories should return a Failure with CategoryFetchAllException',
      () async {
        final Result<List<JobCategoryApiModel>> dummy = Failure(
          CategoryFetchAllException(message: ""),
        );
        provideDummy(dummy);

        when(dataSource.getAllCategories()).thenAnswer((_) async => dummy);
        final result = await repository.getAllCategories();
        expect(result, isA<Result<List<JobCategory>>>());
        expect(result.exceptionOrNull(), isA<CategoryFetchAllException>());
        expect(result.isError(), true);
      },
    );
  });

  group("getCategoryById", () {
     test(
      'getCategoryById should return a Success of JobCategory',
      () async {
        final Result<JobCategoryApiModel> dummy = Success(
          jobCategoryApiModelFake,
        );
        provideDummy(dummy);

        when(dataSource.getCategoryById(jobCategoryApiModelFake.id)).thenAnswer((_) async => dummy);
        final result = await repository.getCategoryById(jobCategoryApiModelFake.id!);
        expect(result, isA<Result<JobCategory>>());
        expect(
          result.getOrNull()?.id,
          jobCategoryApiModelFake.id,
        );
      },
    );

    test(
      'getCategoryById should return a Failure with CategoryFetchByIdException',
      () async {
        final Result<JobCategoryApiModel> dummy = Failure(
          CategoryFetchByIdException(message: "not exist"),
        );
        provideDummy(dummy);

        when(dataSource.getCategoryById("edicao_de_videos")).thenAnswer((_) async => dummy);
        final result = await repository.getCategoryById("edicao_de_videos");
        expect(result, isA<Result<JobCategory>>());
        expect(result.exceptionOrNull(), isA<CategoryFetchByIdException>());
        expect(result.isError(), true);
      },
    );
  });
}
