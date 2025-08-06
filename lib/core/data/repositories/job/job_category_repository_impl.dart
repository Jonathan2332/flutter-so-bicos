// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/datasources/job/job_category_datasource.dart';
import 'package:so_bicos/core/data/repositories/job/job_category_repository.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';
import 'package:so_bicos/core/external/models/job/job_category_api_model.dart';

extension EntityParse on Future<Result<List<JobCategoryApiModel>>> {
  Future<Result<List<JobCategory>>> mapToEntity() =>
      mapFold(_toEntity, (error) => error);
}

List<JobCategory> _toEntity(List<JobCategoryApiModel> models) {
  return models
      .map((category) => JobCategory(name: category.name ?? "Unknown"))
      .toList();
}

class JobCategoryRepositoryImpl extends JobCategoryRepository {
  final JobCategoryDataSource dataSource;

  JobCategoryRepositoryImpl({required this.dataSource});

  @override
  Future<Result<List<JobCategory>>> getAllCategories() =>
      dataSource.getAllCategories().mapToEntity();
}
