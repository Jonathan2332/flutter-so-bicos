// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:so_bicos/core/data/datasources/job/job_category_datasource.dart';

import 'package:so_bicos/core/data/datasources/job/job_datasource.dart';
import 'package:so_bicos/core/data/repositories/job/job_repository.dart';
import 'package:so_bicos/core/domain/models/job/job.dart';
import 'package:so_bicos/core/domain/models/job/job_category.dart';
import 'package:so_bicos/core/external/models/job/job_api_model.dart';

extension EntityParse on Future<Result<List<JobApiModel>>> {
  Future<Result<List<Job>>> mapToEntity() =>
      mapFold(_toEntity, (error) => error);
}

List<Job> _toEntity(List<JobApiModel> models) {
  return models
      .map(
        (job) => Job(
          id: job.id,
          title: job.title ?? "Unknown",
          description: job.description ?? "Unknown",
          category: JobCategory(name: job.category),
          author: job.author ?? "Unknown",
          date: job.date ?? "Unknown",
        ),
      )
      .toList();
}

class JobRepositoryImpl extends JobRepository {
  final JobCategoryDataSource categoryDataSource;
  final JobDataSource dataSource;

  JobRepositoryImpl({required this.dataSource, required this.categoryDataSource});

  @override
  Future<Result<Job>> deleteJob(Job job) {
    // TODO: implement deleteJob
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Job>>> getAllJobs() async {
    final categories = categoryDataSource.getAllCategories();
  }

  @override
  Future<Result<List<Job>>> getJobsByAuthor(String author) {
    // TODO: implement getJobsByAuthor
    throw UnimplementedError();
  }

  @override
  Future<Result<Job>> publishJob(Job job) {
    // TODO: implement publishJob
    throw UnimplementedError();
  }

  @override
  Future<Result<Job>> updateJob(Job job) {
    // TODO: implement updateJob
    throw UnimplementedError();
  }
}
