// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/datasources/job/job_category_datasource.dart';
import 'package:so_bicos/core/data/repositories/job/job_category_repository.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';
import 'package:so_bicos/core/external/models/job/job_category_api_model.dart';

extension EntityParse on Future<Result<List<JobCategoryApiModel>>> {
  Future<Result<List<JobCategory>>> mapToEntity() =>
      mapFold((models) => models.map(_toEntity).toList(), (error) => error);
}

JobCategory _toEntity(JobCategoryApiModel model) {
  return JobCategory(id: model.id ?? "unkwnown", name: model.name ?? "Unknown");
}

class JobCategoryRepositoryImpl extends JobCategoryRepository {
  final JobCategoryDataSource dataSource;

  JobCategoryRepositoryImpl({required this.dataSource});

  @override
  Future<Result<List<JobCategory>>> getAllCategories() =>
      dataSource.getAllCategories().mapToEntity();

  @override
  Future<Result<JobCategory>> getCategoryById(String id) =>
      dataSource.getCategoryById(id).mapFold(_toEntity, (error) => error);
}
